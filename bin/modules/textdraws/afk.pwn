#include <YSI_Coding\y_hooks>

new CodigoDialog[MAX_PLAYERS][128], Tentativas[MAX_PLAYERS];

#define strcatExxx(%0,%1,%2) \
    format(Acaraje, sizeof(Acaraje), %1, %2) , strcat(%0, Acaraje)

Dialog:DIALOG_CODIGO(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;
    if(isnull(inputtext))
    {
        return 1;
    }
    if(!CaracterEspecial(inputtext))
    {
        SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar caracteres especiais!");
        return 1;
    }
    format(CodigoDialog[playerid], 128, inputtext);
    PlayerTextDrawSetString(playerid, AntiAFKCLICKCODIGO[playerid][8], CodigoDialog[playerid]);
    return 1;
}

hook OP_ClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == AntiAFKCLICKCODIGO[playerid][8])
    {
        Dialog_Show(playerid, DIALOG_CODIGO, DIALOG_STYLE_INPUT, "{FF0000}AntiAFK", "{FFFFFF}Confirme o código abaixo o código gerado pelo servidor!", "Confirmar", "Cancelar");
    }
    if(playertextid == AntiAFKCLICKCODIGO[playerid][9])
    {
        if(isnull(CodigoDialog[playerid]))
        {
            Tentativas[playerid]++;
            SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não adicionou nenhum código!");
            if(Tentativas[playerid] >= 3){
                Kick(playerid);
                Jogador[playerid][AFK] = false;
                Jogador[playerid][AFK_Avisos] = 0;
            }
            return 1;
        }
        if(!strcmp(CodigoDialog[playerid], CodigoReal[playerid], true))
        {
            SendClientMessage(playerid, -1, "| ANTI-AFK | Você foi liberado para upar novamente!");
            Tentativas[playerid] = 0;
            OcultarAntiAFK(playerid);
            Jogador[playerid][AFK] = false;
            Jogador[playerid][AFK_Avisos] = 0;

        }
        else
        {
            Tentativas[playerid]++;
            SendClientMessage(playerid, COR_ERRO, "| ERRO | Código inválido!");
            if(Tentativas[playerid] >= 3){
                Kick(playerid);
                Jogador[playerid][AFK] = false;
                Jogador[playerid][AFK_Avisos] = 0;
            }
        }
    }
    return 1;
}


forward PadraoRandom(playerid, StringRandom[]);
public PadraoRandom(playerid, StringRandom[])
{
    new Acaraje[1000];
    new Formatacao[700];
    new rr = random(1);
    switch(rr)
    {
        // CoresRandom[random(sizeof(CoresRandom))][RealCode]
        // GetRandomString(random(8-5)+5)
        // CoresAFK[random(sizeof(CoresAFK))][RealCode]
        // String

        case 0:
        {
            strcatExxx(Formatacao, "~%s~~w~%s~%s~~n~", CoresRandom[random(sizeof(CoresRandom))][RealCode], GetRandomString(random(8-5)+5), CoresRandom[random(sizeof(CoresRandom))][RealCode]);
            strcatExxx(Formatacao, "~w~%s~n~~%s~~%s~~%s~", GetRandomString(random(8-5)+5), CoresRandom[random(sizeof(CoresRandom))][RealCode], CoresRandom[random(sizeof(CoresRandom))][RealCode], CoresRandom[random(sizeof(CoresRandom))][RealCode]);
            strcatExxx(Formatacao, "~w~%s~n~%s~w~~%s~~n~", GetRandomString(random(8-5)+5), GetRandomString(random(8-5)+5), CoresRandom[random(sizeof(CoresRandom))][RealCode]);
            strcatExxx(Formatacao, "~w~~%s~%s~w~~n~~%s~", CoresAFK[random(sizeof(CoresAFK))][RealCode], StringRandom, CoresRandom[random(sizeof(CoresRandom))][RealCode]);
            strcatExxx(Formatacao, "~w~%s~n~%s", GetRandomString(random(8-5)+5), GetRandomString(random(8-5)+5));
        }
        case 1:
        {
            strcatExxx(Formatacao, "~%s~~w~%s~n~~%s~", CoresRandom[random(sizeof(CoresRandom))][RealCode], GetRandomString(random(8-5)+5), CoresRandom[random(sizeof(CoresRandom))][RealCode]);
            strcatExxx(Formatacao, "~%s~~w~~n~%s~%s~~n~", CoresRandom[random(sizeof(CoresRandom))][RealCode], GetRandomString(random(8-5)+5), CoresRandom[random(sizeof(CoresRandom))][RealCode]);
            strcatExxx(Formatacao, "~%s~%s~%s~~w~", CoresAFK[random(sizeof(CoresAFK))][RealCode], StringRandom, CoresRandom[random(sizeof(CoresRandom))][RealCode], GetRandomString(random(8-5)+5));
            strcatExxx(Formatacao, "~%s~~w~~n~%s", CoresRandom[random(sizeof(CoresRandom))][RealCode], GetRandomString(random(8-5)+5));
            strcatExxx(Formatacao, "~w~%s~n~%s", GetRandomString(random(8-5)+5), GetRandomString(random(8-5)+5));
        }

    }
    PlayerTextDrawSetString(playerid, AntiAFKCLICKCODIGO[playerid][11], Formatacao);
    return 1;
}

