//


/**
*
*	forwards
*
**/
forward OnPlayerPay();

// Defeni��es ve�culos

#define VehicleFlatbed			455 // Truck: Flatbed
#define VehicleDFT30			578 // Truck: DFT-30
#define VehicleCementTruck		524 // Truck: Cementtruck
#define VehicleLineRunner		403 // Truck: LineRunner
#define VehicleTanker			514 // Truck: Tanker
#define VehicleRoadTrain		515 // Truck: RoadTrain
#define VehicleTrailerCargo		435 // Trailer: cargo
#define VehicleTrailerCargo2	591 // Trailer: cargo
#define VehicleTrailerOre		450 // Trailer: Ore
#define VehicleTrailerFluids	584 // Trailer: Fluids
#define VehicleYankee           456
#define VehicleYosemite         554
#define VehicleRumpo            440
#define VehicleBoxvile          498
#define VehicleCoach			437 // Bus
#define VehicleBus              431 //Bus�o
#define VehicleShamal           519 // Plane: Shamal
#define VehicleNevada           553 // Plane: Nevada
#define VehicleStuntPlane       513 // Plane: Stuntplane
#define VehicleDodo       		593 // Plane: Dodo
#define VehicleMaverick         487 // Helicopter: Maverick
#define VehicleCargobob         548 // Helicopter: Cargobob
#define VehicleAT400            577 // Plane: AT400
#define VehicleAndromada        592 // Plane: Andromada
#define VehicleBeagle           511
#define VehiclePoliceLSPD       596 // Police Car Los Santos Police Department
#define VehiclePoliceSFPD       597 // Police Car San Fierro Police Department
#define VehiclePoliceLVPD       598 // Police Car Las Venturas Police Department
#define VehicleHPV1000          523 // Police motorcycle
#define VehiclePoliceRanger     599 // Police Ranger
#define VehicleInfernusPolice   411 // Policial Infernus
#define VehicleMaverickPolice   497 // Maverick Policial
#define VehicleEnforcer         427 //Cambur�o LSPD
#define VehiclePatriot          470 //Patriot Exercito
#define VehiclePoliceFBI        490 //Blazer FBI
#define VehicleSwatTank         601 //Cambur�o Swat
#define VehicleFBITruck         528 //Cambur�o FBI
#define VehicleBarracks         433 //Cambur�o Exercito
#define VehicleCargoBob         548 //Heli Exercito
#define VehicleSecurity         428
#define VehicleSandKing			495 // Mafia-van: Sandking
#define VehicleSultan           560 // Mafia-van: Sultan
#define VehicleTaxi             420 // Taxi
#define VehicleCabbie           438
#define VehicleNews             488 // heli da news
#define VehicleBike             509 // Bike: Bike
#define VehicleBMX              481 // Bike: BMX
#define VehicleMountainBike     510 // Bike: Mountain Bike
#define VehicleFaggio           462 // Bike: Faggio
#define VehiclePizzaBoy         448 // Bike: Pizzaboy
#define VehicleBF400            581 // Bike: BF-400
#define VehicleNRG500           522 // Bike: NRG-500
#define VehiclePCJ600           461 // Bike: PCJ-600
#define VehicleFCR900           521 // Bike: FCR-900
#define VehicleFreeway          463 // Bike: Freeway
#define VehicleWayfarer        	586 // Bike: Wayfarer
#define VehicleSanchez          468 // Bike: Sanchez
#define VehicleQuad             471 // Bike: Quad
#define VehicleCoastguard		472 // Boat: Coastguard
#define VehicleDinghy			473 // Boat: Dinghy
#define VehicleJetmax			493 // Boat: Jetmax
#define VehicleLaunch			595 // Boat: Launch
#define VehicleMarquis			484 // Boat: Marquis
#define VehiclePredator			430 // Boat: Predator
#define VehicleReefer			453 // Boat: Reefer
#define VehicleSpeeder			452 // Boat: Speeder
#define VehicleSquallo			446 // Boat: Squallo
#define VehicleTropic			454 // Boat: Tropic
#define VehicleAmbulance        416
#define VehicleRhino            432 // Tank: Rhino
#define VehiclePatriot          470 // Jeep: Patriot
#define VehicleTowTruck         525 // Towtruck
#define VehicleBurrito          482 // Van: Burrito
#define VehicleFaggio           462 // Bike: Faggio
#define VehicleBenson           499 // Truck: Benson
#define VehicleDozer            486 // Dozer
#define VehicleUtilityVan       552 // Utility Van
#define VehicleUtilityTrailer   611 // Utility trailer

#define PCV_TruckerOreTrailer			1
#define PCV_TruckerFluidsTrailer     	2
#define PCV_TruckerCargoTrailer      	3
#define PCV_TruckerCementTruck       	4
#define PCV_TruckerNoTrailer         	5
#define PCV_PilotPlane               	6
#define PCV_PilotHelicopter          	7
#define PCV_MafiaVan                 	8
#define PCV_Barcos                      9


enum
{
	HONESTAS = 1,
	CRIMINOSA,
	TRANSPORTE,
	GOVERNAMENTAL
}

enum e_JobInfo
{
	Float:MaletaX,
	Float:MaletaY,
	Float:MaletaZ,
	Float:SkinX,
	Float:SkinY,
	Float:SkinZ,
	sInterior,
	Salario,
	Color,
	Level,
	SkinID,
	Nome[50],
	Categoria
}
new Job[MAX_PROFISSOES][e_JobInfo];


static VehicleJob[MAX_VEHICLES], bool:IsVehicleJob[MAX_VEHICLES], bool:IsPlayerInWorking[MAX_PLAYERS], pSelectCategory[MAX_PLAYERS], SelectedJob[MAX_PLAYERS][25];


#define TIME_VEHICLE_SPAWN 				(120)


#include ..\bin\modules\profissoes\caminhoneiro\rotas.pwn
#include ..\bin\modules\profissoes\caminhoneiro\comboio.pwn
// ============================== [ LOAD PROFS ] ============================== //

#include "../bin/modules/profissoes/pizzaboy/pizzaboy.pwn"
#include "../bin/modules/profissoes/sedex/sedex.pwn"
#include "../bin/modules/profissoes/eletricista/eletricista.pwn"
#include "../bin/modules/profissoes/despachantedebagagens/despachantedebagagens.pwn"
#include "../bin/modules/profissoes/paramedicoaereo/paramedicoaereo.pwn"
#include "../bin/modules/profissoes/transportador de valores/transportadordevalores.pwn"
#include "../bin/modules/profissoes/reboque/reboque.pwn"
#include "../bin/modules/profissoes/mafia/assaltante.pwn"

