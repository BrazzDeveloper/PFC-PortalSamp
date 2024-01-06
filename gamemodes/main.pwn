 
/*
*
*			@author: 			SammyJ
*			@date-begin: 		08/10/2017
*			@version:			v1.1.0
*
*/

/*
*
*			@author: 			NelsonC e LuizM
*			@date-begin: 		03/02/2021
*			@version:			v1.2.5.1
*
*/


/*
	Proxy:  http://proxy.mind-media.com/blo-ck/proxycheck.php?ip=ip
	SELECT DATEDIFF(DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY));   
*/

/*	 ____   ___  ____   _____  ___    __ ______         __  ____  ______  __ __      ____   ____   ____ 
	|    \ /  _]|    \ |     |/  _]  /  ]      |       /  ]|    ||      ||  |  |    |    \ |    \ /    |									
	|  o  )  [_ |  D  )|   __/  [_  /  /|      |      /  /  |  | |      ||  |  |    |  D  )|  o  )   __|	
	|   _/    _]|    / |  |_|    _]/  / |_|  |_|     /  /   |  | |_|  |_||  ~  |    |    / |   _/|  |  |
	|  | |   [_ |    \ |   _]    [_/   \_  |  |      /   \_  |  |   |  |  |___, |    |    \ |  |  |  |_ |
	|  | |     ||  .  \|  | |     \     | |  |      \     | |  |   |  |  |     |    |  .  \|  |  |     |
	|__| |_____||__|\_||__| |_____|\____| |__|       \____||____|  |__|  |____/     |__|\_||__|  |___._|
*/
#pragma dynamic 4500000
#pragma warning disable 218 

#include <a_samp>

#define DYNAMIC_MEMORY (65536)
#undef MAX_PLAYERS
#define MAX_PLAYERS 	(100)
#undef MAX_GANG_ZONES
#define MAX_GANG_ZONES 	(10)

#include <sscanf>
#include <a_mysql>
#include <Pawn.CMD>
#include <streamer>
#include <discord-connector>

#define DC_BOT_NAME "Rogério"
#define DC_BOT_PREFIX "r!"
#define DC_PREFIX_LENGTH 2

//#include <discord-command>
//#include <mobile>
#include <YSI_Data\y_iterate>
#include <YSI_Coding\y_timers>
#include <EVF>
#include <easyDialog>
#include <progress2>
#include <mSelection>
#include <a_zone>
#include <travaled>
#include <DOF2>
#include <SInclude>
#include <sampmailjs>
#include <gmtime>
//#include <sampvoice>
//#include <formatex>
//#include <dcc>

main()
{
	printf("Number of vehicle createds: %d", Iter_Count(Vehicle) );
}

#include "../bin/includes/utils.inc"
#include "../bin/modules/main.h"//A

public OnGameModeExit()
{
	/**
	*
	*	Kick players.
	*
	**/
	foreach(new i: Player)
		Kick(i);
	
	/**
	*
	*	Close files.
	*
	**/
	DOF2::Exit();

	/**
	*
	*	Close connections mysql.
	*
	**/
	mysql_close();
	return false;
}