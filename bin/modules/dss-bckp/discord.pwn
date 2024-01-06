

#define DCMD:%0(%1,%2,%3)         \
        forward dcmd_%0(DCC_Channel:%1,DCC_User:%2,%3); \
        public dcmd_%0(DCC_Channel:%1,DCC_User:%2,%3)

new DCC_Channel:BotChannel, DCC_Role:RoleStaff, DCC_Role:RoleAdmin, DCC_Role:RoleMod, DCC_Role:Ajudante, DCC_Role:Membro;

#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    RoleStaff = DCC_FindRoleById("364931965897539584");
    RoleAdmin = DCC_FindRoleById("364932650508484609");
    RoleMod = DCC_FindRoleById("365110393061769228");
    Ajudante = DCC_FindRoleById("365110737246486528");
    Membro = DCC_FindRoleById("365111050103816193");
    return true;
}

forward SendDiscord(channel[], const fmat[], va_args<>);
public SendDiscord(channel[], const fmat[], va_args<>)
{
    new str[2000], encode[2000];
    va_format(str, sizeof (str), fmat, va_start<2>);
    BotChannel = DCC_FindChannelById(channel);
    utf8encode(encode, str, sizeof(encode));
    return DCC_SendChannelMessage(BotChannel, encode);
}

forward DCC_OnChannelMessage(DCC_Channel:channel, DCC_User:author, const message[]);
public DCC_OnChannelMessage(DCC_Channel:channel, DCC_User:author, const message[])
{
    new bool:is_bot;
    DCC_IsUserBot(author, is_bot);

    if ( !is_bot )
    {
        new _message[1024], DCC_Guild:guild, cargoDiscord[64];
        utf8decode(_message, message, sizeof(_message));
        DCC_GetChannelGuild(channel, guild);
        GetUserRole(guild, author, 0, cargoDiscord, sizeof(cargoDiscord));

        if ( message[0] == '!' )
        {
            new cmd[32], params[255];
            
            // tirar o ! da variável message
            strdel(_message, 0, 1);

            // separa o cmd dos parametros
            sscanf(_message, "s[28]s[255]", cmd, params);

            new callcmd[32];
            format(callcmd, sizeof(callcmd), "dcmd_%s", cmd);
            if ( funcidx(callcmd) != -1 )
            {
                if ( isnull(params) )
                    CallLocalFunction(callcmd, "dds", _:channel, _:author, "\1");
                else
                    CallLocalFunction(callcmd, "dds", _:channel, _:author, params);
                return true;
            }
        }
        else
        {
            // channel all admins
            if ( DCC_FindChannelById(CHANNEL_ADM) == channel )
            {
            	foreach(new i: Player)
            	{
            		if(call::ADMIN->GetPlayerAdminLevel(i))
            			SendClientMessage(i, 0x8B4726FF, "[ + ] %s %s: disse: %s", cargoDiscord, _message);
            	}
            }
        }
        return true;
    }
    return 1;
}


DCMD:contato(channel, author, params[])
{
    new str[236] = "**`Whatsapp:`** https://chat.whatsapp.com/LnyHivTnYJ0HyYzMynQYB0", temp[128];
  
    format(temp, sizeof(temp), "%c%c**`Instagram:`** https://www.instagram.com/perfectcitygamesonline%c%c", 0xD, 0xA, 0xD, 0xA);
    strcat(str, temp);    
    format(temp, sizeof(temp), "**`Facebook:`** https://www.facebook.com/perfectcitygames%c%c", 0xD, 0xA);
    strcat(str, temp);

    SendDiscord(GetChannelIdDiscord(channel), "<@%s>", GetIDDiscord(author));
    SendDiscord(GetChannelIdDiscord(channel), str);
    return true;
}

DCMD:comandosadm(channel, author, params[])
{
    SendDiscord(GetChannelIdDiscord(channel), "<@%s> **`Comandos Administradores:`** ```» !anunciar » !players```", GetIDDiscord(author));
    return true;
}

DCMD:comandos(channel, author, params[])
{
    SendDiscord(GetChannelIdDiscord(channel), "<@%s> **`Comandos:`** ```» !contato » !top [level/grana]```", GetIDDiscord(author));
    return true;
}

DCMD:players(channel, author, params[])
{
    new count;
    foreach(new i: Player)
    {
        if (IsPlayerConnected(i) )
        {
            SendDiscord(GetChannelIdDiscord(channel), "<@%s> `Players online:`", GetIDDiscord(author));
            SendDiscord(GetChannelIdDiscord(channel), "```%c%c%s [%d]```", 0xD, 0xA, GetUserName(i), i);
            count++;
        }
    }
    if(count == 0)
        return SendDiscord(GetChannelIdDiscord(channel), "<@%s> Nenhum usuário online.", GetIDDiscord(author));
    return true;
}