#include "../bin/modules/profissoes/ladraodeveiculos/ladraodeveiculos.pwn"
//#include "../bin/modules/profissoes/caminhoneiro/caminhoneiro.pwn"
#include "../bin/modules/profissoes/caminhoneiro/caminhoneiro.pwn"
#include "../bin/modules/profissoes/taxi/taxi.pwn"
//#include "../bin/modules/profissoes/petroleiro/petroleiro.pwn"
#include "../bin/modules/profissoes/dnit/dnit.pwn"
#include "../bin/modules/profissoes/policia/policia.pwn"
#include "../bin/modules/profissoes/assaltante/assaltante.pwn"
#include "../bin/modules/profissoes/assasino/assasino.pwn"
#include "../bin/modules/profissoes/bombeiro/bombeiro.pwn"
#include "../bin/modules/profissoes/transportador de madeira/tdm.pwn"
#include "../bin/modules/profissoes/advogado/advogado.pwn"
#include "../bin/modules/profissoes/mecanico/mecanico.pwn"
#include "../bin/modules/profissoes/plantador/ptd.pwn"
#include "../bin/modules/profissoes/produtor/produtor.pwn"
#include "../bin/modules/profissoes/lenhador/lenhador.pwn"
#include "../bin/modules/profissoes/transportador de drogas/tpd.pwn"
#include "../bin/modules/profissoes/lixeiro/lixeiro.pwn"
//#include "../bin/modules/profissoes/Transportardor de Valores/tdv.pwn"
#include "../bin/modules/profissoes/pescador/pescador.pwn"

// Define Cores Profiss�es
#define DesempregadoC 			0xffffffff
#define PizzaBoyC 				0x426477ff
#define CaminhoneiroC			0xBF8A4AFF
#define TaxiC					0xC2BF09FF
#define DnitC 					0x0C6851FF
#define PoliciaC				0x05329CFF
#define AssasinoC				0xA11904FF
#define AssaltanteC				0x9A564BFF
#define BombeiroC				0x9E5C05FF
#define TDMC 					0x089D7FFF
#define AdvogadoC				0x651ECEFF
#define MecanicoC				0x619E1BFF
#define ProdutorC 				0xF5917CFF
#define PTDC 					0x67522CFF
#define TPDC 					0x673B31FF
#define LixeiroC 				0x58A48DFF
#define PescadorC				0x3BA6C3FF
#define SEDEXC                  0xFFFF00AA
#define LenhadorC				0xCD853FAA
#define EletricistaC			0x778899AA
#define DespachanteC			0x008b8bAA
#define	ParamedicoAereoC		0xBC8F8FAA
#define TransportadorValoresC	0x81BEF7AA
#define ReboqueC				0x6E6E6EAA

#define LoopJob(%0)					foreach(new %0: Profissoes)


// ============================== [ CALLBACKs ] ============================== //

function JOB::CountJobs()
{
	return Iter_Count(Profissoes);
}

stock function JOB::ShowPlayerCategoryJobs(playerid)
{
	ShowPlayerDialog(playerid, CATEGORYS_JOBS, DIALOG_STYLE_LIST, "PROFISS�ES", "Honestas\nCriminosas\nTransportes\nGovernamentais", "Selecionar", "Cancelar");
	return true;
}

function JOB::LogarProf(playerid)
{
	SetPVarInt(playerid, "ColorChanged", 0);

	switch(call::PLAYER->GetPlayerVarInt(playerid, Profissao))
	{

		case DESEMPREGADO:
			SetPlayerColor(playerid, DesempregadoC);
		case PIZZA_BOY:
			SetPlayerColor(playerid, PizzaBoyC);
		case CAMINHONEIRO:
			SetPlayerColor(playerid, CaminhoneiroC);
		case TAXISTA:
			SetPlayerColor(playerid, TaxiC);
		case DNIT:
			SetPlayerColor(playerid, DnitC);
		case POLICIA_MILITAR:
			SetPlayerColor(playerid, PoliciaC);
		case ASSASINO:
			SetPlayerColor(playerid, AssasinoC);
		case ASSALTANTE:
			SetPlayerColor(playerid, AssaltanteC);
		case BOMBEIRO:
			SetPlayerColor(playerid, BombeiroC);
		case TRANSPORTADOR:
			SetPlayerColor(playerid, TDMC);
		case TRANSP_DROGAS:
			SetPlayerColor(playerid, TPDC);
		case ADVOGADO:
			SetPlayerColor(playerid, AdvogadoC);
		case MECANICO:
			SetPlayerColor(playerid, MecanicoC);
		case PRODUTOR:
			SetPlayerColor(playerid, ProdutorC);
		case PLANTADOR:
			SetPlayerColor(playerid, PTDC);
		case LIXEIRO:
			SetPlayerColor(playerid, LixeiroC);
		case PESCADOR:
			SetPlayerColor(playerid, PescadorC);
		case SEDEX:
			SetPlayerColor(playerid, SEDEXC);
		case LENHADOR:
			SetPlayerColor(playerid, LenhadorC);
		case ELETRICISTA:
			SetPlayerColor(playerid, EletricistaC);
		case DESPACHANTE:
			SetPlayerColor(playerid, DespachanteC);
		case PARAMEDICO_AEREO:
			SetPlayerColor(playerid, ParamedicoAereoC);
		case TRANSPORTADOR_VALORES:
			SetPlayerColor(playerid, TransportadorValoresC);
		case REBOQUE:
			SetPlayerColor(playerid, ReboqueC);
	}
	return true;
}

function JOB::ShowPlayerJobsInfo(playerid, categoria)
{
	new str[512], query[128];
	str = "Emprego\tLevel\tSal�rio\n";

	mysql_format(getConexao(), query, sizeof(query), "SELECT id,nome,level,salario FROM "TABLE_JOBS" WHERE `categoria`='%d' ORDER BY level ASC", categoria);
	new Cache:cache = mysql_query(getConexao(), query, true), rows=cache_num_rows();
	if ( rows )
	{
		new nome[50], level, salario;
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", SelectedJob[playerid][i]);
			cache_get_value_name(i, "nome", nome);
			cache_get_value_name_int(i, "level", level);
			cache_get_value_name_int(i, "salario", salario);
			format(str, sizeof(str), "%s%s\t{"COR_AMARELO_INC"}%d\t{"COR_VERDE_INC"}R$%s\n", str, nome, level, RealStr(salario));
		}
	}
	else
	{
		ShowPlayerDialog(playerid, JOBS_INFO_SELECTED, DIALOG_STYLE_LIST, "PROFISS�ES", "{"COR_ERRO_INC"}N�o h� nenhuma profiss�o nessa categoria no momento", "OK", "");
		return true;
	}
	cache_delete(cache);
	ShowPlayerDialog(playerid, JOBS_INFO_SELECTED, DIALOG_STYLE_TABLIST_HEADERS, "PROFISS�ES", str, "Selecionar", "Voltar");
	return true;
}
function JOB::GetJobName(jobid, jobname[], len = sizeof(jobname))
{
	if(!call::JOB->IsValidJob(jobid))
		return false;

	format(jobname, len, Job[jobid][Nome]);
	return true;
}

function JOB::GetJobPos(jobid, &Float:x, &Float:y, &Float:z)
{
	if(!call::JOB->IsValidJob(jobid))
		return false;

	x = Job[jobid][MaletaX];
	y = Job[jobid][MaletaY];
	z = Job[jobid][MaletaZ];
	return true;
}

