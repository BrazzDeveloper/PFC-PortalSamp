#include <a_samp>


#define FILTERSCRIPT

#include <Pawn.CMD>
#include <sscanf>
/*
	frango = 19847
	burguer = 2703
	pizza = 2881
	Café = 19835
	refri burger = 2647
	Milk = 19570
*/
new object;
cmd:criarobjeto(playerid, params[])
{
	new objectid, boneid;
	if(sscanf(params, "dd", objectid, boneid))
		return SendClientMessage(playerid, 0xFF0000FF, "Uso correto /criarobjeto [objectid] [boneid]");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	AttachObjectToVehicle(object = CreateObject(objectid, x, y, z, 0.0, 0.0, 0.0), GetPlayerVehicleID(playerid), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	return true;
}
cmd:editarobjeto(playerid)
{

	//EditAttachedObject(playerid, 1);
	EditObject(playerid, object);
	return true;
}

cmd:destruirobjeto(playerid)
{
	RemovePlayerAttachedObject(playerid, 1);
	return true;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ )
{
	printf("AttachObjectToVehicle(%d, vehicleid, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f);", modelid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ);
	return true;
}