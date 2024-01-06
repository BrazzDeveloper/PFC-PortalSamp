// NEW SYSTEM: BASES

/* ----         Started at 20/05/2021 - 10:02                                                     */
/* ----         Author: Luiz "LuizM" Henrique                                                     */
/* ----         Credits:                                                                          */
/* ----         Finished at xx/xx/xxxx - xx:xx                                                    */
/* ----         First patch: xx/xx/xxxx - xx:xx - xxx lines                                       */


#include <YSI_Coding\y_hooks>

flags:criarbase(DEV);
CMD:criarbase(playerid, params[])
{
    new valor;
    if(sscanf(params, "d", valor))
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /CriarBase [valor].");
    
    new query[350];

    new Float:Posicao[4];
    GetPlayerPos(playerid, Posicao[0], Posicao[1], Posicao[2]);

    mysql_format(getConexao(), query, 350, "INSERT INTO `bases`(lider, up, valor, entrada_x, entrada_y, entrada_z, nome, liderid, tag) VALUES ('Ninguem', '1', '%d', '%f', '%f', '%f', 'N/A', '0', 'N/A')", \
    valor, Posicao[0], Posicao[1], Posicao[2]);
    mysql_tquery(getConexao(), query, "AdicionarID_BASE", "i", playerid);

    return 1;
}

forward AdicionarID_BASE(playerid);
public AdicionarID_BASE(playerid)
{
    new id = cache_insert_id();

    SendClientMessage(playerid, -1, "| BASE | Base {1c88f0}%d {ffffff}criada com sucesso.", id);

    call::BASES->ReloadBases();
    return 1;
}