function JOB::SetPlayerMarkJob(playerid, jobid){
	if(!call::JOB->IsValidJob(jobid))
		return false;

	SetPlayerMapIcon(playerid, 70, Job[jobid][MaletaX], Job[jobid][MaletaY], Job[jobid][MaletaZ], 19, 0xFFFFFFAA, MAPICON_GLOBAL);
	return true;
}

function JOB::SetPlayerJob(playerid, jobid)
{
	if(!call::JOB->IsValidJob(jobid))
		return false;

	Jogador[playerid][Profissao] = jobid;

	new query[100];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `profissao`='%d' WHERE `id`='%d';", jobid, call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	mysql_tquery(getConexao(), query);
	call::JOB->SetPlayerJobColor(playerid, jobid);

	/*SendClientMessage(playerid, GetPlayerColor(playerid), "� {"COR_BRANCO_INC"}Voc� entrou para a profiss�o {"COR_SISTEMA_INC"}%s{"COR_BRANCO_INC"} com um sal�rio de {"COR_SISTEMA_INC"}R$%s{"COR_BRANCO_INC"}.", Job[jobid][Nome], RealStr(Job[jobid][Salario]));
	SendClientMessage(playerid, GetPlayerColor(playerid), "� {"COR_BRANCO_INC"}Para ver os comandos da profiss�o digite {"COR_SISTEMA_INC"}/ajuda{"COR_BRANCO_INC"} e v� at� a op��o profiss�o.");*/
	return true;
}

function JOB::SetPlayerJobColor(playerid, jobid)
{
	SetPlayerColor(playerid, Job[jobid][Color]);
	return true;
}

function JOB::IsPlayerInJobLocal(playerid, jobid){
	if(!call::JOB->IsValidJob(jobid))
		return false;

	if(IsPlayerInRangeOfPoint(playerid, 2.0, Job[jobid][MaletaX], Job[jobid][MaletaY], Job[jobid][MaletaZ]) && jobid == GetPVarInt(playerid, "jobid"))
		return true;

	return false;
}

function JOB::SetVehicleJob(vehicleid, jobid){
	if(!call::JOB->IsValidJob(jobid))
		return false;
	IsVehicleJob[vehicleid] = true;
	VehicleJob[vehicleid] = jobid;
	return true;
}

function JOB::GetVehicleJob(vehicleid){
	if(call::JOB->IsValidVehicleJob(vehicleid)){
		return VehicleJob[vehicleid];
	}
	return false;	
}

function JOB::IsValidVehicleJob(vehicleid){
	return IsVehicleJob[vehicleid];
}

function JOB::IsValidJob(jobid){
	if(jobid<0|| jobid >= sizeof(Job))
		return false;

	return true;
}
function JOB::SetPlayerWorking(playerid, bool:value)
{
	IsPlayerInWorking[playerid] = value;
	return true;
}

function JOB::IsPlayerInWorking(playerid){
	return _:IsPlayerInWorking[playerid];
}

forward CancelarServicos(playerid);
public CancelarServicos(playerid)
{
	if(Jogador[playerid][Profissao] == PIZZA_BOY)
	{
		DestroyVehicle(Jogador[playerid][VeiculoLocado]);
		Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;

		if(pInfoPB[playerid][TrabalhandoPB] == true)
		{

			if(pInfoPB[playerid][SegurandoBAG] == true)
			{
				RemovePlayerAttachedObject(playerid, 1); // Bag
			}

			pInfoPB[playerid][SegurandoBAG] = false;
			pInfoPB[playerid][ObjetoBag] = INVALID_OBJECT_ID;
			pInfoPB[playerid][TrabalhandoPB] = false;
			pInfoPB[playerid][RestauranteAceito] = -1;
			pInfoPB[playerid][EntregaAceita] = -1;
			pInfoPB[playerid][EmEntrega] = false;
			pInfoPB[playerid][EntregandoCasa] = false;
			pInfoPB[playerid][TemDelivery] = false;
			DisablePlayerRaceCheckpoint(playerid);

			KillTimer(TimerDelivery[playerid]);
		}
	}

	if(Jogador[playerid][Profissao] == SEDEX)
	{
		DestroyVehicle(Jogador[playerid][VeiculoLocado]);
		Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;

		if(pInfoSEDEX[playerid][LevelProf] != 0)
		{
			pInfoSEDEX[playerid][LevelProf] = 0;
			pInfoSEDEX[playerid][SetAlready] = false;
			pInfoSEDEX[playerid][Parte] = 0;
			pInfoSEDEX[playerid][Rand1] = -1;
			pInfoSEDEX[playerid][AbleToRemove] = false;
			pInfoSEDEX[playerid][HoldingCrate] = false;
			RemovePlayerAttachedObject(playerid, 1);
			DisablePlayerRaceCheckpoint(playerid);
			RemovePlayerMapIcon(playerid, 50);
			call::PLAYER->DisablePlayerGPS(playerid);

			KillTimer(TimerDelivery[playerid]);

			//SendClientMessage(playerid, COR_AMARELO, "| SERVI�O | Servi�o finalizado com sucesso.");
		}
	}

	if(Jogador[playerid][Profissao] == ELETRICISTA)
	{
		if(Jogador[playerid][VeiculoLocado] != INVALID_VEHICLE_ID)
		{
			DestroyVehicle(Jogador[playerid][VeiculoLocado]);
		}
		DestroyDynamicCP(pJobELETRICISTA[playerid][CheckpointID]);
		call::PLAYER->DisablePlayerGPS(playerid);

		Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;
		pJobELETRICISTA[playerid][Working] = false;
		SetPlayerSkin(playerid, Jogador[playerid][Skin]);
		pJobELETRICISTA[playerid][Uniformizado] = false;
		pJobELETRICISTA[playerid][StateID] = INVALID_STATE_ID;
		pJobELETRICISTA[playerid][CheckpointID] = -1;
		pJobELETRICISTA[playerid][Valor] = 0;
		RemovePlayerMapIcon(playerid, 90);
	}

	if(Jogador[playerid][Profissao] == DESPACHANTE)
	{
		DestroyDynamicRaceCP(pJobDESPACHANTE[playerid][RaceCP]);

		if(Jogador[playerid][VeiculoLocado] != INVALID_VEHICLE_ID)
		{
			DestroyVehicle(Jogador[playerid][VeiculoLocado]);
		}

		if(pJobDESPACHANTE[playerid][TrailerLocado] != INVALID_VEHICLE_ID)
		{
			DestroyVehicle(pJobDESPACHANTE[playerid][TrailerLocado]);
		}

		if(pJobDESPACHANTE[playerid][RaceCP] != -1)
		{
			DestroyDynamicRaceCP(pJobDESPACHANTE[playerid][RaceCP]);
		}

		pJobDESPACHANTE[playerid][Working] = false;
		pJobDESPACHANTE[playerid][TrailerLocado] = INVALID_VEHICLE_ID;
		pJobDESPACHANTE[playerid][RaceCP] = -1;
		pJobDESPACHANTE[playerid][LevelDespachante] = 0;
		pJobDESPACHANTE[playerid][Malas] = 0;

		Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;
	}

	if(Jogador[playerid][Profissao] == PARAMEDICO_AEREO)
	{
		DestroyVehicle(Jogador[playerid][VeiculoLocado]);
		DisablePlayerRaceCheckpoint(playerid);

		Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;
		pJobPARAMEDICO_A[playerid][Working] = false;
		pJobPARAMEDICO_A[playerid][Uniformizado] = false;
		pJobPARAMEDICO_A[playerid][Orgao] = -1;
		pJobPARAMEDICO_A[playerid][LevelParamedico] = 0;
		pJobPARAMEDICO_A[playerid][Valor] = 0;

	}

	if(Jogador[playerid][Profissao] == TRANSPORTADOR_VALORES)
	{
		DestroyVehicle(Jogador[playerid][VeiculoLocado]);
		DeletePVar(playerid, "CargaID");

		DisablePlayerRaceCheckpoint(playerid);
		Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;
		pJobTVALORES[playerid][Valor] = 0;
		pJobTVALORES[playerid][LevelCarga] = 0;
		pJobTVALORES[playerid][Working] = false;
	}

	if(Jogador[playerid][Profissao] == REBOQUE)
	{
        DestroyVehicle(Jogador[playerid][VeiculoLocado]);
        Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;

        SetPlayerSkin(playerid, Jogador[playerid][Skin]);
        pJobREBOQUE[playerid][Uniformizado] = false;

		DisablePlayerRaceCheckpoint(playerid);
		call::PLAYER->DisablePlayerGPS(playerid);

		pJobREBOQUE[playerid][Working] = false;
		pJobREBOQUE[playerid][LevelProf] = 0;
		pJobREBOQUE[playerid][Valor] = 0;

		for(new i; i < MAX_ATENDIMENTOS; i++)
		{
			if(pAtendimento[i][IDResponsavel] == playerid)
			{
				DestroyVehicle(pAtendimento[i][VeiculoAtendimento]);
				DestroyDynamicActor(pAtendimento[i][ActorAtendimento]);
				pAtendimento[i][EmAtendimento] = false;
				pAtendimento[i][IDResponsavel] = INVALID_PLAYER_ID;

				pAtendimento[i][VeiculoAtendimento] = INVALID_VEHICLE_ID;
				pAtendimento[i][ActorAtendimento] = INVALID_ACTOR_ID;
			}
		}
	}

	return 1;
}


