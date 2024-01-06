/*
*
*		@author: 	SammyJ
*		@date: 		08/10/2017
*
*/


/*
*
*			Definiï¿½ï¿½es
*
*/

//#define DISCORD					(false)

#define MAX_PLAYER_EMAIL						70
#define MAX_PLAYER_PASSWORD						64

#define IsPlayerAndroid(%0)                 GetPVarInt(%0, "NotAndroid") == 0

DEFINE_HOOK_REPLACEMENT(OnGameModeInit, OnGmInit);
DEFINE_HOOK_REPLACEMENT(Select, Sel);
DEFINE_HOOK_REPLACEMENT(OnPlayer, OP_);

//Definiï¿½ï¿½es de status do PIN
#define PIN_MUDAR_SENHA     1
#define PIN_DESATIVAR		2





#define VALOR_KIT1			800
#define VALOR_KIT2			1200
#define VALOR_KIT3			1600



// ============================== [ MACROS ] ============================== //

new stock __message[300 + MAX_PLAYER_NAME];
#define SendClientMessage(%0,%1,%2,%3) 				format(__message,sizeof(__message),%2,%3),SendClientMessage(%0,%1,__message)
#define SendClientMessageToAll(%0,%1,%2) 			format(__message,sizeof(__message),%1,%2),SendClientMessageToAll(%0,__message)

// ============================== [ INFORMAï¿½ï¿½ES DO SERVIDOR ] ============================== //
#define SERVER_NAME 							"Perfect City RPG #Oficial"
#define SERVER_NAME_TEXTDRAW 					"Perfect City~n~RPG"
#define SERVER_VERSION 							"1.3"
#define VERSION_SAMP_REQUIRED 					"0.3.7-R2"
#define SERVER_SITE 							"perfectcityrpg.com.br"
#define SERVER_EMAIL 							"contato@perfectcityrpg.com.br"
#define minutos(%0) 							(1000 * %0 * 60)

new const CMD_NOT_PERMISSION[] = 				"| ERRO | Você não tem permissão para usar este comando.";
#define CMD_CORRECT_USE							"| ERRO | Uso Correto: %s"

#define MIN_XP									5
#define MAX_TOPS 								10

#define VALOR_POR_ESTRELAS 						500

#define Job_TimeToFailMission       			90

new playerLastComand[MAX_PLAYERS];
new PlayerText:TD@AFK[MAX_PLAYERS][2];
new RandomCODE_AFK[][] =
{
  	"poik",
  	"gfbb",
  	"quas",
  	"qwer",
  	"lbad",
  	"aoyh",
  	"syef",
  	"vlop",
  	"ximn",
  	"port",
  	"bras",
  	"ipir",
  	"kjio",
  	"kopk",
  	"kapa",
  	"zcds",
  	"ouhn",
  	"ltre",
  	"lete",
  	"cdwa",
  	"gytf",
  	"jadn",
  	"kjpg",
  	"raas",
  	"asgd",
  	"ogor",
  	"osff"
};
new Code@AFK[MAX_PLAYERS][24];
// ============================== CMD COUNT ============================== //
enum 
{
	CMD_TYPE_LIMPARCHAT,
	CMD_TYPE_RVS
}

enum
{
	SOLTO = 0,
	PRESO_POLICIA = 1,
	PRESO_ADM = 2
}

new bool: GodMod[MAX_PLAYERS], bool: GodCar[MAX_PLAYERS];

// ============================== [ CORES ] ============================== //
#define COR_SISTEMA 							0xA9C4E4FF
#define COR_SISTEMA_INC 						"A9C4E4"

#define COR_BRANCO 								0xFFFFFFFF
#define COR_BRANCO_INC 							"FFFFFF"

#define COR_AMARELO								0xFFFF00FF
#define COR_AMARELO_INC							"FFFF00"

#define COR_AZUL								0x009acdFF
#define COR_AZUL_INC						 	"009acd"

#define COR_VERMELHO 							0xEF1D1DFF
#define COR_VERMELHO_INC						"EF1D1D"

#define COR_VERDE								0x088A08FF
#define COR_VERDE_INC 							"088A08"

#define COR_VERDE_CLARO							0x58FA82FF
#define COR_VERDE_CLARO_INC						"58FA82"

#define COR_ERRO								0xFE2E2EFF
#define COR_ERRO_INC 							"FE2E2E"

#define COR_LARANJA 							0xFFB017FF
#define COR_LARANJA_INC 						"FFB017"


#define COR_AVISO 								0xD1BB41FF
#define COR_AVISO_INC							"D1BB41"

#define TD_WIDGET_TITLE_PRIMARY 				0x0696D9FF
#define TD_WIDGET_TITLE_PRIMARY_INC 			"0696D9"

#define TD_WIDGET_TITLE_SECONDARY 				0x45C4FFFF
#define TD_WIDGET_TITLE_SECONDARY_INC 			"45C4FF"

#define COR_DISABLE		 						0x696969FF
#define COR_DISABLE_INC 						"696969"


const 
	TD_COLOR_BORDER = 0x009CFFFF,
	TD_COLOR_BASE = 0x000000FF,
	TD_COLOR_TEXT = 0xFFFFFFFF,
	TD_COLOR_SELECT_NORMAL = 0x555555AA,
	TD_COLOR_SELECT_HOVER = 0x555555DD
;

// ============================== [ PROFISSÕES ] ============================== //
enum _:e_JOB_COUNT
{
	DESEMPREGADO,
	PIZZA_BOY,
	CAMINHONEIRO,
	TAXISTA,
	PETROLEIRO,
	DNIT,
	POLICIA_MILITAR,
	ASSALTANTE,
	ASSASINO,
	BOMBEIRO,
	TRANSPORTADOR,
	ADVOGADO,
	MECANICO,
	PLANTADOR,
	PRODUTOR,
	LIXEIRO,
	LENHADOR,
	TRANSP_DROGAS,
	TRANSP_VALORES,
	PESCADOR,
	SEDEX,
	ELETRICISTA,
	DESPACHANTE,
	PARAMEDICO_AEREO,
	TRANSPORTADOR_VALORES,
	REBOQUE
}

#define MAX_VEHICLES_PER_ADMIN 					(2)

// ============================== [ DEFINIÇÃO DE CHAMADA DE FUNÇÃO PERSONALIZADA ] ============================== //

#if defined function
	#undef function
#endif
#define function%0::%1(%2) 						%0_%1(%2)

#if defined call
	#undef call
#endif
#define call::%0->%1(%2)						%0_%1(%2)


// ============================== [ INFO RACE ] ============================== //
#define MAXIMO_VOLTAS			5
#define VALOR_INSCRICAO 		300


// ============================== [ ATTACH INDEX ] ============================== //
enum
{
	ATTACH_CELL,
	ATTACH_PISTOL,
	ATTACH_FUZIL,
	ATTACH_SUBFUZIL,
	ATTACH_KATANA,
	ATTACH_DOZE
}

// ============================= [ DISCORD ] ========================================== //
#define CHANNEL_ADM "429350980484726785"

// ============================== [ TABELAS DO MYSQL ] ============================== //
#define TABLE_USERS 							"usuarios"
#define TABLE_BANNEDS 							"banidos"
#define TABLE_CONQUEST							"conquistas"
#define TABLE_HOUSES 							"casas"
#define TABLE_HOUSES_INTERIORS	 				"casas_interior"
#define TABLE_HOUSES_GARAGES 					"casas_garagem"
#define TABLE_PROPERTY 							"propriedades"
#define TABLE_BUSINESS							"empresas"
#define TABLE_RADARS 							"radares"
#define TABLE_VEHICLES_CONCE 					"concessionaria"
#define TABLE_VEHICLES_PLAYER 					"veiculos"
#define TABLE_GANGZONE 							"gangzones"
#define TABLE_FACTIONS 							"faccoes"
#define TABLE_ANNOUNCE 							"anuncios"
#define TABLE_JOBS 								"profissoes"
#define TABLE_CELLPHONE 						"celulares"
#define TABLE_BANK 								"banco"
#define TABLE_BANK_TRANSACTION 					"banco_transacoes"
#define TABLE_CAIXA_ELETRONICO 					"caixa_eletronico"
#define TABLE_PLANTACOES						"plantacoes"
#define TABLE_PRODUCOES							"producoes"
#define TABLE_PLANTACAO							"plantacao"
#define TABLE_HOTEIS							"hoteis"


// ============================== [ INFORMAÇÕES DE SPAWN ] ============================== //
#define SPAWN_X 								1685.4644
#define SPAWN_Y									-2240.1057
#define SPAWN_Z									13.5469
#define SPAWN_A									181.6587
#define SPAWN_MONEY 							3000

#define SEXO_MASCULINO 							(1)
#define SEXO_FEMININO 							(2)

#define SKIN_MASCULINA 							26
#define SKIN_FEMININA 							192

// ============================== [ FILES LOGS ] ============================== //
#define FILE_BAN 								"admins/bans.txt"
#define FILE_DESBAN 							"admins/desbans.txt"
#define FILE_KICK 								"admins/kicks.txt"
#define FILE_REMOVE_ADMIN 						"admins/remove-admin.txt"
#define FILE_SET_ADMIN 							"admins/set-admin.txt"
#define FILE_GIVE 								"admins/give-gerais.txt"
#define FILE_REMOVE_MONEY						"admins/remove-money.txt"
#define FILE_ADMIN_TELEPORT 					"admins/teleportes.txt"
#define FILE_ADMINS_SETS 						"admins/sets-gerals.txt"
#define FILE_APRENDER_PRISAO					"admins/prender.txt"
#define FILE_SOLTAR_PRISAO						"admins/soltar.txt"
#define FILE_DESTROY_HOUSE 						"admins/destruircasa.txt"
#define FILE_EDIT_HOUSE 						"admins/editarcasa.txt"
#define FILE_SET_VIP 							"admins/sets-vip.txt"
#define FILE_AVISO								"admins/avisos.txt"
#define SOBEIT_LOGS         					"logs/anticheat/Sobeit.txt"
#define SHOTREPEATER_LOGS   					"logs/anticheat/ShotRepeater.txt"
#define INVSLAP_LOGS        					"logs/anticheat/InvisibleSlap.txt"
#define CARFUNCS_LOGS         					"logs/anticheat/CarFuncs.txt"
#define ANIM_LOGS         						"logs/anticheat/Anims.txt"
#define FLY_LOGS         						"logs/anticheat/Fly.txt"


// ============================== [ PREÇOS COMBUSTIVEIS ] ============================== //
#define TYPE_NULL 			0

#define TYPE_GASOLINA 		1
#define VALOR_GASOLINA 		4

#define TYPE_DIESEL 		2
#define VALOR_DIESEL 		7

#define TYPE_AVG			3
#define VALOR_AVG 			14
// ============================== [ FORWARDS ] ============================== //

