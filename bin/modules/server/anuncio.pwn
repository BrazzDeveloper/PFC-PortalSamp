
// ============================== [ FORWARDs ] ============================== //
forward InitAnnouceSystem();
forward OnAnnounceCalled();


// ============================== [ VARIÁVEIS ] ============================== //

//static NumAnnounce, old;

// ============================== [ PUBLICs ] ============================== //
#include <YSI_Coding\y_hooks>
hook OnGameModeInit()
{
	SetTimer("SendMSG", 150000, true);
	//InitAnnouceSystem();
}

new RandomMSG[][] = {
    "| SERVIDOR | {"COR_LARANJA_INC"}Para melhor comunicação, use nosso Discord: {ffffff}discord.gg/rwUbARa4g9",
	"| SERVIDOR | {"COR_LARANJA_INC"}Seja bem-vindo(a) ao nosso servidor!",
	"| SERVIDOR | {"COR_LARANJA_INC"}Está necessitando de ajuda? Chame um Administrador usando {ffffff}/Duvida",
	"| SERVIDOR | {"COR_LARANJA_INC"}Abra sua conta bancária em um dos Bancos de San Andreas!",
	"| SERVIDOR | {"COR_LARANJA_INC"}Há jogadores(as) descumprindo as regras? Use {ffffff}/Relatorio [ID] [Motivo]",
	"| SERVIDOR | {"COR_LARANJA_INC"}Fórum do servidor: {ffffff}www.perfectcityrpg.com.br/forum",
	"| SERVIDOR | {"COR_LARANJA_INC"}Nos ajude a corrigir os bugs do servidor e seja recompensado por isso!",
	"| SERVIDOR | {"COR_LARANJA_INC"}Seja VIP em nosso servidor! Você assim ajuda a manter, e ainda tem benefícios exclusivos! {ffffff}/Ajuda Contato",
	"| SERVIDOR | {"COR_LARANJA_INC"}Para ver os comandos do servidor, use {ffffff}/Ajuda Geral",
	"| SERVIDOR | {"COR_LARANJA_INC"}Curta, comente e compartilhe nossa página do Facebook!",
	"| SERVIDOR | {"COR_LARANJA_INC"}Nossa administração está disponível para lhe ajudar na sua jornada!",
	"| SERVIDOR | {"COR_LARANJA_INC"}Inscreva-se em nosso canal do YouTube: {ffffff}youtube.perfectcityrpg.com.br",
	"| SERVIDOR | {"COR_LARANJA_INC"}Não há administradores online? Peça suporte em nosso Discord! {ffffff}/Ajuda Contato",
	"| SERVIDOR | {"COR_LARANJA_INC"}Adicione nosso IP aos favoritos ( {ffffff}51.222.86.84:7777 {"COR_LARANJA_INC"})",
	"| SERVIDOR | {"COR_LARANJA_INC"}Você tem uma sugestão para o servidor? Descreva para nós no Discord",
	"| SERVIDOR | {"COR_LARANJA_INC"}Perfect City RPG -  Beta",
	"| SERVIDOR | {"COR_LARANJA_INC"}Não divulgue o nosso servidor em outros servidores! Use outros métodos: vídeos, redes sociais, etc...",
	"| SERVIDOR | {"COR_LARANJA_INC"}Deixe sugestões, reclamações, denúncias, entre outros em nosso fórum! {ffffff}/Ajuda Contato",
	"| SERVIDOR | {"COR_LARANJA_INC"}Veja os jogadores mais TOPs do jogo usando o comando {ffffff}/Tops"
};

forward SendMSG();
public SendMSG() {
	new randMSG = random(sizeof(RandomMSG));
	SendClientMessageToAll(-1, RandomMSG[randMSG]);
}

/*public InitAnnouceSystem()
{
	new query[128];

	new Cache:cache = mysql_query(getConexao(), "SELECT * FROM "TABLE_ANNOUNCE";", true);
	NumAnnounce = cache_num_rows();
	cache_delete(cache);

	++old;
	
	if(old > NumAnnounce)
		old = 1;

	mysql_format(getConexao(), query, sizeof(query), "SELECT * FROM "TABLE_ANNOUNCE" WHERE `id`='%d' LIMIT 1;", old);
	mysql_tquery(getConexao(), query, "OnAnnounceCalled");
	return true;
}

public OnAnnounceCalled()
{
	if(cache_num_rows())
	{
		new cor = -1, announce[130];
		cache_get_value_name(0, "texto", announce, sizeof(announce));
		cache_get_value_name_int(0, "cor", cor);

		SendClientMessageToAll(COR_BRANCO, "| SERVIDOR | {%s}%s", cor, announce);
	}
	SetTimer("InitAnnouceSystem", (5 * (60 * 1000)), false);
	return true;
}*/