// ============================== [ CALLBACKs ] ============================== //
#include <YSI_Coding\y_hooks>
hook OnGameModeInit()
{
	new str[128], indice;
	new Cache:cache = mysql_query(getConexao(), "SELECT * FROM "TABLE_JOBS";"), rows = cache_num_rows();
	if(rows)
	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", indice);
			if ( indice != 0)
				Iter_Add(Profissoes, indice);

			cache_get_value_name(i, "nome", Job[indice][Nome], 50);

			cache_get_value_name_float(i, "maleta-x", Job[indice][MaletaX]);
			cache_get_value_name_float(i, "maleta-y", Job[indice][MaletaY]);
			cache_get_value_name_float(i, "maleta-z", Job[indice][MaletaZ]);

			cache_get_value_name_float(i, "skin-x", Job[indice][SkinX]);
			cache_get_value_name_float(i, "skin-y", Job[indice][SkinY]);
			cache_get_value_name_float(i, "skin-z", Job[indice][SkinZ]);
			cache_get_value_name_int(i, "skin-interior", Job[indice][sInterior]);

			cache_get_value_name_int(i, "skin", Job[indice][SkinID]);

			cache_get_value_name_int(i, "level", Job[indice][Level]);
			cache_get_value_name(i, "cor", Job[indice][Color]);
			cache_get_value_name_int(i, "salario", Job[indice][Salario]);

			cache_get_value_name_int(i, "categoria", Job[indice][Categoria]);

			if ( Job[indice][SkinX] != 0 || Job[indice][SkinY] != 0 || Job[indice][SkinZ] != 0)
			{
				CreateDynamic3DTextLabel("Uniforme\nDigite{"COR_VERDE_CLARO_INC"}/Uniforme{"COR_BRANCO_INC"}", COR_BRANCO, Job[indice][SkinX], Job[indice][SkinY], Job[indice][SkinZ] + 0.2, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, Job[indice][sInterior], -1, 20.0);
				CreateDynamicPickup(1275, 23, Job[indice][SkinX], Job[indice][SkinY], Job[indice][SkinZ], -1, Job[indice][sInterior], -1, 20.0);
			}

			format(str, sizeof(str), "%s\nDigite {"COR_VERDE_CLARO_INC"}/AssinarContrato{"COR_BRANCO_INC"}", Job[indice][Nome]);
			CreateDynamic3DTextLabel(str, COR_BRANCO, Job[indice][MaletaX], Job[indice][MaletaY], Job[indice][MaletaZ] + 0.2, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, 0, -1, 20.0);
			CreateDynamicPickup(1210, 23, Job[indice][MaletaX], Job[indice][MaletaY], Job[indice][MaletaZ], -1, 0, -1, 20.0);
		}
		printf("� Foram carregadas %d profiss�es.\n", call::JOB->CountJobs());
		call::TD->UpdateJobsNumber(call::JOB->CountJobs());
	}
	
	//PagarSalario
	SetTimer("OnPlayerPay", 3600000, true);

	cache_delete(cache);
	return true;
}

hook OnPlayerDisconnect(playerid, reason)
{
	DestroyVehicle(Jogador[playerid][VeiculoLocado]);
	DestroyVehicle(pJobDESPACHANTE[playerid][TrailerLocado]);
	DestroyDynamicRaceCP(pJobDESPACHANTE[playerid][RaceCP]);

	CancelarServicos(playerid);
	return 1;
}

hook OnVehicleSpawn(vehicleid)
{
	foreach(new i: Player)
	{
		if(vehicleid == Jogador[i][VeiculoLocado])
		{
			SendClientMessage(i, COR_ERRO, "| SERVI�OS | Seus servi�os foram cancelados pelo seu ve�culo explodir / respawnar.");
			CancelarServicos(i);
		}
	}
	return 1;
}


