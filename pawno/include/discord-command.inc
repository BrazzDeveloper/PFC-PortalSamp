// checking if discord connector included first before dcc.inc
#if !defined dcconnector_included
    #error You need include discord-connector first!
    #endinput
#endif

#if !defined sscanf
	#error You must include both sscanf2 and discord-connector first!
	#endinput
#endif

#if defined dccommand_included
	#endinput
#endif

#define dccommand_included

#if !defined DC_BOT_NAME
	#error You must add `#define DC_BOT_NAME "Your Bot Name"` in your script!
#endif

#if !defined DC_PREFIX
	#define DC_PREFIX "!"
#endif 

#if defined DC_AUTHOR_ONLY
    #if !defined DC_AUTHOR
        #error You must add `#define DC_AUTHOR "Your name"` in your script if you're using DC_AUTHOR_ONLY
    #endif
#endif

#if defined DC_SPECIFIC_CHANNEL
    #if !defined DC_SPECIFIC_CHANNEL_ID
        #error You must add `#define DC_SPECIFIC_CHANNEL_ID "channel_id_here"` in your scriptif you're using DC_SPECIFIC_CHANNEL
    #endif
#endif

#if !defined DC_PREFIX_LENGTH && defined DC_PREFIX
	#define DC_PREFIX_LENGTH 1 //must change this if you change prefix
#endif

#if !defined isnull
    #define isnull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

#define DC_CMD:%0(%1)          \
			forward dccmd_%0(%1); \
			public dccmd_%0(%1)

#define DISCORD DC_CMD

// Forward
forward OnDiscordCommandPerformed(const params[], success, DCC_Message:message);

// Core
public DCC_OnMessageCreate(DCC_Message:message) {
    new 
        DCC_Channel:channel, DCC_User:author, 
		user_name[32 + 1], bool:isBot, 
		messageContext[256];

    // get user id and channel id from message
    DCC_GetMessageAuthor(message, author); 
    DCC_GetMessageChannel(message, channel);
    DCC_GetMessageContent(message, messageContext);

    //this is crucial!
    DCC_IsUserBot(author, isBot);

	if (!DCC_GetUserName(author, user_name))
		return 0;

	if(messageContext[0] == '<' && messageContext[1] == '@')
		return 0;

    #if defined DC_SPECIFIC_CHANNEL
		new channel_name[DCC_ID_SIZE];
	    if(!DCC_GetChannelId(channel, channel_name))
		    return 0; 
		
		if (strcmp(channel_name, DC_SPECIFIC_CHANNEL_ID))
			return 0;
    #endif

    #if defined DC_AUTHOR_ONLY
		if (strcmp(user_name, DC_AUTHOR, false))
			return 0;
    #endif

	if(!strcmp(user_name, DC_BOT_NAME, true)) 
        return 1;

    if (isBot) 
        return 1;

    new command[32], args[134];
    sscanf(messageContext, "s[32]s[134]", command, args);

    if(strfind(command, DC_PREFIX, true) != -1)
    {
        new funcdc[64];
        strdel(command, 0, DC_PREFIX_LENGTH);
        format(funcdc, sizeof(funcdc), "dccmd_%s", command);

        (isnull(args)) &&
            CallLocalFunction(#OnDiscordCommandPerformed, "sii", messageContext, CallLocalFunction(funcdc, "isi", _:author, "\1", _:message), _:message) ||
            CallLocalFunction(#OnDiscordCommandPerformed, "sii", messageContext, CallLocalFunction(funcdc, "isi", _:author, args, _:message), _:message);
    }
    return 1;
}

// By Emmet_ - Not work with JIT compiler (i guess :\)
stock SendDiscordMessage(DCC_Channel:channel, const text[], {Float, _}:...)
{
	static
	    args,
	    str[512];

	/*
     *  Custom function that uses #emit to format variables into a string.
     *  This code is very fragile; touching any code here will cause crashing!
	*/
	if ((args = numargs()) == 2)
	{
	    DCC_SendChannelMessage(channel, text);
	}
	else
	{
		while (--args >= 2)
		{
			#emit LCTRL 5
			#emit LOAD.alt args
			#emit SHL.C.alt 2 
			#emit ADD.C 12 
			#emit ADD
			#emit LOAD.I
			#emit PUSH.pri
		}
		#emit PUSH.S text
		#emit PUSH.C 512
		#emit PUSH.C str
		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri
		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

	    DCC_SendChannelMessage(channel, str);

		#emit RETN
	}
	return 1;
}

#if !defined OnDiscordCommandPerformed
	public OnDiscordCommandPerformed(const params[], success, DCC_Message:message) {
		// This is just uwu, don't add anything here!
		return 1;
	}
#endif