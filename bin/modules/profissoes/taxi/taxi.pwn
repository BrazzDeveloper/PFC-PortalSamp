

enum infoTaxi
{
	bool:Iniciado,
	MotoristaID,
	PassageiroID,
	Valor,
	Bandeira
}
static Taxi[MAX_VEHICLES][infoTaxi], reset[infoTaxi];

static pSettimer[MAX_PLAYERS] = -1, pVehicle[MAX_PLAYERS] = INVALID_VEHICLE_ID;

static
	PlayerText:TDEditor_PTD[MAX_PLAYERS][5], Cancela, bool:OpenC;

#include <YSI_Coding\y_hooks>
hook OnGameModeInit()
{
	new tmpobjid;
	tmpobjid = CreateDynamicObject(18766, 1761.36194, -1692.31177, 13.94197,   0.00000, 0.00000, 90.09677);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "brick", 0x00000000);
	
	tmpobjid = CreateDynamicObject(18766, 1798.55408, -1700.86853, 13.94197,   0.00000, 0.00000, 90.09677);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "brick", 0x00000000);
	
	tmpobjid = CreateDynamicObject(18766, 1798.53967, -1692.13538, 13.94197,   0.00000, 0.00000, 90.09677);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "brick", 0x00000000);
	
	tmpobjid = CreateDynamicObject(18766, 1765.87097, -1686.65491, 13.94197,   0.00000, 0.00000, 180.03668);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "brick", 0x00000000);

	tmpobjid = CreateDynamicObject(18766, 1785.90552, -1686.68726, 13.94197,   0.00000, 0.00000, 179.92171);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "brick", 0x00000000);

	tmpobjid = CreateDynamicObject(18766, 1775.85876, -1686.68274, 13.94197,   0.00000, 0.00000, 179.92171);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "brick", 0x00000000);

	tmpobjid = CreateDynamicObject(18766, 1794.03906, -1686.72449, 13.94197,   0.00000, 0.00000, 179.92171);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "brick", 0x00000000);

	tmpobjid = CreateDynamicObject(18766, 1761.38232, -1692.08887, 13.94197,   0.00000, 0.00000, 90.09677);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "brick", 0x00000000);

	tmpobjid = CreateDynamicObject(18766, 1798.55408, -1700.86853, 13.94197,   0.00000, 0.00000, 90.09677);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "brick", 0x00000000);

	tmpobjid = CreateDynamicObject(18766, 1798.53967, -1692.13538, 13.94197,   0.00000, 0.00000, 90.09677);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "brick", 0x00000000);

	tmpobjid = CreateDynamicObject(18783, 1788.52112, -1696.72095, 10.04520,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tmpobjid, 1, 9514, "711_sfw", "brick", 0x00000000);
	
	tmpobjid = CreateDynamicObject(18783, 1771.88171, -1697.18176, 10.03397,   0.00000, 0.00000, 0.12000);
	SetDynamicObjectMaterial(tmpobjid, 1, 9514, "711_sfw", "brick", 0x00000000);

	CreateDynamicObject(967, 1760.109985, -1696.080810, 12.416500, 0.000000, 0.000000, 180.163375, -1, -1, -1, 300.00, 300.00);
	CreateDynamicObject(966, 1762.145996, -1696.914306, 12.394610, 0.000000, 0.000000, 89.279991, -1, -1, -1, 300.00, 300.00);
	CreateDynamicObject(19310, 1760.064941, -1696.114379, 15.303310, 0.000000, 0.000000, 360.399475, -1, -1, -1, 300.00, 300.00);
	Cancela = CreateDynamicObject(968, 1762.16150, -1696.90295, 13.20880, 0.00000, -91.00000, 88.87519);
	
	/*			TaxiS 				*/
	call::JOB->SetVehicleJob(CreateVehicle(420, 1790.8640, -1690.3817, 13.2475, 177.9990, -1, -1, TIME_VEHICLE_SPAWN), TAXISTA);
	call::JOB->SetVehicleJob(CreateVehicle(420, 1786.5239, -1690.2762, 13.2475, 177.9990, -1, -1, TIME_VEHICLE_SPAWN), TAXISTA);
	call::JOB->SetVehicleJob(CreateVehicle(420, 1781.9609, -1690.2269, 13.2475, 179.2590, -1, -1, TIME_VEHICLE_SPAWN), TAXISTA);
	call::JOB->SetVehicleJob(CreateVehicle(420, 1795.2784, -1690.4408, 13.2475, 177.9990, -1, -1, TIME_VEHICLE_SPAWN), TAXISTA);
	call::JOB->SetVehicleJob(CreateVehicle(420, 1777.5392, -1690.2650, 13.2475, 178.2990, -1, -1, TIME_VEHICLE_SPAWN), TAXISTA);
	call::JOB->SetVehicleJob(CreateVehicle(420, 1773.3357, -1690.2594, 13.2475, 179.2391, -1, -1, TIME_VEHICLE_SPAWN), TAXISTA);
	call::JOB->SetVehicleJob(CreateVehicle(420, 1769.0388, -1690.2190, 13.2475, 180.4072, -1, -1, TIME_VEHICLE_SPAWN), TAXISTA);
	call::JOB->SetVehicleJob(CreateVehicle(420, 1764.6781, -1690.1317, 13.2475, 180.8657, -1, -1, TIME_VEHICLE_SPAWN), TAXISTA);

	/*			Actor 				*/
	CreateDynamicActor(42, 1760.1962, -1696.2220, 13.4347, 177.0069);
}
hook OnPlayerConnect(playerid)
{
	for(new i; i < sizeof(TDEditor_PTD[]); i++)
		TDEditor_PTD[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	call::TAXI->CancelarTrabalho(playerid);
	return true;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if( IsValidVehicle(pVehicle[playerid]) )
	{
		new vehicleid = pVehicle[playerid];
		if(Taxi[vehicleid][PassageiroID] == playerid)
		{
			SendClientMessage(playerid, COR_AZUL, "TAXI: O Passageiro saiu do jogo, você recebeu R$%s", RealStr(Taxi[vehicleid][Valor]));
			GivePlayerMoney(Taxi[vehicleid][MotoristaID], Taxi[vehicleid][Valor]);
			GivePlayerMoney(playerid, -Taxi[vehicleid][Valor]);
		}
		call::TAXI->CancelarTrabalho(Taxi[vehicleid][MotoristaID]);
		call::TAXI->CancelarTrabalho(Taxi[vehicleid][PassageiroID]);
		call::TAXI->reset(vehicleid);
	}
	pVehicle[playerid] = INVALID_VEHICLE_ID;
	return true;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if ( oldstate == PLAYER_STATE_PASSENGER )
	{
		if( IsValidVehicle(pVehicle[playerid]) )
		{
			new vehicleid = pVehicle[playerid];
			if(Taxi[vehicleid][MotoristaID] != playerid)
			{
				SendClientMessage(Taxi[vehicleid][MotoristaID], GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}O Passageiro saiu do veiculo, você recebeu {"COR_VERDE_INC"}R$%s", RealStr(Taxi[vehicleid][Valor]));
				SendClientMessage(Taxi[vehicleid][PassageiroID], GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Você saiu do veiculo e pagou {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} ao motorista.", RealStr(Taxi[vehicleid][Valor]));

				GivePlayerMoney(Taxi[vehicleid][MotoristaID], Taxi[vehicleid][Valor], true);
				GivePlayerMoney(Taxi[vehicleid][PassageiroID], -Taxi[vehicleid][Valor], true);

				pVehicle[Taxi[vehicleid][MotoristaID]] = INVALID_VEHICLE_ID;
				pVehicle[Taxi[vehicleid][PassageiroID]] = INVALID_VEHICLE_ID;
				
				KillTimer(pSettimer[Taxi[vehicleid][MotoristaID]]);
				pSettimer[Taxi[vehicleid][MotoristaID]] = -1;

				call::TAXI->DestroyTaximetro(Taxi[vehicleid][PassageiroID]);
				call::TAXI->DestroyTaximetro(Taxi[vehicleid][MotoristaID]);
				call::TAXI->CancelarTrabalho(playerid);
				
				call::TAXI->reset(vehicleid);
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!IsPlayerInRangeOfPoint(playerid, 20.0, 1762.5563, -1700.8585, 13.5340))
		return Y_HOOKS_CONTINUE_RETURN_1;

	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != TAXISTA)
		return Y_HOOKS_CONTINUE_RETURN_1;

	if(PRESSED(KEY_CROUCH))
	{
		if(OpenC)
			return Y_HOOKS_CONTINUE_RETURN_1;

		call::TAXI->AbrirCancela();
		SetTimer("TAXI_FecharCancela", 5000, false);
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

forward OnPlayerUpdateTaximetro(vehicleid, valor);
public OnPlayerUpdateTaximetro(vehicleid, valor)
{
	new id = Taxi[vehicleid][PassageiroID], playerid = Taxi[vehicleid][MotoristaID];

	if(GetPlayerMoney(id) < (Taxi[vehicleid][Valor] + valor))
	{
		RemovePlayerFromVehicle(id);
		SendClientMessage(playerid, COR_BRANCO, "» O Passageiro não possui mais dinheiro, você recebeu {"COR_VERDE_INC"}R$%s", RealStr(Taxi[vehicleid][Valor]));
		SendClientMessage(id, COR_AVISO, "» Você não tem mais dinheiro para pagar o taxista.");
		GivePlayerMoney(playerid, Taxi[vehicleid][Valor]);

		call::TAXI->CancelarTrabalho(id);
		call::TAXI->CancelarTrabalho(playerid);

		call::TAXI->reset(vehicleid);
		return true;
	}

	Taxi[vehicleid][Valor] += valor;

	static str[35];
	str[0] = EOS;
	format(str, sizeof(str), "Valor: ~h~~h~~h~~g~R$%s", RealStr(Taxi[vehicleid][Valor]));
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][4], str);
	PlayerTextDrawSetString(id, TDEditor_PTD[playerid][4], str);
	return true;
}

forward UpdatePositionPassager(playerid);
public UpdatePositionPassager(playerid)
{
	if( !IsPlayerConnected(playerid) || pVehicle[playerid] != INVALID_VEHICLE_ID)
		return false;
	

	static Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	foreach(new i: Player)
	{
		if( call::PLAYER->GetPlayerVarInt(i, Profissao) != TAXISTA ) 
			continue;

		RemovePlayerMapIcon(i, 10);
		SetPlayerMapIcon(i, 10, x, y, z, 0, COR_AMARELO, MAPICON_GLOBAL);
	}
	SetTimerEx("UpdatePositionPassager", 5000, false, "i", playerid);
	return true;
}

hook OnVehicleSpawn(vehicleid)
{
	if ( Taxi[vehicleid][Iniciado] )
	{
		call::TAXI->reset(vehicleid);
		return Y_HOOKS_CONTINUE_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1; 
}

/*				FUNCTIONS 				*/
function TAXI::CancelarTrabalho(playerid)
{
	if(pSettimer[playerid] != -1)
		KillTimer(pSettimer[playerid]), pSettimer[playerid]=-1;

	pVehicle[playerid] = INVALID_VEHICLE_ID;
	call::TAXI->DestroyTaximetro(playerid);
	return true;
}

function TAXI::reset(vehicleid)
{
	if ( vehicleid != INVALID_VEHICLE_ID)
	{
		Taxi[vehicleid] = reset;
		Taxi[vehicleid][MotoristaID] = INVALID_PLAYER_ID;
		Taxi[vehicleid][PassageiroID] = INVALID_PLAYER_ID;
	}
	return true;
}

function TAXI::AbrirCancela()
{
	static Float:x, Float:y, Float:z;
	GetDynamicObjectPos(Cancela, x, y, z);
	MoveDynamicObject(Cancela, x, y, z+0.0001, 0.0001, 0.000000, 0.000000, 90.000000);
	OpenC = true;
}

forward TAXI_FecharCancela();
public TAXI_FecharCancela()
{
	static Float:x, Float:y, Float:z;
	GetDynamicObjectPos(Cancela, x, y, z);
	MoveDynamicObject(Cancela, x, y, z-0.0001, 0.0001, 0.00000, -90.00000, 88.87519);
	OpenC = false;
	return true;
}

function TAXI::CreateTDEditor_PTD(playerid)
{
	TDEditor_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 38.000000, 265.000000, "_");
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][0], 0.662499, 7.100008);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][0], 105.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][0], 0);

	TDEditor_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 52.000000, 262.000000, "~y~Taximetro");
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][1], 0.224999, 1.750000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][1], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][1], 0);

	TDEditor_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 41.000000, 277.000000, "-");
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][2], 4.362502, 0.250000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][2], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][2], 0);

	TDEditor_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 40.000000, 282.000000, "Bandeira:~h~~h~~h~~b~1");
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][3], 0.224999, 1.750000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][3], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][3], 0);

	TDEditor_PTD[playerid][4] = CreatePlayerTextDraw(playerid, 41.000000, 298.000000, "Valor: ~g~R$0");
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][4], 0.208333, 1.649999);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][4], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][4], 0);
	
	/*TDEditor_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 140.989898, 349.482269, "box");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][0], 0.000000, 6.767203);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][0], 203.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][0], 100);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);

	TDEditor_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 144.289840, 351.583374, "taximetro");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][1], 0.228052, 0.923332);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 0);

	TDEditor_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 136.325042, 361.499969, "-");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][2], 5.000000, 0.300000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][2], 0);

	TDEditor_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 144.289840, 368.982666, "bandeira:~n~~h~~h~~b~1");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][3], 0.228052, 0.923332);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][3], 203.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][3], 0);

	TDEditor_PTD[playerid][4] = CreatePlayerTextDraw(playerid, 144.289840, 391.481750, "valor: ~g~R$0");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][4], 0.228052, 0.923331);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][4], 203.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][4], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][4], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][4], 0);*/

}
function TAXI::DestroyTaximetro(playerid)
{
	for(new i; i < sizeof(TDEditor_PTD[]); i++)
	{
		if ( TDEditor_PTD[playerid][i] != PlayerText:INVALID_TEXT_DRAW )
		{
			PlayerTextDrawDestroy(playerid, TDEditor_PTD[playerid][i]);
			TDEditor_PTD[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		}
	}
}

function TAXI::ShowPlayerTaximetro(playerid)
{
	call::TAXI->CreateTDEditor_PTD(playerid);
	for(new i; i < sizeof(TDEditor_PTD[]); i++){
		PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][i]);
	}
	return true;
}

