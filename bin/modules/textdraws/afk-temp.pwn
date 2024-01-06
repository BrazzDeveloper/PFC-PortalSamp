#include <YSI_Coding\y_hooks>


// Textdraws

LoadPlayerText@AFK(playerid)
{
	TD@AFK[playerid][0] = CreatePlayerTextDraw(playerid, 195.882354, 127.583335, "VOCE_FICOU_AUSENTE");
	PlayerTextDrawLetterSize(playerid, TD@AFK[playerid][0], 0.579764, 2.965000);
	PlayerTextDrawAlignment(playerid, TD@AFK[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD@AFK[playerid][0], -16776961);
	PlayerTextDrawSetShadow(playerid, TD@AFK[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TD@AFK[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, TD@AFK[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD@AFK[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, TD@AFK[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TD@AFK[playerid][0], 0);

	TD@AFK[playerid][1] = CreatePlayerTextDraw(playerid, 332.823364, 213.916732, "Digite_/SairAFK_polk");
	PlayerTextDrawLetterSize(playerid, TD@AFK[playerid][1], 0.507764, 2.206666);
	PlayerTextDrawAlignment(playerid, TD@AFK[playerid][1], 2);
	PlayerTextDrawColor(playerid, TD@AFK[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, TD@AFK[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TD@AFK[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, TD@AFK[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD@AFK[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, TD@AFK[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TD@AFK[playerid][1], 0);
}

// Comandos