// NEW JOB: TRANSPORTADOR DE VALORES

/* ----         Started at 12/05/2021 - 23:53                                                     */
/* ----         Author: Luiz "LuizM" Henrique                                                     */
/* ----         Credits: Thiago (suggestion) and Morgana_ (map design)                            */
/* ----         Finished at 13/05/2021 - 17:14                                                    */
/* ----         First patch: 13/05/2021 - 17:14 - 468 lines                                       */


#include <YSI_Coding\y_hooks>

#define MAX_CARGAS 100

enum CargasTransV
{
	ID,
    cidade[24],
    Float:posX,
    Float:posY,
    Float:posZ
}
new CargasCF[MAX_CARGAS][CargasTransV], Iterator:CargasTV<MAX_CARGAS>;

enum TValores
{
    bool:Working,
    Valor,
    LevelCarga
}
new pJobTVALORES[MAX_PLAYERS][TValores];

static SelectCarga[MAX_PLAYERS][MAX_CARGAS];

function VALORES::CreateMap()
{
    CreateDynamicObject(3785, -2435.21533, 516.89490, 32.63310,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3785, -2435.23633, 523.13849, 32.63310,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3785, -2435.23120, 529.31732, 32.63310,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(334, -2427.79468, 499.07391, 33.26700,   91.00000, 18.00000, 0.00000);
    CreateDynamicObject(19294, -2427.60962, 498.66333, 33.29838,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, -2446.46533, 506.66171, 44.52768,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, -2446.45630, 539.44263, 44.55704,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, -2501.09790, 539.42017, 44.54102,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, -2501.09937, 506.67648, 44.55033,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19121, -2416.87524, 542.45471, 29.37896,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19121, -2403.10767, 542.14136, 29.37887,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19121, -2433.03784, 511.27188, 29.37881,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19121, -2423.43750, 506.16162, 29.37875,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19121, -2394.91333, 517.55658, 29.37760,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3785, -2447.46558, 517.99933, 32.31598,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3785, -2447.46436, 527.91193, 32.32215,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3785, -2455.19971, 503.85876, 32.44691,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19290, -2447.46265, 522.76318, 44.53321,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19290, -2478.12524, 507.66974, 44.43406,   0.00000, 0.00000, 0.00000);

    CreateDynamicPickup(1239, 1, -2442.1726,501.6015,30.0948);
    CreateDynamic3DTextLabel("Transportador de Valores\nAperte '{ffff00}Y{ffffff}' para locar um veículo", -1, -2442.1726,501.6015,30.0948, 10.0);
    return 1;
}

function VALORES::ResetVariables(playerid, bool:dvehicle=false)
{
    if(dvehicle == true)
    {
        DestroyVehicle(Jogador[playerid][VeiculoLocado]);
        Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;
    }

    DisablePlayerRaceCheckpoint(playerid);
    DeletePVar(playerid, "CargaID");

    pJobTVALORES[playerid][Working] = false;
    pJobTVALORES[playerid][Valor] = 0;
    pJobTVALORES[playerid][LevelCarga] = 0;
    return 1;
}

function VALORES::CreateDatabase()
{
    mysql_query(getConexao(), "CREATE TABLE IF NOT EXISTS `cargascf` (\
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY, \
    cidade varchar(24), \
    posX float NOT NULL, \
    posY float NOT NULL, posZ float NOT NULL);", false);

    return 1;
}

function VALORES::LoadCargas()
{
    new Cache:result = mysql_query(getConexao(), "SELECT * FROM `cargascf`", true);
    new rows = cache_num_rows();

    if(rows > 0)
    {
        for(new i; i < rows; i++)
        {
            cache_get_value_int(i, "id", CargasCF[i][ID]);
            cache_get_value_name(i, "cidade", CargasCF[i][cidade]);
            cache_get_value_float(i, "posX", CargasCF[i][posX]);
            cache_get_value_float(i, "posY", CargasCF[i][posY]);
            cache_get_value_float(i, "posZ", CargasCF[i][posZ]);

            Iter_Add(CargasTV, i);
        }
    }

    cache_delete(result);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    call::VALORES->ResetVariables(playerid, true);
    return 1;   
}

hook OnGameModeInit()
{
    call::VALORES->CreateMap();
    call::VALORES->CreateDatabase();

    call::VALORES->LoadCargas();
    return 1;
}

hook OnPlayerEnterRaceCP(playerid)
{
    if(Jogador[playerid][Profissao] == TRANSPORTADOR_VALORES)
    {
        if(pJobTVALORES[playerid][Working] == true)
        {
            if(GetPlayerVehicleID(playerid) != Jogador[playerid][VeiculoLocado])
                return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar em seu veículo locado.");

            if(pJobTVALORES[playerid][LevelCarga] == 1)
            {
                SetTimerEx("NextLevelCF", 3000, 0, "i", playerid);
                TogglePlayerControllable(playerid, false);
                GameTextForPlayer(playerid, "~r~carregando ~w~caminhao", 3000, 5);
                return 1;
            }

            if(pJobTVALORES[playerid][LevelCarga] == 2)
            {
                SetTimerEx("NextLevelCF", 3000, 0, "i", playerid);
                TogglePlayerControllable(playerid, false);
                GameTextForPlayer(playerid, "~r~descarregando ~w~caminhao", 3000, 5);
                return 1;
            }
        }
    }
    return 1;
}

forward NextLevelCF(playerid);
public NextLevelCF(playerid)
{
    TogglePlayerControllable(playerid, true);


    if(pJobTVALORES[playerid][LevelCarga] == 1)
    {
        new query[350];
        format(query, sizeof(query), "SELECT * FROM `cargascf` WHERE `id`='%d'", GetPVarInt(playerid, "CargaID"));

        new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();

        new Float:Posicao[4];

        if(rows > 0)
        {
            cache_get_value_float(0, "posX", Posicao[0]);
            cache_get_value_float(0, "posY", Posicao[1]);
            cache_get_value_float(0, "posZ", Posicao[2]);

        }

        SetPlayerRaceCheckpoint(playerid, 1, Posicao[0], Posicao[1], Posicao[2], 0.0, 0.0, 0.0, 5.0);

        SendClientMessage(playerid, -1, "| CARGA | Você carregou seu Carro Forte com {"COR_LARANJA_INC"}Dinheiro{ffffff}. Siga o {ff0000}ponto vermelho {ffffff}para descarregar.");

        pJobTVALORES[playerid][LevelCarga] = 2;

        cache_delete(result);

        return 1;
    }

    if(pJobTVALORES[playerid][LevelCarga] == 2)
    {
        SendClientMessage(playerid, -1, "| CARGA | Você descarregou o seu Carro Forte e recebeu {31b404}R$%s {ffffff}pelo seu serviço.", RealStr(pJobTVALORES[playerid][Valor]));

        GivePlayerMoney(playerid, pJobTVALORES[playerid][Valor]);

        call::VALORES->ResetVariables(playerid);
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_YES)
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, -2442.1726,501.6015,30.0948))
        {
            if(Jogador[playerid][Profissao] != TRANSPORTADOR_VALORES)
                return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
            
            if(Jogador[playerid][VeiculoLocado] == INVALID_VEHICLE_ID)
            {
                ShowPlayerDialog(playerid, DIALOG_LOCAR_VALORES, DIALOG_STYLE_MSGBOX, "{ffffff}Locar Veículo", "{ffffff}Você deseja locar um '{1c88f0}Securicar{ffffff}'?", "Sim", "Não");
            }
            else 
            {
                ShowPlayerDialog(playerid, DIALOG_DESLOCAR_VALORES, DIALOG_STYLE_MSGBOX, "{ffffff}Devolver Veículo", "{ffffff}Você deseja devolver seu '{1c88f0}Securicar{ffffff}'?", "Sim", "Não");
            }
        }
    }
    return 1;   
}