hook OnPlayerConnect(playerid)
{
	Jogador[playerid][CVIP] = true;
	Jogador[playerid][TCP] = true;

	IsPlayerInWorking[playerid]=false;
	for(new i; i<sizeof(SelectedJob[]); i++)
		SelectedJob[playerid][i]=-1;

	pSelectCategory[playerid]=0;
	return true;
}
hook OnPlayerDeath(playerid, killerid, reason)
{
	if(call::JOB->IsPlayerInWorking(playerid))
	{
		SetPlayerSkin(playerid, call::PLAYER->GetPlayerVarInt(playerid, Skin));
		call::JOB->SetPlayerWorking(playerid, false);
	}

	if(call::JOB->IsPlayerInWorking(playerid) == 1 || pInfoPB[playerid][TrabalhandoPB] == true || pJobELETRICISTA[playerid][Uniformizado] == true || Jogador[playerid][VeiculoLocado] != INVALID_VEHICLE_ID)
	{
		SendClientMessage(playerid, COR_ERRO, "| SERVI�OS | Seus servi�os foram cancelados por voc� se ferir durante o trabalho.");
		CancelarServicos(playerid);
	}
	
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(ispassenger)
		return false;

	foreach(new i: Player)
	{
		if(vehicleid == Jogador[i][VeiculoLocado])
		{
			if(i != playerid)
			{
				if(!ispassenger)
				{
					SendClientMessage(playerid, COR_ERRO, "| ERRO | Este ve�culo � locado e voc� n�o poder� dirigi-lo!");
					ClearAnimations(playerid);
				}
			}
		}
	}

	if( call::JOB->IsValidVehicleJob(vehicleid) )
	{
		if(call::JOB->GetVehicleJob(vehicleid) != call::PLAYER->GetPlayerVarInt(playerid, Profissao))
		{
			static Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			SetPlayerPos(playerid, x, y, z);

			SendClientMessage(playerid, COR_ERRO, "| ERRO | Veiculo exclusivo da profiss�o %s.", Job[call::JOB->GetVehicleJob(vehicleid)][Nome]);			
			return true;
		}
	}
	return true;
}

public OnPlayerPay()
{
	new JobeId[MAX_PLAYERS], Payment[MAX_PLAYERS];
	foreach(new playerid: Player)
	{
		Payment[playerid] = 0;
		if ( call::PLAYER->IsPlayerLogged(playerid) )
		{
			if(Jogador[playerid][AFK] == true)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� n�o recebeu sal�rio por estar ausente.");
			
			JobeId[playerid] = Jogador[playerid][Profissao];
			if( JobeId[playerid] )
			{
				Payment[playerid] = Job[JobeId[playerid]][Salario];
				SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {ffffff}SAL�RIO {"COR_VERDE_INC"}~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
				SendClientMessage(playerid, COR_SISTEMA, "� {ffffff}Profiss�o: {"COR_AMARELO_INC"}%s", Job[JobeId[playerid]][Nome]);
				SendClientMessage(playerid, COR_SISTEMA, "� {ffffff}Sal�rio: {"COR_VERDE_INC"}R$%s{ffffff}.", RealStr(Job[JobeId[playerid]][Salario]));
			}
			else
			{
				Payment[playerid] = 200;
				SendClientMessage(playerid, COR_SISTEMA, "� {"COR_BRANCO_INC"}Voc� est� desempregado e recebeu apenas {"COR_VERDE_INC"}R$200{"COR_BRANCO_INC"} do Governo.");
				GivePlayerMoney(playerid, Payment[playerid]);
			}

			/**
			*
			*	Verificar se tem plano de sa�de
			*
			**/
			if ( Jogador[playerid][Plano] != 0 )
			{
				new p = Jogador[playerid][Plano];
				Payment[playerid] -= Planos[p][Valor];
				SendClientMessage(playerid, COR_SISTEMA, "� {ffffff}Plano de Sa�de: {"COR_VERMELHO_INC"}R$-%s{ffffff}.", RealStr(Planos[p][Valor]));
			}



			/**
			*
			*	Verificar se � vip
			*
			**/
			if ( Jogador[playerid][Vip] )
			{
				SendClientMessage(playerid, COR_SISTEMA, "� {ffffff}Sal�rio VIP: {"COR_VERDE_INC"}R$3.000{ffffff}.");
				Payment[playerid] += 3000;
			}

			/**
			*
			*	Sal�rio ADM
			*
			**/
			if ( call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE )
			{
				switch(call::ADMIN->GetPlayerAdminLevel(playerid))
				{
					case AJUDANTE:
					{
						Payment[playerid] += 1000;
						SendClientMessage(playerid, COR_SISTEMA, "� {"COR_BRANCO_INC"}Sal�rio Ajudante: {"COR_VERDE_INC"}R$1.000");
					}
					case MODERADOR:
					{
						Payment[playerid] += 1800;
						SendClientMessage(playerid, COR_SISTEMA, "� {"COR_BRANCO_INC"}Sal�rio Moderador(a): {"COR_VERDE_INC"}R$1.800");
					}
					case ADMINISTRADOR:
					{
						Payment[playerid] += 2200;
						SendClientMessage(playerid, COR_SISTEMA, "� {"COR_BRANCO_INC"}Sal�rio Administrador(a): {"COR_VERDE_INC"}R$2.200");
					}
					case DIRECAO:
					{
						Payment[playerid] += 2500;
						SendClientMessage(playerid, COR_SISTEMA, "� {"COR_BRANCO_INC"}Sal�rio Staff: {"COR_VERDE_INC"}R$2.500");
					}
					case DEV:
					{
						Payment[playerid] += 5000;
						SendClientMessage(playerid, COR_SISTEMA, "� {"COR_BRANCO_INC"}Sal�rio Dev: {"COR_VERDE_INC"}R$5.000");
					}
				}
			}
			

			/**
			*
			*	Verificar se tem conta no banco
			*
			**/
			if ( call::BANK->IsPlayerAccountOpenned(playerid) )
			{
				new saldo = call::BANK->GetPlayerValueBankAccount(playerid, "saldo"), percent = floatround(saldo * 0.01), query[255];
				
				percent = percent > 5000 ? 5000 : percent;
				Payment[playerid] += percent;

				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BANK" SET `saldo`='%d' WHERE `id`='%d' LIMIT 1;", (saldo + Payment[playerid]), Jogador[playerid][PlayerID] );
				mysql_tquery(getConexao(), query);

				SendClientMessage(playerid, COR_SISTEMA, "� {ffffff}Conta Banc�ria de: {"COR_AZUL_INC"}%s {ffffff}( {"COR_AMARELO_INC"}%06d {ffffff})", GetUserName(playerid), call::BANK->GetPlayerValueBankAccount(playerid, "id"));
				SendClientMessage(playerid, COR_SISTEMA, "� {ffffff}Juros: {"COR_VERDE_INC"}R$%s", RealStr(percent));
				SendClientMessage(playerid, COR_SISTEMA, "� {ffffff}Saldo Antigo: {"COR_LARANJA_INC"}R$%s", RealStr(saldo));
				SendClientMessage(playerid, COR_SISTEMA, "� {ffffff}Novo Saldo: {"COR_VERDE_INC"}R$%s", RealStr(saldo + Payment[playerid]));

			}
			else
			{
				GivePlayerMoney(playerid, Payment[playerid]);
				SendClientMessage(playerid, COR_VERMELHO, "Voc� n�o tem uma conta banc�ria e voc� recebeu seu dinheiro em m�os.");
			}

			/**
			*
			*	fim salario
			*
			**/
			SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {ffffff}SAL�RIO {"COR_VERDE_INC"}~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		}
	}

	/**
	*
	*	Liberar gangzones.
	*
	**/
	foreach(new gang_zone_id: GangZone)
	{
		GangZone[gang_zone_id][Liberado] = true;
	}

	/**
	*
	*	Escrever no log pagamento.txt e chamar fun��o daqui a 1 hora novamente.
	*
	**/
	WriteLog("pagamento.txt", "Pagamento efetuado.");
	//SetTimer("OnPlayerPay", 3600000, true);
	return false;
}

