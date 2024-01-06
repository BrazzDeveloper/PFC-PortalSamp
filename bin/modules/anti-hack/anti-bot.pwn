#include <YSI_Coding\y_hooks>

const MAX_CON_PERM = 8;
const NENHUMA  = 0;
const BAN  = 1;
const KICK = 2;

enum eNick
{
    NickO[24],
    NickT[24],
    punicao,
};

static stock BotNickInteiro[][eNick] =
{
    // nick do bot   nick para trocar   punicao
    { "aux",            "[bot]",        KICK},
    { "con",            "[bot]",        KICK }
};

static stock BotNickParcial[][eNick] =
{
// nick parcial do bot  nick para trocar  punicao
    { "niex",           "[bot]",        KICK },
    { "botz",           "[bot]",        KICK }
};

hook OnPlayerConnect(playerid)
{
    new nick[24], ip[30];
    GetPlayerName(playerid, nick, sizeof nick);
    GetPlayerIp(playerid, ip, sizeof ip);
    for(new i = 0; i < sizeof BotNickInteiro; i++){
        if(strcmp(nick, BotNickInteiro[i][NickO], true ) == 0){
            printf("> Bot Detect: %s[%d] - %s", nick, playerid, ip);
            format(nick, sizeof(nick), "%s%d", BotNickInteiro[i][NickT], playerid);
            SetPlayerName(playerid, nick);
            if(BotNickInteiro[i][punicao] == KICK) Kick(playerid);
            else if(BotNickInteiro[i][punicao] == BAN) BanEx(playerid, "BOT");
            else if(BotNickInteiro[i][punicao] == NENHUMA) printf("> Nenhuma acao foi feita com o BOT: %s[%d] - %s", nick, playerid, ip);
        }
    }

    for(new i = 0; i < sizeof BotNickParcial; i++){
        if(strfind(nick, BotNickParcial[i][NickO], true ) != -1){
            printf("> Bot Detect: %s[%d] - %s", nick, playerid, ip);
            format(nick, sizeof(nick), "%s%d", BotNickParcial[i][NickT], playerid);
            SetPlayerName(playerid, nick);
            if(BotNickParcial[i][punicao] == KICK) Kick(playerid);
            else if(BotNickParcial[i][punicao] == BAN) BanEx(playerid, "BOT");
            else if(BotNickParcial[i][punicao] == NENHUMA) printf("> Nenhuma acao foi feita com o BOT: %s[%d] - %s", nick, playerid, ip);
        }
    }

    new ipget[30], ips;
    for(new i = 0;  i < MAX_PLAYERS; i++){
        if(IsPlayerConnected(i)){
            GetPlayerIp(i, ipget, sizeof ipget);
            if(strcmp(ipget, ip, true) == 0){
                ips++;
            }
        }
    }

    if(ips > MAX_CON_PERM){
        printf("> Conexao excedida %s[%d] - %s", nick, playerid, ip);
        Kick(playerid);
    }
    return 1;
}