function TAXI::CallTaxi(playerid)
{
	static zone[MAX_ZONE_NAME], Float:x, Float:y, Float:z;
	new count;

	zone[0] = EOS;
	GetPlayer3DZone(playerid, zone, sizeof(zone));
	GetPlayerPos(playerid, x, y, z);


	foreach(new i: Player)
	{
		if(call::PLAYER->GetPlayerVarInt(i, Profissao) != TAXISTA)
			continue;

		count++;
		SendClientMessage(i, COR_AMARELO, "| TAXI | {"COR_BRANCO_INC"}%s[%d]{"COR_AMARELO_INC"} está solicitando um taxi em {"COR_BRANCO_INC"}%s{"COR_AMARELO_INC"}.", GetUserName(playerid), playerid, zone);
	}
	if( count ) {
		SetTimerEx("UpdatePositionPassager", 500, false, "i", playerid);
		SendClientMessage(playerid, COR_AMARELO, "| TAXI | Você pediu um táxi, aguarde no local.");
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "Não foi possivel chamar um taxi.");
	return false;
}

/*				CMD 			*/

CMD:taximetro(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa está em um taxi.");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa está de motorista.");

	new vehicleid = GetPlayerVehicleID(playerid);
	if(call::JOB->GetVehicleJob(vehicleid) != TAXISTA)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está no veiculo dos taxistas.");

	new id, valor;
	if(sscanf(params, "ud", id, valor))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/taximetro [playerid/username] [valor=5 á 50]");

	if(playerid == id)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode ligar o taximetro para você mesmo.");

	if(!call::PLAYER->IsPlayerLogged(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está logado.");

	if(GetPlayerVehicleID(id) != vehicleid)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está no taxi.");

	if(valor > 50 || valor < 5)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve usar valores de 5 á 50 reais.");

	if(GetPlayerMoney(id) < valor)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não tem dinheiro para continuar a viagem.");

	if(Taxi[vehicleid][Iniciado])
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Taximetro já está rodando.");

	if(pVehicle[id] != INVALID_VEHICLE_ID)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador já é passageiro de outro taxista.");

	new hora, str[35];
	gettime(hora);
	Taxi[vehicleid][Bandeira] = ( (hora >= 22 || hora  <= 8 ) ? 2 : 1);

	pVehicle[playerid] = vehicleid;
	pVehicle[id] = vehicleid;

	Taxi[vehicleid][Valor] = valor;
	Taxi[vehicleid][MotoristaID] = playerid;
	Taxi[vehicleid][PassageiroID] = id;
	Taxi[vehicleid][Iniciado] = true;

	if(pSettimer[playerid] == -1)
		pSettimer[playerid] = SetTimerEx("OnPlayerUpdateTaximetro", (Taxi[vehicleid][Bandeira] == 2 ? 30000 : 20000), true, "dd", vehicleid, valor);

	call::TAXI->ShowPlayerTaximetro(playerid);
	call::TAXI->ShowPlayerTaximetro(id);

	format(str, sizeof(str), "Bandeira: ~h~~h~~h~~b~%d", Taxi[vehicleid][Bandeira]);
	PlayerTextDrawSetString(id, TDEditor_PTD[playerid][3], str);
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][3], str);

	format(str, sizeof(str), "Valor: ~h~~h~~h~~g~R$%d", Taxi[vehicleid][Valor]);
	PlayerTextDrawSetString(id, TDEditor_PTD[playerid][4], str);
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][4], str);
	
	foreach(new i: Player)
	{
		if(call::PLAYER->GetPlayerVarInt(i, Profissao) == TAXISTA){
			RemovePlayerMapIcon(i, 10);
		}		
	}

	SendClientMessage(playerid, COR_AZUL, "Você iniciou o taximetro em {"COR_VERDE_INC"}R$%s{"COR_AZUL_INC"} na bandeira {"COR_BRANCO_INC"}%d{"COR_AZUL_INC"}.", RealStr(valor), Taxi[vehicleid][Bandeira]);
	SendClientMessage(id, COR_AZUL, "O Taxista iniciou o taximetro em {"COR_VERDE_INC"}R$%s{"COR_AZUL_INC"} na bandeira {"COR_BRANCO_INC"}%d{"COR_AZUL_INC"}.", RealStr(valor), Taxi[vehicleid][Bandeira]);
	return true;
}

