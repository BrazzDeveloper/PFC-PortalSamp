
enum e_FUNCIONARIO_INFO 
{
	Nome[MAX_PLAYER_NAME],
	Entregas
}
static 
	Business[MAX_BUSINESS + 1][e_BUSINESS_INFO],
	Funcionario[MAX_BUSINESS][MAX_FUNCIONARIOS + 1][e_FUNCIONARIO_INFO]
;

#include ../bin/modules/empresas/cmds.pwn
#include ../bin/modules/empresas/dialogs.pwn
#include ../bin/modules/empresas/gerenciar.pwn


const BUSINESS_LENG_RENDER_VAR = 350;
	
// ================================================== [ functions ] ================================================== //

stock static render_string(businessid)
{
	new s[BUSINESS_LENG_RENDER_VAR];
	

	if(Business[businessid][ValorCash] > 0)
	{
		format(s, sizeof(s),
			"{ff0000}Empresa ID %d\n{ffffff}%s\n%s\n{ff8000}Proprietário: {ffffff}%s\n{ff8000}Produção: {ffffff}%d\n{ff8000}Valor: {ffffff}R$%s {ffffff}BitCoins",
			Business[businessid][ID],
			Business[businessid][Nome],
			Business[businessid][Mensagem],
			Business[businessid][Proprietario],
			Business[businessid][Producao],
			RealStr(Business[businessid][ValorCash])
		);
	} else {
		format(s, sizeof(s),
			"{ff0000}Empresa ID %d\n{ffffff}%s\n%s\n{ff8000}Proprietário: {ffffff}%s\n{ff8000}Produção: {ffffff}%d\n{ff8000}Valor: {ffffff}R$%s",
			Business[businessid][ID],
			Business[businessid][Nome],
			Business[businessid][Mensagem],
			Business[businessid][Proprietario],
			Business[businessid][Producao],
			RealStr(Business[businessid][Valor])
		);
	}

	//format(s, sizeof(s),
	//	"{"COR_VERDE_CLARO_INC"}%s\n{ffffff}» Proprietário(a): {"COR_VERDE_CLARO_INC"}%s\n{ffffff}» Trabalhando: {"COR_VERDE_CLARO_INC"}%d{ffffff}/{"COR_VERDE_CLARO_INC"}%d\n{ffffff}» Produção: {"COR_VERDE_CLARO_INC"}%d{ffffff}\n{ffffff}» Cash: {"COR_VERDE_CLARO_INC"}R$%s",
	//	Business[businessid][Nome],
	//	Business[businessid][Proprietario],
	//	call::BUSINESS->CountFuncionarios(businessid),
	//	Business[businessid][MaxFuncionarios],
	//	Business[businessid][Producao],
	//	RealStr(Business[businessid][ValorCash])
	//);

	return s;
}

function BUSINESS::render(businessid)
{
	Business[businessid][PickupID] = CreateDynamicPickup(RETURN_PICKUP_ID(businessid), 23, Business[businessid][Entrada][X], Business[businessid][Entrada][Y], Business[businessid][Entrada][Z] - 0.5, 0, 0, -1, BUSINESS_RENDER_STREAMER);

	Business[businessid][Label][0] = CreateDynamic3DTextLabel(render_string(businessid), COR_BRANCO, Business[businessid][Entrada][X], Business[businessid][Entrada][Y], Business[businessid][Entrada][Z] + 0.3, 6.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0, -1, BUSINESS_RENDER_STREAMER);
	Business[businessid][Label][1] = CreateDynamic3DTextLabel("Use '{"COR_AMARELO_INC"}F{"COR_BRANCO_INC"}' para sair.", COR_BRANCO, Business[businessid][Saida][X], Business[businessid][Saida][Y], Business[businessid][Saida][Z], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, businessid, Business[businessid][Interior], -1, BUSINESS_RENDER_STREAMER);

	Business[businessid][Map] = CreateDynamicMapIcon(Business[businessid][Entrada][X], Business[businessid][Entrada][Y], Business[businessid][Entrada][Z], Business[businessid][MapIcon], COR_BRANCO, 0, 0, -1, BUSINESS_RENDER_STREAMER, MAPICON_LOCAL);
	
	if(Business[businessid][UseActor]){
		Business[businessid][Actor_id] = CreateDynamicActor(Business[businessid][Skin], Business[businessid][ActorPos][X], Business[businessid][ActorPos][Y], Business[businessid][ActorPos][Z], Business[businessid][ActorPos][A], 1, 100.0, businessid, -1, -1);
		CreateDynamic3DTextLabel(Business[businessid][ActorName], 0xFD811DFF, Business[businessid][ActorPos][X], Business[businessid][ActorPos][Y], Business[businessid][ActorPos][Z]+0.7, 15.0, businessid, .interiorid=-1, .streamdistance=15.0);
	}
}
function BUSINESS::DestroyBusiness(businessid)
{
	DestroyDynamicPickup(Business[businessid][PickupID]);

	DestroyDynamic3DTextLabel(Business[businessid][Label][0]);
	DestroyDynamic3DTextLabel(Business[businessid][Label][1]);

	DestroyDynamicMapIcon(Business[businessid][Map]);

	new reset[e_BUSINESS_INFO];
	Business[businessid] = reset;

	Iter_Remove(Business, businessid);
	return true;
}

