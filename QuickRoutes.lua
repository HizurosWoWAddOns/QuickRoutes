
local addon, ns = ...;
local L = ns.L;

local LDB = LibStub("LibDataBroker-1.1");
local LDBIcon = LibStub("LibDBIcon-1.0");
local LibQTip = LibStub("LibQTip-1.0");
local AC = LibStub("AceConfig-3.0");
local ACD = LibStub("AceConfigDialog-3.0");

local QuickRoutes,LDBObject,tt,tt2 = CreateFrame("frame");

local dbDefaults = {
	MinimapIcon = {
		hide = false,
		minimapPos = 220,
		radius = 80,
	},
	hints = true,
	tooltip2 = true,
	showLoaded = true
};

local function C(color,str)
	return "|cff"..( ({ltblue="69ccf0",ltgreen="80ff80",ltyellow="fff569",dkyellow="ffcc00",copper="f0a55f",gray="808080",green="00ff00",blue="0099ff"})[color] or "ffffff" )..str.."|r";
end

-- option panel by ace3
local function opt(info,value)
	local key = info[#info];
	if key=="minimap" then
		if value~=nil then
			QuickRoutesDB.MinimapIcon.hide = not QuickRoutesDB.MinimapIcon.hide;
			LDBIcon:Refresh(addon);
		end
		return not QuickRoutesDB.MinimapIcon.hide;
	elseif value~=nil then
		QuickRoutesDB[key] = value
	end
	return QuickRoutesDB[key];
end

local options = {
	name = addon,
	type = "group",
	get = opt,
	set = opt,
	args = {
		g0 = {
			type = "group", order = 1, inline = true,
			name = L.Info,
			args = {
				desc = {
					type = "description", order = 1, fontSize = "medium",
					name = L.Description.."\n "
				},
				version = {
					type = "description", order = 2, fontSize = "medium",
					name = "" -- filled on player login
				},
				authors = {
					type = "description", order = 3, fontSize = "medium",
					name = "" -- filled on player login
				}
			}
		},
		g1 = {
			type = "group", order = 2, inline = true,
			name = L.OnLogin,
			args = {
				showLoaded = {
					type = "toggle", width = "full",
					name = L.ShowAddOnLoaded, desc = L.ShowAddOnLoadedDesc
				}
			}
		},
		g2 = {
			type = "group", order = 3, inline = true,
			name = L.Minimap,
			args = {
				minimap = {
					type = "toggle", order = 3, width = "full",
					name = L.ShowMinimap, desc = L.ShowMinimapDesc
				}
			}
		},
		g3 = {
			type = "group", order = 4, inline = true,
			name = L.Tooltip,
			args = {
				hints = {
					type = "toggle", order = 1, width = "full",
					name = L.Hints, desc = L.HintsDesc
				},
				tooltip2 = {
					type = "toggle", order = 2, width = "full",
					name = L.SecondTT, desc = L.SecondTTDesc
				}
			}
		}
	}
}

-- register ace3 option table
AC:RegisterOptionsTable(addon, options);
ACD:AddToBlizOptions(addon);
ACD:SetDefaultSize(addon,360,480);

-- second tooltip - list of nodes of the displayed route
local function CreateTooltip2(self, data)
	if LibQTip:IsAcquired(addon.."2") then
		-- tooltip instance already present, clear exists lines
		tt2:Clear()
	else
		-- aquire new tooltip instance from LibQTip
		tt2 = LibQTip:Acquire(addon.."2", 1, "CENTER");
		tt2:SmartAnchorTo(data.parent);
	end

	-- Tiptac Support for LibQTip Tooltips
	if _G.TipTac and _G.TipTac.AddModifiedTip then
		-- Pass true as second parameter because hooking OnHide causes C stack overflows
		_G.TipTac:AddModifiedTip(tt2, true);
	end

	-- tooltip header
	tt2:SetCell(tt2:AddLine(), 1, C("dkyellow",L.Route..L.Colon.." "..data.name), tt:GetHeaderFont() , "LEFT", 0);

	-- create list of categories and node objects
	local cat,obj = {},{};
	local zoneID = C_Map.GetBestMapForUnit("player");
	for k,v in pairs(Routes.db.global.routes[zoneID][data.name].db_type)do
		tinsert(cat, C("ltgreen",L[k]));
	end
	for k,v in pairs(Routes.db.global.routes[zoneID][data.name].selection)do
		tinsert(obj,C("ltgreen",v));
	end

	-- show list of categories
	if #cat>0 then
		table.sort(cat);
		tt2:AddSeparator(4,0,0,0,0);
		tt2:AddLine(C("ltblue",CATEGORIES));
		tt2:AddSeparator();
		tt2:AddLine(table.concat(cat,", "));
	end

	-- show list of node objects
	if #obj>0 then
		table.sort(obj);
		tt2:AddSeparator(4,0,0,0,0);
		tt2:AddLine(C("ltblue",L.Objects));
		tt2:AddSeparator();
		tt2:AddLine(table.concat(obj,", "));
	end

	-- message on empty lists
	if #cat==0 and #obj==0 then
		tt2:AddLine(C("gray",L.NoRouteData));
	end

	-- show tooltip
	tt2:UpdateScrolling();
	tt2:Show();
end

local function HideTooltip2()
	tt2:Hide();
	LibQTip:Release(tt2);
end

local CreateTooltip;
local function ToggleRoute(frame, data)
	-- toggle hidden state
	Routes.db.global.routes[englishZoneName][data.name].hidden = not Routes.db.global.routes[englishZoneName][data.name].hidden;
	-- force update of routes
	Routes:DrawWorldmapLines();
	Routes:DrawMinimapLines(true);
	-- update tooltip
	CreateTooltip(data.parent);
end

function CreateTooltip(parent, data)
	if LibQTip:IsAcquired(addon) then
		-- tooltip instance already present, clear exists lines
		tt:Clear();
	else
		-- aquire new tooltip instance from LibQTip
		tt = LibQTip:Acquire(addon, 1, "CENTER");
		tt:SmartAnchorTo(parent);
		tt:SetAutoHideDelay(0.1, parent);
	end

	-- Tiptac Support for LibQTip Tooltips
	if _G.TipTac and _G.TipTac.AddModifiedTip then
		-- Pass true as second parameter because hooking OnHide causes C stack overflows
		_G.TipTac:AddModifiedTip(tt, true);
	end

	-- header
	tt:AddHeader(C("dkyellow",addon));
	tt:AddSeparator();
	tt:AddSeparator(1,0,0,0,0);

	-- get routes
	local routeNames,zoneRoutes = {},Routes.db.global.routes[C_Map.GetBestMapForUnit("player")] or {};
	for name, data in pairs(zoneRoutes) do
		if data.route and #data.route>0 then
			tinsert(routeNames, name);
		end
	end

	-- list routes
	if routeNames and #routeNames>0 then
		table.sort(routeNames);
		for _,routeName in pairs(routeNames) do
			local texture = (not zoneRoutes[routeName].hidden) and "UI-CheckBox-Check" or "UI-PASSIVEHIGHLIGHT";
			local line = tt:AddLine("|TInterface\\Buttons\\"..texture..":16:16:0:-2|t " .. C("ltblue",routeName));
			tt:SetLineScript(line, "OnMouseUp", ToggleRoute, {parent=parent, name=routeName});

			-- sub tooltip for more infomations about single route
			if QuickRoutesDB.tooltip2 then
				tt:SetLineScript(line, "OnEnter", CreateTooltip2, {parent=tt, name=routeName});
				tt:SetLineScript(line, "OnLeave", HideTooltip2);
			end
		end
	else
		-- No routes found for current zone
		tt:AddLine(C("gray",L.NoRoutesInZone));
	end

	-- add hints
	if QuickRoutesDB.hints then
		tt:AddSeparator(4,0,0,0,0);
		tt:AddLine(C("copper",L.LeftClick).." || "..C("green",L.OpenRoutes));
		tt:AddLine(C("copper",L.RightClick).." || "..C("green",L.OpenOptions));
	end

	-- show tooltip
	tt:UpdateScrolling();
	tt:Show();
end

QuickRoutes:SetScript("OnEvent", function(self, event, ...)
	if event=="ADDON_LOADED" and ...==addon then
		-- check savedvariables
		if QuickRoutesDB==nil then
			QuickRoutesDB = {};
		end
		for k,v in pairs(dbDefaults)do
			if QuickRoutesDB[k]==nil then
				QuickRoutesDB[k] = v;
			end
		end

		-- inform player that the addon is loaded :)
		if QuickRoutesDB.showLoaded then
			print(C("blue",addon)..":",C("green",L.AddOnLoaded));
		end
	elseif event=="PLAYER_LOGIN" then
		-- register data broker
		LDBObject = LDB:NewDataObject(addon,{
			type	=	"launcher",
			label	=	addon,
			text	=	addon,
			icon	=	"Interface\\Addons\\QuickRoutes\\icon.tga",
			OnClick	=	function(_, button)
				local name = "Routes";
				if button == "RightButton" then
					name = addon;
				end
				if ACD.OpenFrames[name]~=nil then
					ACD:Close(name);
				else
					ACD:Open(name);
				end
			end,
			OnEnter = CreateTooltip
		});

		-- register data broker as minimap button
		if LDBObject and LDBIcon then
			LDBIcon:Register(addon, LDBObject, QuickRoutesDB.MinimapIcon);
		end

		-- update option table
		options.args.g0.args.version.name = C("dkyellow",L.Version).." "..GetAddOnMetadata(addon,"version");
		options.args.g0.args.authors.name = C("dkyellow",L.Authors).." "..GetAddOnMetadata(addon,"author");
	end
end);

QuickRoutes:RegisterEvent("PLAYER_LOGIN");
QuickRoutes:RegisterEvent("ADDON_LOADED");
