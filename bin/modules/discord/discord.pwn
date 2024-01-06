
#include <YSI_Coding\y_hooks>

// Vars | Guilds
new DCC_Guild:g_GuildPFC;

// Vars | Roles
new DCC_Role:g_RoleDev;
new DCC_Role:g_RoleDiretorGeral;
new DCC_Role:g_RoleDiretor;
new DCC_Role:g_RoleAdmin;
new DCC_Role:g_RoleMod;
new DCC_Role:g_RoleAjudante;

// Vars | Chanells
new DCC_Channel:g_ChannelCommands;
new DCC_Channel:g_Discord_Chat; 
new DCC_Channel:g_Log_Cmds_Chat;
new DCC_Channel:g_ChangeLog_Chat;
new DCC_Channel:g_Registro_Chat;
new DCC_Channel:g_Sincro_Chat;
new DCC_Channel:g_Links_Chat;
new DCC_Channel:g_Regras_Chat;

hook OnGameModeInit()
{
    // Guilds
    g_GuildPFC = DCC_FindGuildById("801468152135417867");

    // Channels
    g_Discord_Chat = DCC_FindChannelById("801468153359499314");
    g_ChangeLog_Chat = DCC_FindChannelById("822816999255572540");
    g_Log_Cmds_Chat = DCC_FindChannelById("801468152675696670");
    g_Registro_Chat = DCC_FindChannelById("801468152675696678");
    g_Sincro_Chat = DCC_FindChannelById("801468152675696679");
    g_Links_Chat = DCC_FindChannelById("801468153041256452");
    g_Regras_Chat = DCC_FindChannelById("801468153041256455");
    g_ChannelCommands = DCC_FindChannelById("822060963716530186");

    // Roles
    g_RoleDev = DCC_FindRoleById("801468152244207627"); 
    g_RoleDiretorGeral = DCC_FindRoleById("830538820646207518"); 
    g_RoleDiretor = DCC_FindRoleById("801468152244207626");
    g_RoleAdmin = DCC_FindRoleById("801468152135417875");
    g_RoleMod = DCC_FindRoleById("801468152135417874");
    g_RoleAjudante = DCC_FindRoleById("801468152135417873");

    DCC_SetBotActivity("Perfect City RPG");

    return 1;
}

// Stocks

bool:IsUserDev(DCC_User:userid)
{
    new bool:l_HasRole;
    DCC_HasGuildMemberRole(g_GuildPFC, userid, g_RoleDev, l_HasRole);
    return l_HasRole;
}

bool:IsUserDiretorGeral(DCC_User:userid)
{
    new bool:l_HasRole;
    DCC_HasGuildMemberRole(g_GuildPFC, userid, g_RoleDiretorGeral, l_HasRole);
    return l_HasRole;
}

bool:IsUserDiretor(DCC_User:userid)
{
    new bool:l_HasRole;
    DCC_HasGuildMemberRole(g_GuildPFC, userid, g_RoleDiretor, l_HasRole);
    return l_HasRole;
}

bool:IsUserAdmin(DCC_User:userid)
{
    new bool:l_HasRole;
    DCC_HasGuildMemberRole(g_GuildPFC, userid, g_RoleAdmin, l_HasRole);
    return l_HasRole;
}

bool:IsUserMod(DCC_User:userid)
{
    new bool:l_HasRole;
    DCC_HasGuildMemberRole(g_GuildPFC, userid, g_RoleMod, l_HasRole);
    return l_HasRole;
}

bool:IsUserAjudante(DCC_User:userid)
{
    new bool:l_HasRole;
    DCC_HasGuildMemberRole(g_GuildPFC, userid, g_RoleAjudante, l_HasRole);
    return l_HasRole;
}

