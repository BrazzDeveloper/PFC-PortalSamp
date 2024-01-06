
const 
	TEMPO_ESPERA = 5;

enum e_TUTORIAL_INFO
{
	Float:CamPosX,
	Float:CamPosY,
	Float:CamPosZ,
	Float:CamLookX,
	Float:CamLookY,
	Float:CamLookZ,
	Title[30],
	Message[418]
}

static Tutorial[][e_TUTORIAL_INFO] = 
{
	{1407.4421, -1629.7271, 67.2921, 1408.3588, -1630.1249, 66.8861, "PERFECT CITY RPG", "~w~Bem vindo ao servidor ~b~~h~~h~Perfect City~w~.~n~Neste breve tutorial mostraremos alguns locais importantes do servidor e também algumas informacões.~n~Você pode ler as mensagens calmamente, e ao término de sua leitura você pode apertar a tecla '~b~~h~~h~F~w~' ou '~b~~h~~h~ENTER~w~' para acontinuar."},
	{1454.8655, -1718.8129, 35.9339, 1455.4818, -1719.5978, 35.6389, "PREFEITURA", "~w~Aqui é a Prefeitura, local onde você poderá vir para pagar os impostos de sua empresa e de sua casa."},
	{1525.8845, -1691.6125, 22.1532, 1526.6665, -1690.9900, 21.8932, "DEPARTAMENTO DE POLICIA", "~w~Existem vários Departamentos de Polícia espalhados por toda San Andreas.~n~Nos Departamento de Polícia você poderá limpar sua ficha por uma certa quantia.~n~Pagar fiancas de algum preso entre outras coisas."},
	{1340.6238, -1736.4128, 21.9792, 1341.0889, -1737.2966, 21.5543, "LOJA DE UTILITARIOS","~w~Na Loja de Utilitários você poderá comprar alguns produtos essências em sua vida ingame.~n~Aqui você poderá comprar ~b~~h~~h~celular~w~, ~b~~h~~h~créditos para celular~w~, ~b~~h~~h~GPS~w~ entre outras opcões.~n~Volte aqui para ver todas as opcões disponíveis."},
	//{1294.4597, -1845.1277, 19.1245, 1294.5708, -1846.1208, 18.8946, "DETRAN", "~w~Esse é o nosso Detran, você deverá vir até aqui para tirar sua habilitacão.~n~Em nosso servidor temos 5 categorias, que são elas: ~b~~h~~h~Moto~w~, ~b~~h~~h~Carro~w~, ~b~~h~~h~Caminhão~w~, ~b~~h~~h~Barco~w~ e ~b~~h~~h~Aviões~w~.~n~Você poderá dirigir veículos sem habilitacão até o level 5, após isso, você deverá fazer o teste para poder dirigir os veículos."},
	{1674.7736, -1298.5323, 32.0070, 1675.9650,-1327.8551,17.4435, "DETRAN", "~w~Esse é o nosso Detran, você deverá vir até aqui para tirar sua habilitacão.~n~Em nosso servidor temos 5 categorias, que são elas: ~b~~h~~h~Moto~w~, ~b~~h~~h~Carro~w~, ~b~~h~~h~Caminhão~w~, ~b~~h~~h~Barco~w~ e ~b~~h~~h~Aviões~w~.~n~Você poderá dirigir veículos sem habilitacão até o level 5, após isso, você deverá fazer o teste para poder dirigir os veículos."},
	//{1317.6483, -1396.6342, 22.9563, 1317.4347, -1395.6572, 22.6364, "AGÊNCIA DE EMPREGOS", "~w~Aqui na Agência de Empregos você encontra diversas profissões, separadas por categorias.~n~Escolha o modo que seu personagem irá viver, trabalhando ~b~~h~~h~honestamente~w~ ou ~r~~h~~h~praticando delitos~w~.~n~Fique a vontade para escolher."},
	{1237.9401, -1824.7944, 19.9526, 1223.3506,-1815.6993,16.5938, "AGÊNCIA DE EMPREGOS", "~w~Aqui na Agência de Empregos você encontra diversas profissões, separadas por categorias.~n~Escolha o modo que seu personagem irá viver, trabalhando ~b~~h~~h~honestamente~w~ ou ~r~~h~~h~praticando delitos~w~.~n~Fique a vontade para escolher."},
	{1202.7136, -1314.0977, 26.7826, 1201.8319, -1314.5669, 26.3526, "HOSPITAL", "~w~Quando seu personagem morrer, o mesmo será levado ao hospital mais próximo.~n~Se você é um assinante do plano de saúde então os custos do tratamento será pago pelo seu plano caso não seja, então serão cobrado ~g~~h~R$500~w~ a cada vez que morrer.~n~Vale lembrar que em nosso servidor a morte do personagem são um pouco diferentes.~n~Mas isso você vai descobrir jogando."},
	//{615.9816, -1214.2809, 30.3821, 615.4282, -1215.1113, 30.1521, "BANCO", "~w~Esse é um de nossos Bancos.~n~Existem Bancos nos quatro cantos de San Andreas, e existem também caixas eletrônicos espalhados por todo o estado de SA.~n~Nos Bancos você poderá ver seu saldo, depositar seu dinheiro ou sacar, fazer transferencias e ver seu extrato.~n~Mas não se esqueca de que antes você terá que criar sua conta bancária."},
	{1155.9779,-1741.5118,35.7283, 1154.6678,-1768.4678,16.6038, "BANCO", "~w~Esse é um de nossos Bancos.~n~Existem Bancos nos quatro cantos de San Andreas, e existem também caixas eletrônicos espalhados por todo o estado de SA.~n~Nos Bancos você poderá ver seu saldo, depositar seu dinheiro ou sacar, fazer transferencias e ver seu extrato.~n~Mas não se esqueca de que antes você terá que criar sua conta bancária."},
	{509.5040, -1340.2629, 26.5582, 509.0518, -1341.1536, 26.2132, "LOJA DE ROUPAS", "~w~Essa é uma das lojas de roupas que temos no nosso servidor.~n~Venha aqui se quiser trocar a roupa (skin) de seu personagem.~n~Existem outras lojas de roupas espalhadas pelo mapa, e cada loja tem diferentes estilos de roupas."},
	{2122.2488, -1106.2197, 36.6551, 2122.4932, -1107.1895, 36.3897, "CONCESSIONARIA", "~w~Quem nunca sonhou em ter um carro?~n~Em Nosso servidor você poderá ter até 2 se quiser.~n~Assim que tiver uma graninha sobrando é só vir até essa concessionária para comprar seu veiculo.~n~Há quase esqueco de avisar, temos outras concessionárias espalhadas por San Andreas.~n~Cada uma com seu estilo de veículos."},
	{1682.6057,-2337.3450,30.9513, 1683.9274,-2247.9771,13.5496, "BEM VINDO!", "~w~Então é isso! Agora você está preparado para comecar sua vida virtual em nosso servidor.~n~A Qualquer momento no jogo você poderá utilizar os comandos ~b~~h~~h~/regras~w~, e ~b~~h~~h~/ajuda~w~ para lhe auxiliar ingame.~n~Se os comandos não lhe ajudar, você poderá procurar ajuda em nosso fórum no link ~b~~h~~h~www.perfectcityrpg.com.br/forum~w~.~n~~n~~p~Nossa equipe lhe deseja um ótimo jogo!"}
};
static TempoTuto[MAX_PLAYERS];


