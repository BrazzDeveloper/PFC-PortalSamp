forward AntiInvSlap(playerid);
public AntiInvSlap(playerid)
{
    if(Jogador[playerid][Logado] == true)
    {
        if ( call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE )
        {
            new __s_str[200];
            if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING){
                Kick(playerid);
                SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) Administrador(a) [PFC]Betinho kickou o(a) jogador(a) {"COR_BRANCO_INC"}%s{"COR_VERMELHO_INC"} ( Motivo: Suspeita de Invisible Slap. )", GetUserName(playerid));
                format(__s_str, sizeof(__s_str), "O(A) %s foi kickado por suspeita de Invisible Slap", GetUserName(playerid));
                WriteLog(INVSLAP_LOGS, __s_str);
            }
        }
    }
    return 1;
}

// Timer: SetTimerEx("AntiSlap", 500, true, "i", playerid);