// =================================== [ CMDs ] =================================== //

CMD:empregos(playerid)
{
	if(!IsPlayerInDynamicCP(playerid, CP_AGENCIA_1) && !IsPlayerInDynamicCP(playerid, CP_AGENCIA_2))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� n�o est� na ag�ncia de empregos");

	call::JOB->ShowPlayerCategoryJobs(playerid);
	return true;
	
}

CMD:assinarcontrato(playerid)
{
	new jobid = GetPVarInt(playerid, "jobid");
	if(call::JOB->IsPlayerInJobLocal(playerid, jobid) && jobid != 0)
	{
		DeletePVar(playerid, "jobid");
		call::JOB->SetPlayerJob(playerid, jobid);

		call::JOB->LogarProf(playerid);

		SendClientMessage(playerid, COR_LARANJA, "| INFO | Voc� agora trabalha de {ffffff}%s{"COR_LARANJA_INC"}, use {ffffff}/Profissao {"COR_LARANJA_INC"}para ver os comandos da profiss�o", Job[jobid][Nome]);
		
		RemovePlayerMapIcon(playerid, 70);
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Desculpe, n�s n�o recebemos nenhum encaminhamento seu!");
	return true;
}


CMD:profissao(playerid)
{
	new str[2048], jobid = call::PLAYER->GetPlayerVarInt(playerid, Profissao);

	//format(str, sizeof(str), "{"COR_AZUL_INC"}____________________| {"COR_BRANCO_INC"}Ajuda {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} |____________________{"COR_BRANCO_INC"}\n\n", Job[jobid][Nome]);
	strcat(str, "\n\n{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/CP {"COR_BRANCO_INC"}- Chat Profiss�o\n");
	strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/FCP {ffffff}- Para ativar/desativar o Chat-Profiss�o\n\n");
	
	switch(jobid)
	{
		case CAMINHONEIRO:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/CarregarC {"COR_BRANCO_INC"}- Carregar seu Caminh�o\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Comboios {"COR_BRANCO_INC"}- Criar/entrar um comboio\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/SairComboio {"COR_BRANCO_INC"}- Criar/entrar um comboio\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Reatrelar {"COR_BRANCO_INC"}- Para Reatrelar seu trailer ao Caminh�o\n\n");

			strcat(str, "{ffffff}Para Reatrelar, voc� precisa estar trabalhando.\n");
		}
		case TAXISTA:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Taximetro {"COR_BRANCO_INC"}- Iniciar Taximetro\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/FinalizarTaximetro {"COR_BRANCO_INC"}- Finalizar corrida\n\n");
			strcat(str, "{ffffff}Parar abrir a cancela aperte {"COR_AVISO_INC"}'C' {"COR_BRANCO_INC"}se estiver a p� e {"COR_AVISO_INC"}'H' {"COR_BRANCO_INC"}se estiver em um veiculo.\n");
		}
		case PIZZA_BOY:
		{
			strcat(str, "\n\n{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}Instru��es para trabalho na profiss�o:\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}Voc� deve apertar 'Y' no Pickup perto do Actor para equipar sua mochila.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}A partir do momento que voc� equipar sua mochila, voc� estar� livre para receber solicita��es de delivery.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}As solicita��es chegam aleatoriamente conforme o tempo passa, basta esperar que aparecer�.\n\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}Comandos �teis:\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/AceitarDelivery {ffffff}- Para aceitar a solicita��o de delivery assim que receber.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/TerminarTrabalho {ffffff}- Encerra seus servi�os na profiss�o.\n");
		}
		case DNIT:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/PegarServico {"COR_BRANCO_INC"}- Para pegar um servi�o de reparo de radar\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/RepararRadar {"COR_BRANCO_INC"}- Para consertar/reparar o radar\n");
		}
		case POLICIA_MILITAR:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Prender {"COR_BRANCO_INC"}- Para prender um suspeito\n");
			//strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Procurar {"COR_BRANCO_INC"}- Para adicionar estrela de procurado no suspeito\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Perseguir {"COR_BRANCO_INC"}- Para iniciar persegui��o\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Algemar {"COR_BRANCO_INC"}- Para algemar um suspeito\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Desalgemar {"COR_BRANCO_INC"}- Para desalgemar um suspeito\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Arrastar {"COR_BRANCO_INC"}- Para arrastar um jogador para um veiculo\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Procurados {"COR_BRANCO_INC"}- Para pesquisar os procurados da justi�a\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Localizar {"COR_BRANCO_INC"}- Para localizar os suspeitos\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Deslocalizar {"COR_BRANCO_INC"}- Para desativar o localizador\n\n");

			strcat(str, "{ffffff}Parar abrir o port�o aperte {"COR_AVISO_INC"}'C' {"COR_BRANCO_INC"}se estiver a p� e {"COR_AVISO_INC"}'H' {"COR_BRANCO_INC"}se estiver em um veiculo.\n");
		}
		case ASSALTANTE:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Arrombar {"COR_BRANCO_INC"}- Para roubar um banco\n");
		}
		case ASSASINO:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Contratos {"COR_BRANCO_INC"}- Para pesquisar os contratos dispon�veis\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Lalvo {"COR_BRANCO_INC"}- Para localizar o alvo que est� em contrato\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Dalvo {"COR_BRANCO_INC"}- Para deslocalizar o alvo");
		}
		case BOMBEIRO:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/PegarIncendio {"COR_BRANCO_INC"}- Para procurar os inc�ndios dispon�veis\n");
		}
		case TRANSPORTADOR:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/CarregarMadeiras {"COR_BRANCO_INC"}- Para Carregar seu Caminh�o\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/DescarregarMadeiras {"COR_BRANCO_INC"}- Para Descarregar seu Caminh�o\n");
		}
		case ADVOGADO:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Soltar {"COR_BRANCO_INC"}- Para Soltar um player\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Presos {"COR_BRANCO_INC"}- Para Ver a lista de presos\n");
		}
		case MECANICO:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Reparar {"COR_BRANCO_INC"}- Para consertar um veiculo\n");
		}
		case PLANTADOR:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Plantar {"COR_BRANCO_INC"}- Para plantar as drogas\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Colher {"COR_BRANCO_INC"}- Para colher as drogas\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Porto {"COR_BRANCO_INC"}- Para localizar o local da compra das sementes\n");
		}
		case PRODUTOR:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Produzir {"COR_BRANCO_INC"}- Para produzir as drogas\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Coletar {"COR_BRANCO_INC"}- Para coletar as drogas\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Porto {"COR_BRANCO_INC"}- Para localizar o local da compra das Mat�ria-Prima\n");
		}
		case LENHADOR:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/PlantarArvore {"COR_BRANCO_INC"}- Para plantar �rvore\n\n");
			strcat(str, "{ffffff}Para plantar uma �rvore voc� deve comprar sementes no checkpoint do NPC\n");
		}
		case TRANSP_DROGAS:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/CarregarDrogas {"COR_BRANCO_INC"}- Para carregar seu veiculo\n");
		}
		case LIXEIRO:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/IniciarRota {"COR_BRANCO_INC"}- Para iniciar uma rota\n");
		}
		case TRANSP_VALORES:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/PegarMalote {"COR_BRANCO_INC"}- Para iniciar uma rota\n\n");
			strcat(str, "{ffffff}Para pegar o malote, voc� deve ir no Cofre do Banco\n");
		}
		case PESCADOR:
		{
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/PegarPesca {"COR_BRANCO_INC"}- Para pegar os equipamentos de pesca\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Arpao {"COR_BRANCO_INC"}- Para lan�ar o arp�o no conv�s do barco\n");
		}
		case SEDEX:
		{
			strcat(str, "\n\n{"COR_VERMELHO_INC"}� {ffffff}Para trabalhar, voc� deve locar seu ve�culo no estacionamento da Unity Station.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}Instru��es de trabalho:\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}Na profiss�o de SEDEX, h� duas possibilidades para voc� trabalhar.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}Voc� pode trabalhar na coleta de mercadorias na casa de jogadores (utilizando o Burrito).\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}Voc� pode trabalhar no frete de mercadorias na casa de jogadores (utilizando o Yankee).\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}H� 4 comandos que voc� deve usar. {ffffff}/Caixa [coletar/colocar/pegar/entregar]{"COR_LARANJA_INC"}.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}Caso esteja utilizando o Burrito, voc� usar� somente {ffffff}/Caixa Coletar{"COR_LARANJA_INC"}, {ffffff}/Caixa Colocar{"COR_LARANJA_INC"} e {ffffff}/Caixa Pegar{"COR_LARANJA_INC"}, respectivamente.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}Caso esteja utilizando o Yankee, voc� usar� somente {ffffff}/Caixa Colocar{"COR_LARANJA_INC"}, {ffffff}/Caixa Pegar{"COR_LARANJA_INC"} e {ffffff}/Caixa Entregar{"COR_LARANJA_INC"}, respectivamente.\n\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}Comandos �teis:\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Iniciar {ffffff}- Para iniciar os servi�os, estando dentro do ve�culo.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Caixa Coletar {ffffff}- Coleta a caixa na casa, estando trabalhando na �rea de coleta.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Caixa Colocar {ffffff}- Coloca a caixa que est� em suas m�os no ve�culo.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Caixa Pegar {ffffff}- Pega uma caixa de dentro do seu ve�culo.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Caixa Entregar {ffffff}- Entrega uma caixa na casa, estando trabalhando na �rea de frete.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/TerminarTrabalho {ffffff}- Encerra seus servi�os na profiss�o.\n");
		}
		case ELETRICISTA:
		{
			strcat(str, "\n\n{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/IniciarReparo {ffffff}- Para iniciar seu trabalho.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}Aperte {ffffff}H{"COR_LARANJA_INC"} (com ve�culo) ou {ffffff}C {"COR_LARANJA_INC"}(a p�) para abrir o port�o.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/TerminarTrabalho {ffffff}- Encerra seus servi�os na profiss�o.\n\n");
		}

		case DESPACHANTE:
		{
			strcat(str, "\n\n{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/IniciarColeta {ffffff}- Para iniciar a coleta das bagagens.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/TerminarTrabalho {ffffff}- Encerra seus servi�os na profiss�o.\n\n");
		}

		case PARAMEDICO_AEREO:
		{
			strcat(str, "\n\n{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/TransportarOrgao {ffffff}- Para iniciar o transporte de �rg�os.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/TerminarTrabalho {ffffff}- Encerra seus servi�os na profiss�o.\n\n");
		}

		case TRANSPORTADOR_VALORES:
		{
			strcat(str, "\n\n{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Carregar {ffffff}- Para mostrar as cargas dispon�veis.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/TerminarTrabalho {ffffff}- Encerra seus servi�os na profiss�o.\n\n");
		}

		case REBOQUE:
		{
			strcat(str, "\n\n{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/Atendimento {ffffff}- Para realizar um atendimento.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/GuincharVeiculo {ffffff}- Para guinchar o ve�culo danificado.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {"COR_LARANJA_INC"}/TerminarTrabalho {ffffff}- Encerra seus servi�os na profiss�o.\n");
			strcat(str, "{"COR_VERMELHO_INC"}� {ffffff}Caso o ve�culo do atendimento exploda, ser� necess�rio utilizar o comando {"COR_LARANJA_INC"}/TerminarTrabalho {ffffff}na HQ.\n\n");
		}
	}
	strcat(str, "\n\t{"COR_VERMELHO_INC"}Acesse nosso site em {"COR_BRANCO_INC"}"SERVER_SITE"{"COR_VERMELHO_INC"} para mais informa��es.");

	new titulo[100];
	format(titulo, sizeof(titulo), "{ffffff}Comandos de %s", Job[jobid][Nome]);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, titulo, str, "OK", "");
	return true;
}