public OnDiscordCommandPerformed(const params[], success, DCC_Message:message)
{
    new DCC_Channel:l_Channel, DCC_User:l_User, DCC_Embed:l_Embed, l_UserID[20 + 1];

    DCC_GetMessageAuthor(message, l_User);
    DCC_GetUserId(l_User, l_UserID, sizeof(l_UserID));
    DCC_GetMessageChannel(message, l_Channel);

    new String[560];
    if(l_Channel != g_ChannelCommands && !IsUserDev(l_User) && !IsUserDiretorGeral(l_User) && !IsUserDiretor(l_User) && !IsUserAdmin(l_User) && !IsUserMod(l_User) && !IsUserAjudante(l_User))
    {
        format(String, sizeof(String), "<@%s> | Use comandos apenas no canal <#822060963716530186>!", l_UserID);
        l_Embed = DCC_CreateEmbed();
        DCC_SetEmbedColor(l_Embed, 0x833cec);
        DCC_SetEmbedDescription(l_Embed, String);
        DCC_SendChannelEmbedMessage(l_Channel, l_Embed);
        return 1;
    }

    if(!success)
    {
        format(String, sizeof(String), "<@%s> | Comando inexistente, use $help .", l_UserID);
        l_Embed = DCC_CreateEmbed();
        DCC_SetEmbedColor(l_Embed, 0x833cec);
        DCC_SetEmbedDescription(l_Embed, String);
        DCC_SendChannelEmbedMessage(l_Channel, l_Embed);
        return 1;
    }
    return 1;
}

#define stringclear(%0) \
    %0[0] = '\0'

enum DiscordJogador{
    Codigo[70],
    DiscordPlayer[70]
};
new pDiscord[MAX_PLAYERS][DiscordJogador];
new escpass[128];
new escpassnome[128];

/*hook OnPlayerSpawn(playerid)
{
    if ( Jogador[playerid][Logado] == false )
    {       
        new dcentro[128];
        format(dcentro, sizeof dcentro, " ```%s Entrou no servidor.```", GetUserName(playerid));
        DCC_SendChannelMessage(g_Discord_Chat, dcentro);
        return Y_HOOKS_CONTINUE_RETURN_1;
    }

    //DCC_FindRoleById(802719850489315339);
    return 1;
}


hook OnPlayerDisconnect(playerid, reason){
    new Limpar[DiscordJogador];
    pDiscord[playerid] = Limpar;

    new dcsaiu[128];
    format(dcsaiu, sizeof dcsaiu, " ```%s Saiu do servidor.```", GetUserName(playerid));
    DCC_SendChannelMessage(g_Discord_Chat, dcsaiu);
    return 1;
}*/

Dialog:DiscordSincronizacao(playerid, response, listitem, inputtext[]){
    if(!response) return 1;
    if(isnull(inputtext)) return 1;
    new Cache:Conectar, DCC_User:Usuario, userId[DCC_ID_SIZE], bool:Bot, Enviar[128];

    DCC_IsUserBot(Usuario, Bot);
    Usuario = DCC_FindUserById(inputtext);

    if(!DCC_GetUserId(Usuario, userId)) return SendClientMessage(playerid, COR_ERRO, "* Esse discord está inválido!");
    if(!DCC_FindUserById(inputtext)) return SendClientMessage(playerid, COR_ERRO, "* Usuário(a) não encontrado(a)!");
    if(Bot) return SendClientMessage(playerid, COR_ERRO, "* Você não pode sincronizar um bot!");

    mysql_escape_string(inputtext, escpass);
    format(Enviar, sizeof(Enviar), "SELECT * FROM `usuarios` WHERE `discord` = '%s'", escpass);
    Conectar = mysql_query(getConexao(), Enviar);
    if(mysql_errno(getConexao()) != 0) return SendClientMessage(playerid, COR_ERRO, "* Ocorreu um erro ao válidar sua ação, entre em contato com um adminitrador!");
    if(cache_num_rows() > 0){
        SendClientMessage(playerid, COR_ERRO, "* Esse discord já foi sincronizado por outro usuário!");
        cache_delete(Conectar);
        return 1;
    }
    cache_delete(Conectar);

    foreach(new i: Player) {
        if(IsPlayerConnected(i)){
            if(Jogador[i][Logado] == true){
                if(!isnull(pDiscord[i][DiscordPlayer])){
                    if(!strcmp(pDiscord[i][DiscordPlayer], inputtext, true)){
                        SendClientMessage(playerid, COR_ERRO, "* Outro usuário já está registrando esse discord");
                        return 1;
                    }
                }
            }
        }
    }

    format(pDiscord[playerid][Codigo], 70, GetRandomString(5));
    format(pDiscord[playerid][DiscordPlayer], 70, inputtext);
    format(Enviar, sizeof(Enviar), "| DISCORD | Vá até o privado do {00BFFF}BOT Betinho#1542 {ffffff}e envie esse código ( {00BFFF}%s{FFFFFF} )", pDiscord[playerid][Codigo]);
    SendClientMessage(playerid, -1, Enviar);
    return 0;
}

