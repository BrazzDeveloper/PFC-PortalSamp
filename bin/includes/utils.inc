/*
		Metropolitan City (c) 2017-2018 by SammyJ
*/

/*
*
*			includeds utils
*
*/

#include ../bin/includes/checkpoint.inc
#include ../bin/includes/station-radio.inc

/*
native IsPlayerInFrontVehicle(playerid,vehicleid,Float:radius,Float:vehiclelength); 		// retorna true se o jogador estiver na frente do veiculo.
native IsPlayerInPlace(playerid, Float:XMin, Float:YMin, Float:XMax, Float:YMax); 	// retorna se o jogadr está em uma area.
native Float:GetDistanceBetweenPoints(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2); // retorna a distancia entre dois pontos.
native RealStr(value); 						// retorna uma string de uma valor em Reais.
native GetPlayerDistanceToPoint(playerid, Float:x, Float:y); // retorna a distancia do jogador de um ponto especifico.
native IsNumeric(const string[]); 			// retorna se a string[] é um válor númerico.
native CleanChat(playerid = INVALID_PLAYER_ID);  //  limpar o log do chat global se o valor de playerid for igual á INVALID_PLAYER_ID ou limpa o log do chat do playerid se o valor for um id válido.
native Hash(password[], salt[] = ""); 		 	// retorna um hash do do tipo sha256.
native IsValidName(const pName[]); 			 	// retorna se um nome é válido (padrão RPG, ex: Nome_Sobrenome).
native IsValidEmail(const Email[]); 		  	// retorna se um email é válido.
native randomstring(strDest[], strLen = 10); 	// função para gerar uma string randômica.
native GeneretePlate(placa[], len = sizeof(placa)); // funcção para obter uma string de placa veicular.
native ReadFile(file[], return_str[], len = sizeof(return_str)); // ler uma arquivo especificado em file[]
native WriteLog(const File[], string[], maxlength = sizeof(string)); // escreve um log em "/scriptfiles/logs/"
native timestamp(); 						// retorna um string com a data e hora atual do servidor samp_server.
native GetVehicleModelName(veh_model)		// retorna o nome do veiculo pelo modelo.
native GetVehicleName(vehicleid) 			// retorna o nome do veiculo pelo id.
native GetVehicleSpeed(vehicleid, bool:user_mph=false)  // retorna a velocidade do veiculo.
native Exit(); 								// comando para fechar o samp_server.
native isValidHex(code[]); 					// checa se o é um código hex.
native Quit(playerid); 						// força um jogador a crashar.
native CleanPromptLog(); 					// limpa o log do console do samp-server
native RemovePlayerFromJetpack(playerid); 	// Remove o jogador do jetpack.
native ReturnMesFormat(mes); 				// Retorna o nome do mes.
native GetPlayerFramerate(playerid) ;		// obtem o fps do jogador.
native FreezePlayer(playerid, time=0) 		// Congelar jogador por um tempo. Se especificado
*/

/*static indexMail;
stock SendEmail(de[], para[], title[], msg[])
{
	new args[2048];
	format(args, sizeof(args), "title=%s&msg=%s&de=%s&para=%s&charset=utf-8", title, msg, de, para);
	HTTP(indexMail, HTTP_POST, "perfectcitygamesonline.000webhostapp.com/email.php", args, "OnSendEmail");
	indexMail++;
}

forward OnSendEmail(index, status_code, data[]);
public OnSendEmail(index, status_code, data[])
{
	indexMail = 0;
	if(status_code == 200)
	{
		printf("EMAIL: %s", data);
		return true;
	}
	printf("index: %d | Email não enviado", index);
	return false;
}*/

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
	format(dest, sizeof(dest), "%d", value);
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

stock CleanChat(playerid = INVALID_PLAYER_ID)
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


stock Hash(password[], salt[] = "8FeYC#45WSl@DsiSf")
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
/*
*
*	Caracteres proibidos ao digitar no nome.
*
**/
static const AllowCaracter[] =
{
	'#', '`', '\'', '\"', '@', '%', '¨', '&', '+', '!'
};

// ' "

stock IsValidName(const pName[])
{
	for(new i; i < strlen(pName); ++i)
	{
		for(new c; c < sizeof(AllowCaracter); ++c)
		{
			if ( pName[i] == AllowCaracter[c])
				return false;
		}
	}
	return true;
}
/*
stock IsValidName(const pName[])
{

	new 
		count = 0;

	if(pName[0] < 'A' || pName[0] > 'Z') // Verifica se a primeira linha do nome é maiuscula
		return false;
	
	if(strlen(pName) > MAX_PLAYER_NAME) // Verifica se o nome é maior do que o permitido no caso o valor de MAX_PLAYER_NAME
		return false;

	for(new i; i < strlen(pName); i++)
	{
		if(pName[i] == '_') // Verifica se no nome tem um underline _
			count++;

		if(count > 1) // se tiver +1 underline retorna false, ou seja nome inválido.
			return false;

		// verifica se após o underline tem uma letra maiuscula, se não tiver retorna false ou seja nome inválido.
		if(pName[i] == '_' && (pName[i + 1] < 'A' || pName[i + 1] > 'Z'))
			return false;
	}
	// Caso passar por todos as condições retorna true, ou seja nome válido
	return true;
}
*/

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

GeneretePlate(placa[], len = sizeof(placa))
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

GetPlayerSpeed(playerid)
{
    new Float:ST[4];
        
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
    else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 179.28625;

    return floatround(ST[3]);
}

enum eTeleportes {
	tpInterior,
	Float:tpX,
	Float:tpY,
	Float:tpZ,
	Float:tpA,
	tpName[70]
}