forward OnPlayerAuthLogin(playerid);			// callback in modules/jogador/callbacks.pwn
forward OnPlayerRegister(playerid);				// callback in modules/jogador/callbacks.pwn
forward OnTimeOneSeconds();						// callback in modules/times.pwn
forward OnTimeOneSecondsPlayer(playerid); 		// callback in modules/times.pwn
forward Float:function VH::GetVehicleFuel(vehicleid); // forward in ..bin/modules/veiculos/veiculos.pwn
forward GetPlayerHospital(playerid);
forward Float:function PLAYER::GetPlayerVarFloat(playerid, e_PLAYER_INFO:param); // callback in modules/jogador/jogador.pwn
forward bool:function PLAYER::GetPlayerVarBool(playerid, e_PLAYER_INFO:param); 	 // callback in modules/jogador/jogador.pwn
forward Float:function RADAR::GetRadarVarFloat(radarid, e_RADAR_INFO:param);  	 // callback in modules/detran/radares.pwn
forward MySQL:getConexao();

// ============================== [ MOTIVOS CRIMES ] ===================================== //
enum e_CrimesInfo {
	Crime[50],
	Abreviacao[4],
	Estrelas,
	Penalidade[50]
}

new const MotivosSu[][e_CrimesInfo] =
{
	{ "Tentativa de Homicídio", "TH", 6, "30 min cadeia = 5 por estrela" },
	{ "Tráfico de Drogas", "TD", 3, "15 min cadeia = 5 por estrela" },
	{ "Tráfico de Armas", "TA", 3, "15 min cadeia = 5 por estrela" },
	{ "Porte Ilegal de Armas", "PIA", 4, "20 min cadeia = 5 por estrela" },
	{ "Roubo de Veículo", "RV", 4, "20 min cadeia = 5 por estrela" },
	{ "Cúmplice de Fuga", "CF", 2, "10 min cadeia = 5 por estrela" },
	{ "Desacato a Autoridade", "DA", 2, "10 min cadeia = 5 por estrela" },
	{ "Desobediência da Ordem Policial", "DOP", 3, "15 min cadeia = 5 por estrela" },
	{ "Invasão de espaço privado", "IEP", 2, "10 min cadeia = 5 por estrela" },
	{ "Atentado Terrorista", "AT", 6, "30 min cadeia = 5 por estrela" }
};

// ============================== [ HIERARQUIA DOS ADMINS ] ============================== //
enum(<<=1) 
{
	AJUDANTE = 1,
	MODERADOR = 2,
	ADMINISTRADOR = 3,
	DIRECAO = 4,
	DEV = 5
}

// ============================== [ ENUMERADORES ] ============================== //


enum e_POSITION
{
	Float:X,
	Float:Y,
	Float:Z,
	Float:A
}

enum e_HORAS
{
	HORAS,
	MINUTOS,
	SEGUNDOS	
}

enum e_PLANOS_INFO
{
	Nome[20],
	Vida,
	Colete,
	FSS,
	Valor
}
new const Planos[][e_PLANOS_INFO] =
{
	{"Nenhum", 20, 0, 10, 0},
	{"Plano 1", 50, 0, 20, 350},
	{"Plano 2", 80, 50, 50, 450},
	{"Plano 3", 100, 100, 70, 600}
};

//			Camera do Hospital
new const Float:CamasHospitais[][] =
{
	{1156.8373,-1326.6764,-43.4495,356.9346},
	{1156.7682,-1329.1174,-43.4495,356.6213},
	{1156.6409,-1331.1287,-43.4495,11.3481},
	{1150.2723,-1331.1583,-43.4495,195.2765},
	{1150.5477,-1329.1052,-43.4495,174.2830},
	{1150.4421,-1326.7174,-43.4495,174.2830},
	{1150.4377,-1325.0309,-43.4495,174.2830}
};


// 			Deposito de veiculos guinchados.

new const Float:GuinchoVehicle[][] =
{
	{1095.0385, 1227.6885, 10.8119, 0.0000},
	{1090.7770, 1227.7963, 10.8119, 0.0000},
	{1086.5281, 1227.7631, 10.8119, 0.0000},
	{1082.3705, 1227.9579, 10.8119, 0.0000},
	{1078.0507, 1228.2145, 10.8119, 0.0000},
	{1073.4507, 1228.3086, 10.8119, 0.0000},
	{1069.1167, 1228.3627, 10.8119, 0.0000},
	{1064.7800, 1228.3369, 10.8119, 0.0000},
	{1060.3555, 1228.2928, 10.8119, 0.0000},
	{1093.8279, 1235.1702, 10.8119, 88.6800},
	{1093.8663, 1239.4218, 10.8119, 88.6800},
	{1093.7844, 1243.9858, 10.8119, 88.6800},
	{1093.8192, 1248.2966, 10.8119, 88.6800},
	{1093.7800, 1252.4457, 10.8119, 88.6800}
};

// ============================== [ FACTION ] ============================== //

const 
	MAX_FACTIONS = 100, MAX_CARGOS = 7, MAX_FACTION_NAME = 70, INVALID_FACTION_ID = -1;
	
enum e_FACTION_INFO
{
	RowId,
	Nome[MAX_FACTION_NAME],
	Cofre,
	MaxMembros,
	Level,
	Cor,
	Armamentos,
	BaseID,
	Drogas,
}
new Faccao[MAX_FACTIONS + 2][e_FACTION_INFO], Cargo[MAX_FACTIONS + 2][MAX_CARGOS + 1][70], Iterator:Faccao<MAX_FACTIONS>;


// ============================== [ GANG ZONE ] ============================== //
enum
{
	F_CARGO_1 = 1,
	F_CARGO_2,
	F_CARGO_3,
	F_CARGO_4,
	F_CARGO_5,
	F_CARGO_6
}
enum e_GANG_ZONE_INFO
{
	ID,
	GangZoneID,
	Nome[70],
	Float:Min_x,
	Float:Min_y,
	Float:Max_x,
	Float:Max_y,
	Float:Ponto_x,
	Float:Ponto_y,
	Float:Ponto_z,
	FactionRowId,
	Text3D:Label,
	Pickup,
	Color,
	bool:EmDominacao,
	bool:Liberado
}
new GangZone[MAX_GANG_ZONES][e_GANG_ZONE_INFO], Iterator:GangZone<MAX_GANG_ZONES>;

// ============================== [ INFORMAÇÕES DOS HOTEIS ] ============================= //
#define MAX_HOTEL								15
#define INVALID_HOTEL_ID 						(MAX_HOTEL + 1)
#define HOTEL_RENDER_STREAMER 					40.0

#define PICKUP_VEDING 							1272
#define PICKUP_OCCUPED 							19522

enum e_HOTEL_OWNER
{
	Id,
	Name[MAX_PLAYER_NAME]
}

enum e_HOTEL_INFO
{
	ID,
	Owner[e_HOTEL_OWNER],
	Float:Entrada[e_POSITION],
	Float:Saida[e_POSITION],
	Interior,
	InteriorID,
	Valor,
	bool:Trancado,
	Impostos,
	Pickup,
	Text3D:Label[2]
}
new Hotel[MAX_HOTEL + 1][e_HOTEL_INFO], Iterator:Hotel<MAX_HOTEL>, BusID[MAX_PLAYERS];
// ============================== [ INFORMAÇÕES DAS CASAS ] ============================== //

#define MAX_HOUSE								1000
#define INVALID_HOUSE_ID 						(MAX_HOUSE + 1)
#define MAX_HOUSE_MENSAGEM 						(50)

// 50%
#define HOUSE_PORCENT_DESCONT 					0.50
#define HOUSE_VALOR_VENDA(%0) 					floatround(call::HOUSE->GetHouseParamInt(%0, Valor) * HOUSE_PORCENT_DESCONT)

//
#define PH_OCCUPIED_VEDING 						1272
//
#define PH_NON_OCCUPIED 						1273
#define PH_OCCUPIED 							19522
//
#define PH_BTC_NON_OCCUPIED 					19524
#define PH_BTC_OCCUPIED							19523

#define MAPICON_HOUSE_FREE 						31
#define MAPICON_HOUSE_OCCUPIED 					32


#define HOUSE_RENDER_STREAMER 					40.0

#define RETURN_MAPICON_HOUSE(%0) 				( !Casa[%0][Owner][Id] ? MAPICON_HOUSE_FREE : MAPICON_HOUSE_OCCUPIED)

#define CALCULATE_IMPOSTOS(%0,%1) 				( (%0 / 100) * %1)


enum e_INTERIOR_GARAGEM
{
	Name[10],
	Float:vGaragem[4],
	Float:pGaragem[4]
}
new const Float:InteriorGaragem[][e_INTERIOR_GARAGEM] =
{
	{"Pequena", {-1073.9366, 1024.9816, 1483.4960, 199.4094}, {-1073.7999, 1028.7698, 1483.6964, 184.5334} }
};

enum e_GARAGEM
{
	Id,
	Text3D:Label,
	Pickup,
	pEntrada[e_POSITION],
	pSaida[e_POSITION],
	vEntrada[e_POSITION],
	vSaida[e_POSITION],
	bool:Trancado
}

enum e_HOUSE_OWNER
{
	Id,
	Name[MAX_PLAYER_NAME]
}

enum e_HOUSE_INFO
{
	ID,
	Owner[e_HOUSE_OWNER],
	Float:Entrada[e_POSITION],
	Float:Saida[e_POSITION],
	Garagem[e_GARAGEM],
	Interior,
	InteriorID,
	Impostos,
	ImpostosPagos,
	Mensagem[MAX_HOUSE_MENSAGEM],
	Valor,
	Level,
	Aluguel,
	Cofre,
	bool:Alugavel,
	ValorVenda,
	bool:Trancado,
	bool:IsCash,
	Pickup,
	Text3D:Label[2],
	Map
}

new 
	Casa[MAX_HOUSE + 1][e_HOUSE_INFO], Iterator:Casas<MAX_HOUSE>, Iterator:Garagens<MAX_HOUSE>;



#define MAX_PEDAGIOS 50

enum Pedagios
{
	ID,
    CancelaID,
    Text3D:LabelID,
    Valor,
    Float:X,
    Float:Y,
    Float:Z,
    Float:CancelaX,
    Float:CancelaY,
    Float:CancelaZ,
	Float:RotX,
	Float:RotY,
	Float:RotZ,
    Float:AbertoX,
    Float:AbertoY,
    Float:AbertoZ,
    Float:AbertoRotX,
    Float:AbertoRotY,
    Float:AbertoRotZ
}
new cPedagio[MAX_PEDAGIOS][Pedagios];

new Iterator:Pedagio<MAX_PEDAGIOS>;


// ============================== [ INFORMAÇÕES DA EMPRESA ] ============================== //

#define MAX_BUSINESS 							200
#define MAX_BUSINESS_NAME						60
#define INVALID_BUSINESS_ID 					(MAX_BUSINESS + 1)
#define DISTANCE_BUSINESS_TO_PROPERY 			15.0
#define BUSINESS_RENDER_STREAMER 				40.0

