forward AntiAnim(playerid);
public AntiAnim(playerid)
{
    new __Str[380];
    if ( call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE )
    {
        if(GetPlayerAnimationIndex(playerid) == 0)
        {
            if(Jogador[playerid][Logado] == true)
            {
                Kick(playerid);
                format(__Str, sizeof(__Str), "O(A) %s foi kickado por suspeita de Anim Cheat", GetUserName(playerid));
                SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) jogador(a) %s foi kickado(a) por suspeita de Anim-Cheat.", GetUserName(playerid));
                WriteLog(ANIM_LOGS, __Str);
            }
        } 

        if(GetPlayerWeapon(playerid) != WEAPON_PARACHUTE && GetPlayerAnimationIndex(playerid) == 974 ||
        GetPlayerWeapon(playerid) != WEAPON_PARACHUTE && GetPlayerAnimationIndex(playerid) == 972 ||
        GetPlayerWeapon(playerid) != WEAPON_PARACHUTE && GetPlayerAnimationIndex(playerid) == 968)
        {
            Kick(playerid);
            format(__Str, sizeof(__Str), "O(A) %s foi kickado por suspeita de Anim Cheat", GetUserName(playerid));
            SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) jogador(a) %s foi kickado(a) por suspeita de Anim-Cheat.", GetUserName(playerid));
            WriteLog(ANIM_LOGS, __Str);
        }
    }
    return 1;
}