

/*
*
*
*			INCLUDE HOOK
*
*
*/
#include <YSI_Coding\y_hooks>

#define Vaga_Radio 929
#define MAX_SOUNDS 50
#define Controle 						 TogglePlayerControllable

/*
*
*
*			Enums
*
*
*/

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

enum somIC
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

new Sound1[MAX_VEHICLES], Sound2[MAX_VEHICLES], Sound3[MAX_VEHICLES], Sound4[MAX_VEHICLES];
new SomInfo[MAX_SOUNDS][SomI];
new SomInVehicle[MAX_SOUNDS][somIC];
new bool:OuvindoSom[MAX_PLAYERS];
new bool:OuvindoSomCar[MAX_PLAYERS];
new caixa[MAX_VEHICLES] = 0;
new caixa2[MAX_VEHICLES] = 0;
new cxx[MAX_VEHICLES] = 0;
new cxx2[MAX_VEHICLES] = 0;
new cxx3[MAX_VEHICLES] = 0;
new Float:CxY[MAX_VEHICLES];
new Float:CxX[MAX_VEHICLES];
new Float:CxZ[MAX_VEHICLES];
new Float:CxRZ[MAX_VEHICLES];
new Float:CxxY[MAX_VEHICLES];
new Float:CxxX[MAX_VEHICLES];
new Float:CxxZ[MAX_VEHICLES];
new Float:CxxY2[MAX_VEHICLES];
new Float:CxxX2[MAX_VEHICLES];
new Float:CxxZ2[MAX_VEHICLES];
new Float:CxxY3[MAX_VEHICLES];
new Float:CxxX3[MAX_VEHICLES];
new Float:CxxZ3[MAX_VEHICLES];
new SomTimer[MAX_PLAYERS];
new SomTimer2[MAX_PLAYERS];
/*
*
*
*			COMMANDS
*
*
*/

CMD:tocarsom(playerid, params[])
{
	if(isPertoSound(playerid))
		return SendClientMessage(playerid, COR_ERRO, "Erro: Já existe um rádio tocando muito próximo a este local!");

	if(isPertoCarSound(playerid))
		return SendClientMessage(playerid, COR_ERRO, "Erro: Já existe um som de carro tocando muito próximo a este local!");

	if(isPlayerSound(playerid))
		return SendClientMessage(playerid, COR_ERRO, "Erro: Seu rádio portátil já está tocando, desligue-o!");

	Dialog_Show(playerid, DIALOG_SOM, DIALOG_STYLE_LIST,
		"Ligando Rádio Portátil",
		"Rádio Hunter\n\
		{FF8000}Colocar link para tocar\n", "Selecionar", "Sair");

	return 1;
}

