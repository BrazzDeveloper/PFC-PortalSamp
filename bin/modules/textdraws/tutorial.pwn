


static
	PlayerText:TDEditor_PTD[MAX_PLAYERS][3];

#include <YSI_Coding\y_hooks>

function TD::ShowPlayerTutorial(playerid)
{
	TDEditor_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 318.800140, 334.597381, "_"); // Titulo
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][0], 0.306400, 1.532799);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][0], 0.000000, 637.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][0], 8388863);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);

	TDEditor_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 318.399414, 357.765808, "_"); // Mensagem
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][1], 0.223408, 1.442031);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][1], 0.000000, 633.220214);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][1], 100);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 1);

	TDEditor_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 132.250030, 348.399414, "-");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][2], 24.972827, 0.084166);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][2], 1);
	
	for(new i; i < sizeof(TDEditor_PTD[]); i++){
		PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][i]);
	}

	return true;
}

function TD::DestroyPlayerTutorial(playerid)
{
	for(new i; i < sizeof(TDEditor_PTD[]); i++){
		PlayerTextDrawDestroy(playerid, TDEditor_PTD[playerid][i]);
	}
	return true;
}

function TD::UpdateTextDrawTutorial(playerid, title[], body[])
{
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][0], title);
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][1], body);
	return true;
}