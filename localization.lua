
local addon, ns = ...;
local L=setmetatable({},{__index=function(t,k) local v="?"; if(k) then v=tostring(k); rawset(t,k,v); end return v; end});
ns.L=L;

--[[

L["Quickly set and unset routes."] = "";
L["Hide Minimap Icon"] = "";
L["Show or hide the minimap icon."] = "";

]]

if LOCALE_deDE then
	-- For german translations...
	--L["Quickly set and unset routes."] = "";
	L["Hide Minimap Icon"] = "Verstecke Minimap Symbol";
	L["Show or hide the minimap icon."] = "Zeige oder verstecke das Minimap Symbol.";
end

if LOCALE_esES or LOCALE_esMX then
	-- For spanish translations...
end

if LOCALE_frFR then
	-- For french translations...
end

if LOCALE_itIT then
	-- For italian translations...
end
if LOCALE_koKR then
	-- For korean translations...
end

if LOCALE_ptBR then
	-- For Brazilian/Portuguese translations...
end

if LOCALE_ruRU then
	-- For russian translations...
end

if LOCALE_zhCN then
	-- For simplified chinese translations...
end

if LOCALE_zhTW then
	-- For traditional chinese translations...
end