/*CMD:discord(playerid, params[]){
    if(GetPlayerScore(playerid) < 1) return SendClientMessage(playerid, COR_ERRO, "* Você precisa ter no minimo level 1"); 
    new Dialog[600];
    strcat(Dialog, "{FFFFFF}Coloque abaixo seu {FF0000}Discord ID\n\n\n");
    strcat(Dialog, "{FFFFFF}Como faço para pegar meu discord id?\n");
    strcat(Dialog, "{00BFFF}1. {FFFFFF}Vá nas configurações do seu discord\n");
    strcat(Dialog, "{00BFFF}2. {FFFFFF}Vá em {00BFFF}Aparência{FFFFFF} e {00BFFF}Habilite o Modo Desenvolvedor\n");
    strcat(Dialog, "{00BFFF}3. {FFFFFF}Vá no servidor do discord da {00BFFF}Perfect City RPG\n");
    strcat(Dialog, "{00BFFF}4. {FFFFFF}Clique com botão direito no seu perfil no discord da {00BFFF}Perfect City RPG\n");
    strcat(Dialog, "{00BFFF}5. {FFFFFF}Clique em Copiar ID\n\n");
    strcat(Dialog, "{FFFFFF}Caso necessite de ajuda, chame um dos nossos adminitradores através do {FF0000}/duvida\n");
    Dialog_Show(playerid, DiscordSincronizacao, DIALOG_STYLE_INPUT, "{FF0000}Discord", Dialog, "Confirmar", "Cancelar");
    return 1;
}*/