new stock TeleporteInfo[][eTeleportes] =
{
	{0, 1685.7743,-2240.8127,13.5469,181.8442, "Spawn Novatos"},
	{0, 1216.9292,-1812.9769,16.5938,3.1705, "Agência de Empregos LS"},
	{0, -1896.74, 487.079, 35.1719, 275.214, "Agência de Empregos SF"},
	{0, 1555.06,-1675.74,16.1953,89.6941, "Delegacia LS"},
	{0, -1605.51, 710.792, 13.8672, 355.552, "Delegacia SF"},
	{0, 2287.31, 2431.45, 10.8203, 4.1938, "Delegacia LV"},
	{0, -217.839, 978.957, 19.5037, 268.491, "Delegacia FC"},
	{0, 627.138, -571.812, 17.9145, 265.757, "Delegacia Dillimore"},
	{0, -2161.65, -2385.23, 30.7447, 136.702, "Delegacia AP"},
	{0, -1392.35, 2646.29, 55.9696, 262.065, "Delegacia EQ"},
	{0, 1676.37, -1332.79, 17.4379, 10.3837, "Auto Escola LS"},
	{0, -2026.65, -101.407, 35.1641, 34.9728, "Auto Escola SF"},
	{0, 1168.64, 1363.68, 10.8203, 356.146, "Auto Escola LV"},
	{0, 2034.12, -1402.24, 17.2943, 5.7914, "Hospital LS"},
	{0, -2655.17, 640.164, 14.4545, 175.483, "Hospital SF"},
	{0, 1607.71, 1815.76, 10.8203, 357.197, "Hospital LV"},
	{0, -320.218, 1048.43, 20.3403, 355.081, "Hospital FC"},
	{0, -1514.77, 2519.9, 56.0041, 174.647, "Hospital EQ"},
	{0, 1155.8429,-1771.2690,16.6038,181.2885, "Banco LS"},
	{0, -1581.16, 867.503, 7.6953, 177.675, "Banco SF"},
	{0, 2388.99, 2466.08, 10.8203, 86.7549, "Banco LV"},
	{0, -828.064, 1503.65, 19.7659, 1.8352, "Banco LB"},
	{0, 1481.27, -1771.14, 18.7958, -165.0, "Prefeitura LS"},
	{0, -1492.56, 920.213, 7.1875, 91.3333, "Prefeitura SF"},
	{0, 2447.34, 2376.4, 12.1635, 81.1664, "Prefeitura LV"},
	{0, 2232.29, -1159.76, 25.8906, 270.114, "Boate LS"},
	{0, 2691.71, -1710.13, 11.8478, 44.0051, "Autodromo LS"}
};


