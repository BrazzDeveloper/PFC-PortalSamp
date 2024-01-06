/*
*
*
*			INCLUDE HOOK
*
*
*/

#include <YSI_Coding\y_hooks>


/*
*
*
*			DEFINES E ENUMS E VARIÁVEIS
*
*
*/

#define MAX_SOUNDS	50
#define Controle TogglePlayerControllable

enum SomI
{
	bool:somCreated,
	Float:somX,
	Float:somY,
	Float:somZ,
	Float:somVida,
	Text3D:somText,
	somLink[256],
	somID,
	somWorld,
	somObject
};

enum SomIC
{
	bool:somCreated,
	Float:somX,
	Float:somY,
	Float:somZ,
	Float:somVida,
	Text3D:somText,
	somLink[256],
	somID,
	somWorld,
	somCar
};

new 
	SomInfo[MAX_SOUNDS][SomI],
	SomInVehicle[MAX_SOUNDS][SomIC],
	bool:OuvindoSom[MAX_PLAYERS],
	bool:OuvindoSomCar[MAX_PLAYERS],
	caixa[MAX_VEHICLES] = 0,
	caixa2[MAX_VEHICLES] = 0,
	cxx[MAX_VEHICLES] = 0,
	cxx2[MAX_VEHICLES] = 0,
	cxx3[MAX_VEHICLES] = 0,
	Float:CxY[MAX_VEHICLES],
	Float:CxX[MAX_VEHICLES],
	Float:CxZ[MAX_VEHICLES],
	Float:CxRZ[MAX_VEHICLES],
	Float:CxxY[MAX_VEHICLES],
	Float:CxxX[MAX_VEHICLES],
	Float:CxxZ[MAX_VEHICLES],
	Float:CxxY2[MAX_VEHICLES],
	Float:CxxX2[MAX_VEHICLES],
	Float:CxxZ2[MAX_VEHICLES],
	Float:CxxY3[MAX_VEHICLES],
	Float:CxxX3[MAX_VEHICLES],
	Float:CxxZ3[MAX_VEHICLES],
	SomTimer[MAX_PLAYERS],
	SomTimer2[MAX_PLAYERS],
	SlotFull[MAX_PLAYERS] = 0,
	lastSlot[MAX_PLAYERS]
;

/*
*
*
*			FORWARDS
*
*
*/

forward InstSom(playerid);
public InstSom(playerid)
{
	Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
	return 1;
}
forward InstSom2(playerid);
public InstSom2(playerid)
{
	Dialog_Show(playerid, EDIT_SOM_TRIO, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
	return 1;
}

/*
*
*
*			COMMANDS
*
*
*/

CMD:instalarsom(playerid)
{
	new vehicle = GetPlayerVehicleID(playerid);

	if(IsABike(vehicle) || IsAMotorBike(vehicle))
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode instalar som neste veículo, utilize um carro.");
		return 1;
	}

	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa de um veículo.");

	/*if ( !Iter_Contains(VehiclePlayers, vehicle) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Este veículo não é seu.");*/

	if(!PlayerToPoint(playerid, 5.0, 1569.3622,-2154.4934,14.1216))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está na oficina.");

	Dialog_Show(playerid, SOM_INSTALL, DIALOG_STYLE_LIST, "Som Automotivo", "Instalar Som\nRemover Som", "Ok", "Cancelar");

	return 1;
}

CMD:pegarradio(playerid)
{
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar esse comando agora.");

	//if(!Jogador[playerid][pRadio]) 
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possuí um rádio portátil.");

	if(Jogador[playerid][pComRadio])
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está com seu rádio portátil.");

	Jogador[playerid][pComRadio] = true;
	SetPlayerAttachedObject(playerid,1,2226,5,0.394999,0.045000,0.027000,-25.299999,-101.699974);

	return 1;
}

CMD:guardarradio(playerid)
{
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar esse comando agora.");

	//if(!Jogador[playerid][pRadio]) 
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possuí um rádio portátil.");

	if(!Jogador[playerid][pComRadio])
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está com o seu rádio portátil.");

	if(isPlayerSound(playerid)) 
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Seu rádio está tocando, desligue-o.");

	Jogador[playerid][pComRadio] = false;
	RemovePlayerAttachedObject(playerid, 1);
	return 1;
}