function BUSINESS::UpdateBusinessData(businessid)
{
	if(!call::BUSINESS->IsValidBusiness(businessid))
		return false;

	new str[1024], query[2048];
	LoopFuncionarios(i, MAX_FUNCIONARIOS)
	{
		format(str, sizeof(str), "%s`funcionario_%d`='%s',`entregas_funcionario_%d`='%d',", str, i, Funcionario[businessid][i][Nome], i, Funcionario[businessid][i][Entregas]);
	}
	// remove o ultimo , da query acima.
	strdel(str, strlen(str) - 1, strlen(str));

	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BUSINESS" SET `proprietario`='%s',`mensagem`='%s',`level`='%d',`cofre`='%d',`producao`='%d',`max_funcionarios`='%d',%s,`entrada_x`='%f',`entrada_y`='%f',`entrada_z`='%f',`entrada_a`='%f',`saida_x`='%f',`saida_y`='%f',`saida_z`='%f',`saida_a`='%f',`interior`='%d' wHERE `id`='%d' LIMIT 1;", 
		Business[businessid][Proprietario], Business[businessid][Mensagem], Business[businessid][Level], Business[businessid][Cofre], Business[businessid][Producao], Business[businessid][MaxFuncionarios], str,
		Business[businessid][Entrada][X], Business[businessid][Entrada][Y], Business[businessid][Entrada][Z], Business[businessid][Entrada][A],
		Business[businessid][Saida][X], Business[businessid][Saida][Y], Business[businessid][Saida][Z], Business[businessid][Saida][A],
		Business[businessid][Interior],
		Business[businessid][ID]);
	mysql_tquery(getConexao(), query);
	return true;
}




function BUSINESS::SetBusinessExitPos(businessid, Float:x, Float:y, Float:z, Float:a, interior)
{
	if(!call::BUSINESS->IsValidBusiness(businessid))
		return false;

	Business[businessid][Saida][X] = x;
	Business[businessid][Saida][Y] = y;
	Business[businessid][Saida][Z] = z;
	Business[businessid][Saida][A] = a;
	Business[businessid][Interior] = interior;
	return true;
}

function BUSINESS::UpdateBusinessTexts(businessid)
{
	if(!call::BUSINESS->IsValidBusiness(businessid))
		return false;

	UpdateDynamic3DTextLabelText(Business[businessid][Label][0], COR_BRANCO, render_string(businessid));

	DestroyDynamicPickup(Business[businessid][PickupID]);
	Business[businessid][PickupID] = CreateDynamicPickup(RETURN_PICKUP_ID(businessid), 23, Business[businessid][Entrada][X], Business[businessid][Entrada][Y], Business[businessid][Entrada][Z], 0, 0, -1, BUSINESS_RENDER_STREAMER);
	return true;
}

function BUSINESS::GetBusinessColumID(businessid)
{
	if(!call::BUSINESS->IsValidBusiness(businessid))
		return false;

	return Business[businessid][ID];
}

function BUSINESS::ResetVariables(businessid)
{
	Business[businessid][Impostos] = 0;
	Business[businessid][Cofre] = 0;
	Business[businessid][Producao] = 0;
	format(Business[businessid][Mensagem], MAX_STRLEN_MSG, "Nada");

	new query[350];
	format(query, 350, "UPDATE `empresas` SET `impostos`='0', `mensagem`='Nada', `producao`=0 WHERE `id`='%d'", Business[businessid][ID]);
	mysql_query(getConexao(), query, false);

	return 1;
}



function BUSINESS::GetBusinessName(businessid)
{
	new bName[MAX_BUSINESS_NAME];
	if(!call::BUSINESS->IsValidBusiness(businessid))
		return bName;
	format(bName, sizeof(bName), Business[businessid][Nome]);
	return bName;
}