DCMD:anunciar(channel, author, params[])
{
    new DCC_Guild:guild, _params[1024], cargoDiscord[64];
    DCC_GetChannelGuild(channel, guild);
    GetUserRole(guild, author, 0, cargoDiscord, sizeof(cargoDiscord));

    if(sscanf(params, "s[1024]", params))
    {
        SendDiscord(GetChannelIdDiscord(channel), "<@%s> Uso correto: !anunciar [mensagem]", GetIDDiscord(author));
        return false;
    }

    utf8decode(_params, params, sizeof(_params));
    SendClientMessageToAll(0x4370E3FF, "%s %s diz: %s", cargoDiscord, _params);
    return true;
}

DCMD:top(channel, author, params[])
{
    new tipo[15], str[1024]="```PHP", tmp[128];
    if ( sscanf(params, "s[15]", tipo) )
    {
        SendDiscord(GetChannelIdDiscord(channel), "<@%s> Uso correto: !top [level/grana]", GetIDDiscord(author));
        return false;
    }

	if(!strcmp(tipo, "level", true))
	{
		new pName[MAX_PLAYER_NAME], level;

		mysql_query(getConexao(), "SELECT `username`,`level` FROM "TABLE_USERS" WHERE `admin`<'1' ORDER BY `level` DESC LIMIT "#MAX_TOPS";"); // "
				
		for(new i, r=cache_num_rows(); i < r; i++)
		{
			cache_get_value_name(i, "username", pName, MAX_PLAYER_NAME);
			cache_get_value_name_int(i, "level", level);

			format(tmp, sizeof(tmp), "%c%c%d° - %s", 0xD, 0xA, i+1, pName);
			strcat(str, tmp);

			new e = 20 - strlen(pName);
			for(new o = 0; o < e; o++)
			strcat(str, " ");
			format(tmp, sizeof(tmp), "» Level: %d", level);
			strcat(str, tmp);
		}
		strcat(str, "```");
        SendDiscord(GetChannelIdDiscord(channel), "<@%s> TOP JOGADORES VICIADOS:", GetIDDiscord(author));
        SendDiscord(GetChannelIdDiscord(channel), str);
    }
    else if(!strcmp(tipo, "grana", true))
	{
		new pName[MAX_PLAYER_NAME], dinheiro;

		mysql_query(getConexao(), "SELECT u.username, u.dinheiro + b.saldo as total FROM "TABLE_USERS" u LEFT JOIN "TABLE_BANK" b ON b.id = u.id WHERE u.admin < '1' ORDER BY total DESC LIMIT "#MAX_TOPS";"); // "
				
		for(new i, r=cache_num_rows(); i < r; i++)
		{
			cache_get_value_name(i, "username", pName, MAX_PLAYER_NAME);
			cache_get_value_name_int(i, "total", dinheiro);

			format(tmp, sizeof(tmp), "%c%c%d° - %s", 0xD, 0xA, i+1, pName);
			strcat(str, tmp);

			new e = 20 - strlen(pName);
			for(new o = 0; o < e; o++)
			strcat(str, " ");
			format(tmp, sizeof(tmp), "» Dinheiro: R$%s", RealStr(dinheiro));
			strcat(str, tmp);
		}
		strcat(str, "```");
        SendDiscord(GetChannelIdDiscord(channel), "<@%s> TOP JOGADORES RICOS:", GetIDDiscord(author));
        SendDiscord(GetChannelIdDiscord(channel), str);
    }
	return true;
}

stock GetIDDiscord(DCC_User:author)
{
    new id[20 + 1];
    DCC_GetUserId(author, id, 20 + 1);
    return id;
}

stock GetChannelIdDiscord(DCC_Channel:channel)
{
    new id[20 + 1];
    DCC_GetChannelId(channel, id, 20 + 1);
    return id;
}

stock GetUserRole(DCC_Guild:guild, DCC_User:author, index, roleName[], len = sizeof(roleName))
{
    new rolesCount = 0;
    DCC_GetGuildMemberRoleCount(guild, author, rolesCount);
    if ( rolesCount )
    {
        new DCC_Role:role;
        DCC_GetGuildMemberRole(guild, author, index, role);
        DCC_GetRoleName(role, roleName, len);
        return 1;
    }
    return 0;
}