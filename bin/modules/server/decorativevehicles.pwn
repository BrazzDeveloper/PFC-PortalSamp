// VEÍCULOS DECORATIVOS

#include <YSI_Coding\y_hooks>

new DecorativeVehicles[14];

hook OnGameModeInit()
{
    DecorativeVehicles[0] = AddStaticVehicle(433,358.6864,1803.2305,18.8584,156.9523,78,162); //   BARRACKS 1
    DecorativeVehicles[1] = AddStaticVehicle(433,313.9059,2056.7498,18.0773,87.5836,78,162); //  barracks 2
    DecorativeVehicles[2] = AddStaticVehicle(432,345.2408,1817.3365,17.9394,159.9204,71,4); //  Rhino 1
    DecorativeVehicles[3] = AddStaticVehicle(432,275.9414,2025.4821,17.6478,269.4775,71,4); //  Rhino 2
    DecorativeVehicles[4] = AddStaticVehicle(432,290.3037,2035.2545,17.6480,191.6676,71,4); //  rhino 3
    DecorativeVehicles[5] = AddStaticVehicle(470,302.3629,2027.3854,17.6315,270.3288,73,134); //  Patriot 1
    DecorativeVehicles[6] = AddStaticVehicle(470,312.4740,2041.4490,17.6537,87.2031,73,134); //  Patriot 2
    DecorativeVehicles[7] = AddStaticVehicle(470,332.4526,1842.5387,17.6356,269.8290,73,134); //  Patriot 3
    DecorativeVehicles[8] = AddStaticVehicle(425,354.7962,1928.4277,20.0407,74.1207,79,117); //  Hunter 1
    DecorativeVehicles[9] = AddStaticVehicle(417,352.0818,1975.8962,19.5549,92.6182,29,182); //  CargoBob 1
    DecorativeVehicles[10] = AddStaticVehicle(520,275.9495,1955.1815,18.3638,268.3980,70,33); //  Hydra 1
    DecorativeVehicles[11] = AddStaticVehicle(520,316.9300,1976.3910,18.3638,141.7944,70,33); //  Hydra 2
    DecorativeVehicles[12] = AddStaticVehicle(476,274.9493,1988.8176,18.3483,274.5749,78,146); //  Rustler 1
    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    for(new i; i < 14; i++)
    {
        if(vehicleid == DecorativeVehicles[i])
        {
            if(!ispassenger)
            {
                SendClientMessage(playerid, COR_ERRO, "| ERRO | Este é um veículo decorativo e não poderá ser usado.");
                ClearAnimations(playerid);
                RemovePlayerFromVehicle(playerid);
            }
        }
    }
    return 1;
}