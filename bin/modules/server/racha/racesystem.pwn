// NEW RACE SYSTEM

/* ----         Started at 10/05/2021 - 11:28                                                     */
/* ----         Author: Luiz "LuizM" Henrique                                                     */
/* ----         Credits: Silva (suggestion)                                                       */
/* ----         Finished at 10/05/2021 - 18:48                                                    */
/* ----         First patch: 10/05/2021 - 18:48 - 613 lines                                       */


enum pRace 
{
    bool:Participando,
    CheckpointID,
    Voltas,
    bool:Aguardando
}
new pRacha[MAX_PLAYERS][pRace];

enum Racha 
{
    Vencedor,
    Montante,
    ParticipantesRacha,
    bool:EmAndamento,
    MinRacha,
    SegRacha,
    TimerRacha,
    bool:Iniciando,
    SegIniciar,
    eTimingRacha
}
new iRace[Racha];

new SelectVehicle[MAX_PLAYERS][10];


/*CMD:restart(playerid, params[])
{
    new minuto, segundo;

    if(sscanf(params, "dd", minuto, segundo))  
        return false;
    
    iRace[MinRacha] = minuto;
    iRace[SegRacha] = segundo;
    return 1;
}*/

CMD:rachas(playerid)
{
    new String[500], Str[500], time[100];
    strcat(String, "{ffffff}Racha\t{ffffff}Tempo para Iniciar\t{ffffff}Participantes\n");

    format(time, 100, "%02d:%02d", iRace[MinRacha], iRace[SegRacha]);

    if(iRace[MinRacha] == 0 && iRace[SegRacha] == 0)
    {
        format(time, 500, "Disponível para Entrada");
    }

    if(iRace[EmAndamento] == true)
    {
        format(time, 500, "Em Andamento");
    }

    format(Str, 500, "Racha Los Santos\t{ffff00}%s\t{FF8000}%d", time, iRace[ParticipantesRacha]);
    strcat(String, Str);

    ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_TABLIST_HEADERS, "{ffffff}Rachas disponíveis [ {31b404}1 {ffffff}]", String, "Fechar", "");
    return 1;
}

CMD:participar(playerid)
{
    if(pRacha[playerid][Participando] == true)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está participando do racha.");
    
    if(iRace[EmAndamento] == true)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode entrar em um racha em andamento.");
    
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1434.9747,-1882.6564,13.5542))
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo do local de rachas.");

    new query[350];
    format(query, 350, "SELECT `id` FROM `veiculos` WHERE `proprietario_id`='%d'", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
    new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();

    if(rows == 0)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa ter um veículo próprio para entrar em um racha.");
    
    cache_delete(result);

    if(iRace[MinRacha] >= 0)
    {
        if(iRace[SegRacha] > 0)
        {
            SendClientMessage(playerid, COR_ERRO, "| ERRO | Você só pode entrar no racha quando ele estiver disponível.");
            return 1;
        }
    }
    
    ShowPlayerDialog(playerid, DIALOG_APOSTA_RACHA, DIALOG_STYLE_INPUT, "{ffffff}Racha", "{ffffff}Digite o valor que deseja apostar em sua vitória\n{ffffff}Valores permitidos: {31b404}R$2.000 {ffffff}até {31b404}R$5.000", "Confirmar", "Cancelar");
    return 1;
}

Dialog:DIALOG_CHOOSE_VEHICLE(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new vehicle = SelectVehicle[playerid][listitem];
        for(new i; i < sizeof(SelectVehicle[]); i++)
            SelectVehicle[playerid][i] = -1;

        foreach(new vehicleid: VehiclePlayers)
        {
            if(Vehicle[vehicleid][Id] == vehicle)
            {
                new Float:Posicao[4];
                GetVehiclePos(vehicleid, Posicao[0], Posicao[1], Posicao[2]);

                if(!IsPlayerInRangeOfPoint(playerid, 10.0, Posicao[0], Posicao[1], Posicao[2]))
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar mais próximo do veículo selecionado.");
                
                SendClientMessage(playerid, -1, "| RACHA | Você selecionou o veículo '{1c88f0}%s{ffffff}' para correr no racha.", GetVehicleName(vehicleid));
                SendClientMessage(playerid, COR_ERRO, "| RACHA | Sua participação será cancelada caso se distancie deste local (seu dinheiro não será devolvido).");

                GivePlayerMoney(playerid, -GetPVarInt(playerid, "ValorApostado"));

                iRace[Montante] = iRace[Montante] + GetPVarInt(playerid, "ValorApostado");

                pRacha[playerid][Aguardando] = true;

                pRacha[playerid][Participando] = true;

                iRace[ParticipantesRacha]++;

                CancelarServicos(playerid);

                SetVehiclePos(vehicleid, 1440.8083,-1869.6776,13.1177);
                SetVehicleZAngle(vehicleid, 90.9626);
                PutPlayerInVehicle(playerid, vehicleid, 0);

                DisableRemoteVehicleCollisions(playerid, true);
                //TogglePlayerControllable(playerid, 0);
            }
        }

        if(iRace[ParticipantesRacha] > 1)
        {
            if(iRace[Iniciando] == false || iRace[Iniciando] == true)
            {
                foreach(new i: Player)
                {
                    if(pRacha[i][Participando] == true)
                    {
                        SendClientMessage(i, -1, "| RACHA | O(A) jogador(a) {ffff00}%s[%d] {ffffff}entrou no racha.", GetUserName(playerid), playerid);
                        
                        new vehiicleid = GetPlayerVehicleID(i);

                        SetVehiclePos(vehiicleid, 1440.8083,-1869.6776,13.1177);
                        SetVehicleZAngle(vehiicleid, 90.9626);
                        PutPlayerInVehicle(i, vehiicleid, 0);
                        TogglePlayerControllable(i, false);
                    }
                }
                
            }
            iRace[SegIniciar] = 30;
            KillTimer(iRace[TimerRacha]);
            iRace[TimerRacha] = SetTimer("StartContagem", 1000, 0);
        }
    }
    return 1;
}