Dialog:DIALOG_LOCAR_VALORES(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new Float:placesSpawn[][] =
        {
            {-2429.8528,515.4628,30.0488,214.8546},
            {-2425.8696,518.6024,30.0573,223.3976},
            {-2422.6633,521.9240,30.0787,223.4511},
            {-2419.4023,525.1180,30.0572,229.4307},
            {-2416.5002,528.2987,30.0543,240.3965},
            {-2415.1567,532.2020,30.0480,247.5582},
            {-2413.9407,536.1383,30.0513,258.7848},
            {-2413.3389,540.0349,30.0554,269.0966}
        };

        new Rand = random(sizeof(placesSpawn));

        Jogador[playerid][VeiculoLocado] = CreateVehicle(428, placesSpawn[Rand][0], placesSpawn[Rand][1], placesSpawn[Rand][2], placesSpawn[Rand][3], 6, 6, 300000);
        
        SendClientMessage(playerid, -1, "| VEÍCULO | Seu veículo '{1c88f0}Securicar{ffffff}' foi locado com sucesso. Siga o {ff0000}ponto vermelho {ffffff}em seu mapa para pegá-lo.");

        call::PLAYER->SetPlayerMarkGPS(playerid, placesSpawn[Rand][0], placesSpawn[Rand][1], placesSpawn[Rand][2]);
    }
    return 1;
}

