// SISTEMA DE EVENTO TEXTO


#include <YSI_Coding\y_hooks>

enum ETexto
{
    bool:Ativado,
    Float:posX,
    Float:posY,
    Float:posZ,
    Text3D:tlabelid
}
new EventText[ETexto];


flags:et(ADMINISTRADOR);
CMD:et(playerid, params[])
{
    if(EventText[Ativado] == true)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Já há um Evento Texto ativado no momento.");
    
    new Float:Posicao[4];
    GetPlayerPos(playerid, Posicao[0], Posicao[1], Posicao[2]);

    EventText[posX] = Posicao[0];
    EventText[posY] = Posicao[1];
    EventText[posZ] = Posicao[2];

    SendClientMessageToAll(COR_AMARELO, "| EVENTO | O(A) %s %s ativou o evento Encontre o Texto.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));

    EventText[tlabelid] = CreateDynamic3DTextLabel("{ffff00}Evento Texto\n{ffffff}Digite: {ffff00}/Encontrei", -1, EventText[posX], EventText[posY], EventText[posZ], 10.0);

    EventText[Ativado] = true;
    return 1;
}

CMD:encontrei(playerid, params[])
{
    if(EventText[Ativado] == false)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não há um Evento Texto acontecendo no momento.");
    
    new Float:Posicao[4];
    GetPlayerPos(playerid, Posicao[0], Posicao[1], Posicao[2]);

    if(IsPlayerInRangeOfPoint(playerid, 3.0, EventText[posX], EventText[posY], EventText[posZ]))
    {
        SendClientMessageToAll(COR_AMARELO, "| EVENTO | O(A) jogador(a) %s[%d] achou o texto do Evento Texto.", GetUserName(playerid), playerid);

        DestroyDynamic3DTextLabel(EventText[tlabelid]);
        EventText[posX] = 0.0;
        EventText[posY] = 0.0;
        EventText[posZ] = 0.0;
        EventText[Ativado] = false;
    }

    else 
    {
        SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está perto do texto.");
    }

    return 1;
}