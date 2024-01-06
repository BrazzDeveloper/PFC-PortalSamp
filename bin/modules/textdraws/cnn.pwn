
new static Text:TDEditor_TD[2], TimerID = -1;


#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	TDEditor_TD[0] = TextDrawCreate(5.000000, 191.166671, "_"); // Autor 
	TextDrawLetterSize(TDEditor_TD[0], 0.279998, 1.098332);
	TextDrawAlignment(TDEditor_TD[0], 1);
	TextDrawColor(TDEditor_TD[0], -1);
	TextDrawSetShadow(TDEditor_TD[0], 1);
	TextDrawSetOutline(TDEditor_TD[0], 0);
	TextDrawBackgroundColor(TDEditor_TD[0], 255);
	TextDrawFont(TDEditor_TD[0], 2);
	TextDrawSetProportional(TDEditor_TD[0], 1);
	TextDrawSetShadow(TDEditor_TD[0], 1);

	TDEditor_TD[1] = TextDrawCreate(320.625000, 206.183029, "_"); // mensagem
	TextDrawLetterSize(TDEditor_TD[1], 0.400000, 1.600000);
	TextDrawTextSize(TDEditor_TD[1], 10.000000, 640.000000);
	TextDrawAlignment(TDEditor_TD[1], 2);
	TextDrawColor(TDEditor_TD[1], -1);
	TextDrawUseBox(TDEditor_TD[1], 1);
	TextDrawBoxColor(TDEditor_TD[1], 50);
	TextDrawSetShadow(TDEditor_TD[1], 1);
	TextDrawSetOutline(TDEditor_TD[1], 0);
	TextDrawBackgroundColor(TDEditor_TD[1], 255);
	TextDrawFont(TDEditor_TD[1], 1);
	TextDrawSetProportional(TDEditor_TD[1], 1);
	TextDrawSetShadow(TDEditor_TD[1], 1);

	TimerID = -1;
}

stock function TD::ShowCnnMessage(playerid, mensagem[])
{
	new str[MAX_PLAYER_NAME + 124], cargo[50];

	switch( call::ADMIN->GetPlayerAdminLevel(playerid) )
	{
		case DEV: cargo = "~r~~h~~h~]]]] Desenvolvedor~w~";
		case DIRECAO: cargo = "~g~]]]] Diretor~w~";
		case ADMINISTRADOR: cargo = "~b~]]] Adm~w~";
		case MODERADOR: cargo = "~y~]] Mod~w~";
		case AJUDANTE: cargo = "~y~~h~~h~~h~~h~~h~] Ajud~w~";
	}
	
	format(str, sizeof(str), "%s %s", cargo, GetUserName(playerid));
	TextDrawSetString(TDEditor_TD[0], str);
	TextDrawShowForAll(TDEditor_TD[0]);

	TextDrawSetString(TDEditor_TD[1], mensagem);
	TextDrawShowForAll(TDEditor_TD[1]);

	if ( TimerID != -1 )
		KillTimer(TimerID);

	TimerID = SetTimer("TD_HideCnnMessage", 7500, false); 
	return true;
}

forward function TD::HideCnnMessage();
public function TD::HideCnnMessage()
{
	if ( TimerID != -1)
	{
		KillTimer(TimerID);
		TimerID = -1;

		TextDrawHideForAll(TDEditor_TD[0]);
		TextDrawHideForAll(TDEditor_TD[1]);
		
		TextDrawSetString(TDEditor_TD[0], "_");
		TextDrawSetString(TDEditor_TD[1], "_");
	}
	return true;
}

stock DrawsJogador(playerid)
{
	Jogador[playerid][DrawTela][0] = CreatePlayerTextDraw(playerid,320.000000, 163.000000, "~g~Exemplo~n~_");
    PlayerTextDrawAlignment(playerid,Jogador[playerid][DrawTela][0], 2);
    PlayerTextDrawBackgroundColor(playerid,Jogador[playerid][DrawTela][0], 255);
    PlayerTextDrawFont(playerid,Jogador[playerid][DrawTela][0], 3);
    PlayerTextDrawLetterSize(playerid,Jogador[playerid][DrawTela][0], 1.040000, 4.400001);
    PlayerTextDrawColor(playerid,Jogador[playerid][DrawTela][0], -1);
    PlayerTextDrawSetOutline(playerid,Jogador[playerid][DrawTela][0], 0);
    PlayerTextDrawSetProportional(playerid,Jogador[playerid][DrawTela][0], 1);
    PlayerTextDrawSetShadow(playerid,Jogador[playerid][DrawTela][0], 0);
    PlayerTextDrawUseBox(playerid,Jogador[playerid][DrawTela][0], 1);
    PlayerTextDrawBoxColor(playerid,Jogador[playerid][DrawTela][0], 48);
    PlayerTextDrawTextSize(playerid,Jogador[playerid][DrawTela][0], 45.000000, 637.000000);
    PlayerTextDrawSetSelectable(playerid,Jogador[playerid][DrawTela][0], 0);

    Jogador[playerid][DrawTela][1] = CreatePlayerTextDraw(playerid,316.000000, 206.000000, "~w~Mensagem para exemplo.");
    PlayerTextDrawAlignment(playerid,Jogador[playerid][DrawTela][1], 2);
    PlayerTextDrawBackgroundColor(playerid,Jogador[playerid][DrawTela][1], 255);
    PlayerTextDrawFont(playerid,Jogador[playerid][DrawTela][1], 1);
    PlayerTextDrawLetterSize(playerid,Jogador[playerid][DrawTela][1], 0.380000, 1.100000);
    PlayerTextDrawColor(playerid,Jogador[playerid][DrawTela][1], -1);
    PlayerTextDrawSetOutline(playerid,Jogador[playerid][DrawTela][1], 0);
    PlayerTextDrawSetProportional(playerid,Jogador[playerid][DrawTela][1], 1);
    PlayerTextDrawSetShadow(playerid,Jogador[playerid][DrawTela][1], 0);
    PlayerTextDrawSetSelectable(playerid,Jogador[playerid][DrawTela][1], 0);

    return 1;
}

MostrarDrawTela(playerid, tempoms, texto1[], texto2[]) {
    if(Jogador[playerid][FalhaTimer] != 0) KillTimer(Jogador[playerid][FalhaTimer]);
    PlayerTextDrawSetString(playerid, Jogador[playerid][DrawTela][0], texto1);
    PlayerTextDrawSetString(playerid, Jogador[playerid][DrawTela][1], texto2);
    for(new i; i < 2; i++)
        PlayerTextDrawShow(playerid,Jogador[playerid][DrawTela][i]);
    if(tempoms > 0)
        Jogador[playerid][FalhaTimer] = SetTimerEx("LimparDrawTela", tempoms, false, "d", playerid);
    return 1;
}

forward LimparDrawTela(playerid);
public LimparDrawTela(playerid) {
	if(!IsPlayerConnected(playerid)) return 1;
    KillTimer(Jogador[playerid][FalhaTimer]);
    Jogador[playerid][FalhaTimer]=0;
    for(new i; i < 2; i++)
    {
        PlayerTextDrawSetString(playerid, Jogador[playerid][DrawTela][i], "_");
        PlayerTextDrawHide(playerid, Jogador[playerid][DrawTela][i]);
    }
    return 1;
}