CMD:tocarsom(playerid, params[])
{
	if(isPertoSound(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Já existe um rádio tocando muito próximo a este local!");

	if(isPertoCarSound(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Já existe um som de carro tocando muito próximo a este local!");

	if(isPlayerSound(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Seu rádio portátil já está tocando, desligue-o!");

	Dialog_Show(playerid, DIALOG_SOM, DIALOG_STYLE_LIST,
		"Ligando Rádio Portátil",
		"Rádio Hunter\n\
		{FF8000}Colocar link para tocar\n", "Selecionar", "Sair");

	return 1;
}

CMD:tocarsomcarro(playerid, params[])
{

	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veículo.");

	if(isPertoSound(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Já existe um rádio tocando muito próximo a este local!");

	if(isPertoCarSound(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Já existe um som de carro tocando muito próximo a este local!");

	if(isPlayerSound(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Seu rádio portátil já está tocando, desligue-o!");

	Dialog_Show(playerid, DIALOG_SOM_CARRO, DIALOG_STYLE_LIST,
		"Ligando Som do Carro",
		"Rádio Hunter\n\
		{FF8000}Colocar link para tocar\n", "Selecionar", "Sair");

	return 1;
}

CMD:desligarsomcarro(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veículo.");

	if(Vehicle[GetPlayerVehicleID(playerid)][carRadioOn] == 1)
	{
		destroyPlayerCarSound(playerid);
		Vehicle[GetPlayerVehicleID(playerid)][carRadioOn] = 0;
		SendClientMessage(playerid, COR_LARANJA, "Som desligado.");
	} else {
		SendClientMessage(playerid, COR_ERRO, "| ERRO | O som já está desligado.");
	}
	return true;
}

CMD:desligarsom(playerid)
{
	if(SomInfo[playerid][somCreated])
	{
		destroySound(playerid);
		SendClientMessage(playerid, COR_LARANJA, "Você desligou o som.");
	} else {
		SendClientMessage(playerid, COR_ERRO, "| ERRO | O som já está desligado.");
	}
	return true;
}

flags:destruirsom(AJUDANTE);
CMD:destruirsom(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id))
		return SendClientMessage(playerid, COR_ERRO, "USE: /destuirsom [idsom]");

	if(SomInfo[id][somCreated])
	{
		destroySound(id);
		SendClientMessage(playerid, COR_ERRO, "Você destruiu o Som.");
	}
	else SendClientMessage(playerid, COR_ERRO, "Não existe um som com este id.");
	return true;
}

/*
*
*
*			DIALOGS
*
*
*/

Dialog:DIALOG_SOM(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: {
				createSound(playerid, "https://live.hunter.fm/pop_normal");
				PlayAudioStreamForPlayer(playerid,"https://live.hunter.fm/pop_normal");
				SendClientMessage(playerid, COR_SISTEMA, "Você está ouvindo Hunter FM");
				SendClientMessage(playerid, COR_ERRO, "Não está ouvindo as músicas? Aumenta o volume da rádio do seu GTA no menu de opções de rádio.");
			}
			case 1: {
				Dialog_Show(playerid, DIALOG_SOM_URL, DIALOG_STYLE_INPUT, "URL do Som", "Digite uma URL de uma música ou rádio!\n{FF8000}A música pode demorar até 10 segundos para iniciar.", "Tocar", "Cancelar");
			}
		}
		return 1;
	}
	return 1;
}

Dialog:DIALOG_SOM_URL(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(strlen(inputtext) > 250) return SendClientMessage(playerid, COR_ERRO, "| ERRO | O link que você digitou é muito longo.");
		if(strfind(inputtext,"%", true) != -1) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você pode usar caracteres espericiais.");
	
		if(isPertoSound(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Já existe um rádio tocando muito próximo a este local!");
	
		if(strfind(inputtext, "www.youtube.com", true) != -1)
		{
			new localURL[128];
			strmid(localURL, inputtext, strfind(inputtext, "v=")+2,strfind(inputtext, "v=")+19);
			format(inputtext, 128, "http://mwrserver.com/youtube.php?videoid=%s", localURL);
		}
		createSound(playerid, inputtext);
		PlayAudioStreamForPlayer(playerid, inputtext);
		return 1;
	}
	return 1;
}


Dialog:DIALOG_SOM_CARRO(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: {
				createSoundInCar(playerid, "https://live.hunter.fm/pop_normal");
				PlayAudioStreamForPlayer(playerid,"https://live.hunter.fm/pop_normal");
				SendClientMessage(playerid, COR_SISTEMA, "Você está ouvindo Hunter FM");
				SendClientMessage(playerid, COR_ERRO, "Não está ouvindo as músicas? Aumenta o volume da rádio do seu GTA no menu de opções de rádio.");
			}
			case 1: {
				Dialog_Show(playerid, DIALOG_SOM_URL, DIALOG_STYLE_INPUT, "URL do Som", "Digite uma URL de uma música ou rádio!\n{FF8000}A música pode demorar até 10 segundos para iniciar.", "Tocar", "Cancelar");
			}
		}
		return 1;
	}
	return 1;
}

Dialog:SOM_INSTALL(playerid, response, listitem, inputtext[])
{
	new car = GetPlayerVehicleID(playerid);
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				new engine, lights, alarm, doors, bonnet, boot, objective;
				GetVehicleParamsEx(car, engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(car, engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_ON, objective);
				Dialog_Show(playerid, SOM_INSTALL_TYPE, DIALOG_STYLE_TABLIST_HEADERS, "Instalação de Som", "Tipo Caixa\t\tPreço\n\
					Deitada\t\tR$10.000\n\
					Trio\t\tR$30.000\n", "Selecionar", "Sair");
				return 1;
			}
			case 1:
			{
				if(caixa[car] != 0 || cxx[car] != 0 || Vehicle[car][TemSom] != 0 || Vehicle[car][TemTrio] != 0)
				{
					DestroyDynamicObject(caixa[car]);
					DestroyDynamicObject(caixa2[car]);
					caixa[car] = 0;
					caixa2[car] = 0;
					DestroyDynamicObject(cxx[car]);
					DestroyDynamicObject(cxx2[car]);
					DestroyDynamicObject(cxx3[car]);
					cxx[car] = 0;
					cxx2[car] = 0;
					cxx3[car] = 0;
					CxY[car] = -2.710014;
					CxX[car] = 0.000000;
					CxZ[car] = 0.135000;
					CxxX[car] = -0.539999;
					CxxY[car] = -2.490009;
					CxxZ[car] = 0.339999;
					CxxX2[car] = 0.574999;
					CxxY2[car] = -2.490009;
					CxxZ2[car] = 0.339999;
					CxxX3[car] = 0.024999;
					CxxY3[car] = -2.490009;
					CxxZ3[car] = 0.339999;
					CxRZ[car] = 0.000000;
					Vehicle[car][CxXC] = 0;
					Vehicle[car][CxYC] = 0;
					Vehicle[car][CxZC] = 0;
					SendClientMessage(playerid, COR_BRANCO, "Equipamento de som removido com sucesso.");
					Vehicle[car][TemSom] = 0;
					Vehicle[car][TemTrio] = 0;
					Vehicle[car][CxRXX] = 0;
				}
			}
		}
	}
	return true;
}

Dialog:SOM_INSTALL_TYPE(playerid, response, listitem, inputtext[])
{
	new car = GetPlayerVehicleID(playerid);
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				if(caixa[car] != 0 || cxx[car] != 0 || Vehicle[car][TemSom] != 0 || Vehicle[car][TemTrio] != 0)
		        {
			    	SendClientMessage(playerid, COR_BRANCO, "Seu veículo já tem som instalado, utilize remoção de equipamento de som.");
			    	return true;
				}
				SendClientMessage(playerid, COR_SISTEMA, "Instalação em andamento, aguarde...");
				caixa[car] = CreateDynamicObject(2232, 0.0, 0.0, 0.0,   0.00, 0.00, 0.00);//stanga
				caixa2[car] = CreateDynamicObject(2232, 0.0, 0.0, 0.0,   0.00, 0.00, 0.00);//stanga
				AttachDynamicObjectToVehicle(caixa[car], car, 0.000000, -2.710014, 0.135000, 0.000000, -90.0000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(caixa2[car], car, 0.000000, -2.710014, 0.135000, 0.000000, -270.0000, 0.000000); //Object Model: 2232 |
				CxY[car] = -2.710014;
				CxX[car] = 0.000000;
				CxZ[car] = 0.135000;
				CxRZ[car] = 0.000000;
				SomTimer[playerid] = SetTimerEx("InstSom", 5000, false, "i", playerid);
				Controle(playerid,0);
				new Float:PosSomXX[3];
				GetVehiclePos(car, PosSomXX[0],PosSomXX[1],PosSomXX[2]);
				SetVehiclePos(car,PosSomXX[0],PosSomXX[1],PosSomXX[2]+0.1);
				//SetPlayerCameraPos(playerid, 1569.6896,-2160.2039,14.0806);
				//SetPlayerCameraLookAt(playerid, 1569.6896,-2160.2039,14.0806);
				SetCameraBehindPlayer(playerid);
				GivePlayerMoney(playerid, -10000);
			}
			case 1:
			{
				if(caixa[car] != 0 || cxx[car] != 0 || Vehicle[car][TemSom] != 0 || Vehicle[car][TemTrio] != 0)
		        {
			    	SendClientMessage(playerid, COR_BRANCO, "Seu véiculo já tem som instalado, utilize remoção de equipamento de som.");
			    	return true;
				}
				SendClientMessage(playerid, COR_SISTEMA, "Instalação em andamento, aguarde...");
				cxx[car] = CreateDynamicObject(2232, 0.0, 0.0, 0.0,   0.00, 0.00, 0.00);//stanga
				cxx2[car] = CreateDynamicObject(2232, 0.0, 0.0, 0.0,   0.00, 0.00, 0.00);//stanga
				cxx3[car] = CreateDynamicObject(2232, 0.0, 0.0, 0.0,   0.00, 0.00, 0.00);//stanga
			  	AttachDynamicObjectToVehicle(cxx[car], car, -0.539999, -2.490009, 0.339999, 0.000000, 0.000000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(cxx2[car], car, 0.574999, -2.490009, 0.339999, 0.000000, 0.000000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(cxx3[car], car, 0.024999, -2.490009, 0.339999, 0.000000, 0.000000, 0.000000); //Object Model: 2232 |
				CxxX[car] = -0.539999;
				CxxY[car] = -2.490009;
				CxxZ[car] = 0.339999;
				CxxX2[car] = 0.574999;
				CxxY2[car] = -2.490009;
				CxxZ2[car] = 0.339999;
				CxxX3[car] = 0.024999;
				CxxY3[car] = -2.490009;
				CxxZ3[car] = 0.339999;
				SomTimer2[playerid] = SetTimerEx("InstSom2", 5000, false, "i", playerid);
				Controle(playerid,0);
				new Float:PosSomXX[3];
				GetVehiclePos(car, PosSomXX[0],PosSomXX[1],PosSomXX[2]);
				SetVehiclePos(car,PosSomXX[0],PosSomXX[1],PosSomXX[2]+0.1);
				//SetPlayerCameraPos(playerid, 1569.6896,-2160.2039,14.0806);
				//SetPlayerCameraLookAt(playerid, 1569.6896,-2160.2039,14.0806);
				SetCameraBehindPlayer(playerid);
				GivePlayerMoney(playerid, -30000);
			}
		}
		return 1;
	}
	return 1;
}

Dialog:EDIT_SOM_CAIXA(playerid, response, listitem, inputtext[])
{
	new car = GetPlayerVehicleID(playerid);
	if(response)
	{
		switch(listitem)
		{
			case 0: // Esquerda
			{
				if(CxX[car] < -0.5) 
			    {
			    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
					Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			    	return true;
				}
			    new Float:Resultado;
			    Resultado = CxX[car] - 0.1;
				AttachDynamicObjectToVehicle(caixa[car], car, Resultado, CxY[car], CxZ[car], CxRZ[car], -90.0000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(caixa2[car], car, Resultado, CxY[car], CxZ[car], CxRZ[car], -270.0000, 0.000000); //Object Model: 2232 |
				SendClientMessage(playerid, COR_SISTEMA, "Ajuste feito.");
				Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				CxX[car] = Resultado;
				SetCameraBehindPlayer(playerid);
			}
			case 1: // Direita
			{
				if(CxX[car] > 0.5)
			    {
			    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
					Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			    	return true;
				}
			    new Float:Resultado;
			    Resultado = CxX[car] + 0.1;
				AttachDynamicObjectToVehicle(caixa[car], car, Resultado, CxY[car], CxZ[car], CxRZ[car], -90.0000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(caixa2[car], car, Resultado, CxY[car], CxZ[car], CxRZ[car], -270.0000, 0.000000); //Object Model: 2232 |
				SendClientMessage(playerid, COR_SISTEMA, "Ajuste feito.");
				Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				CxX[car] = Resultado;
				SetCameraBehindPlayer(playerid);
			}
			case 2: // Para Frente
			{
				if(CxY[car] > -1.00014)
			    {
			    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
					Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			    	return true;
				}
			    new Float:Resultado;
			    Resultado = CxY[car] + 0.1;
				AttachDynamicObjectToVehicle(caixa[car], car, CxX[car], Resultado, CxZ[car], CxRZ[car], -90.0000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(caixa2[car], car, CxX[car], Resultado, CxZ[car], CxRZ[car], -270.0000, 0.000000); //Object Model: 2232 |
				SendClientMessage(playerid, COR_SISTEMA, "Ajuste feito.");
				Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				CxY[car] = Resultado;
				SetCameraBehindPlayer(playerid);
			}
			case 3: // Para Trás
			{
				if(CxY[car] < -2.110014)
			    {
			    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
					Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			    	return true;
				}
			    new Float:Resultado;
			    Resultado = CxY[car] - 0.1;
				AttachDynamicObjectToVehicle(caixa[car], car, CxX[car], Resultado, CxZ[car], CxRZ[car], -90.0000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(caixa2[car], car, CxX[car], Resultado, CxZ[car], CxRZ[car], -270.0000, 0.000000); //Object Model: 2232 |
				SendClientMessage(playerid, COR_SISTEMA, "Ajuste feito.");
				Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				CxY[car] = Resultado;
				SetCameraBehindPlayer(playerid);
			}
			case 4: // Cima
			{
				if(CxZ[car] > 0.735000)
			    {
			    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
					Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			    	return true;
				}
			    new Float:Resultado;
			    Resultado = CxZ[car] + 0.05;
				AttachDynamicObjectToVehicle(caixa[car], car, CxX[car], CxY[car], Resultado, CxRZ[car], -90.0000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(caixa2[car], car, CxX[car], CxY[car], Resultado, CxRZ[car], -270.0000, 0.000000); //Object Model: 2232 |
				SendClientMessage(playerid, COR_SISTEMA, "Ajuste feito.");
				Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				CxZ[car] = Resultado;
				SetCameraBehindPlayer(playerid);
			}
			case 5: // Baixo
			{
				if(CxZ[car] < -0.235000)
			    {
			    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
					Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			    	return true;
				}
			    new Float:Resultado;
			    Resultado = CxZ[car] - 0.05;
				AttachDynamicObjectToVehicle(caixa[car], car, CxX[car], CxY[car], Resultado, CxRZ[car], -90.0000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(caixa2[car], car, CxX[car], CxY[car], Resultado, CxRZ[car], -270.0000, 0.000000); //Object Model: 2232 |
				SendClientMessage(playerid, COR_SISTEMA, "Ajuste feito.");
				Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				CxZ[car] = Resultado;
				SetCameraBehindPlayer(playerid);
			}
			case 6:/// Girar Frente
			{
				if(CxZ[car] > 360)
			    {
			    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
					Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			    	return true;
				}
			    new Float:Resultado;
			    Resultado = CxRZ[car] - 2.0;
				AttachDynamicObjectToVehicle(caixa[car], car, CxX[car], CxY[car], CxZ[car], Resultado, -90.0000, 0.00000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(caixa2[car], car, CxX[car], CxY[car], CxZ[car], Resultado, -90.0000, 0.00000); //Object Model: 2232 |
				SendClientMessage(playerid, COR_SISTEMA, "Ajuste feito.");
				Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				CxRZ[car] = Resultado;
				SetCameraBehindPlayer(playerid);
			}
			case 7: // Girar Trás
			{
				if(CxZ[car] < -360)
			    {
			    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
					Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			    	return true;
				}
			    new Float:Resultado;
			    Resultado = CxRZ[car] + 2.0;
				AttachDynamicObjectToVehicle(caixa[car], car, CxX[car], CxY[car], CxZ[car], Resultado, -90.0000, 0.00000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(caixa2[car], car, CxX[car], CxY[car], CxZ[car], Resultado, -270.0000, 0.0000); //Object Model: 2232 |
				SendClientMessage(playerid, COR_SISTEMA, "Ajuste feito.");
				Dialog_Show(playerid, EDIT_SOM_CAIXA, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				CxRZ[car] = Resultado;
				SetCameraBehindPlayer(playerid);
			}
			case 8:
			{
				Vehicle[car][CxXC] = CxX[car];
			 	Vehicle[car][CxYC] = CxY[car];
				Vehicle[car][CxZC] = CxZ[car];
				Vehicle[car][CxRXX] = CxRZ[car];
				Vehicle[car][TemSom] = 1;
				Controle(playerid,1);
				SendClientMessage(playerid, COR_SISTEMA, "Instalação concluída com sucesso!");
				SetCameraBehindPlayer(playerid);
			}
		}
		if(!response)
		{
			DestroyDynamicObject(caixa[car]);
			DestroyDynamicObject(caixa2[car]);
			caixa[car] = 0;
			caixa2[car] = 0;
			DestroyDynamicObject(cxx[car]);
			DestroyDynamicObject(cxx2[car]);
			DestroyDynamicObject(cxx3[car]);
			cxx[car] = 0;
			cxx2[car] = 0;
			cxx3[car] = 0;
			CxY[car] = -2.710014;
			CxX[car] = 0.000000;
			CxZ[car] = 0.135000;
			CxxX[car] = -0.539999;
			CxxY[car] = -2.490009;
			CxxZ[car] = 0.339999;
			CxxX2[car] = 0.574999;
			CxxY2[car] = -2.490009;
			CxxZ2[car] = 0.339999;
			CxxX3[car] = 0.024999;
			CxxY3[car] = -2.490009;
			CxxZ3[car] = 0.339999;
			Vehicle[car][CxXC] = 0;
			Vehicle[car][CxYC] = 0;
			Vehicle[car][CxZC] = 0;
			Controle(playerid,1);
			SendClientMessage(playerid, COR_ERRO, "Ok, você não quis finalizar a instalação.");
			SetCameraBehindPlayer(playerid);
			
		}
	}
	return 1;
}

Dialog:EDIT_SOM_TRIO(playerid, response, listitem, inputtext[])
{
	new car = GetPlayerVehicleID(playerid);
	if(response)
	{
		switch(listitem)
		{
			case 0: // Para frente
			{
				if(CxxY[car] > -0.890009)
				{
					SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
					Dialog_Show(playerid, EDIT_SOM_TRIO, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
					return true;
				}
				new Float:Resultado,Float:Resultado2,Float:Resultado3;
				Resultado = CxxY[car] + 0.1;
				Resultado2 = CxxY2[car] + 0.1;
				Resultado3 = CxxY3[car] + 0.1;
				AttachDynamicObjectToVehicle(cxx[car], car, CxxX[car], Resultado, CxxZ[car], CxRZ[car], 0.000000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(cxx2[car], car, CxxX2[car], Resultado2, CxxZ2[car], CxRZ[car], 0.000000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(cxx3[car], car, CxxX3[car], Resultado3, CxxZ3[car], CxRZ[car], 0.000000, 0.000000); //Object Model: 2232 |
				SendClientMessage(playerid, COR_SISTEMA, "Ajuste feito.");
				Dialog_Show(playerid, EDIT_SOM_TRIO, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				CxxY[car] = Resultado;
				CxxY2[car] = Resultado2;
				CxxY3[car] = Resultado3;
				SetCameraBehindPlayer(playerid);
			}
			case 1: // Para trás
			{
				if(CxxY[car] < -3.010014)
			    {
			    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
					Dialog_Show(playerid, EDIT_SOM_TRIO, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			    	return true;
				}
			    new Float:Resultado,Float:Resultado2,Float:Resultado3;
			    Resultado = CxxY[car] - 0.1;
			    Resultado2 = CxxY2[car] - 0.1;
			    Resultado3 = CxxY3[car] - 0.1;
			  	AttachDynamicObjectToVehicle(cxx[car], car, CxxX[car], Resultado, CxxZ[car], CxRZ[car], 0.000000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(cxx2[car], car, CxxX2[car], Resultado2, CxxZ2[car], CxRZ[car], 0.000000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(cxx3[car], car, CxxX3[car], Resultado3, CxxZ3[car], CxRZ[car], 0.000000, 0.000000); //Object Model: 2232 |
				SendClientMessage(playerid, COR_SISTEMA, "Ajuste feito.");
				Dialog_Show(playerid, EDIT_SOM_TRIO, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				CxxY[car] = Resultado;
				CxxY2[car] = Resultado2;
				CxxY3[car] = Resultado3;
				SetCameraBehindPlayer(playerid);
			}
			case 2: // Para cima
			{
				if(CxxZ[car] > 0.8)
			    {
			    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
					Dialog_Show(playerid, EDIT_SOM_TRIO, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			    	return true;
				}
			    new Float:Resultado,Float:Resultado2,Float:Resultado3;
			    Resultado = CxxZ[car] + 0.1;
			    Resultado2 = CxxZ2[car] + 0.1;
			    Resultado3 = CxxZ3[car] + 0.1;
			  	AttachDynamicObjectToVehicle(cxx[car], car, CxxX[car], CxxY[car], Resultado, CxRZ[car], 0.000000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(cxx2[car], car, CxxX2[car], CxxY[car], Resultado2, CxRZ[car], 0.000000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(cxx3[car], car, CxxX3[car], CxxY[car], Resultado3, CxRZ[car], 0.000000, 0.000000); //Object Model: 2232 |
				SendClientMessage(playerid, COR_SISTEMA, "Ajuste feito.");
				Dialog_Show(playerid, EDIT_SOM_TRIO, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				CxxZ[car] = Resultado;
				CxxZ2[car] = Resultado2;
				CxxZ3[car] = Resultado3;
				SetCameraBehindPlayer(playerid);
			}
			case 3: // Para baixo
			{
				if(CxxZ[car] < -0.335000)
			    {
			    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
					Dialog_Show(playerid, EDIT_SOM_TRIO, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			    	return true;
				}
			    new Float:Resultado,Float:Resultado2,Float:Resultado3;
			    Resultado = CxxZ[car] - 0.1;
			    Resultado2 = CxxZ2[car] - 0.1;
			    Resultado3 = CxxZ3[car] - 0.1;
			  	AttachDynamicObjectToVehicle(cxx[car], car, CxxX[car], CxxY[car], Resultado, CxRZ[car], 0.000000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(cxx2[car], car, CxxX2[car], CxxY[car], Resultado2, CxRZ[car], 0.000000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(cxx3[car], car, CxxX3[car], CxxY[car], Resultado3, CxRZ[car], 0.000000, 0.000000); //Object Model: 2232 |
				SendClientMessage(playerid, COR_SISTEMA, "Ajuste feito.");
				Dialog_Show(playerid, EDIT_SOM_TRIO, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				CxxZ[car] = Resultado;
				CxxZ2[car] = Resultado2;
				CxxZ3[car] = Resultado3;
				SetCameraBehindPlayer(playerid);
			}
			case 4://girar para frente
			{
				if(CxxZ[car] < -0.335000)
			    {
			    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
					Dialog_Show(playerid, EDIT_SOM_TRIO, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			    	return true;
				}
			    new Float:Resultado;
			    Resultado = CxRZ[car] - 2.0;
			  	AttachDynamicObjectToVehicle(cxx[car], car, CxxX[car], CxxY[car], CxxZ[car], Resultado, 0.000000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(cxx2[car], car, CxxX2[car], CxxY[car], CxxZ2[car], Resultado, 0.000000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(cxx3[car], car, CxxX3[car], CxxY[car], CxxZ3[car], Resultado, 0.000000, 0.000000); //Object Model: 2232 |
				SendClientMessage(playerid, COR_SISTEMA, "Ajuste feito.");
				Dialog_Show(playerid, EDIT_SOM_TRIO, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				CxRZ[car] = Resultado;
				SetCameraBehindPlayer(playerid);
			}
			case 5: //Girar pra tras
			{
				if(CxxZ[car] < -0.335000)
		    {
		    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, EDIT_SOM_TRIO, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
		    	return true;
				}
			    new Float:Resultado;
			    Resultado = CxRZ[car] + 2.0;
			  	AttachDynamicObjectToVehicle(cxx[car], car, CxxX[car], CxxY[car], CxxZ[car], Resultado, 0.000000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(cxx2[car], car, CxxX2[car], CxxY[car], CxxZ2[car], Resultado, 0.000000, 0.000000); //Object Model: 2232 |
				AttachDynamicObjectToVehicle(cxx3[car], car, CxxX3[car], CxxY[car], CxxZ3[car], Resultado, 0.000000, 0.000000); //Object Model: 2232 |
				SendClientMessage(playerid, COR_SISTEMA, "Ajuste feito.");
				Dialog_Show(playerid, EDIT_SOM_TRIO, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				CxRZ[car] = Resultado;
			}
			case 6: // Finalizado
			{
				Vehicle[car][CxxXC] = CxxX[car];
			 	Vehicle[car][CxxYC] = CxxY[car];
				Vehicle[car][CxxZC] = CxxZ[car];
				Vehicle[car][CxxX2C] = CxxX2[car];
			 	Vehicle[car][CxxY2C] = CxxY2[car];
				Vehicle[car][CxxZ2C] = CxxZ2[car];
				Vehicle[car][CxxX3C] = CxxX3[car];
			 	Vehicle[car][CxxY3C] = CxxY3[car];
				Vehicle[car][CxxZ3C] = CxxZ3[car];
				Vehicle[car][CxRXX] = CxRZ[car];
				Vehicle[car][TemTrio] = 1;
				Controle(playerid,1);
				SendClientMessage(playerid, COR_BRANCO, "Instalação concluída com sucesso!");
				SetCameraBehindPlayer(playerid);
			}
		}
		if(!response)
		{
			DestroyDynamicObject(caixa[car]);
			DestroyDynamicObject(caixa2[car]);
			caixa[car] = 0;
			caixa2[car] = 0;
			DestroyDynamicObject(cxx[car]);
			DestroyDynamicObject(cxx2[car]);
			DestroyDynamicObject(cxx3[car]);
			cxx[car] = 0;
			cxx2[car] = 0;
			cxx3[car] = 0;
			CxY[car] = -2.710014;
			CxX[car] = 0.000000;
			CxZ[car] = 0.135000;
			CxxX[car] = -0.539999;
			CxxY[car] = -2.490009;
			CxxZ[car] = 0.339999;
			CxxX2[car] = 0.574999;
			CxxY2[car] = -2.490009;
			CxxZ2[car] = 0.339999;
			CxxX3[car] = 0.024999;
			CxxY3[car] = -2.490009;
			CxxZ3[car] = 0.339999;
			Vehicle[car][CxXC] = 0;
			Vehicle[car][CxYC] = 0;
			Vehicle[car][CxZC] = 0;
			Controle(playerid,1);
			SendClientMessage(playerid, COR_ERRO, "Ok, você não quis finalizar a instalação.");
			SetCameraBehindPlayer(playerid);
			
		}
	}
	return 1;
}

/*
*
*
*			STOCKS & FUNCTIONS
*
*
*/

stock CountAttachedObjects(playerid)
{
	new 
		count=-1, 
		i=0
	;
	while(i < MAX_PLAYER_ATTACHED_OBJECTS)
	{
		if(Jogador[playerid][pAcP] == 1 && i < 6)
		{
			i = 6;
			continue;
		}
		if(IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			i++;
			continue;
		} 
		else
		{
			count = i;
			lastSlot[playerid] = i;
			i = MAX_PLAYER_ATTACHED_OBJECTS;
			break;
		}
	}
	if(count == -1)
	{
		return SlotFull[playerid] = 1;
	}
	return count;
}

isPlayerSound(playerid){

	for(new x; x != MAX_SOUNDS; x++){

		if(SomInfo[x][somCreated] && SomInfo[x][somID] == playerid){
			return 1;
		}
	}
	return 0;
}

isPertoSound(playerid){

	for(new x; x != MAX_SOUNDS; x++){

		if(SomInfo[x][somCreated] && GetPlayerVirtualWorld(playerid) == SomInfo[x][somWorld] && IsPlayerInRangeOfPoint(playerid, 80.0, SomInfo[x][somX], SomInfo[x][somY], SomInfo[x][somZ])){

			return 1;
		}
	}
	return 0;
}

createSound(playerid, soundUrl[])
{
	static 
		Float:PosSom[4],
		str[128]
	;

	ApplyAnimation(playerid,"BOMBER","BOM_Plant_2Idle",4.1,0,1,1,0,0);

	RemovePlayerAttachedObject(playerid, 1);
	Jogador[playerid][pComRadio] = false;

	GetPlayerPos(playerid, PosSom[0], PosSom[1], PosSom[2]);
	GetPlayerFacingAngle(playerid, PosSom[3]);

	for(new x; x != MAX_SOUNDS; x++)
	{
		if(!SomInfo[x][somCreated])
		{
			SomInfo[x][somCreated] = true;
	        SomInfo[x][somWorld] = GetPlayerVirtualWorld(playerid);
	        SomInfo[x][somVida] = 100.0;
	        SomInfo[x][somX] = PosSom[0];
	        SomInfo[x][somY] = PosSom[1];
	        SomInfo[x][somZ] = PosSom[2]-0.95;
	        SomInfo[x][somID] = playerid;

	        format(SomInfo[x][somLink], 128, soundUrl);

	        SomInfo[x][somObject] = CreateDynamicObject(2226, SomInfo[x][somX], SomInfo[x][somY], SomInfo[x][somZ], 0.0, 0.0, PosSom[3], SomInfo[x][somWorld]);

	        format(str, 128, "-o))) Som de: {ffffff}%s", GetUserName(playerid));
	        SomInfo[x][somText] = CreateDynamic3DTextLabel(str, 0xFF8000FF, SomInfo[x][somX], SomInfo[x][somY], SomInfo[x][somZ]+0.3, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, SomInfo[x][somWorld]);
		
	        return 1;
		}
	}
	return 1;
}

destroySound(id){

	if(SomInfo[id][somCreated]){

	    SomInfo[id][somCreated] = false;

	    DestroyDynamicObject(SomInfo[id][somObject]);
	    DestroyDynamic3DTextLabel(SomInfo[id][somText]);
	    SomInfo[id][somID] = 999;

	    foreach(new i: Player) {

	        if(IsPlayerInRangeOfPoint(i, 71.0, SomInfo[id][somX], SomInfo[id][somY], SomInfo[id][somZ]) && OuvindoSom[i] && GetPlayerVirtualWorld(i) == SomInfo[id][somWorld]){

	            StopAudioStreamForPlayer(i);
	            OuvindoSom[i] = false;
	        }
	    }
	}
}

CheckSoundProx(playerid){

	static
		Str[55]
	;

	for(new x; x != MAX_SOUNDS; x++){

		if(SomInfo[x][somCreated] && GetPlayerVirtualWorld(playerid) == SomInfo[x][somWorld] && IsPlayerInRangeOfPoint(playerid, 70.0, SomInfo[x][somX], SomInfo[x][somY], SomInfo[x][somZ])){

			if(!OuvindoSom[playerid]){

				OuvindoSom[playerid] = true;

				PlayAudioStreamForPlayer(playerid, SomInfo[x][somLink], SomInfo[x][somX], SomInfo[x][somY], SomInfo[x][somZ], 30.0, 1);

				format(Str, sizeof Str, "-o))) Você está ouvindo o rádio de %s.", GetUserName(SomInfo[x][somID]));
				SendClientMessage(playerid, 0x33CCFFAA, Str);
			}

			return 1;
   		}
	}
   	if(OuvindoSom[playerid]){

		StopAudioStreamForPlayer(playerid);
  		OuvindoSom[playerid] = false;
	}

	return 1;
}

createSoundInCar(playerid, urlSound[])
{

	static
		Float:PosSomCarro[4],
		string[78]
	;

	GetPlayerPos(playerid, PosSomCarro[0], PosSomCarro[1], PosSomCarro[2]);
	GetPlayerFacingAngle(playerid, PosSomCarro[3]);

	for(new x; x != MAX_SOUNDS; x++)
	{

		SomInVehicle[x][somCreated] = true;

		SomInVehicle[x][somWorld] = GetPlayerVirtualWorld(playerid);

		SomInVehicle[x][somVida] = 100.0;

		SomInVehicle[x][somX] = PosSomCarro[0];
		SomInVehicle[x][somY] = PosSomCarro[1];
		SomInVehicle[x][somZ] = PosSomCarro[2]-0.95;
		SomInVehicle[x][somID] = playerid;

		format(SomInVehicle[x][somLink], 128, urlSound);

		format(string, sizeof string, "-o))) Som do carro de: %s", GetUserName(playerid));
		Vehicle[GetPlayerVehicleID(playerid)][carRadioOn] = 1;
		SomInVehicle[x][somCar] = GetPlayerVehicleID(playerid);

		SomInVehicle[x][somText] = CreateDynamic3DTextLabel(string, 0xFF8000FF, SomInVehicle[x][somX], SomInVehicle[x][somY], SomInVehicle[x][somZ]+0.3, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, SomInVehicle[x][somWorld]);

		return 1;
	}
	return 1;
}

CheckCarSoundProx(playerid){

	static
		Str[80]
	;

	for(new x; x != MAX_SOUNDS; x++){
		if(SomInVehicle[x][somCreated] && GetPlayerVirtualWorld(playerid) == SomInVehicle[x][somWorld] && IsPlayerInRangeOfPoint(playerid, 70.0, SomInVehicle[x][somX], SomInVehicle[x][somY], SomInVehicle[x][somZ]))
		{
				if(!OuvindoSomCar[playerid]){
					OuvindoSomCar[playerid] = true;

					PlayAudioStreamForPlayer(playerid, SomInVehicle[x][somLink], SomInVehicle[x][somX], SomInVehicle[x][somY], SomInVehicle[x][somZ], 60.0, 1);

					format(Str, sizeof Str, "-o))) Você está ouvindo o Som do carro de %s.", GetUserName(SomInVehicle[x][somID]));
					SendClientMessage(playerid, 0xFFA500F6, Str);
				}
				return 1;
		}
		if(OuvindoSomCar[playerid]) {
			StopAudioStreamForPlayer(playerid);
	  		OuvindoSomCar[playerid] = false;
		}
	}
	return 1;
}

isPlayerCarSound(playerid){

	for(new x; x != MAX_SOUNDS; x++) {

		if(SomInVehicle[x][somCreated] && SomInVehicle[x][somID] == playerid){
			return 1;
		}
	}
	return 0;
}

isPertoCarSound(playerid){

	for(new x; x != MAX_SOUNDS; x++){

		if(SomInVehicle[x][somCreated] && GetPlayerVirtualWorld(playerid) == SomInVehicle[x][somWorld] && IsPlayerInRangeOfPoint(playerid, 80.0, SomInVehicle[x][somX], SomInVehicle[x][somY], SomInVehicle[x][somZ])){

			return 1;
		}
	}
	return 0;
}

destroyPlayerCarSound(playerid){

	for(new x; x != MAX_SOUNDS; x++) {
	    if(SomInVehicle[x][somCreated] && SomInVehicle[x][somID] == playerid){

	        destroySoundInCar(x);
	    }
	}
}

destroyPlayerSound(playerid){

	for(new x; x != MAX_SOUNDS; x++){

	    if(SomInfo[x][somCreated] && SomInfo[x][somID] == playerid){

	        destroySound(x);
	    }
	}
}

destroySoundInCar(id){

	if(SomInVehicle[id][somCreated]){

	    SomInVehicle[id][somCreated] = false;

	    DestroyDynamic3DTextLabel(SomInVehicle[id][somText]);
	    SomInVehicle[id][somID] = 999;
	    Vehicle[SomInVehicle[id][somCar]][carRadioOn] = 0;

	    foreach(new i: Player){

	        if(IsPlayerInRangeOfPoint(i, 71.0, SomInVehicle[id][somX], SomInVehicle[id][somY], SomInVehicle[id][somZ]) && OuvindoSomCar[i] && GetPlayerVirtualWorld(i) == SomInVehicle[id][somWorld]){

	            StopAudioStreamForPlayer(i);
	            OuvindoSomCar[i] = false;
	        }
	    }
	}
}

hook OP_ShootDynamicObject(playerid, weaponid, objectid, Float:x, Float:y, Float:z){

	for(new id; id != MAX_SOUNDS; id++){

	    if(SomInfo[id][somCreated] && objectid == SomInfo[id][somObject]){

			GameTextForPlayer(playerid, "~r~~>~destruindo radio~<~", 5000, 1);

	        if(SomInfo[id][somVida] > 0){

	            SomInfo[id][somVida] -= 4.0;
	        }else{

	            static
					Str[97]
				;

	            format(Str, sizeof Str, "AVISO: %s destruiu seu rádio portátil.", GetUserName(playerid));
	            SendClientMessage(SomInfo[id][somID], COR_ERRO, Str);

                destroyPlayerSound(SomInfo[id][somID]);
	        }
	    }
	}

	return 1;
}