Dialog:DIALOG_DESLOCAR_VALORES(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        call::VALORES->ResetVariables(playerid, true);
        SendClientMessage(playerid, -1, "| VEÍCULO | Seu veículo '{1c88f0}Securicar{ffffff}' foi devolvido com sucesso.");
    }
    return 1;
}

function VALORES::GetZoneName(Float:PosicaoX, Float:PosicaoY)
{
    new ender[MAX_ZONE_NAME];

	GetLocalName(Float:PosicaoX, Float:PosicaoY, ender, sizeof(ender));
    return ender;
}

function VALORES::MetersToKm(playerid, Float:PosicaoX, Float:PosicaoY, Float:PosicaoZ)
{
    new distance = floatround( GetPlayerDistanceFromPoint(playerid, PosicaoX, PosicaoY, PosicaoZ) );
    new distanceinkm = ( distance / 100);
    return distanceinkm;
}

Dialog:DIALOG_CARREGAR_CF(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new city[30];
        switch(listitem)
        {
            case 0: { city = "LS"; }
            case 1: { city = "SF"; }
            case 2: { city = "LV"; }
        }

        new query[350];
        format(query, 350, "SELECT * FROM `cargascf` WHERE `cidade`='%s'", city);

        new Cache:result = mysql_query(getConexao(), query, true);
        new rows = cache_num_rows();
        new String[1000], Str[1000];

        strcat(String, "{ffffff}Destino\t{ffffff}Valor\t{ffffff}Distância\n");

        if(rows > 0)
        {
            for(new i; i < rows; i++)
            {  
                new Float:Posicao[4];
                cache_get_value_int(i, "id", SelectCarga[playerid][i]);
                cache_get_value_float(i, "posX", Posicao[0]);
                cache_get_value_float(i, "posY", Posicao[1]);
                cache_get_value_float(i, "posZ", Posicao[2]);

                format(Str, 1000, "%s\t{31b404}R$%s\t{"COR_LARANJA_INC"}%02d Km\n", call::VALORES->GetZoneName(Posicao[0], Posicao[1]), RealStr(floatround( GetPlayerDistanceFromPoint(playerid, Posicao[0], Posicao[1], Posicao[2])) * 80 / 100 ), call::VALORES->MetersToKm(playerid, Posicao[0], Posicao[1], Posicao[2]) );
                strcat(String, Str);

            }
            new titulo[100];
            format(titulo, 100, "{ffffff}Rotas Disponíveis [ {31b404}%d {ffffff}]", rows);

            ShowPlayerDialog(playerid, DIALOG_CF_LS, DIALOG_STYLE_TABLIST_HEADERS, titulo, String, "Selecionar", "Cancelar");
        }
        else 
        {
            SendClientMessage(playerid, COR_ERRO, "| ERRO | Ainda não há rotas para este destino.");
        }
        cache_delete(result);
    }
    return 1;
}

Dialog:DIALOG_CF_LS(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new rota = SelectCarga[playerid][listitem];
        for(new i; i < sizeof(SelectCarga[]); i++)
            SelectCarga[playerid][i] = -1;

        SetPVarInt(playerid, "CargaID", rota);
        
        new query[350];
        format(query, sizeof(query), "SELECT * FROM `cargascf` WHERE `id`='%d'", rota);
        new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();
        new Float:Posicao[4];

        if(rows > 0)
        {
            cache_get_value_float(0, "posX", Posicao[0]);
            cache_get_value_float(0, "posY", Posicao[1]);
            cache_get_value_float(0, "posZ", Posicao[2]);
        }

        DisablePlayerRaceCheckpoint(playerid);
        SetPlayerRaceCheckpoint(playerid, 1, -2441.6382,522.1832,29.9168, 0.0, 0.0, 0.0, 5.0);

        SendClientMessage(playerid, 0x81BEF7AA, "| SERVIÇO | Siga o ponto marcado em seu mapa para carregar seu Carro Forte.");

        pJobTVALORES[playerid][Working] = true;
        pJobTVALORES[playerid][LevelCarga] = 1;
        pJobTVALORES[playerid][Valor] = floatround( GetPlayerDistanceFromPoint(playerid, Posicao[0], Posicao[1], Posicao[2]) * 80 / 100 );

        cache_delete(result);
    }
    return 1;
}