forward StartContagem();
public StartContagem()
{
    iRace[Iniciando] = true;
    iRace[SegIniciar]--;

    if(iRace[Iniciando] == true)
    {
        iRace[TimerRacha] = SetTimer("StartContagem", 1000, 0);
    }

    if(iRace[SegIniciar] == 0)
    {
        foreach(new i: Player)
        {
            if(pRacha[i][Participando] == true)
            {
                new vehicleid = GetPlayerVehicleID(i);
                new engine, lights, alarm, doors, bonnet, boot, objective;

                GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
                SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
            

                GameTextForPlayer(i, "~g~]]] ~w~vai ~g~]]]", 3000, 5);


                SetPlayerWantedLevel(i, GetPlayerWantedLevel(i)+2);

                TogglePlayerControllable(i, true);

                pRacha[i][Aguardando] = false;
                iRace[EmAndamento] = true;
                pRacha[i][CheckpointID] = 1;
                pRacha[i][Voltas] = 1;

                iRace[Iniciando] = false;

                SetPlayerRaceCheckpoint(i, 0, 1388.0991,-1871.3557,13.1106, 1276.8235,-1851.9159,13.1153, 5.0);

                KillTimer(iRace[TimerRacha]);
            }
        }
        SendClientMessageToAll(COR_AMARELO, "| RACHA | Foi identificado um racha acontecendo em Los Santos.");
    }

    if(iRace[SegIniciar] > 0)
    {
        foreach(new i: Player)
        {
            if(pRacha[i][Participando] == true)
            {
                new String[10];
                format(String, 10, "~r~%d", iRace[SegIniciar]);
                GameTextForPlayer(i, String, 1000, 5);
            }
        }
    }

    return 1;
}

Dialog:DIALOG_APOSTA_RACHA(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(!strval(inputtext))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Digite apenas números.");
        
        if(strval(inputtext) > 5000 || strval(inputtext) < 2000)
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você só pode apostar valores entre R$2.000 e R$5.000.");
        
        if(strval(inputtext) > GetPlayerMoney(playerid))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui dinheiro suficiente.");
        
        SendClientMessage(playerid, -1, "| APOSTA | Você apostou {31b404}R$%s {ffffff}em sua vitória e está participando do Racha Los Santos.", RealStr(strval(inputtext)));

        SetPVarInt(playerid, "ValorApostado", strval(inputtext));

        new String[500], Str[500];
        new query[350];
        format(query, sizeof(query), "SELECT `id`, `modelo` FROM `veiculos` WHERE `proprietario_id`='%d'", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));

        new Cache:result = mysql_query(getConexao(), query, true);
        new rows = cache_num_rows();
        if(rows > 0)
        {
            for(new i; i < rows; i++)
            {
                new nome[50], modelo;

                cache_get_value_int(i, "modelo", modelo);
                cache_get_value_int(i, "id", SelectVehicle[playerid][i]);

                format(nome, 50, "%s", GetVehicleModelName(modelo));

                format(Str, sizeof(Str), "%s\n", nome);
                strcat(String, Str);
                
            }
            ShowPlayerDialog(playerid, DIALOG_CHOOSE_VEHICLE, DIALOG_STYLE_LIST, "{ffffff}Escolha o seu veículo pessoal que deseja utilizar", String, "Selecionar", "Cancelar");
        }

        cache_delete(result);
    
        /*iRace[Montante] = iRace[Montante] + strval(inputtext);

        GivePlayerMoney(playerid, -strval(inputtext));

        iRace[ParticipantesRacha]++;
        pRacha[playerid][Participando] = true;
        pRacha[playerid][CheckpointID] = 1;
        pRacha[playerid][Voltas] = 1;*/

        //SetPlayerRaceCheckpoint(playerid, 0, 1388.0991,-1871.3557,13.1106, 1276.8235,-1851.9159,13.1153, 5.0);
    }
    return 1;
}