#define MAX_STRLEN_MSG 							50
#define BUSINESS_PORCENT_DESCONT 				50
#define RETURN_VALOR_VENDA(%0) 					(call::BUSINESS->GetBusinessParamsInt(%0,Valor) / 100 * BUSINESS_PORCENT_DESCONT)
	
#define PICKUP_BUSINESS_OCCUPED					19605
#define PICKUP_BUSINESS_FREE 					19606

#define RETURN_PICKUP_ID(%0)					(strcmp(Business[%0][Proprietario], "Ninguem", true) == 0 ? PICKUP_BUSINESS_FREE : PICKUP_BUSINESS_OCCUPED)


#define MERCADORIA_LIBERADA						0
#define MERCADORIA_CARREGADA 					-1
#define MERCADORIA_TEMPO						3600

#define MAX_FUNCIONARIOS 						5
#define LoopFuncionarios(%0,%1)					for(new %0 = 1; %0 <= %1; %0++)

enum e_BUSINESS_INFO
{
	ID,
	Nome[MAX_BUSINESS_NAME],
	Proprietario[MAX_PLAYER_NAME],
	Float:Entrada[e_POSITION],
	Float:Saida[e_POSITION],
	Interior,
	Impostos,
	Cofre,
	Valor,
	ValorCash,
	ValorVenda,
	Level,
	Producao,
	Mensagem[MAX_STRLEN_MSG],
	Salario,
	MaxFuncionarios,
	Text3D:Label[2],
	Map,
	PickupID,
	MapIcon,
	bool:UseActor,
	Actor_id,
	Skin,
	Float:ActorPos[e_POSITION],
	ActorName[MAX_PLAYER_NAME]

}
new Iterator:Business<MAX_BUSINESS>;

// ============================== [ INFORMAÇÕES DAS BASES ] ================================ //

#define INVALID_BASE_ID -1
#define MAX_BASES 50
#define MAX_MEMBROS_BASE 50

enum e_BASE_INFO
{
	ID,
	Lider[MAX_PLAYER_NAME],
	LiderID,
	Valor,
	Float:Entrada[e_POSITION],
	Nome[50],
	TAG[20],
	Nivel,
	Text3D:LabelID,
	PickupID,
	Vencimento,
	Cofre
}
new Iterator:Base<MAX_BASES>;

// ============================== [ INFORMAÇÕES DE PLANTAÇÕES ] ================================ //


// ============================== [ INFORMAÇÕES DE PROPRIEDADES ] ============================== //

#define MAX_PROPERTY 							50
#define MAX_PROPERTY_NAME						60
#define INVALID_PROPERTY_ID 					(MAX_PROPERTY + 1)
#define DISTANCE_PROPERTY_TO_PROPERY 			15.0
#define PROPERTY_STRING_RENDER					"{ffffff}%s\n\n{ffffff}Aperte '{c4c4c4}F{ffffff}'"
//#define PROPERTY_STRING_RENDER 					"Propriedade: {00BBFF}%s{FFFFFF}\nEnd.: {00BBFF}%s{FFFFFF}, Nï¿½ {00BBFF}%d{FFFFFF}\nProprietï¿½rio: {00BBFF}Governo"
//#define PROPERTY_VAR_RENDER						Propriedade[propriedadeid][Nome], call::PROPERTY->GetPropertyLocalName(propriedadeid), propriedadeid		
#define PROPERTY_VAR_RENDER						Propriedade[propriedadeid][Nome]
#define PROPERTY_RENDER_STREAMER 				40.0

enum e_PropertyInfo
{
	ID,
	Nome[MAX_PROPERTY_NAME],
	Float:Entrada[e_POSITION],
	Float:Saida[e_POSITION],
	MapIcon,
	Interior,
	Map,
	Text3D:Label,
	Pickup,
}
new Propriedade[MAX_PROPERTY][e_PropertyInfo], Iterator:Propriedades<MAX_PROPERTY>;

// ============================== [ CONCESSIONÁRIA ] ============================== //

#define MAX_VEHICLES_CONCE 			211
#define INVALID_CONCE_VEHICLE_ID 	MAX_VEHICLES_CONCE + 1
enum e_CONCE_INFO
{
	VehicleID,
	Modelid,
	Float:Position[e_POSITION],
	Color1,
	Color2,
	Valor,
	Text3D:Label
}
new Iterator:Concessionaria<MAX_VEHICLES_CONCE>;

// ============================== [ VEICULOS DO JOGADOR ] ============================== //

#define MAX_VEHICLE_PLACA_LEN 		9
#define VALOR_POR_MULTA 			200

enum e_VEHICLE_OWNER_INFO
{
	Id,
	Name[MAX_PLAYER_NAME]
}

enum e_VEHICLE_INFO
{
	Id,
	Owner[e_VEHICLE_OWNER_INFO],
	Float:Fuel,
	Porta,
	Placa[MAX_VEHICLE_PLACA_LEN],
	Rodas,
	PaintJob,
	Nitro,
	Hidraulica,
	UpTime,
	IPVA,
	Multas,
	bool:RadioOn,
	RadioID,
	Float:Position[e_POSITION],
	Interior,
	World,
	carRadioOn,
	CRURL[256],
 	SoundCar,
 	mod1,
	mod2,
	mod3,
	mod4,
	mod5,
	mod6,
	mod7,
	mod8,
	mod9,
	mod10,
	mod11,
	mod12,
	mod13,
	mod14,
	mod15,
	mod16,
	mod17,
	paintjob,
	Capreendido,
	Cbloqueado,
	Float:cQuebradox,
	Float:cQuebradoy,
	Float:cQuebradoz,
	Float:cQuebradoa,
	Float:CxXC,
	Float:CxYC,
	Float:CxZC,
	Float:CxxXC,
	Float:CxxYC,
	Float:CxxZC,
	Float:CxxX2C,
	Float:CxxY2C,
	Float:CxxZ2C,
	Float:CxxX3C,
	Float:CxxY3C,
	Float:CxxZ3C,
	TemSom,
	TemTrio,
	Float:CxRXX
}
new Vehicle[MAX_VEHICLES][e_VEHICLE_INFO], Iterator:Vehicles<MAX_VEHICLES>, Iterator:VehiclePlayers<MAX_VEHICLES>;

// ============================== [ RADAR ] ============================== //

#define MAX_RADARS 			350
enum e_RADAR_INFO
{
	ID,
	ObjectID,
	MapIcon,
	Text3D:Label,
	Float:Position[3],
	Float:Rotation[3],
	Float:Vida,
	Velocidade,
}
new Iterator:Radar<MAX_RADARS>;

// ============================== [ INFORMAÇÕES DO JOGADOR ] ============================== //

#define MAX_VEHICLES_PER_PLAYER 		2

#define MAX_FILE_CONFIG_LEN 		( 25 + MAX_PLAYER_NAME )
#define CONFIG_PLAYER_PATH 			"config/contas/%s.ini"

#define TAG_MOSTRAR_STATUS 			"mostrarStatus"
#define TAG_MOSTRAR_DATA 			"mostrarData"
#define TAG_CORTAGVIP				"CorTag"
#define MAX_PLAYER_WEAPONS 			11

#define TARIFA_LIGACAO 		3
enum
{
	CHAMANDO = 1,
	EM_CHAMADA
}

enum
{
	ACOBRAR,
	EMERGENCIA
}


enum 
{
	ENTROU_NONE,
	ENTROU_EMPRESA,
	ENTROU_CASA,
	ENTROU_PROPRIEDADE,
	ENTROU_GARAGEM
}

enum e_HABILITACAO(<<=1)
{
	HAB_MOTO = 1,
	HAB_CARRO,
	HAB_CAMINHAO,
	HAB_BARCO,
	HAB_AVIAO
}


enum e_PLAYER_INFO
{
	PlayerID,
	Nome[MAX_PLAYERS],
	Email[MAX_PLAYER_EMAIL],
	Senha[MAX_PLAYER_PASSWORD],
	Skin,
	Spawn[e_POSITION],
	Interior,
	World,
	bool:inLogin,
	bool:Logado,
	Sexo,
	Profissao,
	bCarga,
	PorcLevel,
	EXP,
	UPm,
	UPs,
	PIN,
	bool:PinAtivo,
	//Float:Fome,
	//Float:Sede,
	//Float:Sono,
	Fome,
	Sede,
	Sono,
	EmpresaID,
	Mercadoria,
	FuncionarioID,
	ObjectAttached,
	FoodTime,
	Beta,
	bool:Vip,
	TempoVip,
	TempoAtividade[e_HORAS],
	AdminAvisos,
	pHospital,
	bool:pDormindo,
	bool:bPM,
	PassouRadar,
	Multas,
	pFaccao,
	pCargo,
	Preso,
	TempoPreso,
	Crime[10],
	bool:Algemado,
	bool:Perseguido,
	bool:Perseguindo,
	TempoPerseguido,
	bool:AFK,
	VerificarAFK,
    Float:AFK_X,
    Float:AFK_Y,
    AFK_Avisos,
	Avisos,
	bool:GPS,
	Celular,
	SaldoCelular,
	bool:MP3,
	bool:Galao,
	CallerID,
	StateCell,
	TypeCall,
	bool:Agenda,
	TimerCobrancaCelular,
	bool:BankLogin,
	TitularTransf[MAX_PLAYER_NAME],
	NumeroTransf,
	ValorTransf,
	Cash,
	CorNick,
	CorTag,
	TimeContinuar,
	bool:TesteDirecao,
	PontosInTeste,
	e_HABILITACAO:Habilitacao,
	bool:Calado,
	TempoCalado,
	Plano,
	EmTratamento,
	Sementes,
	SementesL,
	Materias,
	Maconha,
	Crack,
	Cocaina,
	Entrou,
	AdvogadoID,
	PrisioneiroID,
	AdvogadoValor,
	QuantMadeiras,
	QuantDrogas,
	Matou,
	Morreu,
	ConviteFaccao,
	ReparandoVeiculo,
	pMorador,
	SkillPistol,
	SkillFuzil,
	SkillMP5,
	SkillShotgun,
	SkillRifle,
	bool:pRadio,
	bool:pComRadio,
	pAcP,
	Discord,
	DiscordID,

	// Empregos
	LoadingTimer,
	LoadingTimerTime,
	VehicleID,
	TrailerID,
	LoadID,
	JobStep,
	JobLoc1,
	JobLoc2,
	bool:Overloaded,
	bool:MafiaLoad,
	bool:MafiaLoadHijacked,
	Float:DonoCarga,
	Float:DNIT_Start, // Salvar distância de quanto esta quando inicar o trabalho
	bool:InConvoy,
	ConvoyID,
	bool:Carregado,
	PlayerText:DrawTela[2],
    FalhaTimer,
    TrabalhoTempo,
    Float:DanoCarga,
    bool:JobStarted,
	TempoComando[11],
	VehicleTimerTime,
	comVeiculo,
	VeiculoLocado,
	TAGBase[20],
	//KitFavela,
	//bool:inFavela,
	//bool:MortoFavela,
	bool:CVIP,
	bool:TCP,
	BaseID,
	AdmTempoLogado
}
new Jogador[MAX_PLAYERS][e_PLAYER_INFO], Iterator:PlayersAdmin<MAX_PLAYERS>;
new TimeColete[MAX_PLAYERS];