CMD:carregar(playerid)
{
    if(Jogador[playerid][Profissao] != TRANSPORTADOR_VALORES)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
    
    if(Jogador[playerid][VeiculoLocado] == INVALID_VEHICLE_ID)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa locar um veículo primeiro.");

    if(GetPlayerVehicleID(playerid) != Jogador[playerid][VeiculoLocado])
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar em seu veículo locado.");
    
    if(!IsPlayerInRangeOfPoint(playerid, 50.0, -2441.6382,522.1832,29.9168))
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar na HQ para usar este comando.");
    
    if(pJobTVALORES[playerid][Working] == true)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está trabalhando.");
    
    ShowPlayerDialog(playerid, DIALOG_CARREGAR_CF, DIALOG_STYLE_LIST, "{ffffff}Selecione a cidade", "Los Santos\nSan Fierro\nLas Venturas", "Selecionar", "Cancelar");
    return 1;
}

/*CMD:ircaixa(playerid, params[])
{
    new id;
    if(sscanf(params, "d", id))
        return false;
    
    foreach(new i: Caixa)
    {
        if(Caixa[i][ID] == id)
        {
            SetPlayerPos(playerid, Caixa[i][Pos][X], Caixa[i][Pos][Y], Caixa[i][Pos][Z]);
        }
    }
    return 1;
}*/

/*CMD:criarrota(playerid)
{

    ShowPlayerDialog(playerid, DIALOG_ROTA_CF, DIALOG_STYLE_LIST, "{ffffff}Selecione a cidade.", "Los Santos\nSan Fierro\nLas Venturas", "Selecionar", "Cancelar");

    return 1;
}

Dialog:DIALOG_ROTA_CF(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new Float:Posicao[4];
        GetPlayerPos(playerid, Posicao[0], Posicao[1], Posicao[2]);

        switch(listitem)
        {
            case 0: // Los Santos
            {
                new query[350];
                mysql_format(getConexao(), query, sizeof(query), "INSERT INTO `cargascf`(`cidade`, `posX`, `posY`, `posZ`) VALUES ('LS', '%f', '%f', '%f')", Posicao[0], Posicao[1], Posicao[2]);
                mysql_tquery(getConexao(), query, "AdicionarID", "i", playerid);
            }

            case 1: // San Fierro
            {
                new query[350];
                mysql_format(getConexao(), query, sizeof(query), "INSERT INTO `cargascf`(`cidade`, `posX`, `posY`, `posZ`) VALUES ('SF', '%f', '%f', '%f')", Posicao[0], Posicao[1], Posicao[2]);
                mysql_tquery(getConexao(), query, "AdicionarID", "i", playerid);
            }

            case 2: // Las Venturas
            {
                new query[350];
                mysql_format(getConexao(), query, sizeof(query), "INSERT INTO `cargascf`(`cidade`, `posX`, `posY`, `posZ`) VALUES ('LV', '%f', '%f', '%f')", Posicao[0], Posicao[1], Posicao[2]);
                mysql_tquery(getConexao(), query, "AdicionarID", "i", playerid);
            }
        }
    }
    return 1;
}

forward AdicionarID(playerid);
public AdicionarID(playerid)
{
    new id = cache_insert_id();
    SendClientMessage(playerid, -1, "| ROTA | Rota {1c88f0}%d {ffffff}criada com sucesso.", id);

    new query[350];
    format(query, 350, "SELECT * FROM `cargascf` WHERE `id`='%d'", id);
    new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();

    if(rows > 0)
    {
        for(new i; i < rows; i++)
        {
            new city[30], Float:Posicao[4];
            cache_get_value_name(0, "cidade", city, 30);
            cache_get_value_float(0, "posX", Posicao[0]);
            cache_get_value_float(0, "posY", Posicao[1]);
            cache_get_value_float(0, "posZ", Posicao[2]);
            SendClientMessage(playerid, -1, "| ROTA | Cidade: {ffff00}%s{ffffff}", city);
            SendClientMessage(playerid, -1, "| ROTA | Posição X: {ffff00}%f{ffffff}, Posição Y: {ffff00}%f{ffffff}, Posição Z: {ffff00}%f", Posicao[0], Posicao[1], Posicao[2]);
        }
        
    }

    cache_delete(result);

    return 1;
}*/