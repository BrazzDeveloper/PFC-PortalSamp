// NEW SYSTEM: BASES

/* ----         Started at 20/05/2021 - 10:02                                                     */
/* ----         Author: Luiz "LuizM" Henrique                                                     */
/* ----         Credits:                                                                          */
/* ----         Finished at xx/xx/xxxx - xx:xx                                                    */
/* ----         First patch: xx/xx/xxxx - xx:xx - xxx lines                                       */

static Base[MAX_BASES][e_BASE_INFO];

#include ../bin/modules/basesystem/cmds.pwn
#include ../bin/modules/basesystem/dialogs.pwn
#include ../bin/modules/basesystem/gerenciar.pwn

#include <YSI_Coding\y_hooks>

stock static render_string(baseid)
{
    new String[750];

    if(call::BASES->CheckBaseBought(baseid))
    {
        format(String, 500, "{ff0000}Base ID %d\n{31b404}Base a Venda\n{ffffff}/ComprarBase\n{ffffff}%s\n{ff8000}Líder: {ffffff}%s\n{ff8000}Preço: {ffffff}R$%s\n{ff8000}Nível: {ffffff}%d/5", \
        Base[baseid][ID], Base[baseid][Nome], Base[baseid][Lider], RealStr(Base[baseid][Valor]), Base[baseid][Nivel]);
    }
    else 
    {
        format(String, 500, "{ff0000}Base ID %d\n{ffffff}%s\n{ff8000}Líder: {ffffff}%s\n{ff8000}Nível: {ffffff}%d/5", \
        Base[baseid][ID], Base[baseid][Nome], Base[baseid][Lider], Base[baseid][Nivel]);
    }

    return String;
}

function BASES::ReloadBases()
{
    for(new i; i < MAX_BASES; i++)
    {
        DestroyDynamic3DTextLabel(Base[i][LabelID]);
        DestroyDynamicPickup(Base[i][PickupID]);

        call::BASES->ResetVariables(i);
    }

    new Cache:result = mysql_query(getConexao(), "SELECT * FROM `bases`", true), rows = cache_num_rows();

    if(rows > 0)
    {
        for(new i; i < rows; i++)
        {
            Iter_Add(Base, i);

            cache_get_value_int(i, "id", Base[i][ID]);
            cache_get_value_name(i, "lider", Base[i][Lider]);
            cache_get_value_int(i, "up", Base[i][Nivel]);
            cache_get_value_int(i, "valor", Base[i][Valor]);
            cache_get_value_float(i, "entrada_x", Base[i][Entrada][X]);
            cache_get_value_float(i, "entrada_y", Base[i][Entrada][Y]);
            cache_get_value_float(i, "entrada_z", Base[i][Entrada][Z]);
            cache_get_value_name(i, "nome", Base[i][Nome]);
            cache_get_value_name(i, "tag", Base[i][TAG]);
            cache_get_value_int(i, "vencimento", Base[i][Vencimento]);
            cache_get_value_int(i, "cofre", Base[i][Cofre]);

            call::BASES->Render(i);

            printf("TAG: %s", Base[i][TAG]);
        }
    }

    cache_delete(result);
    return 1;
}

function BASES::Render(baseid)
{

    Base[baseid][PickupID] = CreateDynamicPickup(1314, 1, Base[baseid][Entrada][X], Base[baseid][Entrada][Y], Base[baseid][Entrada][Z]);
    Base[baseid][LabelID] = CreateDynamic3DTextLabel(render_string(baseid), -1, Base[baseid][Entrada][X], Base[baseid][Entrada][Y], Base[baseid][Entrada][Z]+0.5, 10.0);

    printf("Base ID %d (Iterator) %d (SQL) carregada com sucesso.", baseid, Base[baseid][ID]);
    return 1;
}

function BASES::ResetVariables(baseid)
{
    Base[baseid][ID] = 0;
    Base[baseid][Valor] = 0;
    Base[baseid][Entrada][X] = 0;
    Base[baseid][Entrada][Y] = 0;
    Base[baseid][Entrada][Z] = 0;
    format(Base[baseid][Nome], 10, "N/A");
    format(Base[baseid][TAG], 10, "N/A");
    Base[baseid][Nivel] = 0;
    Base[baseid][PickupID] = -1;
    return 1;
}

function BASES::CheckBaseBought(baseid)
{
    if(!strcmp(Base[baseid][Lider], "Ninguem", false, MAX_PLAYER_NAME))
    {
        return 1;
    }
    return 0;
}

function BASE::GetBaseInRangeOfP(playerid, Float:range)
{
    new Float:Posicao[4];
    GetPlayerPos(playerid, Posicao[0], Posicao[1], Posicao[2]);

    foreach(new baseid: Base)
    {
        if(IsPlayerInRangeOfPoint(playerid, range, Base[baseid][Entrada][X], Base[baseid][Entrada][Y], Base[baseid][Entrada][Z]))
        {
            return baseid;
        }
    }

    return INVALID_BASE_ID;
}

function BASE::CheckBaseMember(playerid, baseid)
{
    if(call::PLAYER->GetPlayerVarInt(playerid, BaseID) == baseid)
    {
        return 1;
    }
    return 0;
}

function BASE::CheckBaseLeader(playerid, baseid)
{
    new leader[MAX_PLAYER_NAME];
    call::BASE->GetBaseParams(baseid, Lider, leader, MAX_PLAYER_NAME);

    if(!strcmp(leader, GetUserName(playerid), false))
    {
        return 1;
    }
    return 0;
}

