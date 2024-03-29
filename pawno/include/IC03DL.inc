/*
	IsClient03DL:
	Allow connections from 0.3.DL to SA-MP 0.3.7 server
	
	Adrian Graber
*/

#if defined A_IC03DL_
    #endinput
#endif
#define A_IC03DL_

#if ! defined PAWNRAKNET_INC_
	#error You must have Pawn.Raknet include in order to use this include.
#endif

/*Variables*/
static bool:IC03DL_IsClient03DL[MAX_PLAYERS char];
	
/*Callbacks*/
public OnIncomingRPC(playerid, rpcid, BitStream:bs)
{
	if(rpcid == 0x19)
	{
		new iVersion,
			byteMod,
			byteNameLen,
			NickName[24],
			uiClientChallengeResponse,
			byteAuthBSLen,
			auth_bs[4*16],
			iClientVerLen,
			ClientVersion[30];

		BS_ReadValue(
			bs,
			PR_INT32, iVersion,
			PR_UINT8, byteMod,
			PR_UINT8, byteNameLen,
			PR_STRING, NickName, byteNameLen,
			PR_UINT32, uiClientChallengeResponse,
			PR_UINT8, byteAuthBSLen,
			PR_STRING, auth_bs, byteAuthBSLen,
			PR_UINT8, iClientVerLen,
			PR_STRING, ClientVersion, iClientVerLen
		);

		IC03DL_IsClient03DL{playerid} = false;
		
		if(strcmp(ClientVersion, "0.3.DL-R1") == 0)
		{
			IC03DL_IsClient03DL{playerid} = true;

			new uiChallenge = uiClientChallengeResponse ^ iVersion;
			iVersion = 4057;

			//fix and solve challenge
			uiClientChallengeResponse = uiChallenge ^ iVersion;
			

			iClientVerLen = 5;
			new ClientVersionP[6] = "0.3.7"; //

			BS_Reset(bs);

			BS_WriteValue(
				bs,
				PR_INT32, iVersion,
				PR_UINT8, byteMod,
				PR_UINT8, byteNameLen,
				PR_STRING, NickName,
				PR_UINT32, uiClientChallengeResponse,
				PR_UINT8, byteAuthBSLen,
				PR_STRING, auth_bs,
				PR_UINT8, iClientVerLen,
				PR_STRING, ClientVersionP
			);
		}

		BS_ResetReadPointer(bs);
		BS_ResetWritePointer(bs);
		
	}
	
	#if defined IC03DL_OnIncomingRPC
		return IC03DL_OnIncomingRPC(playerid, rpcid, BitStream:bs);
	#else
		return 1;
	#endif
}

/*Functions*/
stock IsClient03DL(playerid)
{
	if(0 <= playerid < MAX_PLAYERS)
	{
		return IC03DL_IsClient03DL{playerid};
	}
	return 0;
}

stock IC03DL_GetPlayerVersion(playerid, version_string[], len)
{
	if(0 <= playerid < MAX_PLAYERS)
	{
		if(IC03DL_IsClient03DL{playerid})
		{
			strcat((version_string[0] = EOS, version_string), "0.3.DL-R1", len);
		}
		else
		{
			GetPlayerVersion(playerid, version_string, len);
		}
		return 1;
	}
	return 0;
}

/*Hooks*/
#if defined _ALS_OnIncomingRPC
#undef OnIncomingRPC
#else
#define _ALS_OnIncomingRPC
#endif
#define OnIncomingRPC IC03DL_OnIncomingRPC

#if defined IC03DL_OnIncomingRPC
forward IC03DL_OnIncomingRPC(playerid, rpcid, BitStream:bs);
#endif

#if defined _ALS_GetPlayerVersion
#undef GetPlayerVersion
#else
#define _ALS_GetPlayerVersion
#endif
#define GetPlayerVersion IC03DL_GetPlayerVersion
