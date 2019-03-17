
local addon, ns = ...;
local L=setmetatable({},{__index=function(t,k) local v="?"; if(k) then v=tostring(k); rawset(t,k,v); end return v; end});
ns.L=L;

-- Hi. This addon needs your help for localization. :)
-- https://wow.curseforge.com/projects/quickroutes/localization

L["Colon"] = ":";
L["Archaeology"] = PROFESSIONS_ARCHAEOLOGY;
L["Fishing"] = PROFESSIONS_FISHING;
L["Extract Gas"] = GetSpellInfo(30075) or "Extract Gas";
L["Herbalism"] = GetSpellInfo(170691) or "Herbalism";
L["Logging"] = GetSpellInfo(167895) or "Logging";
L["Mining"] = GetSpellInfo(2575) or "Mining";
L["Treasure"] = GetSpellInfo(188830) or "Treasure";
L["GathererMINE"] = L["Mining"];
L["GathererHERB"] = L["Herbalism"];
L["GathererOPEN"] = L["Treasure"];
L["GatherMate2Herb Gathering"] = L["Herbalism"];
L["GatherMate2Mining"] = L["Mining"];
L["GatherMate2Fishing"] = L["Fishing"];
L["GatherMate2Extract Gas"] = L["Extract Gas"];
L["GatherMate2Treasure"] = L["Treasure"];
L["GatherMate2Archaeology"] = L["Archaeology"];
L["GatherMate2Logging"] = L["Logging"];

--@do-not-package@
L["AddOnLoaded"] = "AddOn loaded..."
L["Authors"] = "AddOn authors:"
L["Description"] = "Gives you quick access to show/hide created routes in current zone"
L["Hints"] = "Show hints"
L["HintsDesc"] = "Display hints in tooltip"
L["Info"] = "Info"
L["LeftClick"] = "Left-click"
L["Minimap"] = "Minimap"
L["NoRouteData"] = "Oops... There are no data in this route"
L["NoRoutesInZone"] = "No routes found for current zone"
L["Objects"] = ""
L["OnLogin"] = "On login"
L["OpenOptions"] = "Open options"
L["OpenRoutes"] = "Open routes"
L["RightClick"] = "Right-click"
L["Route"] = ""
L["SecondTT"] = "Show second tooltip"
L["SecondTTDesc"] = "Display second tooltip with additional informations to a single route"
L["ShowAddOnLoaded"] = "Show 'AddOn loaded'"
L["ShowAddOnLoadedDesc"] = "Show 'AddOn loaded...' message on login"
L["ShowMinimap"] = "Show minimap icon"
L["ShowMinimapDesc"] = "Show or hide the minimap icon"
L["Tooltip"] = "Tooltip"
L["Version"] = "AddOn version:"
L["QueueFirstNode"] = "Start"
L["RemoveQueuedNode"] = "Stop"
L["ChangeWaypointDirection"] = "Change|ndirection"
L["WaypointsTomTom"] = "Waypoints (TomTom)"
L["WaypointsTomTomDesc"] = "Display quick access to routes \"Waypoints (TomTom)\" options in tooltip."
--@end-do-not-package@

--@localization(locale="enUS", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@

if LOCALE_deDE then
	--@do-not-package@
	L["AddOnLoaded"] = "AddOn geladen..."
	L["Authors"] = "AddOn Autoren:"
	L["ChangeWaypointDirection"] = "Richtung|nwechseln"
	L["Description"] = "Gibt dir Schnellzugriff zum anzeigen/verstecken von erstellten Routen der aktuellen Zone"
	L["Hints"] = "Zeige Tipps"
	L["HintsDesc"] = "Zeigt Tipps im Tooltip"
	L["Info"] = "Info"
	L["LeftClick"] = "Linksklick"
	L["Minimap"] = "Minikarte"
	L["NoRouteData"] = "Oops... Da sind keine Daten in der Route"
	L["NoRoutesInZone"] = "Keine Routen gefunden für aktuelle Zone"
	L["Objects"] = "Objekte"
	L["OnLogin"] = "Beim Login"
	L["OpenOptions"] = "Optionen öffnen"
	L["OpenRoutes"] = "Routes öffnen"
	L["QueueFirstNode"] = "Start"
	L["RemoveQueuedNode"] = "Stopp"
	L["RightClick"] = "Rechtsklick"
	L["Route"] = "Route"
	L["SecondTT"] = "Zeige zweiten Tooltip"
	L["SecondTTDesc"] = "Zeigt zweiten Tooltip mit zusätzlichen Informationen zu einer einzelnen Route"
	L["ShowAddOnLoaded"] = "Zeige 'AddOn geladen'"
	L["ShowAddOnLoadedDesc"] = "Zeige 'AddOn geladen...' Nachricht beim Login"
	L["ShowMinimap"] = "Zeige Minimap Symbol"
	L["ShowMinimapDesc"] = "Zeige oder verstecke das Minimap Symbol."
	L["Tooltip"] = "Tooltip"
	L["Version"] = "AddOn Version:"
	L["WaypointsTomTom"] = "Wegpunkte (TomTom)"
	L["WaypointsTomTomDesc"] = "Zeigt Schnellzugriff auf Routes \"Wegpunkte (TomTom)\" Optionen im Tooltip."
	--@end-do-not-package@
	--@localization(locale="deDE", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_esES then
	--@localization(locale="esES", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_esMX then
	--@localization(locale="esMX", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_frFR then
	--@localization(locale="frFR", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_itIT then
	--@localization(locale="itIT", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_koKR then
	--@localization(locale="koKR", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_ptBR then
	--@localization(locale="ptBR", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_ruRU then
	--@localization(locale="ruRU", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_zhCN then
	L["Colon"] = "：";
	--@localization(locale="zhCN", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_zhTW then
	L["Colon"] = "：";
	--@localization(locale="zhTW", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
end


