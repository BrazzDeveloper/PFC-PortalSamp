
new const INTERIOR_ID = 3;


new 
	GATE_DP, bool:GATE_DP_OPENED, BikesNovatos[7], CarrosPublicos[30], ManObject[6], AuxiliarDePintura
;

/*
*
*			Include Files
*
*/

#include ..\bin\modules\mapas\removeobject.pwn

#include ..\bin\modules\mapas\agencia.pwn
#include ..\bin\modules\mapas\antiga-fabrica.pwn
#include ..\bin\modules\mapas\area51.pwn
#include ..\bin\modules\mapas\auto-escola.pwn
#include ..\bin\modules\mapas\banco.pwn
#include ..\bin\modules\mapas\barco-bs.pwn
#include ..\bin\modules\mapas\bases.pwn
#include ..\bin\modules\mapas\casas-adm.pwn
#include ..\bin\modules\mapas\delegacia.pwn
#include ..\bin\modules\mapas\evento-bs.pwn
#include ..\bin\modules\mapas\fazenda.pwn
#include ..\bin\modules\mapas\fruteira.pwn
#include ..\bin\modules\mapas\hospital.pwn
#include ..\bin\modules\mapas\hotel-ls.pwn
#include ..\bin\modules\mapas\hq-advogado.pwn
#include ..\bin\modules\mapas\hq-ifood.pwn
#include ..\bin\modules\mapas\hq-mecanico.pwn
#include ..\bin\modules\mapas\ilha-barco-assaltos.pwn
#include ..\bin\modules\mapas\limpador-rua.pwn
#include ..\bin\modules\mapas\mapa-marques.pwn
#include ..\bin\modules\mapas\mapa-testes.pwn
#include ..\bin\modules\mapas\mineradora.pwn
#include ..\bin\modules\mapas\motorista-onibus.pwn
#include ..\bin\modules\mapas\mount-chiliad.pwn
#include ..\bin\modules\mapas\nova-fazenda.pwn
#include ..\bin\modules\mapas\pisoelevador.pwn
#include ..\bin\modules\mapas\posto-idlewood.pwn
#include ..\bin\modules\mapas\posto-ls.pwn
#include ..\bin\modules\mapas\prisao-int.pwn
#include ..\bin\modules\mapas\refinaria-drogas.pwn
#include ..\bin\modules\mapas\sedex.pwn
#include ..\bin\modules\mapas\shopping.pwn
#include ..\bin\modules\mapas\spawn.pwn

stock function MAP::AbrirPortaoDP(playerid)
{
	if ( GATE_DP_OPENED )
		return false;

	if ( !IsPlayerInRangeOfPoint(playerid, 25.0, 1551.19995, -1627.59998, 9.29930) )
		return false;

	GATE_DP_OPENED = true;
	MoveDynamicObject(GATE_DP, 1551.19995, -1627.59998, 9.29930, 3);
	SetTimerEx("MAP_FecharPortaoDP", 6000, false, "i", playerid);
	return true;
}
forward function MAP::FecharPortaoDP(playerid);
public function MAP::FecharPortaoDP(playerid)
{
	GATE_DP_OPENED = false;
	MoveDynamicObject(GATE_DP, 1551.19995, -1627.59998, 15.20000, 3);
	return true;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if ( newstate == PLAYER_STATE_DRIVER )
	{
		if ( GetVehicleModel(GetPlayerVehicleID(playerid)) == 510 )
		{
			for(new i; i < sizeof(BikesNovatos); i++)
			{
				if ( GetPlayerVehicleID(playerid) == BikesNovatos[i] )
				{
					if ( GetPlayerScore(playerid) >= 10 )
					{
						RemovePlayerFromVehicle(playerid);
						SendClientMessage(playerid, COR_AMARELO, "| INFO | Você possui level igual ou superior que 10 e não poderá usar esta bicicleta.");
						return 1;
					}
				}
			}
		}
		for(new i; i < sizeof(CarrosPublicos); i++)
		{
			if ( GetPlayerVehicleID(playerid) == CarrosPublicos[i] )
			{
				if ( GetPlayerScore(playerid) >= 10 )
				{
					RemovePlayerFromVehicle(playerid);
					SendClientMessage(playerid, COR_AMARELO, "| INFO | Você possui level igual ou superior que 10 e não poderá usar este veículo.");
					return 1;
				}
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}