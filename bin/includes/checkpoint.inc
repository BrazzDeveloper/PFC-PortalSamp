
#if !defined _samp_included
	#include <a_samp>
#endif

/*
*
*	@author: 	SammyJ
*	@date: 		13/10/17
*	@version:	v0.2
*
*/

// ============================== [ Funções ] ============================== //

const RADAR_CP_COLOR = 0xFF0000FF;

static 
	dynamicCP[MAX_PLAYERS],
	enabled[MAX_PLAYERS];

stock SetPlayerCheckpoint_CP(playerid, Float:x, Float:y, Float:z, Float:size)
{
	if ( enabled[playerid] )
	{
		DisablePlayerCheckpoint_CP(playerid);
		return 0;
	}

	dynamicCP[playerid] = CreateDynamicCP(x, y, z, size, .playerid=playerid, .streamdistance=6000.0, .priority=1);
	enabled[playerid] = true;
	return 1;
}

stock DisablePlayerCheckpoint_CP(playerid)
{
	enabled[playerid] = false;
	DestroyDynamicCP(dynamicCP[playerid]);
	dynamicCP[playerid] = -1;
	return 0;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if ( checkpointid == dynamicCP[playerid] )
	{
		#if defined CP_OnPlayerEnterCheckpoint
			CallLocalFunction("CP_OnPlayerEnterCheckpoint", "d", playerid);
		#endif
		return 1;
	}
	#if defined CP_OnPlayerEnterDynamicCP
		return CP_OnPlayerEnterDynamicCP(playerid, checkpointid);
	#else
		return 1;
	#endif
}

public OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
	if ( checkpointid == dynamicCP[playerid] )
	{
		#if defined CP_OnPlayerLeaveCheckpoint
			CallLocalFunction("CP_OnPlayerLeaveCheckpoint", "d", playerid);
		#endif
		return 1;
	}
	#if defined CP_OnPlayerLeaveDynamicCP
		return CP_OnPlayerLeaveDynamicCP(playerid, checkpointid);
	#else
		return 1;
	#endif
}
// ============================== [ Hooks ] ============================== //

// == OnPlayerEnterDynamicCP
#if defined _ALS_OnPlayerEnterDynamicCP
	#undef OnPlayerEnterDynamicCP
#else
	#define _ALS_OnPlayerEnterDynamicCP
#endif

#define OnPlayerEnterDynamicCP CP_OnPlayerEnterDynamicCP

#if defined CP_OnPlayerEnterDynamicCP
	forward CP_OnPlayerEnterDynamicCP(playerid, checkpointid);
#endif


// == OnPlayerEnterCheckpoint

#if defined _ALS_OnPlayerEnterCheckpoint
	#undef OnPlayerEnterCheckpoint
#else
	#define _ALS_OnPlayerEnterCheckpoint
#endif

#define OnPlayerEnterCheckpoint CP_OnPlayerEnterCheckpoint

#if defined CP_OnPlayerEnterCheckpoint
	forward CP_OnPlayerEnterCheckpoint(playerid);
#endif


// == OnPlayerLeaveDynamicCP

#if defined _ALS_OnPlayerLeaveDynamicCP
	#undef OnPlayerLeaveDynamicCP
#else
	#define _ALS_OnPlayerLeaveDynamicCP
#endif

#define OnPlayerLeaveDynamicCP CP_OnPlayerLeaveDynamicCP

#if defined CP_OnPlayerLeaveDynamicCP
	forward CP_OnPlayerLeaveDynamicCP(playerid, checkpointid);
#endif


// == OnPlayerLeaveCheckpoint

#if defined _ALS_OnPlayerLeaveCheckpoint
	#undef OnPlayerLeaveCheckpoint
#else
	#define _ALS_OnPlayerLeaveCheckpoint
#endif

#define OnPlayerLeaveCheckpoint CP_OnPlayerLeaveCheckpoint

#if defined CP_OnPlayerLeaveCheckpoint
	forward CP_OnPlayerLeaveCheckpoint(playerid);
#endif

// ==
#define DisablePlayerCheckpoint	DisablePlayerCheckpoint_CP

// == 
#define SetPlayerCheckpoint	SetPlayerCheckpoint_CP

