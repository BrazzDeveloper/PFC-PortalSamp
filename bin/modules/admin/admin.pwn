//A TESTANDO PORRA

#define ConvertDays(%0) (gettime() + (86400 * (%0)))

enum e_ADMIN_TIME
{
	HORAS,
	MINUTOS,
	SEGUNDOS
}

enum e_ADMIN_INFO
{
	AdminLevel,
	vAdmin[MAX_VEHICLES_PER_ADMIN],
	bool:Trabalhando
}
static 
	Admin[MAX_PLAYERS][e_ADMIN_INFO];

#include ../bin/modules/admin/cmds.pwn
#include ../bin/modules/admin/dialogs.pwn

// ============================== [ CALLBACKS ] ============================== //
#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid)
{
	new reset[e_ADMIN_INFO];
	Admin[playerid] = reset;
}

hook OnPlayerDisconnect(playerid, reason)
{
	call::ADMIN->DestroyAllVehicleToAdmin(playerid);
	GodMod[playerid] = false, GodCar[playerid] = false;
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE)
	{
		if(!call::ADMIN->IsAdminInJob(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em modo trabalho para usar teleport map.");

		if ( call::JOB->IsPlayerInWorking(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar o teleport enquanto trabalha como player.");
		
		//Teleport(playerid, fX, fY, fZ, 0.0, 0, 0, ENTROU_NONE);
		SetPlayerPos(playerid, fX, fY, fZ);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);

		if(IsPlayerInAnyVehicle(playerid)){
			new vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(GetPlayerVehicleID(playerid), fX, fY, fZ);
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0), SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
			PutPlayerInVehicle(playerid, vehicleid, 0);
			Jogador[playerid][Entrou] = ENTROU_NONE;
		}else{
			SetPlayerPos(playerid, fX, fY, fZ);
			SetPlayerInterior(playerid, 0), SetPlayerVirtualWorld(playerid, 0);
			Jogador[playerid][Entrou] = ENTROU_NONE;
		}

		new str[128];
		format(str, sizeof(str), "O %s %s se teleportou para as coordenadas x=%0.3f y=%0.3f z=%0.3f", call::ADMIN->CargoAdmin(Admin[playerid][AdminLevel]), GetUserName(playerid), fX, fY, fZ);
		WriteLog(FILE_ADMIN_TELEPORT, str);
		return true;
	}
	return false;
}

hook OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE)
	{
		if( !call::ADMIN->IsAdminInJob(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em modo trabalho para usar esta função.");

		if ( call::JOB->IsPlayerInWorking(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar essa função enquanto trabalha como player.");

		if ( clickedplayerid == playerid )
			return false;

		SetPVarInt(playerid, "clickedplayerid", clickedplayerid);
		ShowPlayerDialog(playerid, MENU_PLAYER_CLICKED, DIALOG_STYLE_LIST, "OPÇÕES", "Ir\nTrazer", "Selecionar", "Cancelar");
		return true;
	}
	return false;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_FIRE))
	{
		if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE)
		{
			if (IsPlayerInAnyVehicle(playerid))
	       	{
	            AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
	        }
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnVehicleDamageStatusU(vehicleid, playerid)
{
	if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE)
	{
		if(GodCar[playerid] != false)
		{
			RepairVehicle(vehicleid), SetVehicleHealth(vehicleid, 1000.0);
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}
// ============================== [ FUNCTIONS ] ============================== //
function ADMIN::CargoAdmin(level, bool:usecolor=false, resetcolor[]="")
{
	new cargo[35];

	switch(level)
	{
		case DEV:
			format(cargo, sizeof(cargo), "%s%s", (usecolor ? ("{ff6800}Desenvolvedor(a)") : ("Desenvolvedor(a)")));
		case DIRECAO:
			format(cargo, sizeof(cargo), "%s%s", (usecolor ? ("{31B404}Diretor(a)") : ("Diretor(a)")));
		case ADMINISTRADOR:
			format(cargo, sizeof(cargo), "%s%s", (usecolor ? ("{009ACD}Administrador(a)") : ("Administrador(a)")));
		case MODERADOR:
			format(cargo, sizeof(cargo), "%s%s", (usecolor ? ("{FF0000}Moderador(a)") : ("Moderador(a)")));
		case AJUDANTE:
			format(cargo, sizeof(cargo), "%s%s", (usecolor ? ("{FFFF00}Ajudante") : ("Ajudante")));
		default:
			format(cargo, sizeof(cargo), "Jogador(a)");
	}
	if(!isnull(resetcolor))
		format(cargo, sizeof(cargo), "%s{%s}", cargo, resetcolor);

	return cargo; 
}

function ADMIN::GetPlayerAdminLevel(playerid){
	return Admin[playerid][AdminLevel];
}

function ADMIN::SetPlayerAdminLevel(playerid, level){

	if(level < AJUDANTE || level > DEV)
		return false;

	Admin[playerid][AdminLevel] = level;

	if(!Iter_Contains(PlayersAdmin, playerid))
		Iter_Add(PlayersAdmin, playerid);
		
	return true;
}

function ADMIN::ToggleAdminInJob(playerid, bool:toggle)
{
	if(!IsPlayerConnected(playerid) || !call::PLAYER->IsPlayerLogged(playerid))
		return false;

	Admin[playerid][Trabalhando] = toggle;
	return true;
}


function ADMIN::IsAdminInJob(playerid)
{
	if ( !IsPlayerConnected(playerid))
		return false;

	return Admin[playerid][Trabalhando];
}

function ADMIN::RemovePlayerAdmin(playerid){

	if(Iter_Contains(PlayersAdmin, playerid)){
		Iter_Remove(PlayersAdmin, playerid);
		Admin[playerid][AdminLevel] = 0;
		Admin[playerid][Trabalhando] = false;
		return true;
	}
	return false;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	for(new i; i < MAX_VEHICLES_PER_ADMIN; i++)
	{
		foreach(new id: Player)
		{
			if(IsValidVehicle(Admin[id][vAdmin][i]))
			{
				if(vehicleid == Admin[id][vAdmin][i])
				{
					if(!call::ADMIN->IsAdminInJob(playerid))
					{
						SendClientMessage(playerid, COR_ERRO, "| ERRO | Este é um veículo administrativo e você não poderá dirigi-lo!");
						ClearAnimations(playerid);
					}
				}
			}
		}
	}
	return 1;
}

function ADMIN::CreateVehicleToAdmin(playerid, model)
{
	static Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);

	for(new i; i < MAX_VEHICLES_PER_ADMIN; i++)
	{
		if(IsValidVehicle(Admin[playerid][vAdmin][i]))
			continue;

		Admin[playerid][vAdmin][i] = CreateVehicle(model, x, y, z, a, random(200), random(200), -1);
		LinkVehicleToInterior(Admin[playerid][vAdmin][i], GetPlayerInterior(playerid));
		SetVehicleVirtualWorld(Admin[playerid][vAdmin][i], GetPlayerVirtualWorld(playerid));
		PutPlayerInVehicle(playerid, Admin[playerid][vAdmin][i], 0);
		RepairVehicle(Admin[playerid][vAdmin][i]);
		SetVehicleHealth(Admin[playerid][vAdmin][i], 99999.0);
		return true;
	}
	return false;
}

function ADMIN::DestroyAllVehicleToAdmin(playerid)
{
	new count=0;
	for(new i; i < MAX_VEHICLES_PER_ADMIN; i++)
	{
		if(IsValidVehicle(Admin[playerid][vAdmin][i]))
		{
			DestroyVehicle(Admin[playerid][vAdmin][i]);
			Admin[playerid][vAdmin][i] = 0;
			count++;
		}
	}
	if(count)return true;
	return false;
}


function ADMIN::DestroyVehicleToAdmin(playerid, vehicleid)
{
	for(new i; i < MAX_VEHICLES_PER_ADMIN; i++)
	{
		if(Admin[playerid][vAdmin][i] == vehicleid)
		{
			DestroyVehicle(Admin[playerid][vAdmin][i]);
			Admin[playerid][vAdmin][i] = 0;
			return true;
		}
	}
	return false;
}

AccountBanTemp(username[], motivo[], admin[], ip[], tempo)
{
	new query[MAX_PLAYER_NAME + 255];
	tempo = ConvertDays(tempo);
	mysql_format(getConexao(), query, sizeof(query), "INSERT INTO "TABLE_BANNEDS" (`username`,`admin`,`ip`,`data`,`motivo`,`temp-ban`)VALUES('%s','%s','%s',NOW(),'%s','%d')", username, admin, ip, motivo, tempo);
	mysql_tquery(getConexao(), query);
	return true;
}

AccountBanOff(username[], motivo[], admin[], ip[])
{
	new query[MAX_PLAYER_NAME + 255];
	mysql_format(getConexao(), query, sizeof(query), "INSERT INTO "TABLE_BANNEDS" (`username`,`admin`,`ip`,`data`,`motivo`,`temp-ban`)VALUES('%s','%s','%s',NOW(),'%s','0')", username, admin, ip, motivo);
	mysql_tquery(getConexao(), query);
	return true;
}

ReadBan(username[], ip[], info[], len = sizeof(info))
{
	new query[255], tempban;
	mysql_format(getConexao(), query, sizeof(query), "SELECT `admin`,`motivo`,`temp-ban`,DATE_FORMAT(`data`, '%%d/%%m/%%Y as %%H:%%i:%%s') as `dataf` FROM "TABLE_BANNEDS" WHERE `username`='%s' OR `ip`='%s' LIMIT 1;", username, ip);
	new Cache:cache = mysql_query(getConexao(), query, true), admin[MAX_PLAYER_NAME], reason[100], data[30];
			
	cache_get_value_name(0, "admin", admin, sizeof(admin));
	cache_get_value_name(0, "motivo", reason, sizeof(reason));
	cache_get_value_name(0, "dataf", data, sizeof(data));
	cache_get_value_name_int(0, "temp-ban", tempban);

	if(tempban == 0)
	{
		format(info, len, "{"COR_BRANCO_INC"}Você foi banido deste servidor.\n\nAdmin: {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}\nMotivo: {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}\nTempo: {"COR_VERMELHO_INC"}Permanente{"COR_BRANCO_INC"}\nData: {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}.\n\nAcesse nosso fórum em {"COR_SISTEMA_INC"}"SERVER_SITE"", admin, reason, data);
	}
	else if(tempban >= 1)
	{
		format(info, len, "{"COR_BRANCO_INC"}Você foi banido deste servidor.\n\nAdmin: {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}\nMotivo: {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}\nTempo: {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}\nData: {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}.\n\nAcesse nosso fórum em {"COR_SISTEMA_INC"}"SERVER_SITE"", admin, reason, ConvertToDays(tempban), data);
	}
	cache_delete(cache);
	return true;
}

stock ConvertToDays(n)
{
    new t[5], DString[128];
    t[4] = n-gettime();
    t[0] = t[4] / 3600;
    t[1] = ((t[4] / 60) - (t[0] * 60));
    t[2] = (t[4] - ((t[0] * 3600) + (t[1] * 60)));
    t[3] = (t[0]/24);
 
    if(t[3] > 0)
        t[0] = t[0] % 24,
        format(DString, sizeof(DString), "%ddias, %02dh %02dm e %02ds", t[3], t[0], t[1], t[2]);
    else if(t[0] > 0)
        format(DString, sizeof(DString), "%02dh %02dm e %02ds", t[0], t[1], t[2]);
    else
        format(DString, sizeof(DString), "%02dm e %02ds", t[1], t[2]);
    return DString;
}

forward ExecuteToTime(playerid, type, time);
public ExecuteToTime(playerid, type, time)
{
	SetSVarInt("ExecuteToTime_Var", 1);
	if(time <= 0)
	{
		DeleteSVar("ExecuteToTime_Var");
		switch(type)
		{
			case CMD_TYPE_LIMPARCHAT:
			{
				PC_EmulateCommand(playerid, "/limparchat");
			}
			case CMD_TYPE_RVS:
			{
				PC_EmulateCommand(playerid, "/rvs");
			}
		}
		time = 0;
	    return false;
	}
	new str[5];
	--time;
	format(str, sizeof(str),"%d", time);
	GameTextForAll(str, 1000, 3);
	SetTimerEx("ExecuteToTime", 1000, false, "ddd", playerid, type, time);
	return true;
}

stock IsUsedCommandTime()
	return GetSVarInt("ExecuteToTime_Var");

forward TimerMute(playerid);
public TimerMute(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(Jogador[playerid][Calado] != true)
			return false;

		if(Jogador[playerid][TempoCalado] > 0)
		{
			Jogador[playerid][TempoCalado]--;
			SetTimerEx("TimerMute", 1000, false, "i", playerid);
		}
		else
		{
			Jogador[playerid][Calado] = false, Jogador[playerid][TempoCalado] = 0;
			SendClientMessage(playerid, COR_AMARELO, "| INFO | Você foi descalado.");
		}
	}
	return true;
}

forward Respawn10();
public Respawn10()
{
    GameTextForAll("~w~~r~>>~w~Veículos não utilizados serão respawnados em ~r~10~w~ segundos! ~r~<<", 5000, 3);
	//SetTimer("HideTextDrawRV", 5000, false);
	SetTimer("CountRV", 10000, false);
	return 1;
}

forward CountRV();
public CountRV()
{
	CreateCountdownRV(5, 1);
	return 1;
}

PaginaAtividades(playerid, pag, bool:admin=false) {
    new Cache:b, query[250], string[4000], pname[24], topo[128];
    SetPVarInt(playerid, "buscar_reg_pag", pag);
    GetPVarString(playerid, "buscar_reg_player", pname, 24);
    if(admin == true) {
        mysql_format(getConexao(), query, sizeof(query), "SELECT atividade,info,time FROM atividade_administrativa INNER JOIN contas ON contas.ID = atividade_administrativa.pid WHERE contas.Nick='%e' ORDER BY atividade_administrativa.id DESC LIMIT %i,30", pname, pag);
        b = mysql_query(getConexao(), query, true);
        if(cache_num_rows() > 0)
        {
            format(topo, 128, "{FFFF00}# {FFFFFF}Registros do administrador: %s", pname);
            strcat(string, "Atividade\nInformações\tData\n");
            for(new i; i < cache_num_rows(); i++) {
                new atividade[32], info[256], timestamp22, date[6];
                cache_get_value_name(i, "atividade", atividade, 32);
            	cache_get_value_name(i, "info", info, 256);
            	cache_get_value_name_int(i, "time", timestamp22);
                gm_timestamp_to_date(timestamp22, date[0], date[1], date[2], date[5], date[4], date[3]);
                format(string, sizeof(string), "%s%s\t%s\t%02d/%02d/%d %02d:%02d\n", string, atividade, info, date[3], date[4], date[5], date[0], date[1]);
            }
            if(cache_num_rows() >= 30)
                strcat(string, "{FFFF00}Próxima Página\n");
            
            ShowPlayerDialog(playerid, RegAtividades, DIALOG_STYLE_TABLIST_HEADERS, topo, string, "Ok", "Cancelar");
            cache_delete(b);
        }
        else
            SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foram encontrados registros para este administrador.");
        return 1;
    }
    mysql_format(getConexao(), query, sizeof(query), "SELECT atividade,info,time FROM atividades INNER JOIN contas ON contas.ID = atividades.pid WHERE contas.Nick='%e' ORDER BY atividades.id DESC LIMIT %i,30", pname, pag);
    b = mysql_query(getConexao(), query, true);
    if(cache_num_rows() > 0)
    {
        format(topo, 128, "{FFFF00}# {FFFFFF}Registros do jogador: %s", pname);
        strcat(string, "Atividade\nInformações\tData\n");
        for(new i; i < cache_num_rows(); i++) {
            new atividade[32], info[256], timestamp23, date[6];
            cache_get_value_name(i, "atividade", atividade, 32);
            cache_get_value_name(i, "info", info, 256);
            cache_get_value_name_int(i, "time", timestamp23);
            gm_timestamp_to_date(timestamp23, date[0], date[1], date[2], date[5], date[4], date[3]);
            format(string, sizeof(string), "%s%s\t%s\t%02d/%02d/%d %02d:%02d\n", string, atividade, info, date[3], date[4], date[5], date[0], date[1]);
        }
        if(cache_num_rows() >= 30)
            strcat(string, "{FFFF00}Próxima Página\n");
        
        ShowPlayerDialog(playerid, RegAtividades, DIALOG_STYLE_TABLIST_HEADERS, topo, string, "Ok", "Cancelar");
        cache_delete(b);
    }
    else
        SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foram encontrados registros para este jogador.");
    return 1;
}