function BASE::ShowPlayerBaseMenu(playerid, baseid)
{
    new String[1000], Str[1000];

    new nome[50], titulo[100], ExpiraBase[128], lider[MAX_PLAYER_NAME], tag[20];

    rHoraMinuto(call::BASE->GetBaseParamsInt(baseid, Vencimento), ExpiraBase, 128);

    if( (call::BASE->GetBaseParamsInt(baseid, Vencimento) - gettime() ) <= 0) { format(ExpiraBase, 128, "Expirada"); }

    call::BASE->GetBaseParams(baseid, Nome, nome, 50);
    call::BASE->GetBaseParams(baseid, Lider, lider, MAX_PLAYER_NAME);
    call::BASE->GetBaseParams(baseid, TAG, tag, 20);

    new query[350];
    format(query, 350, "SELECT * FROM `usuarios` WHERE `baseid`='%d'", call::BASE->GetBaseParamsInt(baseid, ID));
    new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();

    if(rows)
    {
        format(titulo, 100, "{ffffff}Base - %s", nome);

        format(Str, 1000, "{ff8000}Nome do Clã\t{ffffff}%s\n", nome);
        strcat(String, Str);

        format(Str, 1000, "{ff8000}Vencimento\t{ffff00}%s\n", ExpiraBase);
        strcat(String, Str);

        format(Str, 1000, "{ff8000}Líder:\t{ffffff}%s\n", lider);
        strcat(String, Str);

        format(Str, 1000, "{ff8000}TAG:\t{ffffff}[%s{ffffff}]\n", tag);
        strcat(String, Str);

        format(Str, 1000, "{ff8000}Nível\t{ffffff}%d/5\n", call::BASE->GetBaseParamsInt(baseid, Nivel));
        strcat(String, Str);

        format(Str, 1000, "{ff8000}Cofre\t{31b404}R$%s\n", RealStr(call::BASE->GetBaseParamsInt(baseid, Cofre)));
        strcat(String, Str);

        format(Str, 1000, "{ff8000}Membros\t{ffffff}%d\n", rows);
        strcat(String, Str);

        strcat(String, "{ff8000}Veículos\n");

        strcat(String, "{ff0000}Adicionar um(a) membro\n");

        ShowPlayerDialog(playerid, DIALOG_MENU_BASE, DIALOG_STYLE_TABLIST, titulo, String, "Selecionar", "Fechar");
    }
    else 
    {
        SendClientMessage(playerid, COR_ERRO, "| ERRO | Houve um erro ao processar a informação. Contate um Administrador.");
    }
    cache_delete(result);

    return 1;
}

function BASE::BuyBase(playerid, baseid)
{
    format(Base[baseid][Lider], MAX_PLAYER_NAME, GetUserName(playerid));
    format(Base[baseid][Nome], 50, "N/A");
    format(Base[baseid][TAG], 20, "N/A");
    Base[baseid][Nivel] = 1;
    Base[baseid][Vencimento] = gettime() + ( 86400 * 30 );
    Base[baseid][Cofre] = 0;

    call::BASE->UpdateBaseTexts(baseid);
    return 1;
}

function BASE::UpdateBaseTexts(baseid)
{
    if(!call::BASE->IsValidBase(baseid))
        return false;
    
    UpdateDynamic3DTextLabelText(Base[baseid][LabelID], -1, render_string(baseid));

    DestroyDynamicPickup(Base[baseid][PickupID]);
    Base[baseid][PickupID] = CreateDynamicPickup(1314, 1, Base[baseid][Entrada][X], Base[baseid][Entrada][Y], Base[baseid][Entrada][Z]);

    return 1;
}

function BASE::GetBaseLocalName(baseid)
{
	new endereco[MAX_ZONE_NAME];

	if(!call::BASE->IsValidBase(baseid))
		return endereco;

	GetLocalName(Base[baseid][Entrada][X], Base[baseid][Entrada][Y], endereco, sizeof(endereco));
	return endereco;
}

function BASE::IsValidBase(baseid){
	if(baseid > MAX_BASES || baseid < 0)
		return false;

	return Iter_Contains(Base, baseid);
}

// FUNÇÕES SET && GET

function BASE::SetBaseParams(baseid, e_BASE_INFO:type, value[])
{
    if(!call::BASE->IsValidBase(baseid))
        return false;
    
    format(Base[baseid][type], 200, value);
    return 1;
}

function BASE::GetBaseParams(baseid, e_BASE_INFO:type, value[], len = sizeof(value))
{
    if(!call::BASE->IsValidBase(baseid))
        return false;
    
    format(value, len, Base[baseid][type]);
    return 1;
}

function BASE::SetBaseParamsInt(baseid, e_BASE_INFO:type, value)
{
    if(!call::BASE->IsValidBase(baseid))
        return false;
    
    Base[baseid][type] = value;
    return 1;
}

function BASE::GetBaseParamsInt(baseid, e_BASE_INFO:type)
{
    if(!call::BASE->IsValidBase(baseid))
        return false;
    
    return Base[baseid][type];
}


GetBaseIdByRow(row)
{
    if(row == 0) 
        return INVALID_BASE_ID;

    foreach(new baseid: Base)
    {
        if(Base[baseid][ID] == row)
        {
            return baseid;
        }
    }
    return INVALID_BASE_ID;
}

hook OnGameModeInit()
{
    call::BASES->ReloadBases();
    return 1;
}