CMD:uniforme(playerid)
{
	if(call::JOB->IsPlayerInWorking(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� j� est� trabalhando.");

	new i = call::PLAYER->GetPlayerVarInt(playerid, Profissao);
	if(i == 0)
		return false;

	if(!IsPlayerInRangeOfPoint(playerid, 2.2, Job[i][SkinX], Job[i][SkinY], Job[i][SkinZ]))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� n�o est� no local para bater o ponto.");

	call::JOB->SetPlayerWorking(playerid, true);
	
	if ( Job[i][SkinID] != 0)
		SetPlayerSkin(playerid, Job[i][SkinID]);

	SendClientMessage(playerid, GetPlayerColor(playerid), "� {"COR_BRANCO_INC"}Voc� est� trabalhando.");
	return true;
}

CMD:retiraruniforme(playerid)
{
	if(!call::PLAYER->GetPlayerVarInt(playerid, Profissao))
		return false;

	if ( !call::JOB->IsPlayerInWorking(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� n�o est� em trabalho.");

	switch(call::PLAYER->GetPlayerVarInt(playerid, Profissao))
	{
		//case CAMINHONEIRO:
		//	call::CAM->CancelarEntrega(playerid);
		//case PETROLEIRO:
		//	call::PETROLEIRO->CancelarEntrega(playerid);
		//case PIZZA_BOY:
		//	call::PIZZA->CancelarEntrega(playerid);
		//case TAXISTA:
		//	call::TAXI->CancelarTrabalho(playerid);
		//case DNIT:
		//	call::DNIT->CancelarServico(playerid);
		//case BOMBEIRO:
		//	call::BOMBEIRO->CancelarServico(playerid);
		//case TRANSPORTADOR:
		//	call::TDM->CancelarEntrega(playerid);
		//case PLANTADOR:
		//	call::PLANTACAO->resetVar(playerid);
		//case PRODUTOR:
		//	call::PRODUCAO->resetVar(playerid);
		//case TRANSP_DROGAS:
		//	call::TPD->CancelarEntrega(playerid);
		//case MECANICO:
		//	call::MECANICO->CancelarServico(playerid);
		//case LIXEIRO:
		//	call::LIXEIRO->CancelarServico(playerid);
		//case PESCADOR:
		//	call::PESCADOR->CancelarServico(playerid);
	}
	call::JOB->SetPlayerWorking(playerid, false);
	SetPlayerSkin(playerid, call::PLAYER->GetPlayerVarInt(playerid, Skin));
	SendClientMessage(playerid, COR_AVISO, "Voc� finalizou seu trabalho.");
	return true;
}

CMD:fcp(playerid)
{
	switch(Jogador[playerid][TCP])
	{
		case false:
		{
			SendClientMessage(playerid, COR_AMARELO, "| CHAT - PROFISS�O | Chat-Profiss�o ativado com sucesso.");
			Jogador[playerid][TCP] = true;
			return 1;
		}	
		case true:
		{
			SendClientMessage(playerid, COR_AMARELO, "| CHAT - PROFISS�O | Chat-Profiss�o desativado com sucesso.");
			Jogador[playerid][TCP] = false;
			return 1;
		}
	}
	return 1;	
}

CMD:cp(playerid, params[])
{
	if( isnull(params) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/cp [mensagem]");
	
	if(Jogador[playerid][TCP] == false)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� est� com o Chat-Profiss�o desativado. Ative-o com /FCP.");

	checaXingamento(playerid, params);

	if( AtCaps(params ) == 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Desligue o Caps Lock.");

	if(Jogador[playerid][Calado] == true)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� est� calado(a) e n�o poder� falar no chat.");

	foreach(new i: Player)
	{
		if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) == call::PLAYER->GetPlayerVarInt(i, Profissao))
		{
			if(Jogador[i][TCP] == true)
			{
				SendClientMessage(i, GetPlayerColor(playerid), "| CHAT - PROFISS�O | %s[%d] diz: %s", GetUserName(playerid), playerid, params);
			}
		}
	}
	return true;
}

CMD:terminartrabalho(playerid, params[])
{
	if(Jogador[playerid][Profissao] == PIZZA_BOY)
	{
		SendClientMessage(playerid, COR_AMARELO, "| SERVI�OS | Voc� encerrou seus servi�os como Entregador de iFood.");

		CancelarServicos(playerid);
		return 1;
	}

	if(Jogador[playerid][Profissao] == SEDEX)
	{
		SendClientMessage(playerid, COR_AMARELO, "| SERVI�OS | Voc� encerrou seus servi�os como SEDEX.");

		CancelarServicos(playerid);
		return 1;
	}

	if(Jogador[playerid][Profissao] == ELETRICISTA)
	{
		SendClientMessage(playerid, COR_AMARELO, "| SERVI�OS | Voc� encerrou seus servi�os como Eletricista.");

		CancelarServicos(playerid);
		return 1;
	}

	if(Jogador[playerid][Profissao] == DESPACHANTE)
	{
		SendClientMessage(playerid, COR_AMARELO, "| SERVI�OS | Voc� encerrou seus servi�os como Despachante de Bagagens.");

		CancelarServicos(playerid);
		return 1;
	}

	if(Jogador[playerid][Profissao] == PARAMEDICO_AEREO)
	{
		SendClientMessage(playerid, COR_AMARELO, "| SERVI�OS | Voc� encerrou seus servi�os como Param�dico A�reo.");

		CancelarServicos(playerid);
		return 1;
	}

	if(Jogador[playerid][Profissao] == TRANSPORTADOR_VALORES)
	{
		SendClientMessage(playerid, COR_AMARELO, "| SERVI�OS | Voc� encerrou seus servi�os como Transportador de Valores.");

		CancelarServicos(playerid);
		return 1;
	}

	if(Jogador[playerid][Profissao] == REBOQUE)
	{
		SendClientMessage(playerid, COR_AMARELO, "| SERVI�OS | Voc� encerrou seus servi�os como Reboque.");

		CancelarServicos(playerid);
		return 1;
	}

	SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� n�o tem permiss�o.");
	return 1;	
}


/*			DIALOGS 			*/

Dialog:CATEGORYS_JOBS(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		switch(listitem)
		{
			case 0: // Honestas
				pSelectCategory[playerid] = HONESTAS;

			case 1: // Criminosas
				pSelectCategory[playerid] = CRIMINOSA;

			case 2: // Transportes
				pSelectCategory[playerid] = TRANSPORTE;

			case 3: // Governamental
				pSelectCategory[playerid] = GOVERNAMENTAL;
		}
		call::JOB->ShowPlayerJobsInfo(playerid, pSelectCategory[playerid]);
		return true;
	}
	return true;
}


Dialog:JOBS_INFO_SELECTED(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if ( pSelectCategory[playerid] )
		{
			pSelectCategory[playerid] = 0;
			new jobid = SelectedJob[playerid][listitem];
			for(new i; i < sizeof(SelectedJob[]); i++)
				SelectedJob[playerid][i] = -1;
			
			if ( GetPlayerWantedLevel(playerid) != 0 )
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� n�o pode mudar sua profiss�o pois est� sendo procurado pela policia.");

			if ( jobid == -1)
				return call::JOB->ShowPlayerCategoryJobs(playerid);

			if ( call::PLAYER->GetPlayerVarInt(playerid, Profissao) == jobid)
				return call::JOB->ShowPlayerCategoryJobs(playerid), SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� j� faz parte desta profiss�o.");

			if ( Job[jobid][Level] > GetPlayerScore(playerid) )
				return call::JOB->ShowPlayerCategoryJobs(playerid), SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� n�o tem o level suficiente para trabalhar nesta profiss�o.");

			if ( jobid == 2 && jobid == 4 && jobid == 9 && jobid == 10 && jobid == 18 && !BitFlag_Get(Jogador[playerid][Habilitacao], HAB_CAMINHAO) )
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� n�o possui habilita��o da categoria C");

			call::JOB->SetPlayerWorking(playerid, false);
			SetPlayerSkin(playerid, call::PLAYER->GetPlayerVarInt(playerid, Skin));
			call::JOB->SetPlayerMarkJob(playerid, jobid);
			SetPVarInt(playerid, "jobid", jobid);
			
			new String[1000], Str[1000];
			format(Str, sizeof(Str), "\n{ffffff}Voc� foi aceito na profiss�o de {ff8000}%s{ffffff}.\n", Job[jobid][Nome]);
			strcat(String, Str);

			strcat(String, "{ffffff}Siga a {ff0000}bandeira vermelha {ffffff}marcada em seu mapa para {ffff00}assinar seu contrato{ffffff}.\n");

			ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_MSGBOX, "{ffffff}Profiss�o", String, "Fechar", "");
			
			RemovePlayerAttachedObject(playerid, 1);
			CancelarServicos(playerid);
			return true;
		}
		return true;
	}
	pSelectCategory[playerid]=0;
	call::JOB->ShowPlayerCategoryJobs(playerid);
	return true;
}


CMD:cancelaragencia(playerid, params[])
{
	pSelectCategory[playerid]=0;
	call::JOB->SetPlayerWorking(playerid, false);
	SetPlayerSkin(playerid, call::PLAYER->GetPlayerVarInt(playerid, Skin));
	
	RemovePlayerAttachedObject(playerid, 1);
	CancelarServicos(playerid);
	call::PLAYER->DisablePlayerGPS(playerid);
	return true;
}