function BUSINESS::GetBusinessLocalName(businessid)
{
	new endereco[MAX_ZONE_NAME];

	if(!call::BUSINESS->IsValidBusiness(businessid))
		return endereco;

	GetLocalName(Business[businessid][Entrada][X], Business[businessid][Entrada][Y], endereco, sizeof(endereco));
	return endereco;
}

function BUSINESS::GetBusinessPos(businessid, &Float:x, &Float:y, &Float:z)
{
	if(!call::BUSINESS->IsValidBusiness(businessid))
		return false;

	x = Business[businessid][Entrada][X];
	y = Business[businessid][Entrada][Y];
	z = Business[businessid][Entrada][Z];
	return true;
}

function BUSINESS::GetBusinessInRangeP(playerid, Float:range)
{
	foreach(new businessid: Business)
	{
		if(IsPlayerInRangeOfPoint(playerid, range, Business[businessid][Entrada][X], Business[businessid][Entrada][Y], Business[businessid][Entrada][Z]))
		{
			return businessid;
		}
	}
	return INVALID_BUSINESS_ID;
}


GetBusinessIdByRow(rowid)
{
	foreach(new businessid: Business)
	{
		if ( Business[businessid][ID] == rowid)
		{
			return businessid;
		}
	}
	return INVALID_BUSINESS_ID;
}

function BUSINESS::IsValidBusiness(businessid){
	if(businessid > MAX_BUSINESS || businessid < 0)
		return false;

	return (Iter_Contains(Business, businessid) && !isnull(Business[businessid][Nome]));
}

function BUSINESS::CheckBusinessProper(playerid, businessid)
{
	new proprietario[MAX_PLAYER_NAME];

	call::BUSINESS->GetBusinessParams(businessid, Proprietario, proprietario, MAX_PLAYER_NAME);

	if(!strcmp(proprietario, GetUserName(playerid), false, MAX_PLAYER_NAME))
	{
		return 1;
	}
	return 0;
}

function BUSINESS::CheckBusinessFunc(playerid, businessid)
{
	new id;
	id = GetBusinessIdByRow(call::BUSINESS->GetBusinessParamsInt(businessid, ID));
	if(call::PLAYER->GetPlayerVarInt(playerid, EmpresaID) == id)
	{
		return 1;
	}
	return 0;
}