function TUTO::InitPlayerTutorial(playerid)
{
	call::TD->ShowPlayerTutorial(playerid);
	SetPVarInt(playerid, "tutorialID", 1);
	call::TD->UpdateTextDrawTutorial(playerid, Tutorial[0][Title], Tutorial[0][Message]);

	InterpolateCameraPos(playerid, 1511.9138, -1277.6725, 396.8169, Tutorial[0][CamPosX], Tutorial[0][CamPosY], Tutorial[0][CamPosZ], 10000);
	InterpolateCameraLookAt(playerid, 1511.9011, -1278.6710, 395.8460, Tutorial[0][CamLookX], Tutorial[0][CamLookY], Tutorial[0][CamLookZ], 9000);

	TempoTuto[playerid] = gettime() + TEMPO_ESPERA + 10;
	TempoInativo[playerid] = gettime() + (60 * 15);

	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{"COR_VERMELHO_INC"}IMPORTANTE", "{"COR_BRANCO_INC"}Você perceberá que algumas coisas podem está escritas erradas.\nNa verdade não é bem erradas.\nOque acontece é que em TextDraws alguns caracteres não são aceitos.\nEntão por favor releve hehehe!!!", "OK", "");
	return true;
}

#include <YSI_Coding\y_hooks>
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!call::PLAYER->IsPlayerLogged(playerid))
	{
		if(PRESSED(KEY_SECONDARY_ATTACK))
		{
			if(TempoTuto[playerid] > gettime())
				return GameTextForPlayer(playerid, "~r~Aguarde um momento...", 2000, 4);

			new tutoid = GetPVarInt(playerid, "tutorialID");
			if(tutoid >= sizeof(Tutorial)) // Termino do tutorial.
			{
				call::TD->DestroyPlayerTutorial(playerid); // destruir as textdraws para o player.
				TogglePlayerSpectating(playerid, false);
				DeletePVar(playerid, "tutorialID");

				new query[80];
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `tutorial`='1' WHERE `id`='%d'", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
				mysql_tquery(getConexao(), query);
				return true;
			}

			call::TD->UpdateTextDrawTutorial(playerid, Tutorial[tutoid][Title], Tutorial[tutoid][Message]);
			
			/*
			InterpolateCameraPos(playerid, Tutorial[tutoid-1][CamPosX], Tutorial[tutoid-1][CamPosY], Tutorial[tutoid-1][CamPosZ], Tutorial[tutoid][CamPosX], Tutorial[tutoid][CamPosY], Tutorial[tutoid][CamPosZ], 10000);
			InterpolateCameraLookAt(playerid, Tutorial[tutoid-1][CamLookX], Tutorial[tutoid-1][CamLookY], Tutorial[tutoid-1][CamLookZ], Tutorial[tutoid][CamLookX], Tutorial[tutoid][CamLookY], Tutorial[tutoid][CamLookZ], 9000);
			*/

			SetPlayerCameraPos(playerid, Tutorial[tutoid][CamPosX], Tutorial[tutoid][CamPosY], Tutorial[tutoid][CamPosZ]);
			SetPlayerCameraLookAt(playerid, Tutorial[tutoid][CamLookX], Tutorial[tutoid][CamLookY], Tutorial[tutoid][CamLookZ]);

			TempoTuto[playerid] = gettime() + TEMPO_ESPERA;
			SetPVarInt(playerid, "tutorialID", tutoid + 1);
			return true;
		}
	}
	return false;
}