hook DCC_OnMessageCreate(DCC_Message:message)
{
    new DCC_User:Usuario,
        DCC_Channel:Canal,
        tipo, //Tipo da Sala (Privado etc..)
        Eu[DCC_ID_SIZE],
        mensagem[128],
        bool:bot
    ;

    //Informações da Mensagem
    if(!DCC_GetMessageAuthor(message, Usuario)) return 1; //Autor da Mensagem (ID)
    if(!DCC_GetMessageChannel(message, DCC_Channel:Canal)) return 1; //ID do canal
    if(!DCC_GetChannelType(Canal, DCC_ChannelType:tipo)) return 1; //Tipo da Mensagem
    if(!DCC_GetMessageContent(message, mensagem, sizeof(mensagem))) return 1;
    if(strlen(mensagem) < 5 || strlen(mensagem) > 5) return 1;
    if(!DCC_GetUserId(Usuario, Eu)) return 1;

    DCC_IsUserBot(Usuario, bot);
    if(bot) return 1;
    if(tipo != 1) return 1;  

    for(new i=0; i < MAX_PLAYERS; i++){
        if(IsPlayerConnected(i)){
            if(Jogador[i][Logado] == true){
                if(tipo == 1){
                    if(!strcmp(Jogador[i][Discord], "*")){
                        if(!isnull(mensagem) && !isnull(pDiscord[i][DiscordPlayer])){
                            if(!strcmp(pDiscord[i][DiscordPlayer], Eu)){
                                if(strcmp(mensagem, pDiscord[i][Codigo])) return SendClientMessage(i, COR_ERRO, "* Código informado no discord está inválido!");
                                new Enviar[228],
                                    Cache:Conectar,
                                    CanalID[DCC_ID_SIZE],
                                    DCC_Channel:TargetChannel,
                                    MensagemPrivado[200],
                                    DCC_Role:Tag,
                                    DCC_Guild:Servidor
                                ;
                                mysql_escape_string(pDiscord[i][DiscordPlayer], escpass);
                                mysql_escape_string(GetUserName(i), escpassnome);
                                format(Enviar, sizeof(Enviar), "UPDATE "TABLE_USERS" SET `discord` = '%s' WHERE `username` = '%s'", escpass, escpassnome);
                                Conectar = mysql_query(getConexao(), Enviar);
                                if(mysql_errno(getConexao()) != 0){
                                    SendClientMessage(i, COR_ERRO, "* Ocorreu um erro e sua sincronização foi cancelada!");
                                    SendClientMessage(i, COR_ERRO, "* Informe á um dos nossos administradores sobre esse problema!");
                                    //DelayDiscord = gettime()+10;
                                    return 0;
                                }
                                cache_delete(Conectar);
                                
                                //DelayDiscord = gettime()+95; //Delay de 1 minuto e meio para outro usuário sincronizar!

                                format(Jogador[i][Discord], 70, pDiscord[i][DiscordPlayer]); //Setando no Jogador
                                format(MensagemPrivado, sizeof(MensagemPrivado), "Olá **%s**, sua conta agora está sincronizada! Tenha um ótimo jogo!", GetUserName(i));
                                //Corrigindo e enviando mensagem no discord
                                utf8encode(MensagemPrivado, MensagemPrivado);
                                DCC_GetChannelId(DCC_Channel:Canal, CanalID);
                                TargetChannel = DCC_FindChannelById(CanalID);
                                DCC_SendChannelMessage(TargetChannel, MensagemPrivado);

                                //Colocar Tag Verificado(a)

                                new NickDiscord[70];
                                format(NickDiscord, sizeof(NickDiscord), "%s (%d)", GetUserName(i), random(3000));

                                Tag = DCC_FindRoleById("801468152135417870");
                                Servidor = DCC_FindGuildById("801468152135417867");
                                DCC_AddGuildMemberRole(Servidor, Usuario, Tag);
                                DCC_SetGuildMemberNickname(Servidor, Usuario, NickDiscord);

                                //Jogador[i][Dinheiro] += 2500;
                                SendClientMessage(i, -1, "| DISCORD | Sua conta foi sincronizada com sucesso!");

                                /*format(Enviar, sizeof(Enviar), "INSERT INTO `player_discord` (`user_id`, `username`, `id_discord`, `date`) VALUES ('%d', '%s', '%s', NOW())", Jogador[i][PlayerID], GetUserName(i), pDiscord[i][DiscordPlayer]); 
                                Conectar = mysql_query(getConexao(), Enviar);
                                if(mysql_errno(getConexao()) != 0) {
                                    SendClientMessage(i, COR_ERRO, "* Ocorreu uma falha ao salvar esses dados.");
                                    SendClientMessage(i, COR_ERRO, "* Consulte um desenvolvedor!");
                                    return 1;
                                }
                                cache_delete(Conectar);*/

                                //Limpando Funções
                                stringclear(pDiscord[i][Codigo]);
                                stringclear(pDiscord[i][DiscordPlayer]);
                                /*format(Enviar, sizeof(Enviar), "INSERT INTO `Recompensas` (`NomeAtual`, `nome`, `Recompensa`, `Data`) VALUES ('%s', '%s', 'Sincronização Discord + 2.500', '%d')", GetUserName(i), GetUserName(i), gettime());
                                Conectar = mysql_query(conexao, Enviar);
                                if(mysql_errno(conexao) != 0){
                                    SendClientMessage(i, COR_ERRO, "* Ocorreu uma falha ao salvar essa recompensa");
                                    SendClientMessage(i, COR_ERRO, "* Consulte um administrador no discord!");
                                    return 1;
                                }
                                cache_delete(Conectar);*/
                                return 1;
                            }
                            else{
                                if(!isnull(pDiscord[i][Codigo])){
                                    if(!strcmp(pDiscord[i][Codigo], mensagem)){
                                        SendClientMessage(i, COR_ERRO, "| AVISO | Uma conta do discord não autorizada tentou utilizar seu código!");
                                        return 1;     
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return 1;
}

// ============================ Comandos Discord ======================================== //
flags:changelog125(DEV);
CMD:changelog125(playerid, params[])
{
    new titulo[512], frase[1024], dcmsg[1024], footer[512], footermsg[512];

    format(footer, sizeof(footer), "Perfect City RPG © Todos os direitos reservados.");
    format(dcmsg, sizeof(dcmsg), "**Pescador:**\n\
    - Corrigido bug que não estava pagando\n\
    **Caminhoneiro:**\n\
    - Recriado toda profissão\n\
    * Todos os trailers tem várias entregas específicas\n\
    **Petroleiro:**\n\
    - Removido profissão\n\
    **VIP:**\n\
    - Recriado o comando /Tag mostrando cores pré-definidas e podendo escolher sua própria cor\n\
    **Geral**\n\
    - Removido sistema de Bater Ponto na maioria das profissões, deixando apenas na de Policia\n\
    - Alterado o Hud do servidor\n\
    - Corrigido mensagens de veículos públicos onde os acentos estavam bugando\n\
    - Corrigido frase de pegar mercadoria\n\
    - Corrigido sistema anti-afk\n\
    - Alterado o comando /Admins\n\
    - Adicionado lombadas pelo servidor\n\
    - Criado um sistema de atividades, deixando guardado todas as atividades que você faz\n\
    * Você poderá visualizar suas atividades no UCP quando disponível\n\n\
    Obrigado por nos escolher e tenha um ótimo jogo!");
    utf8encode(frase, dcmsg);
    utf8encode(footermsg, footer);
    utf8encode(titulo, " ");
    new DCC_Embed:embed = DCC_CreateEmbed("Versao: 1.2.5", frase);
    DCC_SetEmbedColour(embed, 0x833cec);
    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/g09Pkie.png");
    DCC_SetEmbedFooter(embed, footermsg, "https://i.imgur.com/g09Pkie.png");
    DCC_SendChannelEmbedMessage(g_ChangeLog_Chat, embed, titulo);
    return SendClientMessage(playerid, 0x08c731FF, "Você mandou uma mensagem no discord como Betinho!");
}

flags:changelog1241(DEV);
CMD:changelog1241(playerid, params[])
{
    new titulo[512], frase[1024], dcmsg[1024], footer[512], footermsg[512];

    format(footer, sizeof(footer), "Perfect City RPG © Todos os direitos reservados.");
    format(dcmsg, sizeof(dcmsg), "**Assaltante:**\n\
    - Adicionado um bloqueio para não assaltar o banco sem policiais no servidor\n\
    - Diminuido valor máximo de assalto\n\
    **Lenhador:**\n\
    - Corrigido problema de árvore não spawnar\n\
    - Adicionado o veículo 'Squad'\n\
    **Transportador de Valores:**\n\
    - Removido profissão da Agência até a versão 1.2.5\n\
    **Geral**\n\
    - Alterado o comando /Trabalhar para /Uniforme\n\
    - Alterado textos em algumas pickups do servidor\n\
    - Adicionado um bloqueio de 10 segundos ao servidor inicar\n\n\
    Obrigado por nos escolher e tenha um ótimo jogo!");
    utf8encode(frase, dcmsg);
    utf8encode(footermsg, footer);
    utf8encode(titulo, " ");
    new DCC_Embed:embed = DCC_CreateEmbed("Versao: 1.2.4.1", frase);
    DCC_SetEmbedColour(embed, 0x833cec);
    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/g09Pkie.png");
    DCC_SetEmbedFooter(embed, footermsg, "https://i.imgur.com/g09Pkie.png");
    DCC_SendChannelEmbedMessage(g_ChangeLog_Chat, embed, titulo);
    return SendClientMessage(playerid, 0x08c731FF, "Você mandou uma mensagem no discord como Betinho!");
}

flags:registromsg(DEV);
CMD:registromsg(playerid, params[])
{
    new titulo[512], frase[1024], dcmsg[1024], footer[512], footermsg[512];

    format(footer, sizeof(footer), "Perfect City RPG © Todos os direitos reservados.");
    format(dcmsg, sizeof(dcmsg), "Seja bem-vindo(a) ao Discord do nosso Servidor!\n\n\
    Clique no ícone :white_check_mark: para conseguir ter acesso a todas as salas disponíveis!\n\
    Por favor, leia as regras no canal #regras-discord para não cometer nenhuma infração e ser banido.\n\
    Nossas redes sociais, estão no canal #links\n\n\
    Obrigado por nos escolher e tenha um ótimo jogo!");
    utf8encode(frase, dcmsg);
    utf8encode(footermsg, footer);
    utf8encode(titulo, " ");
    new DCC_Embed:embed = DCC_CreateEmbed("Perfect City - RPG", frase);
    DCC_SetEmbedColour(embed, 0x833cec);
    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/g09Pkie.png");
    DCC_SetEmbedFooter(embed, footermsg, "https://i.imgur.com/g09Pkie.png");
    DCC_SendChannelEmbedMessage(g_Registro_Chat, embed, titulo);
    return SendClientMessage(playerid, 0x08c731FF, "Você mandou uma mensagem no discord como Betinho!");
}

/*flags:sincromsg(DIRECAO);
CMD:sincromsg(playerid, params[])
{
    new titulo[512], frase[1024], dcmsg[1024], footer[512], footermsg[512];

    format(footer, sizeof(footer), "Perfect City RPG © Todos os direitos reservados.");
    format(dcmsg, sizeof(dcmsg), "Ainda não sincronizou sua conta? \nSiga então os passos a seguir para sincronizar sua conta em nosso servidor.\n\n\
    **1º Passo** Entre em nosso servidor\n\
    **2º Passo** Digite /Discord\n\
    **3º Passo** Vá nas configurações do seu discord\n\
    **4º Passo** Vá em **Aparência** e Habilite o **Modo Desenvolvedor**\n\
    **5º Passo** Clique com botão direito no seu perfil\n\
    **6º Passo** Clique em **Copiar ID**\n\
    **7º Passo** Cole o ID no servidor\n\n\
    Agora basta seguir os passos que o servidor lhe fornecer\n\n\
    Obrigado por nos escolher e tenha um ótimo jogo!");
    utf8encode(frase, dcmsg);
    utf8encode(footermsg, footer);
    utf8encode(titulo, " ");
    new DCC_Embed:embed = DCC_CreateEmbed("Perfect City - RPG", frase);
    DCC_SetEmbedColour(embed, 0x833cec);
    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/g09Pkie.png");
    DCC_SetEmbedFooter(embed, footermsg, "https://i.imgur.com/g09Pkie.png");
    DCC_SendChannelEmbedMessage(g_Sincro_Chat, embed, titulo);
    return SendClientMessage(playerid, 0x08c731FF, "Você mandou uma mensagem no discord como Betinho!");
}*/
flags:sincromsg(DEV);
CMD:sincromsg(playerid, params[])
{
    new titulo[512], frase[1024], dcmsg[1024], footer[512], footermsg[512];

    format(footer, sizeof(footer), "Perfect City RPG © Todos os direitos reservados.");
    format(dcmsg, sizeof(dcmsg), "Sistema de sincronização de contas temporariamente desativado.\n\n\
    Obrigado por nos escolher e tenha um ótimo jogo!");
    utf8encode(frase, dcmsg);
    utf8encode(footermsg, footer);
    utf8encode(titulo, " ");
    new DCC_Embed:embed = DCC_CreateEmbed("Perfect City - RPG", frase);
    DCC_SetEmbedColour(embed, 0x833cec);
    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/g09Pkie.png");
    DCC_SetEmbedFooter(embed, footermsg, "https://i.imgur.com/g09Pkie.png");
    DCC_SendChannelEmbedMessage(g_Sincro_Chat, embed, titulo);
    return SendClientMessage(playerid, 0x08c731FF, "Você mandou uma mensagem no discord como Betinho!");
}

flags:msglinks(DEV);
CMD:msglinks(playerid, params[])
{

    new titulo[512], frase[1024], dcmsg[1024], footer[512], footermsg[512];

    format(footer, sizeof(footer), "Perfect City RPG © Todos os direitos reservados.");

    format(dcmsg, sizeof(dcmsg), "Ainda não nos segue nas redes sociais? Então nos siga e fique por dentro de todas as novidades do servidor!\n\n\
    **Facebook** http://facebook.perfectcityrpg.com.br\n\
    **Instagram** http://instagram.perfectcityrpg.com.br\n\
    **WhatsApp** http://whatsapp.perfectcityrpg.com.br\n\
    **Youtube** http://youtube.perfectcityrpg.com.br\n\
    **Discord** http://discord.perfectcityrpg.com.br\n\
    **Site** http://perfectcityrpg.com.br\n\
    **Fórum** http://forum.perfectcityrpg.com.br\n\n\
    Obrigado por nos escolher!");

    utf8encode(frase, dcmsg), utf8encode(footermsg, footer), utf8encode(titulo, " ");

    new DCC_Embed:embed = DCC_CreateEmbed("Perfect City - RPG", frase);
    DCC_SetEmbedColour(embed, 0x833cec);
    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/g09Pkie.png");
    DCC_SetEmbedFooter(embed, footermsg, "https://i.imgur.com/g09Pkie.png");
    DCC_SendChannelEmbedMessage(g_Links_Chat, embed, titulo);
    return SendClientMessage(playerid, 0x08c731FF, "Você mandou uma mensagem no discord como Betinho!");
}

flags:msgregras(DEV);
CMD:msgregras(playerid, params[])
{

    new titulo[512], frase[2048], dcmsg[2048], footer[512], footermsg[512];

    format(footer, sizeof(footer), "Perfect City RPG © Todos os direitos reservados.");

    format(dcmsg, sizeof(dcmsg), "Aqui estão algumas das nossas regras do Discord!\n\n\
    :white_check_mark: #changelog -  Canal de updates relacionadas ao servidor.\n\n\
    :white_check_mark: #anúncios - Canal designado para anúncios sobre o servidor.\n\n\
    :white_check_mark: #sugestões - Tem uma sugestão para o servidor!? Use este canal para dar a sua sugestão.\n\n\
    :white_check_mark: #regras - Canal onde irá conter todas as regras do servidor.\n\n\
    :white_check_mark: #geral - Canal para o bate-papo em geral\n\n\
    :white_check_mark: #comandos - Canal usado para digitar comandos dos bots\n\n\
    :white_check_mark: #comandos-música - Canal usado para digitar a música que você deseja escutar.\n\n\
    :white_check_mark: Os canais são criados para dar a vocês alguma liberdade de poderem interagir entre vocês em nosso Discord.\n\
    mas...\n\
    :x: Não seja rude, nem desrespeite ninguém.\n\
    :x: Respeite a administração\n\
    :x: Cumpra as regras estabelecidas\n\
    :x: Faça uso correto de todos os canais\n\
    :x: Não faça spam de mensagens em nenhum dos canais.\n\n\
    Atenciosamente, Equipe Perfect City RPG");

    utf8encode(frase, dcmsg), utf8encode(footermsg, footer), utf8encode(titulo, " ");

    new DCC_Embed:embed = DCC_CreateEmbed("Perfect City - RPG", frase);
    DCC_SetEmbedColour(embed, 0x833cec);
    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/g09Pkie.png");
    DCC_SetEmbedFooter(embed, footermsg, "https://i.imgur.com/g09Pkie.png");
    DCC_SendChannelEmbedMessage(g_Regras_Chat, embed, titulo);
    return SendClientMessage(playerid, 0x08c731FF, "Você mandou uma mensagem no discord como Betinho!");
}

flags:falarbot(DEV);
CMD:falarbot(playerid, params[])
{

    if(isnull(params))
        return SendClientMessage(playerid, COR_ERRO, "* Digite /falarbot (mensagem)");

    new dcmsg[1024];//,  title[512];
    format(dcmsg, sizeof(dcmsg), "%s", params);
    new frase[1024], titulo[512];
    //format(title, sizeof(title), "**O %s enviou uma mensagem**!", GetUserName(playerid));
    utf8encode(titulo, "O Betinho enviou uma mensagem");
    utf8encode(frase, dcmsg);
    new DCC_Embed:embed = DCC_CreateEmbed("Perfect City - RPG", frase);
    DCC_SetEmbedColour(embed, 0x833cec);
    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/nmonTfb.png");
    //DCC_SetEmbedImage(embed, "https://i.imgur.com/0zuaQxE.png");
    DCC_SendChannelEmbedMessage(g_Discord_Chat, embed, titulo);
    return SendClientMessage(playerid, -1, "{08c731}Você mandou uma mensagem no discord como Betinho!");
}

// Comandos
DC_CMD:getcolor(DCC_User:userid, params[], DCC_Message:message) 
{
    new
        DCC_Embed:embed,
        DCC_User:author,
        DCC_ChannelType:typeChannel,
        DCC_Channel:channel,
        strcolor[10 + 1],
        color[2],
        String[560];

    DCC_GetMessageAuthor(message, author);
    DCC_GetMessageChannel(message, channel);
    DCC_GetChannelType(channel, typeChannel);

    if(IsUserDev(userid))
    {
        if(sscanf(params, "s[10]", strcolor))
        {
            embed = DCC_CreateEmbed();
            DCC_SetEmbedColor(embed, 0x833cec);
            DCC_SetEmbedDescription(embed, "USE: !getcolor [cor hexadecimal]");
            DCC_SendChannelEmbedMessage(channel, embed);    
            return 1;
        }

        if(strlen(strcolor) != 6)
        {
            embed = DCC_CreateEmbed();
            DCC_SetEmbedColor(embed, 0x833cec);
            DCC_SetEmbedDescription(embed, "Cor invalida.");
            DCC_SendChannelEmbedMessage(channel, embed);    
            return 1;
        }

        sscanf(strcolor, "x", color[0]);
        embed = DCC_CreateEmbed();
        format(String, sizeof(String), "%d", color[0]);
        DCC_SetEmbedDescription(embed, String);
        sscanf(String, "d", color[1]);
        DCC_SetEmbedColor(embed, color[1]);
        DCC_SendChannelEmbedMessage(channel, embed);    
    }
    else
    {
        embed = DCC_CreateEmbed();
        DCC_SetEmbedColor(embed, 0x833cec);
        DCC_SetEmbedDescription(embed, "Voce nao pode utilizar este comando.");
        DCC_SendChannelEmbedMessage(channel, embed);    
    }
    return 1;
}

// Admin Comands
DC_CMD:lerlog(DCC_User:userid, params[], DCC_Message:message) 
{
    new DCC_Channel:l_Channel, DCC_User:l_User, DCC_Embed:l_Embed, l_UserID[20 + 1], l_Type[32], String[560];

    DCC_GetMessageAuthor(message, l_User);
    DCC_GetUserId(l_User, l_UserID, sizeof(l_UserID));
    DCC_GetMessageChannel(message, l_Channel);

    if(IsUserDev(userid) || IsUserDiretorGeral(userid) || IsUserDiretor(userid) || IsUserAdmin(userid))
    {
        if(sscanf(params, "s[32]", l_Type))
        {
            format(String, sizeof(String), "<@%s> | Use: !lerlog [tipo de log]", l_UserID);
            l_Embed = DCC_CreateEmbed();
            DCC_SetEmbedColor(l_Embed, 0x833cec);
            DCC_SetEmbedDescription(l_Embed, String);
            DCC_SendChannelEmbedMessage(l_Channel, l_Embed);
            return 1;
        }

        if(!strcmp(l_Type, "anticheat", true))
        {
            //ShowDiscordLog(l_Channel, LOG_ANTI_CHEAT);
        }
        else if(!strcmp(l_Type, "admin-cmd", true))
        {
            //ShowDiscordLog(l_Channel, LOG_ADMIN_CMD);
        }
        else
        {
            format(String, sizeof(String), "<@%s> | Tipo invalido.", l_UserID);
            l_Embed = DCC_CreateEmbed();
            DCC_SetEmbedColor(l_Embed, 0x833cec);
            DCC_SetEmbedDescription(l_Embed, String);
            DCC_SendChannelEmbedMessage(l_Channel, l_Embed);
        }
    }
    else
    {
        format(String, sizeof(String), "<@%s> | Voce nao tem permissao.", l_UserID);
        l_Embed = DCC_CreateEmbed();
        DCC_SetEmbedColor(l_Embed, 0x833cec);
        DCC_SetEmbedDescription(l_Embed, String);
        DCC_SendChannelEmbedMessage(l_Channel, l_Embed);
    }
    return 1;
}

DC_CMD:buscarlog(DCC_User:userid, params[], DCC_Message:message) 
{
    new DCC_Channel:l_Channel, DCC_User:l_User, DCC_Embed:l_Embed, l_UserID[20 + 1], l_Type[32], l_Search[128], String[560];

    DCC_GetMessageAuthor(message, l_User);
    DCC_GetUserId(l_User, l_UserID, sizeof(l_UserID));
    DCC_GetMessageChannel(message, l_Channel);

    if(IsUserDev(userid) || IsUserDiretorGeral(userid) || IsUserDiretor(userid) || IsUserAdmin(userid))
    {
        if(sscanf(params, "s[32]s[56]", l_Type, l_Search))
        {
            format(String, sizeof(String), "<@%s> | Use: !buscarlog [tipo de log] [texto a ser procurado]", l_UserID);
            l_Embed = DCC_CreateEmbed();
            DCC_SetEmbedColor(l_Embed, 0x833cec);
            DCC_SetEmbedDescription(l_Embed, String);
            DCC_SendChannelEmbedMessage(l_Channel, l_Embed);
            return 1;
        }

        if(!strcmp(l_Type, "anticheat", true))
        {
            //ShowDiscordLogEx(l_Channel, LOG_ANTI_CHEAT, l_Search);
        }
        else if(!strcmp(l_Type, "admin-cmd", true))
        {
            //ShowDiscordLogEx(l_Channel, LOG_ADMIN_CMD, l_Search);
        }
        else
        {
            format(String, sizeof(String), "<@%s> | Tipo invalido.", l_UserID);
            l_Embed = DCC_CreateEmbed();
            DCC_SetEmbedColor(l_Embed, 0x833cec);
            DCC_SetEmbedDescription(l_Embed, String);
            DCC_SendChannelEmbedMessage(l_Channel, l_Embed);
        }
    }
    else
    {
        format(String, sizeof(String), "<@%s> | Voce nao tem permissao.", l_UserID);
        l_Embed = DCC_CreateEmbed();
        DCC_SetEmbedColor(l_Embed, 0x833cec);
        DCC_SetEmbedDescription(l_Embed, String);
        DCC_SendChannelEmbedMessage(l_Channel, l_Embed);
    }
    return 1;
}
