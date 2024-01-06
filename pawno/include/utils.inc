/*
		Metropolitan City (c) 2017-2018 by SammyJ
*/

/*
*
*			includeds utils
*
*/

#if defined _utils_included
	#endinput
#endif

#define _utils_included


#define INVALID_PLAYER_TEXTDRAW 		PlayerText:INVALID_TEXT_DRAW

#if defined INVALID_TEXT_DRAW
	#undef INVALID_TEXT_DRAW
#endif
#define INVALID_TEXT_DRAW 				Text:INVALID_TEXT_DRAW

new sendclientmessage[144];
#define SendClientMessage(%0,%1,%2,%3) (format(sendclientmessage, sizeof(sendclientmessage),%2,%3),SendClientMessage(%0,%1,sendclientmessage))
#define SendClientMessageToAll(%0,%1,%2) (format(sendclientmessage, sizeof(sendclientmessage),%1,%2),SendClientMessageToAll(%0,sendclientmessage))

static indexMail;
stock SendEmail(de[], para[], title[], msg[], script[])
{
	#pragma unused script
	new args[2048], url[100];
	format(args, sizeof(args), "title=%s&msg=%s&de=%s&para=%s&charset=utf-8", title, msg, de, para);
	format(url, sizeof(url), "dev.perfectcityrpg.com/email/%s", script);
	HTTP(indexMail, HTTP_POST, url, args, "OnSendEmail");
	indexMail++;
}

forward OnSendEmail(index, response, data[]);
public OnSendEmail(index, response, data[])
{
	if(response)
	{
		indexMail = 0;
		printf("data: %s, response: %d, index: %d", data, response, index);
		return true;
	}
	print("não foi possivel enviar o email.");
	return false;
}

// HOLDING(keys)
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))

// PRESSED(keys)
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

// PRESSING(keyVariable, keys)
#define PRESSING(%0,%1) \
	(%0 & (%1))

// RELEASED(keys)
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

stock randomEx(max, min=0)
{
	return (random(max - min) + min);
}

#if defined _ALS_random
	#undef random
#else
	#define _ALS_random
#endif

#define random randomEx

stock GetPlayerIDByName(const pName[])
{
	static gpName[MAX_PLAYER_NAME];
	
	foreach(new i: Player)
	{
		GetPlayerName(i, gpName, sizeof(gpName));
		if(strcmp(pName, gpName, false) == 0)
			return i;
	}
	return INVALID_PLAYER_ID;
}

stock IsPlayerInFrontVehicle(playerid,vehicleid,Float:radius,Float:vehiclelength)
{
  new Float:x,Float:y,Float:z,Float:a;
  GetVehiclePos(vehicleid, x, y, z);
  GetPlayerFacingAngle(vehicleid, a);
  x += (vehiclelength* floatsin(-a, degrees));
  y += (vehiclelength* floatcos(-a, degrees));
  return IsPlayerInRangeOfPoint(playerid,radius,x,y,z);
}

stock Float:GetDistanceBetweenPoints(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2) // reference code http://forum.sa-mp.com/showpost.php?p=3666981&postcount=10
{ 
    return VectorSize(x1-x2,y1-y2,z1-z2);
}  

stock RealStr(value)
{
	new 
		dest[14], count = 0;
	valstr(dest, value);

	for(new i = strlen(dest); i != 0; i--)
	{		
		count++;
		if(count == 3 && i >= 2)
			strins(dest, ".", i - 1, sizeof(dest)),count=0;
	}
	return dest;
}

stock ConvertEncoding(string[])
{
	static arrCharacters[][] =
	{
		{'ã','š'}, {'Ã','ƒ'}, {'á','˜'}, {'á','—'},
		{'â','™'}, {'é','ž'}, {'É','‡'}, {'ê','Ÿ'}, 
		{'Ê','ˆ'}, {'í','¢'}, {'õ','¨'}, {'ó','¦'},
		{'ô','§'}, {'Ô','‘'}, {'ú','ª'}, {'Ú','“'}
	};
	for(new i = 0, len = strlen(string); i < len; ++i)
	{
	    for(new j = 0, len2 = sizeof(arrCharacters); j < len2; ++j)
	    {
	        if(string[i] == arrCharacters[j][0])
	        {
	            string[i] = arrCharacters[j][1];
	        }
	    }
	}
}

stock Text:TextDrawCreate_fix(Float:x, Float:y, text[])
{
	ConvertEncoding(text);
	return TextDrawCreate(x, y, text);
}
#if defined _ALS_TextDrawCreate
	#undef TextDrawCreate
#else 
	#define _ALS_TextDrawCreate
#endif

#define TextDrawCreate TextDrawCreate_fix