enum StateVehicle
{
	Panels,
	Doors[4],
	Lights[4],
	Tires[4]
}
new State[MAX_VEHICLES][StateVehicle];

#define MAX_PROFISSOES 			(26)
#define MAX_CAIXAS 				100

new Iterator:Profissoes<MAX_PROFISSOES>, Iterator:Caixa<MAX_CAIXAS>;

#define MAX_CONVOYS                 11
#define CONVOY_MAX_MEMBERS          70
#define CONVOY_EMPTY                0
#define CONVOY_OPEN                 1
#define CONVOY_FULL         	    2
#define CONVOY_CLOSED               3

enum TConvoyData
{
	Members[CONVOY_MAX_MEMBERS],
	LoadID,
	Location1,
	Location2,
	Status,
	ConvoyStep,
	TrailerModel,
    TruckModel, // No caso, de não ser comboio de TRAILERS
	bool:LeaderInformedTrailers,
	ConvoyTimer,
    ComboioNome[20],
	SenhaComboio[50],
    Text:ComboioDraw[2]
};
new AConvoys[MAX_CONVOYS][TConvoyData];



// ================= [ CAIXA ELETRONICO ]
enum e_CAIXAE_INFO
{
	ID,
	ObjectID,
	Text3D:Label,
	Valor,
	Float:Pos[e_POSITION],
	Interior,
	World
}
new Caixa[MAX_CAIXAS][e_CAIXAE_INFO];


// ============================== [ VARIÁVEIS ] ============================== //

new mS_CarAdmins = mS_INVALID_LISTID, mS_AllSkins = mS_INVALID_LISTID, mS_AllWeapons = mS_INVALID_LISTID, m_string[255];

//new ActorSpawn, ActorHospital;

new 
	CP_AGENCIA_1, CP_AGENCIA_2, CP_POUPA_TEMPO[3], CP_BAYSIDE, CP_NEWPREFEITURA, CP_PREFEITURA, CP_DETRAN[7], CP_BANCO[6], CP_ARMAS, CP_DP[3], CP_ARMASDP[3], CP_HOSPITAL, bool:Blocked[MAX_PLAYERS];

static
	MySQL:conexao;

new Autotunning[MAX_PLAYERS] = 0;

// ============================== [ ANTI HACK ] ============================== //

#include "../bin/modules/times.pwn"
#include "../bin/modules/anti-hack/anti-hack.pwn"
//#include "../bin/modules/server/logs.pwn"
//#include "../bin/modules/anti-hack/anti-cheat.pwn"

// ============================== [ HOOKS & CALLBACKS ] ============================== //

#include <YSI_Coding\y_hooks>


hook OnGameModeInit()
{
	print("» Inicializando sistemas...\n");
	
	print("» Conectando ao banco de dados...\n");
	conexao = mysql_connect_file();
	if ( mysql_errno() != 0 )
	{
		SendRconCommand("hostname Perfect City RPG ## MANUTENÇÃO ##");
		SendRconCommand("password __manutencao");
		print("| ERRO | Não foi possivel criar uma conexão com o banco de dados, verifique os dados em \"mysql.ini\".");
		return Y_HOOKS_BREAK_RETURN_1;
	}
	mysql_query_file(conexao, "querys/tabelas.sql", false);

	SendRconCommand("hostname "SERVER_NAME"");
	SendRconCommand("gamemodetext Brasil RPG - "SERVER_VERSION"");
	SendRconCommand("language Português Brasil");
	SendRconCommand("hostname Iniciando servidor, aguarde...");
	SendRconCommand("language Português Brasil");
	SendRconCommand("password sadhusahdauhs");
	SetTimer("RemoverSenhaInicio", 10000, false);

	// Status 

	SetTimer("Timer@UP1", 30000, true);
	/*SetTimer("Timer@SEDE", 120000, true);
	SetTimer("Timer@FOME", 300000, true);
	SetTimer("Timer@SONO", 540000, true);*/

	EnableStuntBonusForAll(false);
	ManualVehicleEngineAndLights();
	DisableInteriorEnterExits();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_STREAMED);
	LimitPlayerMarkerRadius(30.0);
	UsePlayerPedAnims();
	SetNameTagDrawDistance(30.0);
	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, 2000);

	// Loads Selections
	mS_CarAdmins = LoadModelSelectionMenu("selection/vehicles.txt");
	mS_AllSkins = LoadModelSelectionMenu("selection/skins.txt");
	mS_AllWeapons = LoadModelSelectionMenu("selection/armas.txt");

	// Creates Checkpoint, Labels and Actores
	CP_BAYSIDE = CreateDynamicCP(-2237.0862, 2353.8521, 4.9809, 1.1, -1, 0, -1, 20.0);
	CreateDynamic3DTextLabel("Use {"COR_AMARELO_INC"}/PegarMercadoria{"COR_BRANCO_INC"} para pegar sua mercadoria.", COR_BRANCO, -2237.0862, 2353.8521, 4.9809, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, 0, -1, 20.0);


	CreateDynamic3DTextLabel("Agência de Empregos", COR_BRANCO, 349.5017, 162.1570, 1014.1875, 20.0, .testlos=1, .streamdistance=20.0, .interiorid=3, .worldid=-1);
	CP_AGENCIA_1 = CreateDynamicCP(349.5017, 162.1570, 1014.1875, 1.1, .streamdistance=20.0, .interiorid=3, .worldid=-1);

	CreateDynamic3DTextLabel("Agência de Empregos", COR_BRANCO, 345.1997, 162.1192, 1014.1875, 20.0, .testlos=1, .streamdistance=20.0, .interiorid=3, .worldid=-1);
	CP_AGENCIA_2 = CreateDynamicCP(345.1997, 162.1192, 1014.1875, 1.1, .streamdistance=20.0, .interiorid=3, .worldid=-1);

	//CP_NEWPREFEITURA = CreateDynamicCP(362.6277,173.6559,1008.3828, 1.1, .streamdistance=20.0, .interiorid=0, .worldid=0);
	CP_NEWPREFEITURA = CreateDynamicCP(362.6277,173.6559,1008.3828, 1.1);
	CreateDynamic3DTextLabel("Prefeitura", 0x14B27CFF, 1096.28, -1050.68, 1088.00, 10.0, .streamdistance=20.0, .interiorid=0);

	/*CP_ARMAS_FAVELA = CreateDynamicCP(2197.1970, -1194.4746, 25.3509,  1.2, -1, -1, -1, 100.0); // Armas Favela
	CreateDynamic3DTextLabel("Digite {"COR_AMARELO_INC"}/Armas{"COR_BRANCO_INC"} para comprar seu kit.", COR_BRANCO, 2197.1970, -1194.4746, 25.3509, 20.0, .streamdistance=20.0, .interiorid=0);*/

	/*FavelaZone[0] = GangZoneCreate(2102.763183, -1098.157836, 2312.763183, -1000.157836);
	FavelaZone[1] = GangZoneCreate(2172.763183, -1154.157836, 2256.763183, -1098.157836);*/

	//ActorSpawn = CreateActor(217, 1688.1864,-2246.5581,13.5469,30.4298);
	CreateActor(217, 1688.1864,-2246.5581,13.5469,30.4298);
	CreateDynamic3DTextLabel("Informações Úteis\nDigite {ffffff}/infos{"COR_AMARELO_INC"}", COR_AMARELO, 1688.1864,-2246.5581,13.5469, 10.0, .streamdistance=20.0, .interiorid=0);

	// ActorHospital = 
	CreateActor(276, 1165.9147,-1324.9756,-44.2836, 1.2401);
	// ============================== [ AUTO ESCOLAS ] ============================== //
	CreateDynamic3DTextLabel("Auto Escola - Terrestre", 0x16A75AFF, 1300.4597, -1867.5258, 13.700, 20.0, .testlos=1, .streamdistance=20.0, .interiorid=0, .worldid=-1);
	CP_DETRAN[0] = CreateDynamicCP(675.7534,-1358.9934,17.4676, 1.1, .streamdistance=20.0, .interiorid=0, .worldid=-1); // CP Los Santos

	CreateDynamic3DTextLabel("Auto Escola - Terrestre", 0x16A75AFF, 1300.5763, -1871.4797, 13.700, 20.0, .testlos=1, .streamdistance=20.0, .interiorid=0, .worldid=-1);
	CP_DETRAN[1] = CreateDynamicCP(1677.6418,-1352.4249,17.4677, 1.1, .streamdistance=20.0, .interiorid=0, .worldid=-1); // CP Los Santos
	
	CreateDynamic3DTextLabel("Auto Escola - Terrestre", 0x16A75AFF, -2032.8784, -117.596, 1035.17, 20.0, .testlos=1, .streamdistance=20.0, .interiorid=0, .worldid=-1);
	CP_DETRAN[2] = CreateDynamicCP(-2032.8784, -117.596, 1035.17, 1.1, .streamdistance=20.0, .interiorid=3, .worldid=-1); // CP San Fierro

	CreateDynamic3DTextLabel("Auto Escola - Terrestre", 0x16A75AFF, 1171.9674, 1357.8705, 10.9219, 20.0, .testlos=1, .streamdistance=20.0, .interiorid=0, .worldid=-1);
	CP_DETRAN[3] = CreateDynamicCP(1171.9674, 1357.8705, 10.9219, 1.1, .streamdistance=20.0, .interiorid=0, .worldid=-1); // CP Las Venturas

	CreateDynamic3DTextLabel("Auto Escola - Terrestre", 0x16A75AFF, 1171.9413, 1354.0161, 10.9219, 20.0, .testlos=1, .streamdistance=20.0, .interiorid=0, .worldid=-1);
	CP_DETRAN[4] = CreateDynamicCP(1171.9413, 1354.0161, 10.9219, 1.1, .streamdistance=20.0, .interiorid=0, .worldid=-1); // CP Las Venturas

	CreateDynamicMapIcon(415.3265, 2533.5447, 19.14840, 5, COR_BRANCO, .streamdistance=100.0, .interiorid=0, .worldid=0);
	CreateDynamic3DTextLabel("Auto Escola - Aviação", 0x16A75AFF, 415.3265, 2533.5447, 19.14840, 20.0, .testlos=1, .streamdistance=20.0, .interiorid=0, .worldid=0);
	CP_DETRAN[5] = CreateDynamicCP(415.3265, 2533.5447, 19.14840, 1.1, .streamdistance=20.0, .interiorid=0, .worldid=0); // CP Auto escola Aviaï¿½ï¿½o.
	// ============================================================================================================================================================================================================ //
	
	// ============================== [ DEPARTAMENTO DE POLICIA ] ============================== //
	CP_DP[0] = CreateDynamicCP(248.7233, 67.9884, 1003.6406, 1.0, .interiorid=6, .streamdistance=10.0);//ls
	CreateDynamic3DTextLabel("Departamento de Policia de Los Santos", 0x16A75AFF, 248.7233, 67.9884, 1003.6406, 10.0, .interiorid=6, .streamdistance=10.0);

	CP_DP[1] = CreateDynamicCP(246.5317,118.3733,1003.2188, 1.0, .interiorid=10, .streamdistance=10.0);//sf
	CreateDynamic3DTextLabel("Departamento de Policia de San Fierro", 0x16A75AFF, 246.5317, 118.3733, 1003.2188, 10.0, .interiorid=10, .streamdistance=10.0);

	CP_DP[2] = CreateDynamicCP(298.5375,178.8100,1007.1719, 1.0, .interiorid=3, .streamdistance=10.0);//lv
	CreateDynamic3DTextLabel("Departamento de Policia de Las Venturas", 0x16A75AFF, 298.5375, 178.8100, 1007.1719, 10.0, .interiorid=3, .streamdistance=10.0);

	CP_ARMASDP[0] = CreateDynamicCP(254.0876, 78.8198, 1003.6406, 1.0, .interiorid=6, .streamdistance=10.0);// Equipar-se em Los Santos
	CreateDynamic3DTextLabel("Equipar-se", 0x16A75AFF, 254.0876, 78.8198, 1003.6406, 1.0, .interiorid=6, .streamdistance=10.0);// Equipar-se em Los Santos

	CP_ARMASDP[1] = CreateDynamicCP(272.5082, 117.7337, 1004.6172, 1.0, .interiorid=10, .streamdistance=10.0);// Equipar-se em San Fierro
	CreateDynamic3DTextLabel("Equipar-se", COR_AZUL, 272.5082, 117.7337, 1004.6172, 10.0, .interiorid=10, .streamdistance=10.0);// Equipar-se em San Fierro

	CP_ARMASDP[2] = CreateDynamicCP(272.5082, 117.7337, 1004.6172, 1.0, 3, .streamdistance=10.0);// Equipar-se em Las Venturas
	CreateDynamic3DTextLabel("Equipar-se", COR_AZUL, 272.5082, 117.7337, 1004.6172, 10.0, .interiorid=6, .streamdistance=10.0);// Equipar-se em Las Venturas
	// ============================================================================================================================================================================================================ //
	
	// ============================== [ HOSPITAIS ] ============================== //
	CP_HOSPITAL = CreateDynamicCP(1166.2931,-1322.3184,-45.3, 1.1, .interiorid=0, .streamdistance=10.0);
	CreateDynamic3DTextLabel("Hospital", 0x16A75AFF, 1166.2931,-1322.3184,-44.5, 10.0, .streamdistance=10.0, .interiorid=0, .testlos=1);
	// ========================================================================================================================================================= //

	CP_POUPA_TEMPO[0] = CreateDynamicCP(1830.9723, -1289.4006, 22.2109, 1.1, .interiorid=0, .streamdistance=10.0); // Eduarda
	CreateDynamic3DTextLabel("Atendimento - Veiculos", COR_BRANCO, 1830.9723, -1289.4006, 22.2109, 10.0, .interiorid=0, .streamdistance=10.0, .testlos=1);// Equipar-se em Las Venturas

	CP_POUPA_TEMPO[1] = CreateDynamicCP(1829.7789, -1293.1106, 22.2109, 1.1, .interiorid=0, .streamdistance=10.0); // aghata 
	CreateDynamic3DTextLabel("Atendimento - Poupa tempo", COR_BRANCO, 1829.7789, -1293.1106, 22.2109, 10.0, .interiorid=0, .streamdistance=10.0, .testlos=1);// Equipar-se em Las Venturas
	
	CP_POUPA_TEMPO[2] = CreateDynamicCP(1831.1827, -1293.6414, 22.2109, 1.1, .interiorid=0, .streamdistance=10.0); // fernanda
	CreateDynamic3DTextLabel("Atendimento - Poupa tempo", COR_BRANCO, 1831.1827, -1293.6414, 22.2109, 10.0, .interiorid=0, .streamdistance=10.0, .testlos=1);// Equipar-se em Las Venturas

	// ============================== [ CONFIG EVF ] ============================== //
	EVF::ToggleVehicleBlinking(true);
	// ============================================================================ //

	/**
	*
	*	Marcações
	*
	**/

	// Fazenda Plantador de Maconha
	CreateDynamicRectangle(-1474.3016, -1602.8999, -1399.6624, -1447.9050, 0xB20D0D99);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