#define MAX_INTERIORS 					144
enum eInteriores
{
	iInterior,
	Float:iX,
	Float:iY,
	Float:iZ,
	Float:iA,
	iName[70]
}
new stock InteriorInfo[MAX_INTERIORS][eInteriores] = 
{
	{5, 770.8033, -0.7033, 1000.7267, 22.8599, "Ganton Gym"},
	{3, 974.0177, -9.5937, 1001.1484, 22.6045, "Brothel"},
	{3, 961.9308, -51.9071, 1001.1172, 95.5381, "Brothel2"},
	{3, 830.6016, 5.9404, 1004.1797, 125.8149, "Inside Track Betting"},
	{3, 1037.8276, 0.397, 1001.2845, 353.9335, "Blastin' Fools Records"},
	{3, 1212.1489, -28.5388, 1000.9531, 170.5692, "The Big Spread Ranch"},
	{18, 1290.4106, 1.9512, 1001.0201, 179.9419, "Warehouse 1"},
	{1, 1412.1472, -2.2836, 1000.9241, 114.661, "Warehouse 2"},
	{3, 1527.0468, -12.0236, 1002.0971, 350.0013, "B Dup's Apartment"},
	{2, 1523.5098, -47.8211, 1002.2699, 262.7038, "B Dup's Crack Palace"},
	{3, 612.2191, -123.9028, 997.9922, 266.5704, "Wheel Arch Angels"},
	{3, 512.9291, -11.6929, 1001.5653, 198.7669, "OG Loc's House"},
	{3, 418.4666, -80.4595, 1001.8047, 343.2358, "Barber Shop"},
	{3, 386.5259, 173.6381, 1008.3828, 63.7399, "Planning Department"},
	{3, 238.7541, 139.3179, 1003.0234, 3.7270, "Las Venturas Police Department"},
	{3, 206.4627, -137.7076, 1003.0938, 10.9347, "Pro-Laps"},
	{3, -100.2674, -22.9376, 1000.7188, 17.285, "Sex Shopn"},
	{3, -201.2236, -43.2465, 1002.2734, 45.8613, "Las Veturas Tattoo parlor"},
	{17, -202.9381, -6.7006, 1002.2734, 204.2693, "Lost San Fierro Tattoo parlor"},
	{17, -25.7220, -187.8216, 1003.5469, 5.0760, "24/7 (version 1)"},
	{5, 372.3092,-133.1233,1001.4922, 354.2285, "Pizza Stack"},
	{17, 378.026, -190.5155, 1000.6328, 141.0245, "Rusty Browns Donuts"},
	{7, 315.244, -140.8858, 999.6016, 7.4226, "Ammu-nation"},
	{5, 225.0306, -9.1838, 1002.218, 85.5322, "Victim"},
	{2, 611.3536, -77.5574, 997.9995, 320.9263, "Loco Low Co"},
	{10, 246.0688, 108.9703, 1003.2188, 0.2922, "San Fierro Police Department"},
	{10, 6.0856, -28.8966, 1003.5494, 5.0365, "24/7 (version 2 - large)"},
	{7, 773.7318, -74.6957, 1000.6542, 5.2304, "Below The Belt Gym (Las Venturas)"},
	{1, 621.4528, -23.7289, 1000.9219, 15.6789, "Transfenders"},
	{1, 445.6003, -6.9823, 1000.7344, 172.2105, "World of Coq"},
	{1, 285.8361, -39.0166, 1001.5156, 0.7529, "Ammu-nation (version 2)"},
	{1, 204.1174, -46.8047, 1001.8047, 357.5777, "SubUrban"},
	{1, 245.2307, 304.7632, 999.1484, 273.4364, "Denises Bedroom"},
	{3, 290.623, 309.0622, 999.1484, 89.9164, "Helenas Barn"},
	{5, 322.5014, 303.6906, 999.1484, 8.1747, "Barbaras Love nest"},
	{1, -2041.2334, 178.3969, 28.8465, 156.2153, "San Fierro Garage"},
	{1, -1402.6613, 106.3897, 1032.2734, 105.1356, "Oval Stadium"},
	{7, -1403.0116, -250.4526, 1043.5341, 355.8576, "8-Track Stadium"},
	{2, 1204.6689, -13.5429, 1000.9219, 350.0204, "The Pig Pen (strip club 2)"},
	{10, 2016.1156, 1017.1541, 996.875, 88.0055, "Four Dragons"},
	{1, -741.8495, 493.0036, 1371.9766, 71.7782, "Liberty City"},
	{2, 2447.8704, -1704.4509, 1013.5078, 314.5253, "Ryder's house"},
	{1, 2527.0176, -1679.2076, 1015.4986, 260.9709, "Sweets House"},
	{10, -1129.8909, 1057.5424, 1346.4141, 274.5268, "RC Battlefield"},
	{3, 2496.0549, -1695.1749, 1014.7422, 179.2174, "The Johnson House"},
	{10, 366.0248, -73.3478, 1001.5078, 292.0084, "Burger shot"},
	{1, 2233.9363, 1711.8038, 1011.6312, 184.3891, "Caligulas Casino"},
	{2, 269.6405, 305.9512, 999.1484, 215.6625, "Katies Lovenest"},
	{2, 414.2987, -18.8044, 1001.8047, 41.4265, "Barber Shop 2 (Reeces)"},
	{2, 1.1853, -3.2387, 999.4284, 87.5718, "Angel Pine Trailer"},
	{18, -30.9875, -89.6806, 1003.5469, 359.8401, "24/7 (version 3)"},
	{18, 161.4048, -94.2416, 1001.8047, 0.7938, "Zip"},
	{3, -2638.8232, 1407.3395, 906.4609, 94.6794, "The Pleasure Domes"},
	{5, 1267.8407, -776.9587, 1091.9063, 231.3418, "Madd Doggs Mansion"},
	{2, 2536.5322, -1294.8425, 1044.125, 254.9548, "Big Smokes Crack Palace"},
	{5, 2350.1597, -1181.0658, 1027.9766, 99.1864, "Burning Desire Building"},
	{1, -2158.6731, 642.09, 1052.375, 86.5402, "Wu-Zi Mus"},
	{10, 419.8936, 2537.1155, 10.0000, 67.6537, "Abandoned AC tower"},
	{14, 256.9047, -41.6537, 1002.0234, 85.8774, "Wardrobe/Changing room"},
	{14, 204.1658, -165.7678, 1000.5234, 181.7583, "Didier Sachs"},
	{12, 1133.35, -7.8462, 1000.6797, 165.8482, "Casino (Redsands West)"},
	{14, -1420.4277, 1616.9221, 1052.5313, 159.1255, "Kickstart Stadium"},
	{17, 493.1443, -24.2607, 1000.6797, 356.9864, "Club"},
	{18, 1727.2853, -1642.9451, 20.2254, 172.4193, "Atrium"},
	{16, -202.842, -24.0325, 1002.2734, 252.8154, "Los Santos Tattoo Parlor"},
	{5, 2233.6919, -1112.8107, 1050.8828, 8.6483, "Safe House group 1"},
	{6, 1211.2484, 1049.0234, 359.941, 170.9341, "Safe House group 2"},
	{9, 2319.1272, -1023.9562, 1050.2109, 167.3959, "Safe House group 3"},
	{10, 2261.0977, -1137.8833, 1050.6328, 266.88, "Safe House group 4"},
	{17, -944.2402, 1886.1536, 5.0051, 179.8548, "Sherman Dam"},
	{16, -26.1856, -140.9164, 1003.5469, 2.9087, "24/7 (version 4)"},
	{15, 2217.281, -1150.5349, 1025.7969, 273.7328, "Jefferson Motel"},
	{1, 1.5491, 23.3183, 1199.5938, 359.9054, "Jet Interior"},
	{1, 681.6216, -451.8933, -25.6172, 166.166, "The Welcome Pump"},
	{3, 234.6087, 1187.8195, 1080.2578, 349.4844, "Burglary House X1"},
	{2, 225.5707, 1240.0643, 1082.1406, 96.2852, "Burglary House X2"},
	{1, 224.288, 1289.1907, 1082.1406, 359.868, "Burglary House X3"},
	{5, 239.2819, 1114.1991, 1080.9922, 270.2654, "Burglary House X4"},
	{15, 207.5219, -109.7448, 1005.1328, 358.62, "Binco"},
	{15, 295.1391, 1473.3719, 1080.2578, 352.9526, "4 Burglary houses"},
	{15, -1417.8927, 932.4482, 1041.5313, 0.7013, "Blood Bowl Stadium"},
	{12, 446.3247, 509.9662, 1001.4195, 330.5671, "Budget Inn Motel Room"},
	{0, 2306.3826, -15.2365, 26.7496, 274.49, "Palamino Bank"},
	{0, 2331.8984, 6.7816, 26.5032, 100.2357, "Palamino Diner"},
	{0, 663.0588, -573.6274, 16.3359, 264.9829, "Dillimore Gas Station"},
	{18, -227.5703, 1401.5544, 27.7656, 269.2978, "Lil Probe Inn"},
	{0, -688.1496, 942.0826, 13.6328, 177.6574, "Torrenos Ranch"},
	{0, -1916.1268, 714.8617, 46.5625, 152.2839, "Zombotech - lobby area"},
	{0, 818.7714, -1102.8689, 25.794, 91.1439, "Crypt in LS cemetery (temple)"},
	{0, 255.2083, -59.6753, 1.5703, 1.4645, "Blueberry Liquor Store"},
	{2, 446.626, 1397.738, 1084.3047, 343.9647, "Pair of Burglary Houses"},
	{5, 227.3922, 1114.6572, 1080.9985, 267.459, "Crack Den"},
	{5, 227.7559, 1114.3844, 1080.9922, 266.2624, "Burglary House X11"},
	{4, 261.1165, 1287.2197, 1080.2578, 178.9149, "Burglary House X12"},
	{4, 291.7626, -80.1306, 1001.5156, 290.2195, "Ammu-nation (version 3)"},
	{4, 449.0172, -88.9894, 999.5547, 89.6608, "Jays Diner"},
	{4, -27.844, -26.6737, 1003.5573, 184.3118, "24/7 (version 5)"},
	{0, 2135.2004, -2276.2815, 20.6719, 318.59, "Warehouse 3"},
	{4, 306.1966, 307.819, 1003.3047, 203.1354, "Michelles Love Nest"},
	{10, 24.3769, 1341.1829, 1084.375, 8.3305, "Burglary House X14"},
	{1, 963.0586, 2159.7563, 1011.0303, 175.313, "Sindacco Abatoir"},
	{0, 2548.4807, 2823.7429, 10.8203, 270.6003, "K.A.C.C. Military Fuels Depot"},
	{0, 215.1515, 1874.0579, 13.1406, 177.5538, "Area 69"},
	{4, 221.6766, 1142.4962, 1082.6094, 184.9618, "Burglary House X13"},
	{12, 2323.7063, -1147.6509, 1050.7101, 206.5352, "Unused Safe House"},
	{6, 344.9984, 307.1824, 999.1557, 193.643, "Millies Bedroom"},
	{12, 411.9707, -51.9217, 1001.8984, 173.3449, "Barber Shop"},
	{4, -1421.5618, -663.8262, 1059.5569, 170.9341, "Dirtbike Stadium"},
	{6, 773.8887, -47.7698, 1000.5859, 10.7161, "Cobra Gym"},
	{6, 246.6695, 65.8039, 1003.6406, 7.9562, "Los Santos Police Department"},
	{14, -1864.9434, 55.7325, 1055.5276, 85.8541, "Los Santos Airport"},
	{4, -262.1759, 1456.6158, 1084.3672, 82.459, "Burglary House X15"},
	{5, 22.861, 1404.9165, 1084.4297, 349.6158, "Burglary House X16"},
	{5, 140.3679, 1367.8837, 1083.8621, 349.2372, "Burglary House X17"},
	{3, 1494.8589, 1306.48, 1093.2953, 196.065, "Bike School"},
	{14, -1813.213, -58.012, 1058.9641, 335.3199, "Francis International Airport"},
	{16, -1401.067, 1265.3706, 1039.8672, 178.6483, "Vice Stadium"},
	{6, 234.2826, 1065.229, 1084.2101, 4.3864, "Burglary House X18"},
	{6, -68.5145, 1353.8485, 1080.2109, 3.5742, "Burglary House X19"},
	{6, -2240.1028, 136.973, 1035.4141, 269.0954, "Zeros RC Shop"},
	{6, 297.144, -109.8702, 1001.5156, 20.2254, "Ammu-nation (version 4)"},
	{6, 316.5025, -167.6272, 999.5938, 10.3031,"Ammu-nation (version 5)"},
	{15, -285.2511, 1471.197, 1084.375, 85.6547, "Burglary House X20"},
	{6, -26.8339, -55.5846, 1003.5469, 3.9528, "24/7 (version 6)"},
	{6, 442.1295, -52.4782, 999.7167, 177.9394, "Secret Valley Diner"},
	{2, 2182.2017, 1628.5848, 1043.8723, 224.8601, "Rosenbergs Office in Caligulas"},
	{6, 748.4623, 1438.2378, 1102.9531, 0.6069, "Fanny Batters Whore House"},
	{8, 2807.3604, -1171.7048, 1025.5703, 193.7117, "Colonel Furhbergers"},
	{9, 366.0002, -9.4338, 1001.8516, 160.528, "Cluckin Bell"},
	{1, 2216.1282, -1076.3052, 1050.4844, 86.428, "The Camels Toe Safehouse"},
	{1, 2268.5156, 1647.7682, 1084.2344, 99.7331, "Caligulas Roof"},
	{2, 2236.6997, -1078.9478, 1049.0234, 2.5706, "Old Venturas Strip Casino"},
	{3, -2031.1196, -115.8287, 1035.1719, 190.1877, "Driving School"},
	{8, 2365.1089, -1133.0795, 1050.875, 177.3947, "Verdant Bluffs Safehouse"},
	{0, 1168.512, 1360.1145, 10.9293, 196.5933, "Bike School"},
	{9, 315.4544, 976.5972, 1960.8511, 359.6368, "Andromada"},
	{10, 1893.0731, 1017.8958, 31.8828, 86.1044, "Four Dragons Janitors Office"},
	{11, 501.9578, -70.5648, 998.7578, 171.5706, "Bar"},
	{8, -42.5267, 1408.23, 1084.4297, 172.068, "Burglary House X21"},
	{11, 2283.3118, 1139.307, 1050.8984, 19.7032, "Willowfield Safehouse"},
	{9, 84.9244, 1324.2983, 1083.8594, 159.5582, "Burglary House X22"},
	{9, 260.7421, 1238.2261, 1084.2578, 84.3084, "Burglary House X23"},
	{0, -1658.1656, 1215.0002, 7.25, 103.9074, "Ottos Autos"},
	{0, -1961.6281, 295.2378, 35.4688, 264.4891, "Wang Cars"}
};

