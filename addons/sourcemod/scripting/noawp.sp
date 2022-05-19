#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "Atlas"
#define PLUGIN_VERSION "0.00"

ConVar g_pluginenabled;

#include <sourcemod>
#include <sdkhooks>
#include <cstrike>


#pragma newdecls required

public Plugin myinfo = 
{
	name = "Awp Yasak.",
	author = PLUGIN_AUTHOR,
	description = "Awp yasaklamak için kullanılıyor.",
	version = PLUGIN_VERSION,
	url = ""
};

public void OnPluginStart()
{
	g_pluginenabled = CreateConVar("atl_awponly", "0", "Awp açık mı kapalı mı ?");
	
}


public void OnClientPutInServer(int client)
{
		char sMap[64];
		GetCurrentMap(sMap, sizeof(sMap));
		if(StrEqual(sMap , "aim_redline")) 
		{
			SDKHook(client, SDKHook_WeaponCanUse, onWeaponUse);
		}
}
public void OnEntityCreated(int entitiy, const char[] classname)
{
	if(g_pluginenabled.BoolValue)
	{
		SDKHook(entitiy, SDKHook_WeaponCanUse, onWeaponUse);
	}
}

public Action CS_OnBuyCommand(int client, const char[] weapon)
{
	if(g_pluginenabled.BoolValue) 
	{
		if(StrEqual(weapon , "awp"))
		{
			return Plugin_Handled;
		}
		return Plugin_Continue;
	}
	else 
	{
		return Plugin_Continue;
	}
}


public Action onWeaponUse(int client, int weapon)
{
	char weaponName[32];
	GetEntityClassname(weapon, weaponName, sizeof(weaponName));
	if (StrEqual(weaponName, "weapon_awp"))
		return Plugin_Handled;
		
	return Plugin_Continue;
}
