public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if ( call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE )
    {
        if(hittype == BULLET_HIT_TYPE_PLAYER && hitid != INVALID_PLAYER_ID)
        {
            if(GetPVarInt(playerid, "TempoRapid") == 0 || GetPVarInt(playerid, "TempoRapid") > GetTickCount())
            {
                if(GetPVarFloat(playerid, "CuX") != 0.0 && GetPVarFloat(playerid, "CuY") != 0.0 && GetPVarFloat(playerid, "CuZ") != 0.0)
                {
                    if(GetPVarFloat(playerid, "CuX") == floatabs(fX) && GetPVarFloat(playerid, "CuY") == floatabs(fY) && GetPVarFloat(playerid, "CuZ") == floatabs(fZ))
                    {
                        SetPVarInt(playerid, "ContagemRapid", GetPVarInt(playerid, "ContagemRapid")+1);
                        if(GetPVarInt(playerid, "ContagemRapid") >= 2)
                        {
                            new s_s_str[200];
                            Kick(playerid);
                            SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) jogador(a) %s foi kickado(a) por suspeita de Shot-Repeater.", GetUserName(playerid));
                            format(s_s_str, sizeof(s_s_str), "O(A) %s foi kickado por suspeita de Shot Repeater", GetUserName(playerid));
                            WriteLog(SHOTREPEATER_LOGS, s_s_str);
                        }
                        SetPVarFloat(playerid, "CuX", floatabs(fX));
                        SetPVarFloat(playerid, "CuY", floatabs(fY));
                        SetPVarFloat(playerid, "CuZ", floatabs(fZ));
                        return 0;
                    }
                }
                else
                {
                    if(GetPVarInt(playerid, "ContagemRapid") == 0)
                    {
                        SetPVarInt(playerid, "TempoRapid", GetTickCount()+2000);
                    }
                    SetPVarFloat(playerid, "CuX", floatabs(fX));
                    SetPVarFloat(playerid, "CuY", floatabs(fY));
                    SetPVarFloat(playerid, "CuZ", floatabs(fZ));
                }
            }
            else
            {
                DeletePVar(playerid, "ContagemRapid");
                DeletePVar(playerid, "TempoRapid");
                DeletePVar(playerid, "CuX");
                DeletePVar(playerid, "CuY");
                DeletePVar(playerid, "CuZ");

            }
        }
    }
    return 1;
} 