CMD:finalizartaximetro(playerid)
{
	new vehicleid = pVehicle[playerid];

	if(vehicleid == INVALID_VEHICLE_ID)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não iniciou o taximetro.");

	if(playerid != Taxi[vehicleid][MotoristaID])
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é o motorista deste taxi.");

	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) == TAXISTA)
	{
		SendClientMessage(Taxi[vehicleid][MotoristaID], COR_SISTEMA, "» {"COR_BRANCO_INC"}O Taximetro foi {"COR_VERDE_INC"}finalizado{"COR_BRANCO_INC"}, e você recebeu {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.", RealStr(Taxi[vehicleid][Valor]));
		SendClientMessage(Taxi[vehicleid][PassageiroID], COR_SISTEMA, "» {"COR_BRANCO_INC"}O Taxista {"COR_VERDE_INC"}finalizou{"COR_BRANCO_INC"} o taximetro, você pagou {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}", RealStr(Taxi[vehicleid][Valor]));

		GivePlayerMoney(Taxi[vehicleid][MotoristaID], Taxi[vehicleid][Valor]);
		GivePlayerMoney(Taxi[vehicleid][PassageiroID], -Taxi[vehicleid][Valor]);

		call::TAXI->CancelarTrabalho(Taxi[vehicleid][MotoristaID]);
		call::TAXI->CancelarTrabalho(Taxi[vehicleid][PassageiroID]);
		call::TAXI->reset(vehicleid);
		return true;
	}
	return true;
}