stock GetInteriorInformation(interiorid, interior_name[]="", &Float:eX=0.0, &Float:eY=0.0, &Float:eZ=0.0, &Float:eA=0.0, &Interior=0)
{
	if(interiorid < -1 || interiorid > sizeof(InteriorInfo))
		return false;

	format(interior_name, 70, InteriorInfo[interiorid][iName]);
	eX = InteriorInfo[interiorid][iX];
	eY = InteriorInfo[interiorid][iY];
	eZ = InteriorInfo[interiorid][iZ];
	eA = InteriorInfo[interiorid][iA];
	Interior = InteriorInfo[interiorid][iInterior];
	return true;
}

stock Exit(){
	return SendRconCommand(#exit);
}

#define VERIFY_HEX_10				10
#define VERIFY_HEX_8				8
#define VERIFY_HEX_6				6
stock IsValidHex(const code[], max_len_verify = VERIFY_HEX_10)
{
	new count;

	if(strlen(code) != max_len_verify)
		return false;

	if(max_len_verify == 10 && strfind(code, "x", true) == 1)
	{
		new x;

		for(new i; i < max_len_verify; i++)
		{
			switch(code[i])
			{
				case 'A','B','C','D','E','F','a','b','c','d','e','f','0','1','2','3','4','5','6','7','8','9':
					++count;
				case 'x':
					++x, ++count;
			}
		}
		if(count == max_len_verify  && x == 1) return true;
	}
	else
	{
		for(new i; i < max_len_verify; i++)
		{
			switch(code[i])
			{
				case 'A','B','C','D','E','F','a','b','c','d','e','f','0','1','2','3','4','5','6','7','8','9':
					++count;
			}
		}
		if(max_len_verify == count) return true;
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

enum e_SOUNDS
{
	SOUND_NO_SOUND,
	SOUND_ERRO,
	SOUND_CLICK_SUCESS,
	SOUND_CLICK_ERROR,
	SOUND_BOMB_TANQUE,
}
static sounds[e_SOUNDS] =
{
	654465654,
	1085,
	1083,
	1085,
	6000
};

stock SoundForPlayer(playerid, e_SOUNDS:sound)
{
	return PlayerPlaySound(playerid, sounds[sound], 0.0, 0.0, 0.0);
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
		case 3:mesF__="Marco";
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


#define GetPlayerFramerate(%0) \
	(g_PlayerFramerate[%0])

new stock g_PlayerFramerate [MAX_PLAYERS];

public OnPlayerUpdate(playerid)
{
	static old_drunk [MAX_PLAYERS];

	new new_drunk = GetPlayerDrunkLevel(playerid);
	if(new_drunk <= 100)
		SetPlayerDrunkLevel(playerid, 2000);
	else if(new_drunk != old_drunk[playerid])
	{
		new framerate = old_drunk[playerid] - new_drunk;
		if(framerate > 0)
			g_PlayerFramerate[playerid] = framerate;

		old_drunk[playerid] = new_drunk;
	}
	#if defined utils_OnPlayerUpdate
		return utils_OnPlayerUpdate(playerid);
	#else
		return 1;
	#endif
}


#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif

#define OnPlayerUpdate utils_OnPlayerUpdate

#if defined utils_OnPlayerUpdate
	forward utils_OnPlayerUpdate(playerid);
#endif


/// corrigir erro de string1 e string2 vazios

stock strcmpfix(const string1[], const string2[], bool:ignorecase=false, length=cellmax)
{
	return (strcmp(string1, string2, ignorecase, length) && (!isnull(string1) && !isnull(string2) ) );
}

#if defined _ALS_strcmp
	#undef strcmp
#else
	#define _ALS_strcmp
#endif

#define strcmp strcmpfix

stock formatSeconds(seconds, &hours_left, &minutes_left, &seconds_left)
{
    hours_left = seconds/60/60;
    minutes_left = (seconds - hours_left*60*60)/60;
    seconds_left = (seconds - hours_left*60*60 - minutes_left*60);
    return 1;
}

static FreezTimer[MAX_PLAYERS]=-1;
stock FreezePlayer(playerid, time=0)
{
	TogglePlayerControllable(playerid, false);
	
	if (FreezTimer[playerid] != -1)
		KillTimer(FreezTimer[playerid]);

	if (time)
		FreezTimer[playerid] = SetTimerEx("unFreezePlayer", time * 1000, false, "i", playerid);

	return true;
}

forward unFreezePlayer(playerid);
public unFreezePlayer(playerid)
{
	if ( !IsPlayerConnected(playerid) )
		return false;

	TogglePlayerControllable(playerid, true);
	return true;
}


public OnPlayerDisconnect(playerid, reason)
{
	if ( FreezTimer[playerid] != -1)
		KillTimer(FreezTimer[playerid]);

	FreezTimer[playerid]=-1;
	#if defined utils_OnPlayerDisconnect
		return utils_OnPlayerDisconnect(playerid);
	#else
		return true;
	#endif
}


#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	OnPlayerDisconnect
#endif

#define OnPlayerDisconnect utils_OnPlayerDisconnect

#if defined utils_OnPlayerDisconnect
	forward utils_OnPlayerDisconnect(playerid);
#endif

#define BitFlag_Set(%0,%1) %0 |= %1
#define BitFlag_Clear(%0,%1) %0 &= ~%1
#define BitFlag_Get(%0,%1) ((%0 & %1) == %1)
#define BitFlag_Toggle(%0,%1) %0 ^= %1


const _strlib_med_string = 256;
stock str_replace(sSearch[], sReplace[], const sSubject[], &iCount = 0)
{
	new
		iLengthTarget = strlen(sSearch),
		iLengthReplace = strlen(sReplace),
		iLengthSource = strlen(sSubject),
		iItterations = (iLengthSource - iLengthTarget) + 1;

	new
		sTemp[128],
		sReturn[_strlib_med_string];

	strcat(sReturn, sSubject, _strlib_med_string);
	iCount = 0;

	for(new iIndex; iIndex < iItterations; ++iIndex)
	{
		strmid(sTemp, sReturn, iIndex, (iIndex + iLengthTarget), (iLengthTarget + 1));

		if(!strcmp(sTemp, sSearch, false))
		{
			strdel(sReturn, iIndex, (iIndex + iLengthTarget));
			strins(sReturn, sReplace, iIndex, iLengthReplace);

			iIndex += iLengthTarget;
			iCount++;
		}
	}

	return sReturn;
}

stock str_replace_to_char(string[], len, max_len = sizeof(string))
{
	for(new i; i < len; i++)
	{

		if ( i >= max_len  )
			break;

		string[i] = '.';
	}
	return true;
}

stock IsVehicleInRangeOfPoint(vehicleid, Float:range, Float:x, Float:y, Float:z)
{
	return range >= GetVehicleDistanceFromPoint(vehicleid, x, y, z); 
}

stock GetVehicleIdToRadiu(vehicleid, Float:radius)
{
	if ( !IsValidVehicle(vehicleid) )
		return INVALID_VEHICLE_ID;

	new 
		Float:dis, Float:old_dis=99999.0, vehid = INVALID_VEHICLE_ID,
		Float:x, Float:y, Float:z, Float:o_x, Float:o_y, Float:o_z;

	GetVehiclePos(vehicleid, x, y, z);

	foreach(new search_vehicle: Vehicle)
	{
		if ( search_vehicle == vehicleid )
			continue;

		GetVehiclePos(search_vehicle, o_x, o_y, o_z);
		dis = GetDistanceBetweenPoints(x, y, z, o_x, o_y, o_z);
		if ( (dis < old_dis) && dis <= radius)
		{
			old_dis = dis;
			vehid = search_vehicle;
		}
	}
	return vehid;
}

stock InRangeOfAnyCar(playerid)
{
	new Float:VehPos[3], id = -1;
	for(new I = 0; I < GetVehiclePoolSize(); I++)
	{
		GetVehiclePos(I, VehPos[0], VehPos[1], VehPos[2]);
		if(IsPlayerInRangeOfPoint(playerid, 5.0, VehPos[0], VehPos[1], VehPos[2]))
		{
			id = I;
 			break;
		}
	}
	return id;
}

stock GetPlayerDistanceToVehicle(playerid, vehicleid)
{
	new Float:PCoords[3], Float:VCoords[3];
	GetPlayerPos(playerid, PCoords[0], PCoords[1], PCoords[2]);
	GetVehiclePos(vehicleid, VCoords[0], VCoords[1], VCoords[2]);
	new Float:Distance[4];
	for(new n=0; n<3; n++)
	{

		Distance[n] = floatabs(PCoords[n]) - floatabs(VCoords[n]);
	}
	Distance[3] = floatsqroot((Distance[0] * Distance[0]) + (Distance[1] * Distance[1]) + (Distance[2] * Distance[2]));
	return _:Distance[3];
}

stock GetPlayerVehicleProx(playerid)
{
	new nearest[2] = {-1, -1};
	for(new v=0; v < MAX_VEHICLES; v++)
	{
		if(GetVehicleModel(v) == 453)
		{
			if(nearest[0] == -1)
			{
				nearest[0] = v;
				nearest[1] = floatround(GetPlayerDistanceToVehicle(playerid, v));
			}
			else
			{
				if(floatround(GetPlayerDistanceToVehicle(playerid, v)) < nearest[1])
				{
					nearest[0] = v;
					nearest[1] = floatround(GetPlayerDistanceToVehicle(playerid, v));
				}
			}
		}
	}
	return nearest[0];
}

new PlayerText:WantedInfo[MAX_PLAYERS], WantedLevel[MAX_PLAYERS];
stock SetPlayerWantedLevel_util(playerid, level)
{
	WantedLevel[playerid] = level;
	if ( level > 6 )
	{
		static info[11];
		format(info, sizeof(info), "+%d", (level - 6) );

		if ( WantedInfo[playerid] == INVALID_PLAYER_TEXT_DRAW )
		{
			WantedInfo[playerid] = CreatePlayerTextDraw(playerid, 496.550811, 105.599472, "_");
			PlayerTextDrawLetterSize(playerid, WantedInfo[playerid], 0.403410, 1.798334);
			PlayerTextDrawAlignment(playerid, WantedInfo[playerid], 3);
			PlayerTextDrawColor(playerid, WantedInfo[playerid], -5963521);
			PlayerTextDrawSetShadow(playerid, WantedInfo[playerid], 1);
			PlayerTextDrawSetOutline(playerid, WantedInfo[playerid], 1);
			PlayerTextDrawBackgroundColor(playerid, WantedInfo[playerid], 255);
			PlayerTextDrawFont(playerid, WantedInfo[playerid], 1);
			PlayerTextDrawSetProportional(playerid, WantedInfo[playerid], 1);
			PlayerTextDrawSetShadow(playerid, WantedInfo[playerid], 1);

			PlayerTextDrawShow(playerid, WantedInfo[playerid]);
		}
		PlayerTextDrawSetString(playerid, WantedInfo[playerid], info);
	}
	else
	{
		if ( WantedInfo{playerid} != INVALID_PLAYER_TEXT_DRAW )
		{
			PlayerTextDrawDestroy(playerid, WantedInfo[playerid]);
			WantedInfo{playerid} = INVALID_PLAYER_TEXT_DRAW;
		}	
	}
	return SetPlayerWantedLevel(playerid, (level > 250 ? 250 : level));
}
#if defined _ALS_SetPlayerWantedLevel
	#undef SetPlayerWantedLevel
#else
	#define _ALS_SetPlayerWantedLevel
#endif 

#define SetPlayerWantedLevel SetPlayerWantedLevel_util

stock ClearAnimations_util(playerid)
{
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);
	return ClearAnimations(playerid);
}

#if defined _ALS_ClearAnimations
	#undef ClearAnimations
#else
	#define _ALS_ClearAnimations
#endif 

#define ClearAnimations ClearAnimations_util




stock GetPlayerWantedLevel_util(playerid)
{
	return WantedLevel[playerid];
}
#if defined _ALS_GetPlayerWantedLevel
	#undef GetPlayerWantedLevel
#else
	#define _ALS_GetPlayerWantedLevel
#endif 

#define GetPlayerWantedLevel GetPlayerWantedLevel_util




stock GetPlayerPos_util(playerid, &Float:x, &Float:y, &Float:z)
{
	if ( !IsPlayerConnected(playerid) )
		return false;

	GetPlayerPos(playerid, x, y, z);

	x = x > 9999.0 || x < -9999.0  ? 0.0 : x;
	y = y > 9999.0 || y < -9999.0  ? 0.0 : y;
	z = z > 9999.0 || z < -9999.0  ? 0.0 : z;
	return true;
}
#if defined _ALS_GetPlayerPos
	#undef GetPlayerPos
#else
	#define _ALS_GetPlayerPos
#endif 

#define GetPlayerPos GetPlayerPos_util

/**
*
*	Hooks
*
**/
#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid)
{
	WantedInfo[playerid] = INVALID_PLAYER_TEXT_DRAW;
}

#define CAR 0
#define BIKE 1
#define MOTORBIKE 2

stock GetVehicleDoorsDamageStatus(vehicleid, &FrontLeft, &FrontRight, &RearLeft, &RearRight)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	FrontLeft = Doors >> 16 & 7;
	FrontRight = Doors >> 24 & 7;
	RearLeft = Doors >> 32 & 7;
	RearRight = Doors >> 40 & 7;
	return true;
}

stock GetVehicleLightsDamageStatus(vehicleid, &First, &Second, &Third, &Fourth)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	First = Lights & 1;
	Second = Lights >> 1 & 1;
	Third = Lights >> 2 & 1;
	Fourth = Lights >> 3 & 1;
	return true;
}

stock GetVehicleTiresDamageStatus(vehicleid, &FrontLeft, &FrontRight, &RearLeft, &RearRight)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);

	if(GetVehicleModel(vehicleid) == MOTORBIKE || GetVehicleModel(vehicleid) == BIKE) FrontLeft = Tires >> 1 & 1, FrontRight = Tires & 1;
	else
	{
		RearRight = Tires & 1;
		FrontRight = Tires >> 1 & 1;
		RearLeft = Tires >> 2 & 1;
		FrontLeft = Tires >> 3 & 1;
	}
	return true;
}