stock TextDrawSetString_fix(Text:TextDraw, text[])
{
	ConvertEncoding(text);
	return TextDrawSetString(TextDraw, text);
}
#if defined _ALS_TextDrawSetString
	#undef TextDrawSetString
#else 
	#define _ALS_TextDrawSetString
#endif

#define TextDrawSetString TextDrawSetString_fix

stock PlayerText:CreatePlayerTextDraw_fix(playerid, Float:x, Float:y, text[])
{
	ConvertEncoding(text);
	return CreatePlayerTextDraw(playerid, x, y, text);
}
#if defined _ALS_CreatePlayerTextDraw
	#undef CreatePlayerTextDraw
#else 
	#define _ALS_CreatePlayerTextDraw
#endif

#define CreatePlayerTextDraw CreatePlayerTextDraw_fix

stock PlayerTextDrawSetString_fix(playerid, PlayerText:Playertext, text[])
{
	ConvertEncoding(text);
	return PlayerTextDrawSetString(playerid, Playertext, text);
}
#if defined _ALS_PlayerTextDrawSetString
	#undef PlayerTextDrawSetString
#else 
	#define _ALS_PlayerTextDrawSetString
#endif

#define PlayerTextDrawSetString PlayerTextDrawSetString_fix

stock GameTextForPlayer_fix(playerid,string[],time,style)
{
	ConvertEncoding(string);
	return GameTextForPlayer(playerid,string,time,style);
}
#if defined _ALS_GameTextForPlayer
	#undef GameTextForPlayer
#else 
	#define _ALS_GameTextForPlayer
#endif

#define GameTextForPlayer GameTextForPlayer_fix

stock GameTextForAll_fix(string[],time,style)
{
	ConvertEncoding(string);
	return GameTextForAll(string,time,style);
}
#if defined _ALS_GameTextForAll
	#undef GameTextForAll
#else 
	#define _ALS_GameTextForAll
#endif

#define GameTextForAll GameTextForAll_fix


stock GetPlayerDistanceToPoint(playerid, Float:x, Float:y)
{
    new Float:tmpdis;
    new Float:x1, Float:y1, Float:z1;
    GetPlayerPos(playerid, x1, y1, z1);
    tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2));
    return floatround(tmpdis);
}

stock IsNumeric(const string[])
{
    for(new i = 0, j = strlen(string); i < j; i++)
    {
		if((string[i] > '9' || string[i] < '0')) return 0;
    }
    return 1;
}

stock cleanChat(playerid = INVALID_PLAYER_ID)
{
	if(playerid == INVALID_PLAYER_ID)
	{
		for(new i; i < 100; i++){
			SendClientMessageToAll(-1, "");
		}
	}
	else
	{
		for(new i; i < 100; i++){
			SendClientMessage(playerid, -1, "");
		}
	}
	return false;
}


stock Hash(password[], salt[])
{
	new ret_hash[65];
	SHA256_PassHash(password, salt, ret_hash, sizeof(ret_hash));
	return ret_hash;
}


#define Kick(%0) SetTimerEx("Kicka", 100, false, "i", %0)
forward Kicka(p); public Kicka(p) {
    #undef Kick
    Kick(p);
    #define Kick(%0) SetTimerEx("Kicka", 100, false, "i", %0)
    return 1;
}

stock IsValidName(const pName[])
{
	new 
		count = 0;

	if(pName[0] < 'A' || pName[0] > 'Z')
		return false;
	
	if(strlen(pName) > MAX_PLAYER_NAME)
		return false;

	for(new i; i < strlen(pName); i++)
	{
		if(pName[i] == '_')
			count++;

		if(count > 1)
			return false;

		if(pName[i] == '_' && (pName[i + 1] < 'A' || pName[i + 1] > 'Z'))
			return false;
	}
	return true;
}

stock IsValidEmail(const email[]) // by Bruno13 http://forum.sa-mp.com/showpost.php?p=3917662&postcount=3273
{ 
    new size = strlen(email); 

    if(size < 7) 
        return false; 

    new atFinded, 
        i; 

    for(i = 0; i < size; i++) 
    { 
        switch(email[i]) 
        { 
            case 'A'..'Z', 'a'..'z', '0'..'9', '_', '.', '-': continue; 
            default: 
            { 
                if(email[i] == '@') 
                { 
                    atFinded++; 
                    continue; 
                } 

                return false; 
            } 
        } 
    } 
    return (atFinded == 1); 
}  

stock GeneretePlate(placa[], len = sizeof(placa))
{
	new letras[4];
	for(new i; i < sizeof(letras); i++){
		letras[i] = random(90, 65);
	}
	letras[sizeof(letras)-1] = 0;
	format(placa, len, "%s-%4d", letras, random(9999));
	return true;
}

