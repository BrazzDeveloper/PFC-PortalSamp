// NEW SYSTEM: Vehicle Attached Objects

/* ----         Started at 16/05/2021 - 14:55                                                     */
/* ----         Author: Luiz "LuizM" Henrique                                                     */
/* ----         Credits: HarryPotter (suggestion)                                                 */
/* ----         Finished at 16/05/2021 - 04:24                                                    */
/* ----         First patch: 16/05/2021 - 04:24 - 625 lines                                       */

#include <YSI_Coding\y_hooks>

#define MAX_OBJECTS_PER_VEHICLE  5

enum __CompraObject
{
    bool:Viewing
}
new pCompraObject[MAX_PLAYERS][__CompraObject];

function VEHOBJECTS::CreateMap()
{
    CreateDynamicObject(18647, 1652.91333, 2199.78174, 14.67292,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(18647, 1652.91577, 2197.82104, 14.67290,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(18647, 1652.91736, 2195.81006, 14.67290,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(18647, 1652.92651, 2193.79053, 14.67290,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(18647, 1652.92627, 2191.83643, 14.67290,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(18647, 1652.91992, 2189.81372, 14.67290,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(18647, 1653.75256, 2187.22632, 14.67290,   0.30000, 0.06000, 45.65999);
    CreateDynamicObject(18647, 1655.53906, 2186.34058, 14.69290,   0.30000, 1.80000, 90.12000);
    CreateDynamicObject(18647, 1657.30017, 2186.34033, 14.67290,   0.30000, 1.80000, 90.11998);
    CreateDynamicObject(18647, 1659.25867, 2186.34619, 14.67290,   0.30000, 1.80000, 90.11998);
    CreateDynamicObject(18647, 1661.20471, 2186.35815, 14.67290,   0.30000, 1.80000, 90.11998);
    CreateDynamicObject(18647, 1663.08130, 2187.26611, 14.67290,   0.30000, 1.80000, 136.37994);
    CreateDynamicObject(18647, 1663.90417, 2189.06372, 14.67290,   0.54000, 10.80000, 180.11961);
    CreateDynamicObject(18647, 1663.90540, 2191.03076, 14.65290,   0.54000, 10.80000, 180.11960);
    CreateDynamicObject(18647, 1663.90796, 2192.99219, 14.63290,   0.54000, 10.80000, 180.11960);
    CreateDynamicObject(18647, 1663.89600, 2194.95532, 14.61290,   0.54000, 10.80000, 180.11960);
    CreateDynamicObject(18647, 1663.87024, 2196.94482, 14.59290,   0.54000, 10.80000, 180.11960);
    CreateDynamicObject(18647, 1663.87183, 2198.94751, 14.57290,   0.54000, 10.80000, 180.11960);
    CreateDynamicObject(18647, 1663.84497, 2199.86719, 14.57290,   0.54000, 10.80000, 180.11960);
    CreateDynamicObject(3785, 1623.78809, 2200.59668, 15.88146,   0.00000, 0.00000, 266.00000);
    CreateDynamicObject(3785, 1637.91138, 2200.62402, 15.88150,   0.00000, 0.00000, 266.00000);
    CreateDynamicObject(3785, 1652.44470, 2200.58130, 15.88150,   0.00000, 0.00000, 266.00000);
    CreateDynamicObject(18014, 1617.87683, 2185.52881, 10.24460,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(18014, 1617.87683, 2190.16455, 10.24460,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(18014, 1617.87683, 2194.80542, 10.24460,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(18014, 1617.87683, 2199.43896, 10.24460,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3785, 1663.04382, 2200.60400, 15.65250,   0.00000, 0.00000, -87.77996);
    CreateDynamicObject(3785, 1664.18274, 2208.47852, 13.81250,   0.00000, 0.00000, -7.61994);

    CreateDynamicPickup(1239, 1, 1658.4735,2199.8977,10.8203);
    CreateDynamic3DTextLabel("Loja de Acessórios\nAperte '{ffff00}Y{ffffff}' para comprar acessórios", -1, 1658.4735,2199.8977,10.8203, 10.0);

    return 1;
}

function BUYOBJECTS::ResetVariables(playerid)
{
    pCompraObject[playerid][Viewing] = false;
    return 1;
}

hook OnGameModeInit()
{
    call::VEHOBJECTS->CreateMap();
    return 1;
}

hook OnPlayerConnect(playerid)
{
    call::BUYOBJECTS->ResetVariables(playerid);
    RemoveBuildingForPlayer(playerid, 1257, 1636.3750, 2182.3672, 11.0938, 0.25);
    return 1;
}

hook OnPlayerDisconnect(playerid)
{
    call::BUYOBJECTS->ResetVariables(playerid);
    return 1;   
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_YES)
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1658.4735,2199.8977,10.8203))
        {
            ShowPlayerDialog(playerid, DIALOG_VEH_OBJECTS, DIALOG_STYLE_LIST, "{ffffff}Objetos Disponíveis", "Pranchas\nCaixa de Ferramenta\nSkate\nBolas\nPlaca de Táxi\nCaixa de Som\nAerofólio\nCaixão\nMala", "Selecionar", "Cancelar");
        }
    }
    return 1;
}

Dialog:DIALOG_VEH_OBJECTS(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0: // Pranchas
            {
                new String[200];
                strcat(String, "{ffffff}Objeto\t{ffffff}Valor\n");
                strcat(String, "{ffffff}Prancha 1\t{31b404}R$5.000\n");
                strcat(String, "{ffffff}Prancha 2\t{31b404}R$5.000\n");
                strcat(String, "{ffffff}Prancha 3\t{31b404}R$5.000\n");
                strcat(String, "{ffffff}Prancha 4\t{31b404}R$5.000\n");

                ShowPlayerDialog(playerid, DIALOG_OBJECTS_PRANCHA, DIALOG_STYLE_TABLIST_HEADERS, "{ffffff}Pranchas Disponíveis [ {31b404}4 {ffffff}]", String, "Selecionar", "Cancelar");
            }
        }
    }
    return 1;
}

Dialog:DIALOG_OBJECTS_PRANCHA(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0: // Prancha 1
            {
                SetPlayerAttachedObject(playerid, 7, 2410, 1);
                SendClientMessage(playerid, -1, "| OBJETO | Você está visualizando o objeto. Caso queira comprar, aperte {ffff00}Y{ffffff}. Para cancelar, aperte {ffff00}N{ffffff}.");

            }
        }
    }
    return 1;
}