stock IsPlayerSobeit(playerid)
{  
    if(IsPlayerNPC(playerid)) return 0;
    new Serial[80], Count;  
    gpci(playerid, Serial, sizeof(Serial));  
    for(new i = 0; i < strlen(Serial); i++)  
    {  
        if(Serial[i] >= '0' && Serial[i] <= '9')  Count++;
    }  
    return(Count>= 30 || strlen(Serial) <= 30);
} 