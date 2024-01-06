
stock IsPlayerInWater(playerid)
{
    new Float:Posxxa[1];
    GetPlayerPos(playerid, Posxxa[0], Posxxa[0], Posxxa[0]);
    if(Posxxa[0] < 0.7) switch(GetPlayerAnimationIndex(playerid)) { case 1543,1538,1539: return 1; }
    if(GetPlayerDistanceFromPoint(playerid,-965,2438,42) <= 700 && Posxxa[0] < 45)return 1;
    new Float:water_places[][] =
    {
        {25.0,  2313.0, -1417.0,        23.0},
        {15.0,  1280.0, -773.0,         1082.0},
        {15.0,  1279.0, -804.0,         86.0},
        {20.0,  1094.0, -674.0,         111.0},
        {26.0,  194.0,  -1232.0,        76.0},
        {25.0,  2583.0, 2385.0,         15.0},
        {25.0,  225.0,  -1187.0,        73.0},
        {50.0,  1973.0, -1198.0,        17.0}
    };
    for(new t=0; t < sizeof water_places; t++)
            if(GetPlayerDistanceFromPoint(playerid,water_places[t][1],water_places[t][2],water_places[t][3]) <= water_places[t][0]) return 1;
    return 0;
} 


hook OnPlayerSpawn(playerid)
{
    SetTimerEx("AntiFly", 1000, true, "i", playerid);
    return 1;
}

forward AntiFly(playerid);
public AntiFly(playerid)
{
    if ( IsPlayerConnected(playerid) )
    {
        new Animacao;
        Animacao = GetPlayerAnimationIndex(playerid);
        new ___str[200];
        switch(Animacao)
        {
            case 958, 959, 972, 974:
            {
                if(!IsPlayerInWater(playerid))
                {
                    if(!IsPlayerInAnyVehicle(playerid))
                    {
                        new ArmaID;
                        new Balas;
                        GetPlayerWeaponData(playerid, 11, ArmaID, Balas);
                        if(ArmaID != 46)
                        {
                            Kick(playerid);
                            SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) jogador(a) %s foi kickado(a) por suspeita de Fly-Hack.", GetUserName(playerid));
                            format(___str, sizeof(___str), "O(A) %s foi kickado por suspeita de Fly Hack", GetUserName(playerid));
                            WriteLog(FLY_LOGS, ___str);
                        }
                    }
                }
            }
            case 1539, 1058, 1538:
            {
                if(!IsPlayerInAnyVehicle(playerid))
                {
                    if(!IsPlayerInWater(playerid))
                    {
                        Kick(playerid);
                        SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) jogador(a) %s foi kickado(a) por suspeita de Fly-Hack.", GetUserName(playerid));
                        format(___str, sizeof(___str), "O(A) %s foi kickado por suspeita de Fly Hack", GetUserName(playerid));
                        WriteLog(FLY_LOGS, ___str);
                    }
                }
            }
        }
    }
    return 1;
} 