stock GetVehiclePanelsDamageStatus(vehicleid, &FrontLeft, &FrontRight, &RearLeft, &RearRight, &WindShield, &FrontBumper, &RearBumper)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	FrontLeft = Panels & 15;
	FrontRight = Panels >> 4 & 15;
	RearLeft = Panels >> 8 & 15;
	RearRight = Panels >> 12 & 15;
	WindShield = Panels >> 16 & 15;
	FrontBumper = Panels >> 20 & 15;
	RearBumper = Panels >> 24 & 15;
	return true;
}

stock UpdateVehicleDoorsDamageStatus(vehicleid, FrontLeft, FrontRight, RearLeft, RearRight)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	return UpdateVehicleDamageStatus(vehicleid, Panels, (FrontLeft << 16) | (FrontRight << 24) | (RearLeft << 32) | (RearRight << 40), Lights, Tires);
}

stock UpdateVehicleLightsDamageStatus(vehicleid, First, Second, Third, Fourth)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	return UpdateVehicleDamageStatus(vehicleid, Panels, Doors, First | (Second << 1) | (Third << 2) | (Fourth << 3), Tires);
}

stock UpdateVehicleTiresDamageStatus(vehicleid, FrontLeft, FrontRight, RearLeft, RearRight)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	if(GetVehicleModel(vehicleid) == MOTORBIKE || GetVehicleModel(vehicleid) == BIKE) return UpdateVehicleDamageStatus(vehicleid, Panels, Doors, Lights, FrontRight | (FrontLeft << 1));
	else return UpdateVehicleDamageStatus(vehicleid, Panels, Doors, Lights, RearRight | (FrontRight << 1) | (RearLeft << 2) | (FrontLeft << 3));
}