stock randomstring(strReturn[], strLen = sizeof(strReturn)) // by RyDeR | link = http://forum.sa-mp.com/showthread.php?t=276913
{
	new 
		strDest[128];

	while(strLen--)
		strDest[strLen] = random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0');

	format(strReturn, strLen, strDest);
}

stock ReadFile(file[], return_str[], len = sizeof(return_str))
{
	if(!fexist(file))
		return false;

	new 
		File:arquivo, _str[1024];
	
	arquivo = fopen(file, io_readwrite);
	while(fread(arquivo, _str))
	{
		strcat(return_str, _str, len);
	}
	return fclose(arquivo);
}

stock WriteLog(const File[], const string[], maxlength = sizeof(string))
{
	new
		str_log[1024], path[70], File:logfile;

	#if defined filemanager_included
		if(!dir_exists("scriptfiles/logs/"))
			dir_create("scriptfiles/logs/");
	   	
	   	format(path, sizeof(path), "logs/%s", File);
	    logfile = fopen(path, io_append);

		if(logfile)
		{
		    format(str_log, maxlength + 50, "[%s] %s\r\n", timestamp(), string);
		    fwrite (logfile, str_log);
		    return fclose(logfile);
		}
		printf("» Erro: não foi possivel criar o log, verifique se o cominho \"%s\".", path);
		return false;
	#else

	    if(!fexist("logs/"))
	    	return print("Erro: A Pasta não foi criada em \"ScriptFiles\\logs\""), false;

	   	format(path, sizeof(path), "logs/%s", File);
	    
	    logfile = fopen(path, io_append);
		if(logfile)
		{
		    format(str_log, maxlength + 27, "[%s] %s\r\n", timestamp(), string);
		    fwrite (logfile, str_log);
		    return fclose(logfile);
		}
		printf("» Erro: não foi possivel criar o log, verifique se o cominho \"%s\".", path);
		return false;
	#endif
}

stock timestamp()
{
	new str[30], _ano, _mes, _dia, _hora, _minuto, _segundos;
	getdate(_ano, _mes, _dia), gettime(_hora, _minuto, _segundos);
	format(str, sizeof(str), "%02d/%02d/%d as %02d:%02d:%02d", _dia, _mes, _ano, _hora, _minuto, _segundos);
	return str;
}

stock GetVehicleSpeed(vehicleid, bool:user_mph = false) // http://forum.sa-mp.com/showpost.php?p=1626586&postcount=7
{
	if(IsValidVehicle(vehicleid))
	{
		new
		    Float:x, Float:y, Float:z, vel;

		GetVehicleVelocity( vehicleid, x, y, z );
		if(user_mph)
			vel = floatround( floatsqroot( x*x + y*y + z*z ) * 200 );		// KM/H
		else
			vel = floatround( floatsqroot( x*x + y*y + z*z ) * 200 / 1.609344 ); // MPH

		return vel;
	}
	return false;
}

stock HexToInt(string[]) // wiki samp => http://wiki.sa-mp.com/wiki/Colors_List#Convert_string_to_value_with_pawn
{
    if(!string[0]) return 0;
    new cur = 1, res = 0;
    for(new i = strlen(string); i > 0; i--)
    {
        res += cur * (string[i - 1] - ((string[i - 1] < 58) ? (48) : (55)));
        cur = cur * 16;
    }
    return res;
}

stock Quit(playerid){
	GameTextForPlayer(playerid,"$!#{]{]¨¨**&~w",500,6);
	return Kick(playerid);
}

stock CleanPromptLog(){
	return print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
}
stock RemovePlayerFromJetpack(playerid)
{
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		SetPlayerPos(playerid, x, y, z);
		return true;
	}
	return false;
}

stock ReturnMesFormat(mes)
{
	static
		mesF__[15];
	switch(mes){
		case 1:mesF__="Janeiro";
		case 2:mesF__="Fevereiro";
		case 3:mesF__="Março";
		case 4:mesF__="Abril";
		case 5:mesF__="Maio";
		case 6:mesF__="Junho";
		case 7:mesF__="Julho";
		case 8:mesF__="Agosto";
		case 9:mesF__="Setembro";
		case 10:mesF__="Outubro";
		case 11:mesF__="Novembro";
		case 12:mesF__="Dezembro";
		default:mesF__="Unknown";
	}
	return mesF__;
}

stock IsPlayerInPlace(playerid, Float:XMin, Float:YMin, Float:XMax, Float:YMax)
{
	static Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x, y, z);

	if( x >= XMin && y >= YMin && x < XMax && y < YMax )
		return true;

	return false;
}
stock formatSeconds(seconds, &hours_left, &minutes_left, &seconds_left)
{
    hours_left = seconds/60/60;
    minutes_left = (seconds - hours_left*60*60)/60;
    seconds_left = (seconds - hours_left*60*60 - minutes_left*60);
    return 1;
}
