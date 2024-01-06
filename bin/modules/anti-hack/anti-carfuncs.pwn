/*public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
    if ( call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE )
    {
        new Float:VidaVeiculo;
        GetVehicleHealth(vehicleid, VidaVeiculo);
        if(VidaVeiculo < 1.0)
        {
            Kick(playerid);
            format(String, sizeof(String), "O(A) %s foi kickado por suspeita de CarFuncs", GetUserName(playerid));
            WriteLog(CARFUNCS_LOGS, String);
        }
    }
    return 0;
}*/