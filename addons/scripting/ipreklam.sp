#include <sourcemod>
//////////////////////////////////////////////////////////////////////////////////////
new ConVar:g_Discord_Link;
new String:Discord_Link[64];
///////////////////////////////////////////////////////////////////////////////
public Plugin:myinfo = 
{ 
    name = "IP Reklam", 
    description = "IP Reklam Eklentisi !ip",
    author = "ByDexter", 
    version = "1.0", 
    url = "https://steamcommunity.com/id/ByDexterTR/" 
}; 
/////////////////////////////////////////////////////////////////////////////////////
public OnMapStart()
{
	CreateTimer(1.0, Reklam, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);	
}
/////////////////////////////////////////////////////////////////////////////////////
public OnPluginStart()
{
	g_Discord_Link = CreateConVar("discord_link", "!BYDEXTER!", "Bütün eklentilerin reklamlarını buradan değiştirebilirsiniz. ([ ] gibi işaretler koymayınız)");
	
	AutoExecConfig(true, "ByDexterIPReklam", "ByDexter");
	
	//RegConsoleCmd("sm_ip", ipadresi, "");
}
/////////////////////////////////////////////////////////////////////////////////////
/*public Action:ipadresi(client, args)
{	  	
	int pieces[4];
	int longip = GetConVarInt(FindConVar("hostip"));
	pieces[0] = (longip >> 24) & 0x000000FF;
	pieces[1] = (longip >> 16) & 0x000000FF;
	pieces[2] = (longip >> 8) & 0x000000FF;
	pieces[3] = longip & 0x000000FF;

	char NetIP[32];
	Format(NetIP, sizeof(NetIP), "%d.%d.%d.%d", pieces[0], pieces[1], pieces[2], pieces[3]);       	
 
	PrintToChat(client, "\x01\x0B\x01[\x04==============================================\x01]");	
	PrintToChat(client, " \x04[\x02ByDexter\x04] \x0cSunucu IP Adresi: \x0e%s", NetIP);
	PrintToChat(client, " \x04[\x02ByDexter\x04] \x0cDiscord Adresimiz: \x0ehttps://discord.gg/dfygFwQ");
	PrintToChat(client, "[\x04==============================================\x01]");	
 	
 	PrintHintText(client, "<font size='20' color='#8B0000'>[KeyfiAlem]</font><font size='20' color='#00FFFF'>Sunucu IP Adresımız:</font><font size='20' color='#FFD700'> %s</font>", NetIP);    	
     	  
	new Handle:hHudText = CreateHudSynchronizer();
	SetHudTextParams(0.0, -0.60, 3.0, 0, 153, 255, 0, 2, 1.0, 0.1, 0.2);
	ShowSyncHudText(client, hHudText, "IP Adresi: %s", NetIP);
	CloseHandle(hHudText);	
	
	PrintToConsole(client, "||| ↓↓↓↓↓↓↓↓↓↓ ||| → SUNUCU IP ADRESIMIZ ← ||| ↓↓↓↓↓↓↓↓↓↓ |||");
	PrintToConsole(client, "==============================================================");
	PrintToConsole(client, "[KeyfiAlem] Sunucu IP Adresi: %s", NetIP);	
	PrintToConsole(client, "[KeyfiAlem] Discord Adresimiz: https://discord.gg/dfygFwQ");				
	PrintToConsole(client, "==============================================================");
	PrintToConsole(client, "||| ↑↑↑↑↑↑↑↑↑↑ ||| → SUNUCU IP ADRESIMIZ ← ||| ↑↑↑↑↑↑↑↑↑↑ |||");		
}  */
/////////////////////////////////////////////////////////////////////////////////////
public Action:Reklam(Handle:Timer)
{	  
	GetConVarString(g_Discord_Link, Discord_Link, sizeof(Discord_Link));
	
	int pieces[4];
	int longip = GetConVarInt(FindConVar("hostip"));
	pieces[0] = (longip >> 24) & 0x000000FF;
	pieces[1] = (longip >> 16) & 0x000000FF;
	pieces[2] = (longip >> 8) & 0x000000FF;
	pieces[3] = longip & 0x000000FF;

	char NetIP[32];
	Format(NetIP, sizeof(NetIP), "%d.%d.%d.%d", pieces[0], pieces[1], pieces[2], pieces[3]);       	
  
	for (new i = 1; i <= MaxClients; i++) 
		if(IsClientInGame(i))
		{
			{   
				new Handle:hHudText = CreateHudSynchronizer();
				SetHudTextParams(0.0, -0.95, 1.0, GetRandomInt(0, 255), GetRandomInt(0, 255), GetRandomInt(0, 255), 255);
				ShowSyncHudText(i, hHudText, "IP Adresi: %s \nDiscord: %s", NetIP, Discord_Link);
				CloseHandle(hHudText);	
			}
		}
}  
//////////////////////////////////////////////////////////////////////////////////////