stock UpdateVehiclePanelsDamageStatus(vehicleid, FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	return UpdateVehicleDamageStatus(vehicleid, FrontLeft | (FrontRight << 4) | (RearLeft << 8) | (RearRight << 12) | (WindShield << 16) | (FrontBumper << 20) | (RearBumper << 24), Doors, Lights, Tires);
}

stock PlayerToPoint(playerid, Float:radi, Float:x, Float:y, Float:z)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))){
			return true;
		}
	}
	return 0;
}

IsABike(vehicleid)
{
    new model = GetVehicleModel(vehicleid);
    
    switch(model)
    {
        case 509, 481, 510: return 1;
    }
    
    return 0;
}

/*IsAMotorBike(vehicleid)
{
    new model = GetVehicleModel(vehicleid);
    
    switch(model)
    {
        case 509, 481, 510, 462, 448, 581, 522, 461, 421, 523, 463, 586, 468, 471: return 1;
    }
    
    return 0;
}*/

stock GetVehicleSpeeed(playerid)
{
    new Float:ST[4];

    if(IsPlayerInAnyVehicle(playerid))
    	GetVehicleVelocity(GetPlayerVehicleID(playerid), ST[0], ST[1], ST[2]);
    else
    	GetPlayerVelocity(playerid, ST[0], ST[1], ST[2]);

    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 179.28625;
    return floatround(ST[3]);
}