new actor;

#include <YSI_Coding\y_hooks>

hook OnPlayerDisconnect(playerid)
{
    pRacha[playerid][Participando] = false;
    pRacha[playerid][CheckpointID] = 0;
    pRacha[playerid][Voltas] = 0;
    pRacha[playerid][Aguardando] = false;
    return 1;
}

function RACHA::CancelarRacha(playerid)
{
    if(pRacha[playerid][Participando] == true)
    {
        DisablePlayerRaceCheckpoint(playerid);
    }

    pRacha[playerid][Participando] = false;
    pRacha[playerid][CheckpointID] = 0;
    pRacha[playerid][Voltas] = 0;
    pRacha[playerid][Aguardando] = false;

    iRace[ParticipantesRacha]--;

    if(iRace[ParticipantesRacha] == 0)
    {
        iRace[Vencedor] = INVALID_PLAYER_ID;
        iRace[Montante] = 0;
        iRace[ParticipantesRacha] = 0;
        iRace[EmAndamento] = false;
        iRace[MinRacha] = 0;
        iRace[SegRacha] = 0;
        iRace[TimerRacha] = -1;
        iRace[Iniciando] = false;
        iRace[SegIniciar] = 0;

    }
    return 1;
}

CMD:desistir(playerid, params[])
{

    if(pRacha[playerid][Participando])
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um racha.");
    
    SendClientMessage(playerid, COR_ERRO, "| RACHA | Você foi desclassificado por desistir do racha.");

    call::RACHA->CancelarRacha(playerid);

    return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(oldstate == PLAYER_STATE_DRIVER)
    {
        if(pRacha[playerid][Participando])
        {
            SendClientMessage(playerid, COR_ERRO, "| RACHA | Você foi desclassificado por sair de seu veículo.");

            call::RACHA->CancelarRacha(playerid);
        }
    }
    return 1;
}

hook OnPlayerUpdate(playerid)
{
    if(pRacha[playerid][Aguardando] == true)
    {
        if(!IsPlayerInRangeOfPoint(playerid, 50.0, 1434.9747,-1882.6564,13.5542))
        {
            SendClientMessage(playerid, COR_ERRO, "| RACHA | Você se distanciou do local do racha e sua participação foi cancelada.");

            pRacha[playerid][Participando] = false;
            pRacha[playerid][CheckpointID] = 0;
            pRacha[playerid][Voltas] = 0;
            pRacha[playerid][Aguardando] = false;

            iRace[ParticipantesRacha]--;
        
        }
    }
    return 1;
}


forward TimingRacha(playerid);
public TimingRacha(playerid)
{
    if(iRace[MinRacha] == 0 && iRace[SegRacha] == 0)
        return 1;
    
    iRace[SegRacha]--;

    if(iRace[SegRacha] == 0)
    {
        if(iRace[MinRacha] > 0)
        {
            iRace[MinRacha]--;
            iRace[SegRacha] = 59;
        }

        else if(iRace[MinRacha] == 0)
        {
            iRace[MinRacha] = 0;
            iRace[SegRacha] = 0;
        }
    }
    return 1;
}

hook OnGameModeInit()
{
    iRace[Montante] = 0;
    iRace[Vencedor] = INVALID_PLAYER_ID;
    iRace[ParticipantesRacha] = 0;
    iRace[EmAndamento] = false;
    iRace[MinRacha] = 0;
    iRace[SegRacha] = 0;

    iRace[eTimingRacha] = SetTimer("TimingRacha", 1000, 1);

    actor = CreateDynamicActor(116, 1435.7961,-1882.6956,13.5548,89.7243); // Actor Racha
    ApplyDynamicActorAnimation(actor, "DEALER", "DEALER_IDLE", 4.0,1,1,1,1,0);

    CreateDynamicPickup(1239, 1, 1434.9747,-1882.6564,13.5542); // Pickup Racha
    CreateDynamic3DTextLabel("Racha de Rua\nDigite {ffff00}/Participar {ffffff}para participar.", -1, 1434.9747,-1882.6564,13.5542, 6.8); // Label Racha
    return 1;
}

hook OnPlayerEnterRaceCP(playerid)
{
    if(pRacha[playerid][Participando] == true)
    {
        if(pRacha[playerid][CheckpointID] > 0)
        {
            GenerateCheckpoints(playerid);
        }
    }
    return 1;
}