forward RemoverSenhaInicio();
public RemoverSenhaInicio()
{
	SendRconCommand("hostname "SERVER_NAME"");
	SendRconCommand("gamemodetext Brasil RPG - ("SERVER_VERSION")");
	SendRconCommand("language Português Brasil");
	SendRconCommand("password admin@pfc");
	return 1;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	if( !IsPlayerAdmin(playerid) )
	{
		if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE)
		{
			if(Jogador[playerid][Calado] != false) 
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você está calado e não pode falar no chat ou usar comandos."), false;
		}

		if((flags & DIRECAO) && call::ADMIN->GetPlayerAdminLevel(playerid) < flags ||
			(flags & ADMINISTRADOR) && call::ADMIN->GetPlayerAdminLevel(playerid) < flags ||
			(flags & MODERADOR) && call::ADMIN->GetPlayerAdminLevel(playerid) < flags ||
			(flags & AJUDANTE) && call::ADMIN->GetPlayerAdminLevel(playerid) < flags)
			return SendClientMessage(playerid, COR_AMARELO, "| AVISO | Você digitou ( {"COR_BRANCO_INC"}/%s {"COR_AMARELO_INC"}) e o comando não foi encontrado, use {"COR_BRANCO_INC"}/Ajuda {"COR_AMARELO_INC"}ou {"COR_BRANCO_INC"}/Duvida", cmd), false;

		if(call::ADMIN->GetPlayerAdminLevel(playerid) < DIRECAO && (flags & AJUDANTE || flags & MODERADOR || flags & ADMINISTRADOR) && !call::ADMIN->IsAdminInJob(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa usar /LogarAdm para utilizar comandos administrativos."),false;

	}

	//if(strcmp(cmd,"sairafk", true) != 0 && Jogador[playerid][AFK] == true)
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você está AFK e não pode usar comandos."), false;

	if(Jogador[playerid][AFK] == true)
	{
		if(strcmp(cmd, "sairafk", true) != 0)
		{
			if(Jogador[playerid][Preso] == 0)
			{
				SendClientMessage(playerid, COR_ERRO, "| ERRO | Você está AFK e não pode usar comandos.");
				return false;
			}
		}
	}


	if (  call::PLAYER->GetPlayerVarInt(playerid, Preso) && call::ADMIN->GetPlayerAdminLevel(playerid) < MODERADOR )
	{
		if ( strcmp(cmd, "aceitar", true) != 0 
			&& strcmp(cmd, "recusar", true) != 0 
			&& strcmp(cmd, "advogados", true) != 0 
			&& strcmp(cmd, "advogado", true) != 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar comandos enquanto estiver preso."), false;
	}

	return true;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
	if(result == -1)
		return SendClientMessage(playerid, COR_AMARELO, "| AVISO | Você digitou ( {"COR_BRANCO_INC"}/%s {"COR_AMARELO_INC"}) e o comando não foi encontrado, use {"COR_BRANCO_INC"}/Ajuda {"COR_AMARELO_INC"}ou {"COR_BRANCO_INC"}/Duvida", cmd);
		//return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Comando ({"COR_BRANCO_INC"}/%s{"COR_ERRO_INC"}) nï¿½o existe, use {"COR_BRANCO_INC"}/ajuda{"COR_ERRO_INC"} para mais informaï¿½ï¿½es.", cmd);
	
	if(result)
	{
		if(Jogador[playerid][AFK] == false)
		{
			Jogador[playerid][AFK] = false;
			playerLastComand[playerid] = GetTickCount();
			return 0;
		}
	}
	return true;
}

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
	if(response)
	{
		if(listid == mS_CarAdmins)
		{
			if(call::ADMIN->CreateVehicleToAdmin(playerid, modelid)){
				SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você criou um '{ffffff}%s{"COR_AZUL_INC"}' (%d).", GetVehicleModelName(modelid), modelid);
			}		
			return true;
		}
		else if ( listid == mS_AllSkins)
		{
			SendClientMessage(playerid, COR_AZUL, "» Você selecionou a skin id {"COR_BRANCO_INC"}%d{"COR_BRANCO_INC"}.", modelid);
			SetPlayerSkin(playerid, modelid);
			return true;
		}
		else if ( listid == mS_AllWeapons)
		{
			SendClientMessage(playerid, COR_AZUL, "» Você selecionou a arma id {"COR_BRANCO_INC"}%d{"COR_BRANCO_INC"}.", modelid);
			GivePlayerWeapon(playerid, modelid, 99999);
			return true;
		}
	}
	return true;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if( call::PLAYER->GetPlayerRequestGPS(playerid) )
	{
		call::PLAYER->DisablePlayerGPS(playerid);
		SendClientMessage(playerid, COR_VERDE, "| GPS | {"COR_BRANCO_INC"}Você chegou ao seu destino.");
		return 1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}


public OnPlayerConnect(playerid)
{
	SetPlayerTeam(playerid, NO_TEAM);
	DrawsJogador(playerid);
	LoadPlayerText@AFK(playerid);
	playerLastComand[playerid] = GetTickCount();
	//LoadFavelaText(playerid);
	return true;
}

Dialog:DIALOG_TUNNING(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			
		}
	}
	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{

	if(checkpointid == CP_NEWPREFEITURA){
		ShowPlayerDialog(playerid, MENU_PREFEITURA, DIALOG_STYLE_LIST, "MENU PREFEITURA", "Pagar Impostos\nLimpar Habilitação", "Selecionar", "Fechar");
		return true;
	}
	else if(checkpointid == CP_AGENCIA_1 || checkpointid == CP_AGENCIA_2)
	{
		//ApplyAnimation(playerid,"PED","SEAT_idle", 4.0, 1, 0, 0, 0, 0);
		callcmd::empregos(playerid);
		return true;
	}
	else if(checkpointid == CP_DETRAN[0] || checkpointid == CP_DETRAN[1] || checkpointid == CP_DETRAN[2] || checkpointid == CP_DETRAN[3] || checkpointid == CP_DETRAN[4]){
		callcmd::menudetran(playerid);
		return true;
	}
	else if ( checkpointid == CP_DETRAN[5] ){ // Auto Escola de Aviação
		callcmd::menudetranaviacao(playerid);
	}
	else if ( checkpointid == CP_DP[0] || checkpointid == CP_DP[1] || checkpointid == CP_DP[2] ){
		new valor = GetPlayerWantedLevel(playerid) * VALOR_POR_ESTRELAS;
		ShowPlayerDialog(playerid, MENU_DP, DIALOG_STYLE_TABLIST, "MENU DP", "Limpar Ficha\t{31b404}R$%s\nPresos", "Selecionar", "Fechar", RealStr(valor));
	}
	else if ( checkpointid == CP_ARMASDP[0] || checkpointid == CP_ARMASDP[1] || checkpointid == CP_ARMASDP[2] )
	{
		if ( call::PLAYER->GetPlayerVarInt(playerid, Profissao) != POLICIA_MILITAR )
			return true;

		if(!call::JOB->IsPlayerInWorking(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	    if(Blocked[playerid] == true) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já se equipou recentemente.");
	    GivePlayerWeapon(playerid, 31, 500), GivePlayerWeapon(playerid, 29, 400), GivePlayerWeapon(playerid, 17, 10);
	    GivePlayerWeapon(playerid, 24, 300), GivePlayerWeapon(playerid, 27, 300), GivePlayerWeapon(playerid, 16, 10);
	    SetPlayerArmour(playerid, 100);
		SendClientMessage(playerid, COR_AZUL, "| POLICIA | Você acabou de se equipar.");
	    Blocked[playerid] = true, SetTimerEx("BloqueandoArmasDP", minutos(15) , true, "i", playerid);
	}
	else if ( checkpointid == CP_HOSPITAL ){ // Menu Hospital
		ShowPlayerDialog(playerid, MENU_HOSPITAL, DIALOG_STYLE_LIST, "MENU DE ATENDIMENTO DO HOSPITAL", "Ver Planos de Saúde\nRecuperar Vida", "Selecionar", "Fechar");

	}
	else if ( checkpointid == CP_POUPA_TEMPO[0]) // Eduarda
	{
		SetPVarInt(playerid, "index_atendimento", 0);

		SetPlayerPos(playerid, 1831.6586,-1289.1975,22.2109);
		SetPlayerFacingAngle(playerid, 359.9234);
		TogglePlayerControllable(playerid, false);
		

		/**
		*
		*	setar a animação
		*
		**/
		ApplyAnimation(playerid,"PED","SEAT_idle", 4.0, 1, 0, 0, 0, 0);

		ShowPlayerDialog(playerid, MENU_POUPA_TEMPO, DIALOG_STYLE_LIST, "POUPA TEMPO - VEICULOS", "Vender Veiculo\nGuinchar", "Selecionar", "Sair");
		return true;
	}
	else if ( checkpointid == CP_POUPA_TEMPO[1] ) // Agatha
	{
		SetPVarInt(playerid, "index_atendimento", 1);

		SetPlayerPos(playerid, 1829.1405,-1293.7604,22.2109);
		SetPlayerFacingAngle(playerid, 94.0009);
		TogglePlayerControllable(playerid, false);
		

		/**
		*
		*	setar a animação
		*
		**/
		ApplyAnimation(playerid,"PED","SEAT_idle", 4.0, 1, 0, 0, 0, 0);

		ShowPlayerDialog(playerid, MENU_POUPA_TEMPO, DIALOG_STYLE_LIST, "POUPA TEMPO - VEICULOS", "Vender Veiculo\nGuinchar", "Selecionar", "Sair");
		return true;
	}

	else if ( checkpointid == CP_POUPA_TEMPO[2] ) // Fernanda
	{
		SetPVarInt(playerid, "index_atendimento", 2);

		SetPlayerPos(playerid, 1831.6758,-1292.8108,22.2109);
		SetPlayerFacingAngle(playerid, 278.2427);
		TogglePlayerControllable(playerid, false);
		

		/**
		*
		*	setar a animação
		*
		**/
		ApplyAnimation(playerid,"PED","SEAT_idle", 4.0, 1, 0, 0, 0, 0);

		ShowPlayerDialog(playerid, MENU_POUPA_TEMPO, DIALOG_STYLE_LIST, "POUPA TEMPO - VEICULOS", "Vender Veiculo\nGuinchar", "Selecionar", "Sair");
		return true;
	}
	return false;
}

forward BloqueandoArmasDP(playerid);
public BloqueandoArmasDP(playerid) return Blocked[playerid] = false;

/**
*
*	DIALOGs
*
**/
Dialog:MENU_POUPA_TEMPO(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		new index = GetPVarInt(playerid, "index_atendimento");

		/**
		 *
		 * Menu Eduarda - veiculos
		 *
		 **/
		
		switch(listitem)
		{
			case 0: // Vender Veiculo.
			{
				new info[512], count, valor;
				info = "Veiculo\tValor da venda\tPlaca\n";
				foreach(new vehicleid: VehiclePlayers)
				{
					if( Vehicle[vehicleid][Owner][Id] == Jogador[playerid][PlayerID] )
					{
						valor = floatround(call::CONCE->GetVehicleValorByModel(GetVehicleModel(vehicleid)) / 2);
						format(info, sizeof(info), "%s{"COR_AMARELO_INC"}%s\t{"COR_VERDE_INC"}R$%s\t%s\n", info, GetVehicleName(vehicleid), RealStr(valor), Vehicle[vehicleid][Placa] );
						count++;
					}
				}
				if ( count )
					return ShowPlayerDialog(playerid, MENU_VENDER_VEICULO, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_AZUL_INC"}VENDA DO VEICULO", info, "Vender", "Voltar");

				SendClientMessage(playerid, COR_ERRO, "Você não tem um veiculo para vender.");

				
				OnPlayerEnterDynamicCP(playerid, CP_POUPA_TEMPO[index]);
				return true;
			}
			case 1: // Guinchar veiculo
			{
				new info[512], count, valor;
				info = "Veiculo\tPlaca\tValor\n";
				foreach(new vehicleid: VehiclePlayers)
				{
					if( Vehicle[vehicleid][Owner][Id] == Jogador[playerid][PlayerID] )
					{
						valor = floatround(call::CONCE->GetVehicleValorByModel(GetVehicleModel(vehicleid)) * 0.01);
						format(info, sizeof(info), "%s{"COR_AMARELO_INC"}%s\t%s\t{25D917}R$%s\n", info, GetVehicleName(vehicleid), Vehicle[vehicleid][Placa], RealStr(valor));
						count++;
					}
				}
				if ( count )
					return ShowPlayerDialog(playerid, MENU_GUINCHAR_VEICULO, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_AZUL_INC"}VENDA DO VEICULO", info, "Vender", "Voltar");

				SendClientMessage(playerid, COR_ERRO, "Você não tem um veiculo para guinchar.");

				OnPlayerEnterDynamicCP(playerid, CP_POUPA_TEMPO[index]);
				return true;
			}
		}		
	}
	TogglePlayerControllable(playerid, true);
	ClearAnimations(playerid);
	DeletePVar(playerid, "index_atendimento");
	return false;
}

Dialog:MENU_VENDER_VEICULO(playerid, response, listitem, inputtext[])
{
	new index = GetPVarInt(playerid, "index_atendimento");
	OnPlayerEnterDynamicCP(playerid, CP_POUPA_TEMPO[index]);
	if ( response )
	{
		new count;
		foreach(new vehicleid: VehiclePlayers)
		{
			if( Vehicle[vehicleid][Owner][Id] == Jogador[playerid][PlayerID] )
			{
				if( listitem == count )
				{
					if ( Vehicle[vehicleid][Multas] > 0 )
						return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não aceitamos veiculos com multas atrasadas, você deve primeiro pagar as multas do veiculo.");

					if ( Vehicle[vehicleid][IPVA] > 0 )
						return SendClientMessage(playerid, COR_ERRO, "| ERRO | O veiculo tem IPVA's atrasados, você precisa primeiro pagar os IPVA's do veiculo.");

					new valor = floatround(call::CONCE->GetVehicleValorByModel(GetVehicleModel(vehicleid)) / 2);
					SetPVarInt(playerid, "venda@vehicleid", vehicleid);
					ShowPlayerDialog(playerid, CONFIMAR_VENDA_VEICULO, DIALOG_STYLE_MSGBOX, "{"COR_AZUL_INC"}CONFIRMAR VENDA", "{"COR_BRANCO_INC"}Você deseja vender seu veiculo {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"} por {"COR_VERDE_INC"}R$%s {"COR_BRANCO_INC"}?\n\n\t{"COR_ERRO_INC"}Essa aï¿½ï¿½o ï¿½ irreverssï¿½vel!", "Confirmar", "Cancelar", GetVehicleName(vehicleid), RealStr(valor));
					return true;
				}
				count++;
			}
		}
		return true;
	}
	return true;
}

Dialog:MENU_GUINCHAR_VEICULO(playerid, response, listitem, inputtext[])
{
	new index = GetPVarInt(playerid, "index_atendimento");
	OnPlayerEnterDynamicCP(playerid, CP_POUPA_TEMPO[index]);
	if ( response )
	{
		new count;
		foreach(new vehicleid: VehiclePlayers)
		{
			if( Vehicle[vehicleid][Owner][Id] == Jogador[playerid][PlayerID] )
			{
				if( listitem == count )
				{
					new valor = floatround(call::CONCE->GetVehicleValorByModel(GetVehicleModel(vehicleid)) * 0.01);
					GivePlayerMoney(playerid, -valor, true);

					new rand = random(sizeof(GuinchoVehicle));
					SetVehiclePos(vehicleid, GuinchoVehicle[rand][0], GuinchoVehicle[rand][1], GuinchoVehicle[rand][2]);
					SetVehicleZAngle(vehicleid, GuinchoVehicle[rand][3]);
					EVF::SetVehicleSpawnInfo(vehicleid, GuinchoVehicle[rand][0], GuinchoVehicle[rand][1], GuinchoVehicle[rand][2], GuinchoVehicle[rand][3], 0, 0);

					SendClientMessage(playerid, COR_BRANCO, "Seu veiculo {"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"} foi guinchado até o deposito em Las Venturas, você pagou {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.", GetVehicleName(vehicleid), RealStr(valor) );
					return true;
				}
				count++;
			}
		}
		return true;
	}
	OnPlayerEnterDynamicCP(playerid, CP_POUPA_TEMPO[index]);
	return true;
}

Dialog:CONFIMAR_VENDA_VEICULO(playerid, response, listitem, inputtext[])
{
	new index = GetPVarInt(playerid, "index_atendimento");
	OnPlayerEnterDynamicCP(playerid, CP_POUPA_TEMPO[index]);

	if ( response )
	{
		new vehicleid = GetPVarInt(playerid, "venda@vehicleid");
		DeletePVar(playerid, "venda@vehicleid");

		if ( !IsValidVehicle(vehicleid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Veiculo inválido.");

		if( Vehicle[vehicleid][Owner][Id] != Jogador[playerid][PlayerID] )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é o proprietário desse veiculo.");

		new query[128], valor = floatround(call::CONCE->GetVehicleValorByModel(GetVehicleModel(vehicleid)) / 2);

		/**
		*
		*	deletar dados no banco de dados.
		*
		**/
		mysql_format(getConexao(), query, sizeof(query), "DELETE FROM "TABLE_VEHICLES_PLAYER" WHERE `id`='%d' LIMIT 1;", Vehicle[vehicleid][Id]);
		mysql_tquery(getConexao(), query);



		DestroyVehicle(vehicleid);
		/**
		*
		*	resetar informaï¿½ï¿½es nas variï¿½veis.
		*
		**/
		new reset[e_VEHICLE_INFO];
		Vehicle[vehicleid] = reset;
		Iter_Remove(VehiclePlayers, vehicleid);

		GivePlayerMoney(playerid, valor, true);

		SendClientMessage(playerid, COR_AZUL, "* {"COR_BRANCO_INC"}Você vendeu o seu veiculo {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"} por {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.", GetVehicleName(vehicleid), RealStr(valor));
		return true;
	}
	return true;
}

Dialog:MENU_HOSPITAL(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		switch(listitem)
		{
			case 0: // Planos
			{
				new str[1024];
				for(new i; i < sizeof(Planos); i++)
				{
					format(str, sizeof(str), "%s%s\tVida:{"COR_AZUL_INC"}%d{"COR_BRANCO_INC"} Colete: {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"} FSS: {"COR_AZUL_INC"}+%d{"COR_BRANCO_INC"}\t{"COR_VERDE_INC"}R$%s\n", str, Planos[i][Nome], Planos[i][Vida], Planos[i][Colete], Planos[i][FSS], RealStr(Planos[i][Valor]) );
				}
				
				ShowPlayerDialog(playerid, MENU_PLANOS_SAUDE, DIALOG_STYLE_TABLIST, "PLANOS DE SAÚDE", str, "Contratar", "Voltar");
				return true;
			}
			case 1:
			{
				if ( Jogador[playerid][EmTratamento] != 0 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está em tratamento.");

				if ( call::PLAYER->GetPlayerVarBool(playerid, Perseguido) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você está sendo perseguido pela policia e não pode recuperar sua vida agora.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				
				if ( health >= 100 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está com a vida cheia.");

				new rand = random(sizeof(CamasHospitais));
				Teleport(
					playerid,
					CamasHospitais[rand][0],
					CamasHospitais[rand][1],
					CamasHospitais[rand][2],
					CamasHospitais[rand][3],
					GetPlayerInterior(playerid),
					GetPlayerVirtualWorld(playerid),
					Jogador[playerid][Entrou]
				);

				SetPlayerCameraPos(playerid, 1149.4744, -1333.1227, -43.3371);
				SetPlayerCameraLookAt(playerid, 1150.1132, -1332.3553, -43.5470);

				ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
				Jogador[playerid][EmTratamento] = SetTimerEx("EmTratamentoHospital", 5000, true, "d", playerid);
				SendClientMessage(playerid, -1, "| TRATAMENTO | Você está recebendo o devido tratamento médico. Por favor, aguarde...");
				return true;
			}
		}
		return true;
	}
	return true;
}

forward EmTratamentoHospital(playerid);
public EmTratamentoHospital(playerid)
{
	if ( !IsPlayerConnected(playerid) )
		return KillTimer(Jogador[playerid][EmTratamento]), Jogador[playerid][EmTratamento] = 0;

	new Float:vida;
	GetPlayerHealth(playerid, vida);
	if ( vida >= 100 )
	{
		KillTimer(Jogador[playerid][EmTratamento]);
		Jogador[playerid][EmTratamento]=0;

		SendClientMessage(playerid, COR_VERMELHO, "* {"COR_BRANCO_INC"} Seu tratamento foi concluido.");
		//ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);
		ClearAnimations(playerid);
		SetCameraBehindPlayer(playerid);
		return true;
	}
	SetPlayerHealth(playerid, vida + 10);
	return true;
}

Dialog:MENU_PLANOS_SAUDE(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		if ( call::PLAYER->GetPlayerVarInt(playerid, Plano) == listitem )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já é assinante deste plano de saúde."), OnPlayerEnterDynamicCP(playerid, CP_HOSPITAL);

		if ( GetPlayerMoney(playerid) < Planos[listitem][Valor] )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro para adquirir esse plano.");
		call::PLAYER->SetPlayerVarInt(playerid, Plano, listitem);

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET plano_saude=%d WHERE id=%d LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, Plano), call::PLAYER->GetPlayerVarInt(playerid, PlayerID) );
		mysql_tquery(getConexao(), query);

		SendClientMessage(playerid, -1, "| HOSPITAL | Você assinou o plano de saúde {"COR_AZUL_INC"}%s. {ffffff}Você irá pagar {31b404}R$%s{"COR_BRANCO_INC"} por salário.", Planos[listitem][Nome], RealStr(Planos[listitem][Valor]));
		return true;
	}
	OnPlayerEnterDynamicCP(playerid, CP_HOSPITAL);
	return true;
}

Dialog:MENU_DP(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		switch(listitem)
		{
			case 0: // Limpar ficha criminal
			{
				if ( GetPlayerWantedLevel(playerid) < 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está sendo procurado pela policia.");

				new valor = GetPlayerWantedLevel(playerid) * VALOR_POR_ESTRELAS;
				
				if ( GetPlayerMoney(playerid) < valor )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem o valor necessário para limpar sua ficha criminal.");

				SendClientMessage(playerid, -1, "| INFO | Você removeu {"COR_LARANJA_INC"}%d {ffffff}estrelas de procurado e pagou {31b404}R$%s{ffffff}!", GetPlayerWantedLevel(playerid), RealStr(valor));
				GivePlayerMoney(playerid, -valor);
				SetPlayerWantedLevel(playerid, 0);
				return true;
			}
			case 1:
			{
				callcmd::presos(playerid);
			}
		}
		return true;
	}
	return true;
}

Dialog:MENU_PREFEITURA(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: // Pagar impostos
			{
				ShowPlayerDialog(playerid, MENU_IMPOSTOS, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}MENU PREFEITURA » {"COR_BRANCO_INC"}PAGAR IMPOSTOS", "Casa\nEmpresa", "Selecionar", "Voltar");
				return true;
			}
			case 1: // limpar pontos na carteira
			{
				new valor = Jogador[playerid][Multas] * VALOR_POR_MULTA;
				ShowPlayerDialog(playerid, MENU_LIMPAR_CARTEIRA, DIALOG_STYLE_MSGBOX, "MENU PREFEITURA » {"COR_BRANCO_INC"}LIMPAR PONTOS NA CARTEIRA", 
					"{"COR_BRANCO_INC"}Você tem {"COR_VERMELHO_INC"}%d{"COR_BRANCO_INC"} pontos em sua habilitação, para limpar você precisa de {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.\n\n\t{"COR_ERRO_INC"}Você deseja limpar os pontos de sua habilitação?", "Limpar", "Voltar", call::PLAYER->GetPlayerVarInt(playerid, Multas), RealStr(valor) );
				return true;
			}
		}
		return true;
	}
	return true;
}

Dialog:MENU_IMPOSTOS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: // casa
			{
				new casaid = GetPlayerHouse(playerid);

				if(casaid == INVALID_HOUSE_ID)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui uma casa.");

				if ( Jogador[playerid][PlayerID] != Casa[casaid][Owner][Id] )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é o proprietário desta casa.");

				if (  Casa[casaid][IsCash] )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua casa é por BitCoins e não precisa pagar impostos.");

				if ( call::HOUSE->GetHouseParamInt(casaid, Impostos) < 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua casa não tem impostos a pagar.");

				ShowPlayerDialog(playerid, PAGAR_IMPOSTO_CASA, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}MENU PREFEITURA » PAGAR IMPOSTOS » {"COR_BRANCO_INC"}CASA", 
					"{"COR_BRANCO_INC"}Você tem {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"} impostos a pagar de sua casa.\n\nValor {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}\n\n\tVocê deseja pagar seus impostos agora?",
					"Pagar", "Voltar", call::HOUSE->GetHouseParamInt(casaid, Impostos), RealStr(CALCULATE_IMPOSTOS(call::HOUSE->GetHouseParamInt(casaid, Valor),call::HOUSE->GetHouseParamInt(casaid, Impostos))) );
				return true;
			}
			case 1: // empresas
			{
				new empresaid = call::PLAYER->GetPlayerVarInt(playerid, EmpresaID);
				
				if(empresaid == INVALID_BUSINESS_ID)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem uma empresa.");

				new pName[MAX_PLAYER_NAME];
				call::BUSINESS->GetBusinessParams(empresaid, Proprietario, pName);
				
				if ( strcmp(pName, GetUserName(playerid), true) != 0 || isnull(pName) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário desta empresa.");

				if ( call::BUSINESS->GetBusinessParamsInt(empresaid, Impostos) < 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua empresa não tem impostos a pagar.");

				ShowPlayerDialog(playerid, PAGAR_IMPOSTO_EMPRESA, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}MENU PREFEITURA » PAGAR IMPOSTO » {"COR_BRANCO_INC"}EMPRESA", 
					"{"COR_BRANCO_INC"}Você tem {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"} impostos a pagar de sua empresa.\n\nValor {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}\n\n\tVocê deseja pagar seus impostos agora?",
					"Pagar", "Voltar", call::BUSINESS->GetBusinessParamsInt(empresaid, Impostos), RealStr(CALCULATE_IMPOSTOS(call::BUSINESS->GetBusinessParamsInt(empresaid, Valor),call::BUSINESS->GetBusinessParamsInt(empresaid, Impostos))));
				return true;
			}
		}
		return true;
	}
	OnPlayerEnterDynamicCP(playerid, CP_NEWPREFEITURA);
	return true;
}
Dialog:MENU_LIMPAR_CARTEIRA(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		if ( Jogador[playerid][Multas] < 1 )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem tem pontos na carteira de habilitação."), OnPlayerEnterDynamicCP(playerid, CP_NEWPREFEITURA);

		new valor = Jogador[playerid][Multas] * VALOR_POR_MULTA;
		
		if ( GetPlayerMoney(playerid) < valor )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui dinheiro suficiente."), OnPlayerEnterDynamicCP(playerid, CP_NEWPREFEITURA);

		GivePlayerMoney(playerid, -valor, true);

		Jogador[playerid][Multas] = 0;
		
		new query[100];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET multas=0 WHERE `id`='%d' LIMIT 1;", Jogador[playerid][PlayerID]);
		mysql_tquery(getConexao(), query);

		SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Você limpou os pontos da sua Carteira de Habilitação.");
		return true;
	}
	OnPlayerEnterDynamicCP(playerid, CP_NEWPREFEITURA);
	return true;
}