IsATrailerAttached(vehicleid)
{
    for(new i = 1, j = GetVehiclePoolSize(); i <= j; i++)
    {
        if(GetVehicleTrailer(i) == vehicleid)
            return true;
    }
    return false;
}

/*enum AntiAFKCORESRANDOM
{
    RealCode[10]
};

new CoresRandom[][AntiAFKCORESRANDOM] =
{
    {"g"},
    {"y"},
    {"b"},
    {"l"},
    {"r"},
    {"p"},
    {"n"},
    {"w~~b"},
    {"l~~p~~g"},
    {"b~~r~~l"},
    {"l~~b~~r"},
    {"n~~y"},
    {"n~~g~~n"},
    {"l~~l~~y"}
};

new CoresAFK[][AntiAFKCORESRANDOM] =
{
    {"g"},
    {"y"},
    {"b"},
    {"r"},
    {"p"}
};

new PlayerText:AntiAFKCLICKCODIGO[MAX_PLAYERS][13]; //Textdraw*/

new ANT_CARACTER[] = { "-", "+", ",", "=", "'", "*", "?", "[", "]", "`", "´", "/",
"|", "{", "}", "<", ">", "£", "³", "¢¬", "³", "²", "²", "¹", "#", "&", ")",
"(", "¹", "°", "¨", "¬", "%", "$", "!", "^", "~"};