forward GenerateCheckpoints(playerid);
public GenerateCheckpoints(playerid)
{
    if(pRacha[playerid][Participando] == true)
    {
        if(pRacha[playerid][Voltas] != 4)
        {
            if(pRacha[playerid][CheckpointID] == 1)
            {
                if(pRacha[playerid][Voltas] == 2)
                {
                    if(iRace[Vencedor] == INVALID_PLAYER_ID)
                    {
                        foreach(new i: Player)
                        {
                            if(pRacha[i][Participando] == true)
                            {
                                SendClientMessage(i, COR_AMARELO, "| RACHA | O(A) jogador(a) %s[%d] venceu o racha de Los Santos.", GetUserName(playerid), playerid);
                            }
                        }
                        SendClientMessage(playerid, -1, "| RACHA | Você venceu o racha e recebeu {31B404}R$%s {ffffff}pela vitória.", RealStr(iRace[Montante]));

                        GivePlayerMoney(playerid, iRace[Montante]);

                        iRace[Vencedor] = INVALID_PLAYER_ID;
                        iRace[Montante] = 0;
                        iRace[EmAndamento] = false;
                        iRace[ParticipantesRacha] = 0;
                        iRace[MinRacha] = 59;
                        iRace[SegRacha] = 59;

                        
                        foreach(new i: Player)
                        {
                            if(pRacha[i][Participando] == true)
                            {

                                pRacha[i][Participando] = false;
                                pRacha[i][CheckpointID] = 0;
                                pRacha[i][Voltas] = 0;
                                pRacha[i][Aguardando] = false;
                                DisablePlayerRaceCheckpoint(i);
                                DisableRemoteVehicleCollisions(i, 0);
                            }
                        }

                        return 1;
                    }
                }

                else if(pRacha[playerid][Voltas] < 2)
                {
                    SetPlayerRaceCheckpoint(playerid, 0, 1276.8235,-1851.9159,13.1153, 1061.7712,-1840.3756,13.2060, 5.0);
                    pRacha[playerid][CheckpointID]++;
                }

            }

            else if(pRacha[playerid][CheckpointID] == 2)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 1061.7712,-1840.3756,13.2060, 964.5230,-1781.2000,13.8306, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 3)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 964.5230,-1781.2000,13.8306, 748.8869,-1762.6268,12.5765, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 4)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 748.8869,-1762.6268,12.5765, 632.5979,-1717.3879,13.7348, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 5)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 632.5979,-1717.3879,13.7348, 642.2682,-1210.1400,17.8374, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 6)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 642.2682,-1210.1400,17.8374, 868.0080,-1007.0154,32.9799, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 7)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 868.0080,-1007.0154,32.9799, 1137.6392,-954.7371,42.2442, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 8)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 1137.6392,-954.7371,42.2442, 1362.2107,-955.7349,33.8703, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 9)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 1362.2107,-955.7349,33.8703, 1368.0804,-1142.0560,23.3815, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 10)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 1368.0804,-1142.0560,23.3815, 1728.1210,-1163.4402,23.3702, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 11)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 1728.1210,-1163.4402,23.3702, 1867.8011,-1164.9073,23.4010, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 12)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 1867.8011,-1164.9073,23.4010, 1945.4395,-1043.7914,23.7160, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 13)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 1945.4395,-1043.7914,23.7160, 2270.6658,-1158.0676,26.3694, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 14)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 2270.6658,-1158.0676,26.3694, 2268.0959,-1379.2836,23.5602, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 15)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 2268.0959,-1379.2836,23.5602, 2211.2605,-1404.5149,23.5501, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 16)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 2211.2605,-1404.5149,23.5501, 2171.2888,-1752.9589,13.1084, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 17)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 2171.2888,-1752.9589,13.1084, 1822.0670,-1761.6876,13.1099, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 18)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 1822.0670,-1761.6876,13.1099, 1789.5109,-1831.4502,13.1096, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 19)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 1789.5109,-1831.4502,13.1096, 1689.5585,-1828.0500,13.1094, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 20)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 1689.5585,-1828.0500,13.1094, 1436.9275,-1871.4229,13.1170, 5.0);
                pRacha[playerid][CheckpointID]++;
            }

            else if(pRacha[playerid][CheckpointID] == 21)
            {
                SetPlayerRaceCheckpoint(playerid, 0, 1388.0991,-1871.3557,13.1106, 1276.8235,-1851.9159,13.1153, 5.0);
                pRacha[playerid][CheckpointID] = 1;
                pRacha[playerid][Voltas]++;
            }
        }
    }
    return 1;
}

flags:rachatime(AJUDANTE);
CMD:rachatime(playerid, params[])
{
    SendClientMessage(playerid, COR_AMARELO, "| PFC - ADMIN | Você diminuiu o tempo para o racha iniciar para 00:10.");
    iRace[MinRacha] = 0;
    iRace[SegRacha] = 10;
    return 1;
}