function BUSINESS::ShowPlayerBusinessMenu(playerid, businessid)
{
	if(businessid == call::PLAYER->GetPlayerVarInt(playerid, EmpresaID))
	{
		if(businessid == INVALID_BUSINESS_ID)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma empresa.");
			
		if(!call::BUSINESS->CheckBusinessFunc(playerid, businessid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário desta empresa.");

		new String[1000], Str[1000];
		format(Str, 1000, "{ffffff}Mensagem\t{ffffff}%s\n", Business[businessid][Mensagem]);
		strcat(String, Str);

		format(Str, 1000, "{ffffff}Cofre\t{31b404}R$%s\n", RealStr(Business[businessid][Cofre]));
		strcat(String, Str);

		new query[350];
		format(query, sizeof(query), "SELECT * FROM `usuarios` WHERE `empresaid`=%d", Business[businessid][ID]);
		new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();

		format(Str, 1000, "{ffffff}Funcionários\t{ff8000}%d\n", rows-1);
		strcat(String, Str);

		format(Str, 1000, "{ffffff}Vender Empresa\t{31b404}R$%s\n", RealStr( call::BUSINESS->GetBusinessParamsInt(businessid, Valor) * 80 / 100 ) );
		strcat(String, Str);

		strcat(String, "{ff8000}Entregar Mercadoria\n");

		strcat(String, "{ff8000}Contratar Funcionário(a)\n");

	

		cache_delete(result);

		ShowPlayerDialog(playerid, BUSINESS_MENU, DIALOG_STYLE_TABLIST, "{ffffff}Menu Empresa", String, "Selecionar", "Fechar");
		return true;
	}
	return false;
}

// ================================================== [ callbacks & hooks ] ================================================== //
#include <YSI_Coding\y_hooks>
forward OnLoadBusiness(playerid);
public OnLoadBusiness(playerid)
{
	if(cache_insert_id())
	{
		new query[60];
		mysql_format(getConexao(), query, sizeof(query), "SELECT * FROM "TABLE_BUSINESS" WHERE `id`='%d'", cache_insert_id());
		new Cache:cache = mysql_query(getConexao(), query, true), businessid = Iter_Count(Business) + 1;

		Iter_Add(Business, businessid);

		cache_get_value_name_int(0, "id", Business[businessid][ID]);
		
		cache_get_value_name(0, "nome", Business[businessid][Nome], MAX_BUSINESS_NAME);
		cache_get_value_name(0, "proprietario", Business[businessid][Proprietario], MAX_PLAYER_NAME);

		cache_get_value_name_float(0, "entrada_x", Business[businessid][Entrada][X]);
		cache_get_value_name_float(0, "entrada_y", Business[businessid][Entrada][Y]);
		cache_get_value_name_float(0, "entrada_z", Business[businessid][Entrada][Z]);
		cache_get_value_name_float(0, "entrada_a", Business[businessid][Entrada][A]);

		cache_get_value_name_float(0, "saida_x", Business[businessid][Saida][X]);
		cache_get_value_name_float(0, "saida_y", Business[businessid][Saida][Y]);
		cache_get_value_name_float(0, "saida_z", Business[businessid][Saida][Z]);
		cache_get_value_name_float(0, "saida_a", Business[businessid][Saida][A]);
		cache_get_value_name_int(0, "interior", Business[businessid][Interior]);

		cache_get_value_name(0, "actorname", Business[businessid][ActorName], MAX_PLAYER_NAME);
		cache_get_value_name_float(0, "actor_x", Business[businessid][ActorPos][X]);
		cache_get_value_name_float(0, "actor_y", Business[businessid][ActorPos][Y]);
		cache_get_value_name_float(0, "actor_z", Business[businessid][ActorPos][Z]);
		cache_get_value_name_float(0, "actor_a", Business[businessid][ActorPos][A]);
		cache_get_value_name_int(0, "useactor", Business[businessid][UseActor]);

		cache_get_value_name_int(0, "cofre", Business[businessid][Cofre]);
		cache_get_value_name_int(0, "producao", Business[businessid][Producao]);

		cache_get_value_name_int(0, "valor", Business[businessid][Valor]);
		cache_get_value_name_int(0, "valor_cash", Business[businessid][ValorCash]);

		cache_get_value_name(0, "mensagem", Business[businessid][Mensagem], MAX_STRLEN_MSG);
		cache_get_value_name_int(0, "max_funcionarios", Business[businessid][MaxFuncionarios]);
		cache_get_value_name_int(0, "level", Business[businessid][Level]);

		cache_get_value_name_int(0, "salario", Business[businessid][Salario]);
		cache_get_value_name_int(0, "valor_venda", Business[businessid][ValorVenda]);

		cache_get_value_name_int(0, "impostos", Business[businessid][Impostos]);

		new str[30];
		LoopFuncionarios(i, MAX_FUNCIONARIOS)
		{
			format(str, sizeof(str), "funcionario_%d", i);
			cache_get_value_name(0, str, Funcionario[businessid][i][Nome], MAX_PLAYER_NAME);

			format(str, sizeof(str), "entregas_funcionario_%d", i);
			cache_get_value_name_int(0, str, Funcionario[businessid][i][Entregas]);
		}

		cache_get_value_name_int(0, "mapicon", Business[businessid][MapIcon]);

		call::BUSINESS->render(businessid);
		cache_delete(cache);

		SendClientMessage(playerid, COR_SISTEMA, "Empresa: {"COR_BRANCO_INC"}A Empresa foi criada com {"COR_VERDE_INC"}exito{"COR_BRANCO_INC"}.");
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel criar a empresa.");
	return true;
}

hook OnGameModeInit()
{
	print("» Carregando empresas...\n");

	new Cache:cache = mysql_query(getConexao(), "SELECT * FROM "TABLE_BUSINESS";"), rows = cache_num_rows();
	if(rows)
	{
		for(new businessid; businessid < rows; businessid++)
		{
			if(businessid >= MAX_BUSINESS){
				rows = MAX_BUSINESS;
				print("Sistema de Empresas chegou ao seu limite de "#MAX_BUSINESS#" empresas carregadas.");
				break;
			}

			Iter_Add(Business, businessid);

			cache_get_value_name_int(businessid, "id", Business[businessid][ID]);
			
			cache_get_value_name(businessid, "nome", Business[businessid][Nome], MAX_BUSINESS_NAME);
			cache_get_value_name(businessid, "proprietario", Business[businessid][Proprietario], MAX_PLAYER_NAME);

			cache_get_value_name_float(businessid, "entrada_x", Business[businessid][Entrada][X]);
			cache_get_value_name_float(businessid, "entrada_y", Business[businessid][Entrada][Y]);
			cache_get_value_name_float(businessid, "entrada_z", Business[businessid][Entrada][Z]);
			cache_get_value_name_float(businessid, "entrada_a", Business[businessid][Entrada][A]);

			cache_get_value_name_float(businessid, "saida_x", Business[businessid][Saida][X]);
			cache_get_value_name_float(businessid, "saida_y", Business[businessid][Saida][Y]);
			cache_get_value_name_float(businessid, "saida_z", Business[businessid][Saida][Z]);
			cache_get_value_name_float(businessid, "saida_a", Business[businessid][Saida][A]);
			cache_get_value_name_int(businessid, "interior", Business[businessid][Interior]);

			cache_get_value_name_int(businessid, "cofre", Business[businessid][Cofre]);
			cache_get_value_name_int(businessid, "producao", Business[businessid][Producao]);

			cache_get_value_name_int(businessid, "valor", Business[businessid][Valor]);
			cache_get_value_name_int(businessid, "valor_cash", Business[businessid][ValorCash]);

			cache_get_value_name(businessid, "mensagem", Business[businessid][Mensagem], MAX_STRLEN_MSG);
			cache_get_value_name_int(businessid, "max_funcionarios", Business[businessid][MaxFuncionarios]);
			cache_get_value_name_int(businessid, "level", Business[businessid][Level]);

			cache_get_value_name_int(businessid, "salario", Business[businessid][Salario]);
			cache_get_value_name_int(businessid, "valor_venda", Business[businessid][ValorVenda]);
			cache_get_value_name_int(businessid, "impostos", Business[businessid][Impostos]);

			cache_get_value_name_int(businessid, "mapicon", Business[businessid][MapIcon]);

			call::BUSINESS->render(businessid);
		}
		printf("\t- Total de %d empresas carregadas.\n", Iter_Count(Business));
	}
	else
		print("\t- Nenhuma empresa carregada.\n");


	cache_delete(cache);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if ( IsPlayerInAnyVehicle(playerid) )return Y_HOOKS_CONTINUE_RETURN_1;

	if(PRESSED(KEY_SECONDARY_ATTACK))
	{
		foreach(new businessid: Business)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, Business[businessid][Entrada][X], Business[businessid][Entrada][Y], Business[businessid][Entrada][Z]))
			{
				Teleport(
					playerid,
					Business[businessid][Saida][X],
					Business[businessid][Saida][Y],
					Business[businessid][Saida][Z],
					Business[businessid][Saida][A],
					Business[businessid][Interior],
					businessid,
					ENTROU_EMPRESA
				);
				return Y_HOOKS_BREAK_RETURN_1;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 2.0, Business[businessid][Saida][X], Business[businessid][Saida][Y], Business[businessid][Saida][Z]) && GetPlayerVirtualWorld(playerid) == businessid)
			{
				call::PLAYER->SetPlayerVarInt(playerid, Entrou, ENTROU_NONE);
				Teleport(
					playerid,
					Business[businessid][Entrada][X],
					Business[businessid][Entrada][Y],
					Business[businessid][Entrada][Z],
					Business[businessid][Entrada][A],
					0,
					0,
					ENTROU_NONE
				);
				return Y_HOOKS_BREAK_RETURN_1;
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}



// ================================================== [ functions set & get ] ================================================== //

function BUSINESS::SetBusinessParams(businessid, e_BUSINESS_INFO:type, value[])
{
	if(!call::BUSINESS->IsValidBusiness(businessid))
		return false;
		
	format(Business[businessid][type], 200, value);
	return true;
}
function BUSINESS::GetBusinessParams(businessid, e_BUSINESS_INFO:type, value[], len = sizeof(value))
{
	if(!call::BUSINESS->IsValidBusiness(businessid))
		return false;

	format(value, len, Business[businessid][type]);
	return true;
}

function BUSINESS::SetBusinessParamsInt(businessid, e_BUSINESS_INFO:type, value)
{
	if(!call::BUSINESS->IsValidBusiness(businessid))
		return false;
		
	Business[businessid][type] = value;
	return true;
}
function BUSINESS::GetBusinessParamsInt(businessid, e_BUSINESS_INFO:type)
{
	if(!call::BUSINESS->IsValidBusiness(businessid))
		return false;

	return Business[businessid][type];
}