stock CaracterEspecial(text[])
{
    for(new a; a < strlen(text); ++a){
        for(new b; b < sizeof(ANT_CARACTER); b++){
            if(text[a] == ANT_CARACTER[b]) return 0;
        }
    }
    return 1;
}

stock alfabeto [ 1 + ('Z' - 'A') ] = { 'A', 'B', ...}  ;
stock numeros [ 1 + ('9' - '0') ] = { '0', '1', ...}  ;
stock GetRandomString(size = 0xff)
{
    static stringBuff[0xff];
    if(size < 0xff && size) {
        for(new i; i != size; i++) stringBuff[i] = bool: random(2) ? numeros [random(sizeof numeros )] : alfabeto [random(sizeof alfabeto )];
        stringBuff[size] = EOS;
    }
    return stringBuff;
}

/*Float:GetPointDistanceToPoint(Float:fX1,Float:fY1,Float:fX2,Float:fY2)
{
  static Float:x, Float:y;
  x = fX1-fX2;
  y = fY1-fY2;
  return floatsqroot(x*x+y*y);
}*/
Float:GetPointDistanceToPointEx(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
  static Float:x, Float:y, Float:z;
  x = x1-x2;
  y = y1-y2;
  z = z1-z2;
  return floatsqroot(x*x+y*y+z*z);
}

/**
* NOME VEÍCULOS
*/
new carName[][] ={
  "Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
  "Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
  "Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
  "Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
  "Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
  "Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
  "Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
  "Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer","Hotring Racer",
  "Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
  "Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
  "Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
  "Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
  "Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
  "Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer","Emperor",
  "Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car","Police Car",
  "Police Car","Police Ranger","Picador","S.W.A.T.","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer","Luggage Trailer",
  "Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};

verSerial(playerid)
{
	new serialp[41];

	gpci(playerid, serialp, sizeof(serialp));
	return serialp;
}

#define gerarPIN() \
        (((random(9) + 1) * 1000) + (random(10) * 100) + (random(10) * 10) + random(10))

GetPlayerIpEx(playerid)
{
    static ip[20];
    GetPlayerIp(playerid, ip, 20);
    return ip;
}

forward rHoraMinuto(InputSec, OutputString[], OutputStringLen);
public rHoraMinuto(InputSec, OutputString[], OutputStringLen)
{
    new
      Days, Hours, Mins, Secs;

	InputSec = InputSec - gettime();
    Days = floatround((InputSec / 86400), floatround_floor); // get Days
    Secs = (InputSec - (Days * 86400));// remove days from total seconds
    Hours = floatround((Secs / 3600), floatround_floor); // get Hours
    Secs = (Secs - (Hours * 3600)); // remove Hours from secs
    Mins = floatround((Secs / 60), floatround_floor);// get Mins
    Secs = (Secs - (Mins * 60));// remove Mins from secs, whats left is seconds

	if(Days > 0)
	{
		format(OutputString, OutputStringLen, "%02d dia(s) e %02d hora(s)", Days, Hours);
	}

	else if(Days == 0)
	{
		if(Hours > 0)
		{
			format(OutputString, OutputStringLen, "%02d hora(s) e %02d minuto(s)", Hours, Mins);
		}
		
		else if(Hours == 0)
		{
			if(Mins > 0)
			{
				format(OutputString, OutputStringLen, "%02d minuto(s) e %02d segundo(s)", Mins, Secs);
			}

			else if(Mins == 0)
			{
				format(OutputString, OutputStringLen, "%02d segundo(s)", Secs);
			}
		}
	}
    return 1;
}

gerarKey(tamanho=10, bool:maiusculas=true, bool:numbers=true, bool:simbolos=false) {
    new retorno[65];
    new le[] = {"abcdefghijklmnopqrstuvwxyz"};
    new LE[] = {"ABCDEFGHIJKLMNOPQRSTUVWXYZ"};
    new num[] = {"1234567890"};
    new sim[] = {"!@#$%*-"};
    new caracteres[128];
    strcat(caracteres, le);
    if(maiusculas == true)
        strcat(caracteres, LE);
    if(numbers == true)
        strcat(caracteres, num);
    if(simbolos == true)
        strcat(caracteres, sim);
    for(new i = 0; i <= tamanho; i++) {
        retorno[i] = caracteres[random(strlen(caracteres))];
    }
    return retorno;
}

convert_encoding(const texto[])
{
	new string[256];
	for(new i = 0; texto[i]; ++i)
	{
		string[i] = texto[i];
		switch(string[i])
		{
			case 0xC0 .. 0xC3: string[i] -= 0x40;            case 0xC7 .. 0xC9: string[i] -= 0x42;            case 0xD2 .. 0xD5: string[i] -= 0x44;            case 0xD9 .. 0xDC: string[i] -= 0x47;            case 0xE0 .. 0xE3: string[i] -= 0x49;
			case 0xE7 .. 0xEF: string[i] -= 0x4B;            case 0xF2 .. 0xF5: string[i] -= 0x4D;            case 0xF9 .. 0xFC: string[i] -= 0x50;            case 0xC4, 0xE4: string[i] = 0x83;            case 0xC6, 0xE6: string[i] = 0x84;            case 0xD6, 0xF6: string[i] = 0x91;            case 0xD1, 0xF1: string[i] = 0xEC;            case 0xDF: string[i] = 0x96;            case 0xBF: string[i] = 0xAF;
		}
	}
	return string;
}