Dialog:PAGAR_IMPOSTO_CASA(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new casaid = GetPlayerHouse(playerid);

		if(casaid == INVALID_HOUSE_ID)
			return ShowPlayerDialog(playerid, MENU_IMPOSTOS, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}MENU PREFEITURA » {"COR_BRANCO_INC"}PAGAR IMPOSTOS", "Casa\nEmpresa", "Selecionar", "Voltar"), SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui uma casa.");

		if ( Jogador[playerid][PlayerID] != Casa[casaid][Owner][Id] )
			return ShowPlayerDialog(playerid, MENU_IMPOSTOS, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}MENU PREFEITURA » {"COR_BRANCO_INC"}PAGAR IMPOSTOS", "Casa\nEmpresa", "Selecionar", "Voltar"), SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietï¿½rio desta casa.");

		new valor = CALCULATE_IMPOSTOS(call::HOUSE->GetHouseParamInt(casaid, Valor), call::HOUSE->GetHouseParamInt(casaid, Impostos));
		if (GetPlayerMoney(playerid) < valor)
			return ShowPlayerDialog(playerid, PAGAR_IMPOSTO_CASA, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}MENU PREFEITURA » PAGAR IMPOSTOS » {"COR_BRANCO_INC"}CASA", "{"COR_BRANCO_INC"}Você tem {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"} impostos a pagar de sua casa.\n\nValor {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}\n\n\tVocê deseja pagar seus impostos agora?\n\n{"COR_ERRO_INC"}Você não tem dinheiro suficiente para pagar os impostos.", "Pagar", "Voltar", call::HOUSE->GetHouseParamInt(casaid, Impostos), RealStr(CALCULATE_IMPOSTOS(call::HOUSE->GetHouseParamInt(casaid, Valor),call::HOUSE->GetHouseParamInt(casaid, Impostos))) );
		
		if(valor <= 0)
			return ShowPlayerDialog(playerid, MENU_IMPOSTOS, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}MENU PREFEITURA » {"COR_BRANCO_INC"}PAGAR IMPOSTOS", "Casa\nEmpresa", "Selecionar", "Voltar"), SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua casa não tem impostos pendentes a pagar.");
		
		++Casa[casaid][ImpostosPagos];
		if ( Casa[casaid][ImpostosPagos] >= 30 )
		{
			Casa[casaid][ImpostosPagos] = 0;
			++Casa[casaid][Level];

			UpdateHouseLabel(casaid);
			SendClientMessage(playerid, -1, "| CASA | Sua casa subiu para o level {1c88f0}%d{ffffff}.", Casa[casaid][Level]);
		}
		call::HOUSE->SetHouseParamInt(casaid, Impostos, 0);

		new query[255];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOUSES" SET `impostos`='0',`impostos_pagos`='%d',`level`='%d' WHERE `id`='%d' LIMIT 1;", Casa[casaid][ImpostosPagos], Casa[casaid][Level], call::HOUSE->GetHouseParamInt(casaid, ID));
		mysql_tquery(getConexao(), query);

		GivePlayerMoney(playerid, -valor);
		SendClientMessage(playerid, -1, "| IMPOSTOS | Você quitou todos os impostos da sua casa no valor de {"COR_VERDE_INC"}R$%s{ffffff}.", RealStr(valor));
		return true;
	}
	ShowPlayerDialog(playerid, MENU_IMPOSTOS, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}MENU PREFEITURA » {"COR_BRANCO_INC"}PAGAR IMPOSTOS", "Casa\nEmpresa", "Selecionar", "Voltar");
	return true;
}