CMD:tocarsomcarro(playerid, params[])
{

	if(isPertoSound(playerid))
		return SendClientMessage(playerid, COR_ERRO, "Erro: Já existe um rádio tocando muito próximo a este local!");

	if(isPertoCarSound(playerid))
		return SendClientMessage(playerid, COR_ERRO, "Erro: Já existe um som de carro tocando muito próximo a este local!");

	if(isPlayerSound(playerid))
		return SendClientMessage(playerid, COR_ERRO, "Erro: Seu rádio portátil já está tocando, desligue-o!");

	Dialog_Show(playerid, DIALOG_SOM_CARRO, DIALOG_STYLE_LIST,
		"Ligando Som do Carro",
		"Rádio Hunter\n\
		{FF8000}Colocar link para tocar\n", "Selecionar", "Sair");

	return 1;
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
		if(strlen(inputtext) > 250) return SendClientMessage(playerid, COR_ERRO, "Erro: O link que você digitou é muito longo.");
		if(strfind(inputtext,"%", true) != -1) return SendClientMessage(playerid, COR_ERRO, "Erro: Você pode usar caracteres espericiais.");
	
		if(isPertoSound(playerid))
			return SendClientMessage(playerid, COR_ERRO, "Erro: Já existe um rádio tocando muito próximo a este local!");
	
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

Dialog:SOMDIALOG(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new car99;
	    car99 = GetPlayerVehicleID(playerid);
		if(listitem == 0) // Instalar
	    {
	    	SendClientMessage(playerid, -1, "Debug passou");
	        new engine, lights, alarm, doors, bonnet, boot, objective;
	    	Dialog_Show(playerid, SOMDIALOG1, DIALOG_STYLE_LIST, "Tipo de Instalação", "Caixa Deitada(R$5.000)\nTrio(R$20.000)", "Ok", "Cancelar");
			GetVehicleParamsEx(car99, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(car99, engine, lights, alarm, doors, bonnet, VEHICLE_PARAMS_ON, objective);
	    }
	    if(listitem == 1) // Remove
	    {
	        if(caixa[car99] != 0 || cxx[car99] != 0 || Vehicle[car99][TemSom] != 0 || Vehicle[car99][TemTrio] != 0)
	        {
				DestroyDynamicObject(caixa[car99]);
				DestroyDynamicObject(caixa2[car99]);
				caixa[car99] = 0;
				caixa2[car99] = 0;
				DestroyDynamicObject(cxx[car99]);
				DestroyDynamicObject(cxx2[car99]);
				DestroyDynamicObject(cxx3[car99]);
				cxx[car99] = 0;
				cxx2[car99] = 0;
				cxx3[car99] = 0;
				CxY[car99] = -2.710014;
				CxX[car99] = 0.000000;
				CxZ[car99] = 0.135000;
				CxxX[car99] = -0.539999;
				CxxY[car99] = -2.490009;
				CxxZ[car99] = 0.339999;
				CxxX2[car99] = 0.574999;
				CxxY2[car99] = -2.490009;
				CxxZ2[car99] = 0.339999;
				CxxX3[car99] = 0.024999;
				CxxY3[car99] = -2.490009;
				CxxZ3[car99] = 0.339999;
				CxRZ[car99] = 0.000000;
				Vehicle[car99][CxXC] = 0;
				Vehicle[car99][CxYC] = 0;
				Vehicle[car99][CxZC] = 0;
				SendClientMessage(playerid, COR_BRANCO, "Equipamento de som removido com sucesso.");
				Vehicle[car99][TemSom] = 0;
				Vehicle[car99][TemTrio] = 0;
				Vehicle[car99][CxRXX] = 0;
				//
			}
			else
			{
				SendClientMessage(playerid, COR_BRANCO, "Seu véiculo não tem equipamento de som instalado.");
			}
			
	    }
	}
	return 1;
}

Dialog:SOMDIALOG1(playerid, response, listitem, inputtext[])
{
	new car99;
	car99 = GetPlayerVehicleID(playerid);
	if(response)
	{
		if(listitem == 0)
	    {
	        if(caixa[car99] != 0 || cxx[car99] != 0 || Vehicle[car99][TemSom] != 0 || Vehicle[car99][TemTrio] != 0)
	        {
		    	SendClientMessage(playerid, COR_BRANCO, "Seu véiculo já tem som instalado, utilize remoção de equipamento de som.");
		    	return true;
			}
			SendClientMessage(playerid, COR_BRANCO, "Instalação em andamento, aguarde...");
			caixa[car99] = CreateDynamicObject(2232, 0.0, 0.0, 0.0,   0.00, 0.00, 0.00);//stanga
			caixa2[car99] = CreateDynamicObject(2232, 0.0, 0.0, 0.0,   0.00, 0.00, 0.00);//stanga
			AttachDynamicObjectToVehicle(caixa[car99], car99, 0.000000, -2.710014, 0.135000, 0.000000, -90.0000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(caixa2[car99], car99, 0.000000, -2.710014, 0.135000, 0.000000, -270.0000, 0.000000); //Object Model: 2232 |
			CxY[car99] = -2.710014;
			CxX[car99] = 0.000000;
			CxZ[car99] = 0.135000;
			CxRZ[car99] = 0.000000;
			SomTimer[playerid] = SetTimerEx("InstSom", 5000, false, "i", playerid);
			Controle(playerid,0);
			new Float:PosSomXX[3];
			GetVehiclePos(car99, PosSomXX[0],PosSomXX[1],PosSomXX[2]);
			SetVehiclePos(car99,PosSomXX[0],PosSomXX[1],PosSomXX[2]+0.1);
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
			GivePlayerMoney(playerid, -5000);
	    }
	    if(listitem == 1)
		{
	        if(caixa[car99] != 0 || cxx[car99] != 0 || Vehicle[car99][TemSom] != 0 || Vehicle[car99][TemTrio] != 0)
	        {
		    	SendClientMessage(playerid, COR_BRANCO, "Seu véiculo já tem som instalado, utilize remoção de equipamento de som.");
		    	return true;
			}
			SendClientMessage(playerid, COR_BRANCO, "Instalação em andamento, aguarde...");
			cxx[car99] = CreateDynamicObject(2232, 0.0, 0.0, 0.0,   0.00, 0.00, 0.00);//stanga
			cxx2[car99] = CreateDynamicObject(2232, 0.0, 0.0, 0.0,   0.00, 0.00, 0.00);//stanga
			cxx3[car99] = CreateDynamicObject(2232, 0.0, 0.0, 0.0,   0.00, 0.00, 0.00);//stanga
		  	AttachDynamicObjectToVehicle(cxx[car99], car99, -0.539999, -2.490009, 0.339999, 0.000000, 0.000000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(cxx2[car99], car99, 0.574999, -2.490009, 0.339999, 0.000000, 0.000000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(cxx3[car99], car99, 0.024999, -2.490009, 0.339999, 0.000000, 0.000000, 0.000000); //Object Model: 2232 |
			CxxX[car99] = -0.539999;
			CxxY[car99] = -2.490009;
			CxxZ[car99] = 0.339999;
			CxxX2[car99] = 0.574999;
			CxxY2[car99] = -2.490009;
			CxxZ2[car99] = 0.339999;
			CxxX3[car99] = 0.024999;
			CxxY3[car99] = -2.490009;
			CxxZ3[car99] = 0.339999;
			SomTimer2[playerid] = SetTimerEx("InstSom2", 5000, false, "i", playerid);
			Controle(playerid,0);
			new Float:PosSomXX[3];
			GetVehiclePos(car99, PosSomXX[0],PosSomXX[1],PosSomXX[2]);
			SetVehiclePos(car99,PosSomXX[0],PosSomXX[1],PosSomXX[2]+0.1);
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
			GivePlayerMoney(playerid, -20000);
	    }
	}
	return 1;
}
Dialog:SOMDIALOG2(playerid, response, listitem, inputtext[])
{
	new car99;
	car99 = GetPlayerVehicleID(playerid);
	if(response)
	{
		if(listitem == 0) //Esquerda
	    {
		    if(CxX[car99] < -0.5)
		    {
		    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
		    	return true;
			}
		    new Float:Resultado;
		    Resultado = CxX[car99] - 0.1;
			AttachDynamicObjectToVehicle(caixa[car99], car99, Resultado, CxY[car99], CxZ[car99], CxRZ[car99], -90.0000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(caixa2[car99], car99, Resultado, CxY[car99], CxZ[car99], CxRZ[car99], -270.0000, 0.000000); //Object Model: 2232 |
			SendClientMessage(playerid, COR_BRANCO, "Ajuste feito.");
			Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			CxX[car99] = Resultado;
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
	    }
	    if(listitem == 1) //Direita
	    {
		    if(CxX[car99] > 0.5)
		    {
		    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
		    	return true;
			}
		    new Float:Resultado;
		    Resultado = CxX[car99] + 0.1;
			AttachDynamicObjectToVehicle(caixa[car99], car99, Resultado, CxY[car99], CxZ[car99], CxRZ[car99], -90.0000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(caixa2[car99], car99, Resultado, CxY[car99], CxZ[car99], CxRZ[car99], -270.0000, 0.000000); //Object Model: 2232 |
			SendClientMessage(playerid, COR_BRANCO, "Ajuste feito.");
			Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			CxX[car99] = Resultado;
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
	    }
	    if(listitem == 2)//Para Frente
		{
		    if(CxY[car99] > -1.00014)
		    {
		    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
		    	return true;
			}
		    new Float:Resultado;
		    Resultado = CxY[car99] + 0.1;
			AttachDynamicObjectToVehicle(caixa[car99], car99, CxX[car99], Resultado, CxZ[car99], CxRZ[car99], -90.0000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(caixa2[car99], car99, CxX[car99], Resultado, CxZ[car99], CxRZ[car99], -270.0000, 0.000000); //Object Model: 2232 |
			SendClientMessage(playerid, COR_BRANCO, "Ajuste feito.");
			Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			CxY[car99] = Resultado;
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
	    }
	    if(listitem == 3)//Para Trás
		{
		    if(CxY[car99] < -2.110014)
		    {
		    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
		    	return true;
			}
		    new Float:Resultado;
		    Resultado = CxY[car99] - 0.1;
			AttachDynamicObjectToVehicle(caixa[car99], car99, CxX[car99], Resultado, CxZ[car99], CxRZ[car99], -90.0000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(caixa2[car99], car99, CxX[car99], Resultado, CxZ[car99], CxRZ[car99], -270.0000, 0.000000); //Object Model: 2232 |
			SendClientMessage(playerid, COR_BRANCO, "Ajuste feito.");
			Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			CxY[car99] = Resultado;
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
	    }
	    if(listitem == 4)//Cima
		{
		    if(CxZ[car99] > 0.735000)
		    {
		    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
		    	return true;
			}
		    new Float:Resultado;
		    Resultado = CxZ[car99] + 0.05;
			AttachDynamicObjectToVehicle(caixa[car99], car99, CxX[car99], CxY[car99], Resultado, CxRZ[car99], -90.0000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(caixa2[car99], car99, CxX[car99], CxY[car99], Resultado, CxRZ[car99], -270.0000, 0.000000); //Object Model: 2232 |
			SendClientMessage(playerid, COR_BRANCO, "Ajuste feito.");
			Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			CxZ[car99] = Resultado;
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
	    }
	    if(listitem == 5)//Baixo
		{
		    if(CxZ[car99] < -0.235000)
		    {
		    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
		    	return true;
			}
		    new Float:Resultado;
		    Resultado = CxZ[car99] - 0.05;
			AttachDynamicObjectToVehicle(caixa[car99], car99, CxX[car99], CxY[car99], Resultado, CxRZ[car99], -90.0000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(caixa2[car99], car99, CxX[car99], CxY[car99], Resultado, CxRZ[car99], -270.0000, 0.000000); //Object Model: 2232 |
			SendClientMessage(playerid, COR_BRANCO, "Ajuste feito.");
			Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			CxZ[car99] = Resultado;
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
	    }
	    if(listitem == 6)//girar frente
		{
		    if(CxZ[car99] > 360)
		    {
		    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
		    	return true;
			}
		    new Float:Resultado;
		    Resultado = CxRZ[car99] - 2.0;
			AttachDynamicObjectToVehicle(caixa[car99], car99, CxX[car99], CxY[car99], CxZ[car99], Resultado, -90.0000, 0.00000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(caixa2[car99], car99, CxX[car99], CxY[car99], CxZ[car99], Resultado, -90.0000, 0.00000); //Object Model: 2232 |
			SendClientMessage(playerid, COR_BRANCO, "Ajuste feito.");
			Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			CxRZ[car99] = Resultado;
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
	    }
	    if(listitem == 7)//girar trás
		{
		    if(CxZ[car99] < -360)
		    {
		    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
		    	return true;
			}
		    new Float:Resultado;
		    Resultado = CxRZ[car99] + 2.0;
			AttachDynamicObjectToVehicle(caixa[car99], car99, CxX[car99], CxY[car99], CxZ[car99], Resultado, -90.0000, 0.00000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(caixa2[car99], car99, CxX[car99], CxY[car99], CxZ[car99], Resultado, -270.0000, 0.0000); //Object Model: 2232 |
			SendClientMessage(playerid, COR_BRANCO, "Ajuste feito.");
			Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			CxRZ[car99] = Resultado;
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
	    }
	    if(listitem == 8)//Concluiu
		{
			Vehicle[car99][CxXC] = CxX[car99];
		 	Vehicle[car99][CxYC] = CxY[car99];
			Vehicle[car99][CxZC] = CxZ[car99];
			Vehicle[car99][CxRXX] = CxRZ[car99];
			Vehicle[car99][TemSom] = 1;
			Controle(playerid,1);
			SendClientMessage(playerid, COR_BRANCO, "Instalação concluída com sucesso!");
			SetCameraBehindPlayer(playerid);
			
	    }
	}
	if(!response)
	{
		DestroyDynamicObject(caixa[car99]);
		DestroyDynamicObject(caixa2[car99]);
		caixa[car99] = 0;
		caixa2[car99] = 0;
		DestroyDynamicObject(cxx[car99]);
		DestroyDynamicObject(cxx2[car99]);
		DestroyDynamicObject(cxx3[car99]);
		cxx[car99] = 0;
		cxx2[car99] = 0;
		cxx3[car99] = 0;
		CxY[car99] = -2.710014;
		CxX[car99] = 0.000000;
		CxZ[car99] = 0.135000;
		CxxX[car99] = -0.539999;
		CxxY[car99] = -2.490009;
		CxxZ[car99] = 0.339999;
		CxxX2[car99] = 0.574999;
		CxxY2[car99] = -2.490009;
		CxxZ2[car99] = 0.339999;
		CxxX3[car99] = 0.024999;
		CxxY3[car99] = -2.490009;
		CxxZ3[car99] = 0.339999;
		Vehicle[car99][CxXC] = 0;
		Vehicle[car99][CxYC] = 0;
		Vehicle[car99][CxZC] = 0;
		Controle(playerid,1);
		SendClientMessage(playerid, COR_BRANCO, "Ok, você não quis finalizar a instalação.");
		SetCameraBehindPlayer(playerid);
		
	}
	return 1;
}

Dialog:SOMDIALOG3(playerid, response, listitem, inputtext[])
{
	new car99;
	car99 = GetPlayerVehicleID(playerid);
	if(response)
	{

		if(listitem == 0)
		{
			if(CxxY[car99] > -0.890009)
			{
				SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, SOMDIALOG3, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
				return true;
			}
			new Float:Resultado,Float:Resultado2,Float:Resultado3;
			Resultado = CxxY[car99] + 0.1;
			Resultado2 = CxxY2[car99] + 0.1;
			Resultado3 = CxxY3[car99] + 0.1;
			AttachDynamicObjectToVehicle(cxx[car99], car99, CxxX[car99], Resultado, CxxZ[car99], CxRZ[car99], 0.000000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(cxx2[car99], car99, CxxX2[car99], Resultado2, CxxZ2[car99], CxRZ[car99], 0.000000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(cxx3[car99], car99, CxxX3[car99], Resultado3, CxxZ3[car99], CxRZ[car99], 0.000000, 0.000000); //Object Model: 2232 |
			SendClientMessage(playerid, COR_BRANCO, "Ajuste feito.");
			Dialog_Show(playerid, SOMDIALOG3, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			CxxY[car99] = Resultado;
			CxxY2[car99] = Resultado2;
			CxxY3[car99] = Resultado3;
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
		}
		if(listitem == 1)//Para Trás
		{
		    if(CxxY[car99] < -3.010014)
		    {
		    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, SOMDIALOG3, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
		    	return true;
			}
		    new Float:Resultado,Float:Resultado2,Float:Resultado3;
		    Resultado = CxxY[car99] - 0.1;
		    Resultado2 = CxxY2[car99] - 0.1;
		    Resultado3 = CxxY3[car99] - 0.1;
		  	AttachDynamicObjectToVehicle(cxx[car99], car99, CxxX[car99], Resultado, CxxZ[car99], CxRZ[car99], 0.000000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(cxx2[car99], car99, CxxX2[car99], Resultado2, CxxZ2[car99], CxRZ[car99], 0.000000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(cxx3[car99], car99, CxxX3[car99], Resultado3, CxxZ3[car99], CxRZ[car99], 0.000000, 0.000000); //Object Model: 2232 |
			SendClientMessage(playerid, COR_BRANCO, "Ajuste feito.");
			Dialog_Show(playerid, SOMDIALOG3, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			CxxY[car99] = Resultado;
			CxxY2[car99] = Resultado2;
			CxxY3[car99] = Resultado3;
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
	    }
	    if(listitem == 2)//Cima
		{
		    if(CxxZ[car99] > 0.8)
		    {
		    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, SOMDIALOG3, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
		    	return true;
			}
		    new Float:Resultado,Float:Resultado2,Float:Resultado3;
		    Resultado = CxxZ[car99] + 0.1;
		    Resultado2 = CxxZ2[car99] + 0.1;
		    Resultado3 = CxxZ3[car99] + 0.1;
		  	AttachDynamicObjectToVehicle(cxx[car99], car99, CxxX[car99], CxxY[car99], Resultado, CxRZ[car99], 0.000000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(cxx2[car99], car99, CxxX2[car99], CxxY[car99], Resultado2, CxRZ[car99], 0.000000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(cxx3[car99], car99, CxxX3[car99], CxxY[car99], Resultado3, CxRZ[car99], 0.000000, 0.000000); //Object Model: 2232 |
			SendClientMessage(playerid, COR_BRANCO, "Ajuste feito.");
			Dialog_Show(playerid, SOMDIALOG3, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			CxxZ[car99] = Resultado;
			CxxZ2[car99] = Resultado2;
			CxxZ3[car99] = Resultado3;
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
	    }
	    if(listitem == 3)//Baixo
		{
		    if(CxxZ[car99] < -0.335000)
		    {
		    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, SOMDIALOG3, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
		    	return true;
			}
		    new Float:Resultado,Float:Resultado2,Float:Resultado3;
		    Resultado = CxxZ[car99] - 0.1;
		    Resultado2 = CxxZ2[car99] - 0.1;
		    Resultado3 = CxxZ3[car99] - 0.1;
		  	AttachDynamicObjectToVehicle(cxx[car99], car99, CxxX[car99], CxxY[car99], Resultado, CxRZ[car99], 0.000000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(cxx2[car99], car99, CxxX2[car99], CxxY[car99], Resultado2, CxRZ[car99], 0.000000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(cxx3[car99], car99, CxxX3[car99], CxxY[car99], Resultado3, CxRZ[car99], 0.000000, 0.000000); //Object Model: 2232 |
			SendClientMessage(playerid, COR_BRANCO, "Ajuste feito.");
			Dialog_Show(playerid, SOMDIALOG3, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			CxxZ[car99] = Resultado;
			CxxZ2[car99] = Resultado2;
			CxxZ3[car99] = Resultado3;
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
	    }
	    if(listitem == 4)//girar para frente
		{
		    if(CxxZ[car99] < -0.335000)
		    {
		    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, SOMDIALOG3, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
		    	return true;
			}
		    new Float:Resultado;
		    Resultado = CxRZ[car99] - 2.0;
		  	AttachDynamicObjectToVehicle(cxx[car99], car99, CxxX[car99], CxxY[car99], CxxZ[car99], Resultado, 0.000000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(cxx2[car99], car99, CxxX2[car99], CxxY[car99], CxxZ2[car99], Resultado, 0.000000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(cxx3[car99], car99, CxxX3[car99], CxxY[car99], CxxZ3[car99], Resultado, 0.000000, 0.000000); //Object Model: 2232 |
			SendClientMessage(playerid, COR_BRANCO, "Ajuste feito.");
			Dialog_Show(playerid, SOMDIALOG3, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			CxRZ[car99] = Resultado;
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
	    }
	    if(listitem == 5)//girar para trás
		{
		    if(CxxZ[car99] < -0.335000)
		    {
		    	SendClientMessage(playerid, COR_BRANCO, "Limite de posicionamento da caixa atingido.");
				Dialog_Show(playerid, SOMDIALOG3, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
		    	return true;
			}
		    new Float:Resultado;
		    Resultado = CxRZ[car99] + 2.0;
		  	AttachDynamicObjectToVehicle(cxx[car99], car99, CxxX[car99], CxxY[car99], CxxZ[car99], Resultado, 0.000000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(cxx2[car99], car99, CxxX2[car99], CxxY[car99], CxxZ2[car99], Resultado, 0.000000, 0.000000); //Object Model: 2232 |
			AttachDynamicObjectToVehicle(cxx3[car99], car99, CxxX3[car99], CxxY[car99], CxxZ3[car99], Resultado, 0.000000, 0.000000); //Object Model: 2232 |
			SendClientMessage(playerid, COR_BRANCO, "Ajuste feito.");
			Dialog_Show(playerid, SOMDIALOG3, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
			CxRZ[car99] = Resultado;
			SetPlayerCameraPos(playerid, 1873.0994,-1851.5099,14.7042);
			SetPlayerCameraLookAt(playerid, 1869.8363,-1844.8060,14.4880);
	    }
	    if(listitem == 6)//Concluiu
		{
			Vehicle[car99][CxxXC] = CxxX[car99];
		 	Vehicle[car99][CxxYC] = CxxY[car99];
			Vehicle[car99][CxxZC] = CxxZ[car99];
			Vehicle[car99][CxxX2C] = CxxX2[car99];
		 	Vehicle[car99][CxxY2C] = CxxY2[car99];
			Vehicle[car99][CxxZ2C] = CxxZ2[car99];
			Vehicle[car99][CxxX3C] = CxxX3[car99];
		 	Vehicle[car99][CxxY3C] = CxxY3[car99];
			Vehicle[car99][CxxZ3C] = CxxZ3[car99];
			Vehicle[car99][CxRXX] = CxRZ[car99];
			Vehicle[car99][TemTrio] = 1;
			Controle(playerid,1);
			SendClientMessage(playerid, COR_BRANCO, "Instalação concluída com sucesso!");
			SetCameraBehindPlayer(playerid);
			
	    }
	}
	if(!response)
	{
		DestroyDynamicObject(caixa[car99]);
		DestroyDynamicObject(caixa2[car99]);
		caixa[car99] = 0;
		caixa2[car99] = 0;
		DestroyDynamicObject(cxx[car99]);
		DestroyDynamicObject(cxx2[car99]);
		DestroyDynamicObject(cxx3[car99]);
		cxx[car99] = 0;
		cxx2[car99] = 0;
		cxx3[car99] = 0;
		CxY[car99] = -2.710014;
		CxX[car99] = 0.000000;
		CxZ[car99] = 0.135000;
		CxxX[car99] = -0.539999;
		CxxY[car99] = -2.490009;
		CxxZ[car99] = 0.339999;
		CxxX2[car99] = 0.574999;
		CxxY2[car99] = -2.490009;
		CxxZ2[car99] = 0.339999;
		CxxX3[car99] = 0.024999;
		CxxY3[car99] = -2.490009;
		CxxZ3[car99] = 0.339999;
		Vehicle[car99][CxXC] = 0;
		Vehicle[car99][CxYC] = 0;
		Vehicle[car99][CxZC] = 0;
		Controle(playerid,1);
		SendClientMessage(playerid, COR_BRANCO, "Ok, você não quis finalizar a instalação.");
		SetCameraBehindPlayer(playerid);
		
	}
	return 1;
}

/*
*
*
*			CALLBACKS
*
*
*/

forward InstSom(playerid);
public InstSom(playerid)
{
	Dialog_Show(playerid, SOMDIALOG2, DIALOG_STYLE_LIST, "Mover Caixa:", "Para Esquerda\nPara Direita\nPara Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
	return 1;
}
forward InstSom2(playerid);
public InstSom2(playerid)
{
	Dialog_Show(playerid, SOMDIALOG3, DIALOG_STYLE_LIST, "Mover Trio:", "Para Frente\nPara Trás\nPara Cima\nPara Baixo\nRotacionar Para Frente\nRotacionar Para Trás\nFinalizar Instalação", "Ok", "Cancelar");
	return 1;
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

	RemovePlayerAttachedObject(playerid, Vaga_Radio);
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

destroySound(id){

	if(SomInfo[id][somCreated]){

	    SomInfo[id][somCreated] = false;

	    DestroyDynamicObject(SomInfo[id][somObject]);
	    DestroyDynamic3DTextLabel(SomInfo[id][somText]);
	    SomInfo[id][somID] = 999;

	    foreach(Player, i){

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

stock PutSound(vehicleid)
{
    if(GetVehicleModel(vehicleid) == 535)
   	{
		Sound1[vehicleid] = CreateObject(2232, 0.0, 0.0, 0.0,0.0, 0.0, 96.0);
		Sound2[vehicleid] = CreateObject(2232, 0.0, 0.0, 0.0,0.0, 0.0, 96.0);
		Sound3[vehicleid] = CreateObject(2229, 0.0, 0.0, 0.0,0.0, 0.0, 96.0);
		Sound4[vehicleid] = CreateObject(2229, 0.0, 0.0, 0.0,0.0, 0.0, 96.0);
   	    AttachObjectToVehicle(Sound1[vehicleid], vehicleid, -0.564999, -2.024998, 0.989999, 0.000000, 0.000000, 0.000000); //Object Model: 2232 |
		AttachObjectToVehicle(Sound2[vehicleid], vehicleid, 0.594999, -2.024998, 0.989999, 0.000000, 0.000000, 0.000000); //Object Model: 2232 |
		AttachObjectToVehicle(Sound3[vehicleid], vehicleid, -0.454999, -1.774998, 1.469998, -0.000000, 90.047943, 0.000000); //Object Model: 2229 |
		AttachObjectToVehicle(Sound4[vehicleid], vehicleid, 0.509999, -1.774998, 2.085000, -0.000000, -90.034461, 0.000000); //Object Model: 2229 |
		Vehicle[vehicleid][SoundCar] = 1086;
   	}
}

stock RemoveSound(vehicleid)
{
    if(Vehicle[vehicleid][SoundCar] == 1086)
   	{
		DestroyObject(Sound1[vehicleid]);
		DestroyObject(Sound2[vehicleid]);
		DestroyObject(Sound3[vehicleid]);
		DestroyObject(Sound4[vehicleid]);
		Vehicle[vehicleid][SoundCar] = 0;
	}
}

CMD:testesound(playerid)
{
	new car = GetPlayerVehicleID(playerid);
	PutSound(car);
	Vehicle[car][SoundCar] = 1086;

	return 1;
}

CMD:tirarsound(playerid)
{
	new car = GetPlayerVehicleID(playerid);
	RemoveSound(car);
	return 1;
}


CMD:instalarsom(playerid)
{
	new vehicle = GetPlayerVehicleID(playerid);

	if(IsABike(vehicle) || IsAMotorBike(vehicle))
	{
		SendClientMessage(playerid, COR_ERRO, "Erro: Você não pode instalar som neste veículo, utilize um carro.");
		return 1;
	}

	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "Erro: Você precisa de um veículo.");

	if ( !Iter_Contains(VehiclePlayers, vehicle) )
		return SendClientMessage(playerid, COR_ERRO, "Erro: Este veículo não é seu.");

	if(!PlayerToPoint(playerid, 5.0, 1569.3622,-2154.4934,14.1216))
		return SendClientMessage(playerid, COR_ERRO, "Erro: Você não está na oficina.");

	Dialog_Show(playerid, SOMDIALOG, DIALOG_STYLE_LIST, "Som Automotivo", "Instalar Som\nRemover Som", "Ok", "Cancelar");

	return 1;
}