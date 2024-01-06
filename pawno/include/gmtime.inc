/*----------------------------------------------------------------------------------------------------*-

Àâòîð:
	Fro îí æå Fro1sha
	
Îïèñàíèå:
	GMT âðåìÿ â SA:MP
 
Ïðàâà: 
    Copyright © 2009-2011 TBG
	


                            ______              __________             
                            ___  /______  __    ___  ____/____________ 
                            __  __ \_  / / /    __  /_   __  ___/  __ \
                            _  /_/ /  /_/ /     _  __/   _  /   / /_/ /
                            /_.___/_\__, /      /_/      /_/    \____/ 
                                   /____/                              
                                                                              
																				
           _______________       _________                                              
           ___  __/__  __ )      __  ____/_____ _______ ________________ ___________  __
           __  /  __  __  |_______  / __ _  __ `/_  __ `__ \  _ \_  ___/ __  ___/  / / /
           _  /   _  /_/ /_/_____/ /_/ / / /_/ /_  / / / / /  __/(__  )___  /   / /_/ / 
           /_/    /_____/        \____/  \__,_/ /_/ /_/ /_/\___//____/_(_)_/    \__,_/  
                                                                                        

	http://tb-games.ru/
	
-*----------------------------------------------------------------------------------------------------*/

#if defined _gmtime_included
  #endinput
#endif
#define _gmtime_included
#pragma library gmtime

// -------------------------------------------------------------------------------------*-

native gm_SetTimeZone(hour = 0, minute = 0);
native gm_gettime(&hour = 0, &minute = 0, &second = 0);
native gm_getdate(&year=0, &month = 0, &day = 0, &wday = 0);

native gm_strftime(const string[], dest[], size = sizeof(dest));
native gm_timestamp();
native gm_mktime(hour, minute, second, year, month, day);
native gm_timestamp_to_date(timestamp, &hour = 0, &minute = 0, &second = 0, &year = 0, &month = 0, &day = 0);

native gm_GetMonthDay(month, year = 1990);
native gm_ConvertSeconds(time, &hour = 0, &minute = 0, &second = 0, &year = 0, &month = 0, &day = 0);

// -------------------------------------------------------------------------------------*-

#if defined AUTO_SETUP

#define SetTimeZone 		gm_SetTimeZone
#define gettime 			gm_gettime
#define getdate 			gm_getdate
#define strftime 			gm_strftime
#define timestamp 			gm_timestamp
#define mktime 				gm_mktime
#define timestamp_to_date 	gm_timestamp_to_date
#define GetMonthDay 		gm_GetMonthDay
#define ConvertSeconds 		gm_ConvertSeconds

#undef AUTO_SETUP

#endif

// -------------------------------------------------------------------------------------*-

#if !defined IsLeapYear

#define IsLeapYear(%0) \
    ((!((%0) & 0x03)) && (((%0) % 100) || !((%0) % 400)))
	
#endif
	
// -------------------------------------------------------------------------------------*-

stock NOW()
{
	new result[32],year,month,day,hour,minute,second,wday;
	gm_getdate(year, month, day, wday);
	gm_gettime(hour, minute, second);
	format(result, sizeof result, "%s %02d/%02d/%d %02d:%02d:%02d", GetDayName(wday), day, month, year, hour, minute, second);
	return result;
}

// -------------------------------------------------------------------------------------*-

stock CURDATE()
{
	new result[20],year,month,day;
	gm_getdate(year, month, day);
	//format(result, sizeof result, "%d-%02d-%02d", year, month, day);
    format(result, sizeof result, "%02d/%02d/%d", day,month,year);
	return result;
}

// -------------------------------------------------------------------------------------*-

stock CURTIME()
{
	new result[20],hour,minute,second;
	gm_gettime(hour, minute, second);
	format(result, sizeof result, "%02d:%02d:%02d", hour, minute, second);
	return result;
}

// -------------------------------------------------------------------------------------*-	

stock GetMonthName(month)
{
	new result[20];
	switch (month)
	{
		case 1: result = "Janeiro";
		case 2: result = "Fevereiro";
		case 3: result = "Março";
		case 4: result = "Abril";
		case 5: result = "Maio";
		case 6: result = "Junho";
		case 7: result = "Julho";
		case 8: result = "Agosto";
		case 9: result = "Setembro";
		case 10: result = "Outubro";
		case 11: result = "Novembro";
		case 12: result = "Dezembro";
		default: result = "erro";
	}
	
 	return result;
}

// -------------------------------------------------------------------------------------*-

stock GetDayName(weekday)
{
	new result[20];
	switch (weekday)
	{
		case 1:	result = "Segunda-Feira";
		case 2:	result = "Terca-Feira";
		case 3:	result = "Quarta-Feira";
		case 4:	result = "Quinta-Feira";
		case 5:	result = "Sexta-Feira";
		case 6:	result = "Sábado";
		case 0:	result = "Domingo";
       	default: result = "erro";
	}
	
	return result;
}

// ---------------------------------------------------------------------------------------

stock GetDayNameFromDate(day, month, year) { // Nick
    new newdate, result[20];
    if(month < 3) {
        month = month + 12;
        year = year - 1;
    }
    newdate = (day + (2 * month) + ((6 * (month + 1)) / 10) + year + (year / 4) -(year / 100) + (year / 400) + 1) % 7;
    switch(newdate) {
        case 0: result = "Domingo";
        case 1: result = "Segunda-Feira";
        case 2: result = "Terca-Feira";
        case 3: result = "Quarta-Feira";
        case 4: result = "Quinta-Feira";
        case 5: result = "Sexta-Feira";
        case 6: result = "Sábado";
		default: result = "erro"; 
    }
    return result;
}

// -----------------------------------------------------------------