Dialog:PAGAR_IMPOSTO_EMPRESA(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new empresaid = call::PLAYER->GetPlayerVarInt(playerid, EmpresaID);
		if ( empresaid == INVALID_BUSINESS_ID )
			return ShowPlayerDialog(playerid, MENU_IMPOSTOS, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}MENU PREFEITURA » {"COR_BRANCO_INC"}PAGAR IMPOSTOS", "Casa\nEmpresa", "Selecionar", "Voltar"), SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui uma empresa.");

		new pName[MAX_PLAYER_NAME];
		call::BUSINESS->GetBusinessParams(empresaid, Proprietario, pName);

		if ( strcmp(pName, GetUserName(playerid), true) != 0 || isnull(pName) )
			return ShowPlayerDialog(playerid, MENU_IMPOSTOS, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}MENU PREFEITURA » {"COR_BRANCO_INC"}PAGAR IMPOSTOS", "Casa\nEmpresa", "Selecionar", "Voltar"), SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é o proprietário desta empresa.");
		
		new valor = CALCULATE_IMPOSTOS(call::BUSINESS->GetBusinessParamsInt(empresaid, Valor), call::BUSINESS->GetBusinessParamsInt(empresaid, Impostos));
		
		if ( valor > GetPlayerMoney(playerid) )
			return ShowPlayerDialog(playerid, MENU_IMPOSTOS, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}MENU PREFEITURA » {"COR_BRANCO_INC"}PAGAR IMPOSTOS", "Casa\nEmpresa", "Selecionar", "Voltar"), SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente para pagar seus impostos.");

		if ( valor <= 0 )
			return ShowPlayerDialog(playerid, MENU_IMPOSTOS, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}MENU PREFEITURA » {"COR_BRANCO_INC"}PAGAR IMPOSTOS", "Casa\nEmpresa", "Selecionar", "Voltar"), SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua empresa não tem impostos pendentes a pagar.");
		
		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BUSINESS" SET `impostos`='0' WHERE `id`='%d' LIMIT 1;", call::BUSINESS->GetBusinessParamsInt(empresaid, ID));
		mysql_tquery(getConexao(), query);

		call::BUSINESS->SetBusinessParamsInt(empresaid, Impostos, 0);

		GivePlayerMoney(playerid, -valor);
		SendClientMessage(playerid, -1, "| IMPOSTOS | Você quitou todos os impostos da sua empresa no valor de {31b404}R$%s{ffffff}.", RealStr(valor));
		return true;
	}
	ShowPlayerDialog(playerid, MENU_IMPOSTOS, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}MENU PREFEITURA » {"COR_BRANCO_INC"}PAGAR IMPOSTOS", "Casa\nEmpresa", "Selecionar", "Voltar");
	return true;
}

