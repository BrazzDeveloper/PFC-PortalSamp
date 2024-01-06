// NEW SYSTEM: DISCORD LOGS

/* ----         Started at 21/05/2021 - 21:13                                                     */
/* ----         Author: Luiz "LuizM" Henrique                                                     */
/* ----         Credits:                                                                          */
/* ----         Finished at xx/xx/xxxx - xx:xx                                                    */
/* ----         First patch: xx/xx/xxxx - xx:xx - xxx lines                                       */


forward FormatLog(channel, const message[]);
public FormatLog(channel, const message[])
{
    new DCC_Embed:embed;
    new DCC_Channel:channelsend;
    new StrTitulo[128], StrMessage[256], newMessage[256];

    new hora, minuto, segundo, ano, mes, dia;
    gettime(hora, minuto, segundo);
    getdate(ano, mes, dia);

    embed = DCC_CreateEmbed();

    if(channel == LOG_DUVIDAS)
    {
        channelsend = DCC_FindChannelById(CHANNEL_DUVIDAS);

        utf8encode(StrTitulo, "LOG de Dúvida", 128);
    }

    else if(channel == LOG_RELATORIOS)
    {
        channelsend = DCC_FindChannelById(CHANNEL_RELATORIOS);

        utf8encode(StrTitulo, "LOG de Relatório", 128);
    }

    else if(channel == LOG_AVISOS)
    {
        channelsend = DCC_FindChannelById(CHANNEL_AVISOS);

        utf8encode(StrTitulo, "LOG de Aviso", 128);
    }

    else if(channel == LOG_PRISOES)
    {
        channelsend = DCC_FindChannelById(CHANNEL_PRISOES);

        utf8encode(StrTitulo, "LOG de Prisões Administrativas", 128);
    }

    else if(channel == LOG_BANIMENTOS)
    {
        channelsend = DCC_FindChannelById(CHANNEL_BANIMENTOS);

        utf8encode(StrTitulo, "LOG de Banimentos", 128);
    }

    else if(channel == LOG_LOGINADMIN)
    {
        channelsend = DCC_FindChannelById(CHANNEL_LOGINADMIN);

        utf8encode(StrTitulo, "LOG de Atividade Administrativa", 128);
    }



    format(StrMessage, 256, "%s - [%02d:%02d:%02d - %02d:%02d:%02d]", message, dia, mes, ano, hora, minuto, segundo);

    format(newMessage, sizeof(newMessage), "%s - [%02d:%02d:%02d - %02d:%02d:%02d]", message, dia, mes, ano, hora, minuto, segundo);

    utf8encode(StrMessage, newMessage, 256);

    DCC_SetEmbedDescription(embed, StrMessage);
    DCC_SetEmbedTitle(embed, StrTitulo);
    DCC_SetEmbedColor(embed, 16711680);

    DCC_SendChannelEmbedMessage(channelsend, embed);
   
    /*new StrMessage[256];
    utf8encode(StrMessage, message, 256);

    DCC_SendChannelMessage(channelsend, StrMessage);*/

    /*native DCC_Embed:DCC_CreateEmbed(const title[] = "", const description[] = "", const url[] = "", const timestamp[] = "", color = 0, const footer_text[] = "", const footer_icon_url[] = "", const thumbnail_url[] = "", const image_url[] = "");
    native DCC_DeleteEmbed(DCC_Embed:embed);
    native DCC_SendChannelEmbedMessage(DCC_Channel:channel, DCC_Embed:embed, const message[] = "", const callback[] = "", const format[] = "", {Float, _}:...);*/
    //native DCC_SendChannelMessage(DCC_Channel:channel, const message[], const callback[] = "", const format[] = "", {Float, _}:...);
    return 1;
}


public DCC_OnMessageCreate(DCC_Message:message)
{
    new content[DCC_ID_SIZE], DCC_Channel:channel, DCC_User:author;
    DCC_GetMessageContent(message, content);
    DCC_GetMessageChannel(message, channel);
    DCC_GetMessageAuthor(message, author);

    new usernamedc[DCC_USERNAME_SIZE];

    DCC_GetUserName(author, usernamedc, sizeof(usernamedc));

    new bool:is_bot;

	if (!DCC_IsUserBot(author, is_bot))
		return 0; //invalid user

	if(is_bot)
		return 0;

    new command_name[25], params[150];

    if(sscanf(content, "s[25]S()[150]", command_name, params))
    {
		return 0;
    }

    /*if(!strcmp(command_name, "!rd", true))
    {
        new id, texto[128];
        if(sscanf(params, "us[128]", id, texto))
            return DCC_SendChannelMessage(DCC_Channel:channel, "```| ERRO | Use: !RD [id] [Resposta].```");
        
        if(!call::PLAYER->IsPlayerLogged(id))
            return DCC_SendChannelMessage(DCC_Channel:channel, "```| ERRO | Jogador(a) nao conectado(a).```");
        
        DCC_DeleteMessage(message);

		new duvida[128];
		utf8encode(duvida, texto, 128);

        new StrMessage[256], strformat[256];
        format(strformat, 256, "```| RESPOSTA | Resposta enviada para o(a) jogador(a) %s[%d] ( %s )```", GetUserName(id), id, texto);
		//utf8encode(StrMessage, strformat, 256);


        SendClientMessage(id, COR_AZUL, "| DÚVIDA | Dúvida respondida de %s ( %s )", usernamedc, duvida);
        
        DCC_SendChannelMessage(DCC_Channel:channel, strformat);
    }*/
    return 1;
}