// Criar e Exibir a Textdraw
stock MostrarAntiAFK(playerid)
{
    AntiAFKCLICKCODIGO[playerid][0] = CreatePlayerTextDraw(playerid, 176.875000, 134.000000, "box");
    PlayerTextDrawLetterSize(playerid, AntiAFKCLICKCODIGO[playerid][0], 0.000000, 19.875000);
    PlayerTextDrawTextSize(playerid, AntiAFKCLICKCODIGO[playerid][0], 461.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, AntiAFKCLICKCODIGO[playerid][0], 1);
    PlayerTextDrawColor(playerid, AntiAFKCLICKCODIGO[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, AntiAFKCLICKCODIGO[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, AntiAFKCLICKCODIGO[playerid][0], -1061109505);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, AntiAFKCLICKCODIGO[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, AntiAFKCLICKCODIGO[playerid][0], 255);
    PlayerTextDrawFont(playerid, AntiAFKCLICKCODIGO[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, AntiAFKCLICKCODIGO[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][0], 0);

    AntiAFKCLICKCODIGO[playerid][1] = CreatePlayerTextDraw(playerid, 362.725036, 135.800155, "box");
    PlayerTextDrawLetterSize(playerid, AntiAFKCLICKCODIGO[playerid][1], 0.000000, 19.494014);
    PlayerTextDrawTextSize(playerid, AntiAFKCLICKCODIGO[playerid][1], 460.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, AntiAFKCLICKCODIGO[playerid][1], 1);
    PlayerTextDrawColor(playerid, AntiAFKCLICKCODIGO[playerid][1], -1);
    PlayerTextDrawUseBox(playerid, AntiAFKCLICKCODIGO[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, AntiAFKCLICKCODIGO[playerid][1], 471604479);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, AntiAFKCLICKCODIGO[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, AntiAFKCLICKCODIGO[playerid][1], 255);
    PlayerTextDrawFont(playerid, AntiAFKCLICKCODIGO[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid, AntiAFKCLICKCODIGO[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][1], 0);

    AntiAFKCLICKCODIGO[playerid][2] = CreatePlayerTextDraw(playerid, 178.125000, 131.083389, "P");
    PlayerTextDrawLetterSize(playerid, AntiAFKCLICKCODIGO[playerid][2], 0.611873, 2.200830);
    PlayerTextDrawAlignment(playerid, AntiAFKCLICKCODIGO[playerid][2], 1);
    PlayerTextDrawColor(playerid, AntiAFKCLICKCODIGO[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, AntiAFKCLICKCODIGO[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, AntiAFKCLICKCODIGO[playerid][2], 255);
    PlayerTextDrawFont(playerid, AntiAFKCLICKCODIGO[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, AntiAFKCLICKCODIGO[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][2], 0);

    AntiAFKCLICKCODIGO[playerid][3] = CreatePlayerTextDraw(playerid, 187.750000, 131.083389, "FC");
    PlayerTextDrawLetterSize(playerid, AntiAFKCLICKCODIGO[playerid][3], 0.611873, 2.200830);
    PlayerTextDrawAlignment(playerid, AntiAFKCLICKCODIGO[playerid][3], 1);
    PlayerTextDrawColor(playerid, AntiAFKCLICKCODIGO[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, AntiAFKCLICKCODIGO[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, AntiAFKCLICKCODIGO[playerid][3], 255);
    PlayerTextDrawFont(playerid, AntiAFKCLICKCODIGO[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, AntiAFKCLICKCODIGO[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][3], 0);

    AntiAFKCLICKCODIGO[playerid][4] = CreatePlayerTextDraw(playerid, 268.449981, 184.449905, "Para_desbloquear_o_anti-afk~n~Coloque_o_codigo_que_esta_com_cor_diferente");
    PlayerTextDrawLetterSize(playerid, AntiAFKCLICKCODIGO[playerid][4], 0.220623, 1.121665);
    PlayerTextDrawAlignment(playerid, AntiAFKCLICKCODIGO[playerid][4], 2);
    PlayerTextDrawColor(playerid, AntiAFKCLICKCODIGO[playerid][4], 471604479);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, AntiAFKCLICKCODIGO[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, AntiAFKCLICKCODIGO[playerid][4], 255);
    PlayerTextDrawFont(playerid, AntiAFKCLICKCODIGO[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, AntiAFKCLICKCODIGO[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][4], 0);

    AntiAFKCLICKCODIGO[playerid][5] = CreatePlayerTextDraw(playerid, 233.599761, 167.433273, "Informacao:");
    PlayerTextDrawLetterSize(playerid, AntiAFKCLICKCODIGO[playerid][5], 0.381249, 1.424998);
    PlayerTextDrawAlignment(playerid, AntiAFKCLICKCODIGO[playerid][5], 1);
    PlayerTextDrawColor(playerid, AntiAFKCLICKCODIGO[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][5], 1);
    PlayerTextDrawSetOutline(playerid, AntiAFKCLICKCODIGO[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, AntiAFKCLICKCODIGO[playerid][5], 255);
    PlayerTextDrawFont(playerid, AntiAFKCLICKCODIGO[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, AntiAFKCLICKCODIGO[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][5], 1);

    AntiAFKCLICKCODIGO[playerid][6] = CreatePlayerTextDraw(playerid, 186.875000, 253.316802, "box");
    PlayerTextDrawLetterSize(playerid, AntiAFKCLICKCODIGO[playerid][6], 0.000000, 0.750000);
    PlayerTextDrawTextSize(playerid, AntiAFKCLICKCODIGO[playerid][6], 348.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, AntiAFKCLICKCODIGO[playerid][6], 1);
    PlayerTextDrawColor(playerid, AntiAFKCLICKCODIGO[playerid][6], -1);
    PlayerTextDrawUseBox(playerid, AntiAFKCLICKCODIGO[playerid][6], 1);
    PlayerTextDrawBoxColor(playerid, AntiAFKCLICKCODIGO[playerid][6], 105);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, AntiAFKCLICKCODIGO[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, AntiAFKCLICKCODIGO[playerid][6], 255);
    PlayerTextDrawFont(playerid, AntiAFKCLICKCODIGO[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, AntiAFKCLICKCODIGO[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][6], 0);

    AntiAFKCLICKCODIGO[playerid][7] = CreatePlayerTextDraw(playerid, 245.625000, 225.000045, "Codigo:");
    PlayerTextDrawLetterSize(playerid, AntiAFKCLICKCODIGO[playerid][7], 0.400000, 1.600000);
    PlayerTextDrawAlignment(playerid, AntiAFKCLICKCODIGO[playerid][7], 1);
    PlayerTextDrawColor(playerid, AntiAFKCLICKCODIGO[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][7], 1);
    PlayerTextDrawSetOutline(playerid, AntiAFKCLICKCODIGO[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, AntiAFKCLICKCODIGO[playerid][7], 255);
    PlayerTextDrawFont(playerid, AntiAFKCLICKCODIGO[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, AntiAFKCLICKCODIGO[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][7], 1);

    AntiAFKCLICKCODIGO[playerid][8] = CreatePlayerTextDraw(playerid, 199.400421, 251.266662, "Coloque_o_codigo_aqui");
    PlayerTextDrawLetterSize(playerid, AntiAFKCLICKCODIGO[playerid][8], 0.321249, 1.010830);
    PlayerTextDrawTextSize(playerid, AntiAFKCLICKCODIGO[playerid][8], 317.000000, 12.0000);
    PlayerTextDrawAlignment(playerid, AntiAFKCLICKCODIGO[playerid][8], 1);
    PlayerTextDrawColor(playerid, AntiAFKCLICKCODIGO[playerid][8], -1);
    PlayerTextDrawUseBox(playerid, AntiAFKCLICKCODIGO[playerid][8], 1);
    PlayerTextDrawBoxColor(playerid, AntiAFKCLICKCODIGO[playerid][8], 0);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, AntiAFKCLICKCODIGO[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, AntiAFKCLICKCODIGO[playerid][8], 255);
    PlayerTextDrawFont(playerid, AntiAFKCLICKCODIGO[playerid][8], 1);
    PlayerTextDrawSetProportional(playerid, AntiAFKCLICKCODIGO[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][8], 0);
    PlayerTextDrawSetSelectable(playerid, AntiAFKCLICKCODIGO[playerid][8], true);

    AntiAFKCLICKCODIGO[playerid][9] = CreatePlayerTextDraw(playerid, 253.825042, 270.016693, "");
    PlayerTextDrawLetterSize(playerid, AntiAFKCLICKCODIGO[playerid][9], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, AntiAFKCLICKCODIGO[playerid][9], 33.000000, 36.000000);
    PlayerTextDrawAlignment(playerid, AntiAFKCLICKCODIGO[playerid][9], 1);
    PlayerTextDrawColor(playerid, AntiAFKCLICKCODIGO[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, AntiAFKCLICKCODIGO[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, AntiAFKCLICKCODIGO[playerid][9], 0);
    PlayerTextDrawFont(playerid, AntiAFKCLICKCODIGO[playerid][9], 5);
    PlayerTextDrawSetProportional(playerid, AntiAFKCLICKCODIGO[playerid][9], 0);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][9], 0);
    PlayerTextDrawSetSelectable(playerid, AntiAFKCLICKCODIGO[playerid][9], true);
    PlayerTextDrawSetPreviewModel(playerid, AntiAFKCLICKCODIGO[playerid][9], 19134);
    PlayerTextDrawSetPreviewRot(playerid, AntiAFKCLICKCODIGO[playerid][9], 0.000000, -90.000000, -90.000000, 1.000000);

    AntiAFKCLICKCODIGO[playerid][10] = CreatePlayerTextDraw(playerid, 178.750000, 247.750030, "");
    PlayerTextDrawLetterSize(playerid, AntiAFKCLICKCODIGO[playerid][10], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, AntiAFKCLICKCODIGO[playerid][10], 21.000000, 18.000000);
    PlayerTextDrawAlignment(playerid, AntiAFKCLICKCODIGO[playerid][10], 1);
    PlayerTextDrawColor(playerid, AntiAFKCLICKCODIGO[playerid][10], -1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, AntiAFKCLICKCODIGO[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, AntiAFKCLICKCODIGO[playerid][10], 0);
    PlayerTextDrawFont(playerid, AntiAFKCLICKCODIGO[playerid][10], 5);
    PlayerTextDrawSetProportional(playerid, AntiAFKCLICKCODIGO[playerid][10], 0);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][10], 0);
    PlayerTextDrawSetPreviewModel(playerid, AntiAFKCLICKCODIGO[playerid][10], 19305);
    PlayerTextDrawSetPreviewRot(playerid, AntiAFKCLICKCODIGO[playerid][10], 0.000000, 0.000000, 190.000000, 1.000000);

    AntiAFKCLICKCODIGO[playerid][11] = CreatePlayerTextDraw(playerid, 411.474975, 140.416671, "ASLKDDASJK~r~~n~JDASDJLKASSKJL~w~");
    PlayerTextDrawLetterSize(playerid, AntiAFKCLICKCODIGO[playerid][11], 0.288749, 1.226665);
    PlayerTextDrawAlignment(playerid, AntiAFKCLICKCODIGO[playerid][11], 2);
    PlayerTextDrawColor(playerid, AntiAFKCLICKCODIGO[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, AntiAFKCLICKCODIGO[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, AntiAFKCLICKCODIGO[playerid][11], 255);
    PlayerTextDrawFont(playerid, AntiAFKCLICKCODIGO[playerid][11], 1);
    PlayerTextDrawSetProportional(playerid, AntiAFKCLICKCODIGO[playerid][11], 1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][11], 0);

    AntiAFKCLICKCODIGO[playerid][12] = CreatePlayerTextDraw(playerid, 177.500000, 301.999969, "02:59");
    PlayerTextDrawLetterSize(playerid, AntiAFKCLICKCODIGO[playerid][12], 0.274374, 1.320000);
    PlayerTextDrawAlignment(playerid, AntiAFKCLICKCODIGO[playerid][12], 1);
    PlayerTextDrawColor(playerid, AntiAFKCLICKCODIGO[playerid][12], -1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, AntiAFKCLICKCODIGO[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, AntiAFKCLICKCODIGO[playerid][12], 255);
    PlayerTextDrawFont(playerid, AntiAFKCLICKCODIGO[playerid][12], 1);
    PlayerTextDrawSetProportional(playerid, AntiAFKCLICKCODIGO[playerid][12], 1);
    PlayerTextDrawSetShadow(playerid, AntiAFKCLICKCODIGO[playerid][12], 0);

    for(new i=0; i < 13; i++)
    {
        PlayerTextDrawShow(playerid, AntiAFKCLICKCODIGO[playerid][i]);
    }
    SelectTextDraw(playerid, 0x00FA9AFF);
    SetPVarInt(playerid, "SelecionarESC", 1);
    return 1;
}

stock OcultarAntiAFK(playerid)
{
    for(new i=0; i < 13; i++)
    {
        PlayerTextDrawHide(playerid, AntiAFKCLICKCODIGO[playerid][i]);
    }
    SetPVarInt(playerid, "SelecionarESC", 0);
    CancelSelectTextDraw(playerid);
    return 1;
}