/*static
    chat_msgOut[144];


stock SendErrorMsgF(playerid, const fmat[], {Float,_}:...) {
    formatex(chat_msgOut, sizeof(chat_msgOut), fmat, ___(2));
    return SendErrorMsg(playerid, chat_msgOut);
}

stock SendServerMsgF(playerid, const fmat[], {Float,_}:...) {
    formatex(chat_msgOut, sizeof(chat_msgOut), fmat, ___(2));
    return SendServerMsg(playerid, chat_msgOut);
}

stock SendMsgF(playerid, colour, const fmat[], {Float,_}:...) {
    formatex(chat_msgOut, sizeof(chat_msgOut), fmat, ___(3));
    return SendClientMessage(playerid, colour, chat_msgOut);
}

stock SendMsgAllF(colour, const fmat[], {Float,_}:...) {
    formatex(chat_msgOut, sizeof(chat_msgOut), fmat, ___(2));
    return SendClientMessageToAll(colour, chat_msgOut);
}*/

/*
*
*			Functions
*
*/

MySQL:getConexao()
{
	return conexao;
}

RegistrarAtividade(pid, const atividade[], const info[]) { // Registra a atividade do jogador
    new qq[300];
    mysql_format(getConexao(), qq, sizeof(qq), "INSERT INTO atividades (pid, atividade, info, time) VALUES (%i, '%e', '%e', %i)", pid, atividade, info, gettime());
    mysql_pquery(getConexao(), qq);
    return 1;
}

RegistrarAtividade_Admin(pid, const atividade[], const info[]) { // Registra a atividade do administrador
    new qqq[320];
    mysql_format(getConexao(), qqq, sizeof(qqq), "INSERT INTO atividade_administrativa (pid, atividade, info, time) VALUES (%i, '%e', '%e', %i)", pid, atividade, info, gettime());
    mysql_pquery(getConexao(), qqq);
    return 1;
}


#define CHANNEL_REGISTROS "845453809693098014"
#define CHANNEL_DUVIDAS "845451328490831882"
#define CHANNEL_RELATORIOS "845454653796646943"
#define CHANNEL_AVISOS "845450536026112050"
#define CHANNEL_PRISOES "845450318107377724"
#define CHANNEL_BANIMENTOS "845450106835828746"
#define CHANNEL_LOGINADMIN "845455150045855774"

#define LOG_REGISTROS 1
#define LOG_DUVIDAS 2
#define LOG_RELATORIOS 3
#define LOG_AVISOS 4
#define LOG_PRISOES 5
#define LOG_BANIMENTOS 6
#define LOG_LOGINADMIN 7



/*
*
*			Include
*
*/



#include ../bin/modules/server/npcs.pwn
#include ../bin/modules/server/shop.pwn
#include ../bin/modules/server/anuncio.pwn
#include ../bin/modules/server/detran.pwn
#include ../bin/modules/server/racha/racesystem.pwn
#include ../bin/modules/server/radares.pwn
#include ../bin/modules/server/banco.pwn
#include ../bin/modules/server/pedagio.pwn
#include ../bin/modules/textdraws/textdraws.pwn
#include ../bin/modules/jogador/jogador.pwn
#include ../bin/modules/profissoes/profissao.pwn
#include ../bin/modules/admin/admin.pwn
#include ../bin/modules/discord/discord_logs.pwn

#include ../bin/modules/veiculos/objetos.pwn
#include ../bin/modules/propriedades/propriedades.pwn
//#include ../bin/modules/profissoes/profissao.pwn
#include ../bin/modules/eventos/evento.pwn
#include ../bin/modules/basesystem/bases.pwn
#include ../bin/modules/veiculos/veiculo.pwn
#include ../bin/modules/empresas/empresas.pwn
#include ../bin/modules/casas/casa.pwn
#include ../bin/modules/checkip/checkip.pwn
#include ../bin/modules/concessionaria/conce.pwn
#include ../bin/modules/attach/attachment.pwn
#include ../bin/modules/faccoes/faccoes.pwn
#include ../bin/modules/mapas/mapas-geral.pwn
#include ../bin/modules/server/actors.pwn
#include ../bin/modules/server/caixas_eletronicos.pwn
#include ../bin/modules/server/gangzone.pwn
#include ../bin/modules/hoteis/hotel.pwn
#include ../bin/modules/hoteis/action.pwn
#include ../bin/modules/hoteis/dialogs.pwn
#include ../bin/modules/server/decorativevehicles.pwn
#include ../bin/modules/eventotexto/texto.pwn
//#include ../bin/modules/server/boate.pwn
//#include ../bin/modules/server/voice.pwn
//#include ../bin/modules/server/skills.pwn
//#include ../bin/modules/discord/discord.pwn
//#include ../bin/modules/jogador/som.pwn
#include ../bin/modules/server/teste.pwn