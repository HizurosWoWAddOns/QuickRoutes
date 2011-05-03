local QuickRoutes = CreateFrame("frame")

local LibQTip = LibStub('LibQTip-1.0')

local tooltip
local LDB_ANCHOR
local GROUP_CHECKMARK	= "|TInterface\\Buttons\\UI-CheckBox-Check:0|t"

local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("QuickRoutes",
{
	type	=	"launcher",
	label	=	"Routes",
	text	=	"Routes",
	icon	=	"Interface\\Addons\\QuickRoutes\\icon.tga",
	OnClick	=	function(_, button)
		if button == "LeftButton" then
			LibStub("AceConfigDialog-3.0"):Open("Routes")
		else
			InterfaceOptionsFrame_OpenToCategory("QuickRoutes")
		end
	end,
});

local LDBIcon = LDB and LibStub("LibDBIcon-1.0", true)

local options = {
	name = "QuickRoutes",
	type = "group",
	args = {
		confdesc = {
			order = 1,
			type = "description",
			name = "Quickly set and unset routes.\n",
			cmdHidden = true
		},
		displayheader = {
			order = 2,
			type = "header",
			name = "QuickRoutes Options",
		},
		hide_minimapicon = {
			type = "toggle", width = "double",
			name = "Hide Minimap Icon",
			desc = "Show or hide the minimap icon.",
			order = 3,
			get = function() return QuickRoutesDB.MinimapIcon.hide end,
			set = function(_, v)
				QuickRoutesDB.MinimapIcon.hide = v
				if v then LDBIcon:Hide("QuickRoutes") else LDBIcon:Show("QuickRoutes") end
			end,
		},
	},
}

LibStub("AceConfig-3.0"):RegisterOptionsTable("QuickRoutes", options)
LibStub("AceConfigDialog-3.0"):AddToBlizOptions("QuickRoutes")

local zoneTable = {}
local zoneData
local zone


local function Entry_OnMouseUp(frame, route_name, button)
	Routes.db.global.routes[zone][route_name].hidden = not Routes.db.global.routes[zone][route_name].hidden
	Routes:DrawWorldmapLines()
	Routes:DrawMinimapLines(true)
	LDB.OnEnter(LDB_ANCHOR)
end

-- Setup the Title Font. 14
local ssTitleFont = CreateFont("ssTitleFont")
ssTitleFont:SetTextColor(1,0.823529,0)
ssTitleFont:SetFont(GameTooltipText:GetFont(), 14)

-- Setup the Header Font. 12
local ssHeaderFont = CreateFont("ssHeaderFont")
ssHeaderFont:SetTextColor(1,0.823529,0)
ssHeaderFont:SetFont(GameTooltipHeaderText:GetFont(), 12)

-- Setup the Regular Font. 12
local ssRegFont = CreateFont("ssRegFont")
ssRegFont:SetTextColor(1,0.823529,0)
ssRegFont:SetFont(GameTooltipText:GetFont(), 12)

function LDB.OnEnter(self)
	LDB_ANCHOR = self

	if LibQTip:IsAcquired("QuickRoutes") then
		tooltip:Clear()
	else
		tooltip = LibQTip:Acquire("QuickRoutes", 2, "RIGHT", "LEFT")

		tooltip:SetBackdropColor(0,0,0,1)

		tooltip:SetHeaderFont(ssHeaderFont)
		tooltip:SetFont(ssRegFont)

		tooltip:SmartAnchorTo(self)
		tooltip:SetAutoHideDelay(0.25, self)
	end

	local line = tooltip:AddLine()
	tooltip:SetCell(line, 1, "QuickRoutes", ssTitleFont , "CENTER", 0)
	tooltip:AddSeparator()
	tooltip:AddLine(" ")

	zone = GetRealZoneText()
	if Routes.LZName[zone] then
		zone = Routes.LZName[zone][1] -- Get mapfile
		zoneData = Routes.db.global.routes[zone]
	end

	if type(zoneData) == "table" then
		for i = #zoneTable, 1, -1 do
			zoneTable[i] = nil
		end

		for route_name in pairs(zoneData) do
			tinsert(zoneTable, route_name)
		end
		table.sort(zoneTable)

		local route_name, route_data, checked
		for i = 1, #zoneTable do
			route_name = zoneTable[i]
			route_data = zoneData[route_name]
			checked = not route_data.hidden

			if route_data.route and #route_data.route > 0 then
				line = tooltip:AddLine()
				if checked then
					tooltip:SetCell(line, 1, GROUP_CHECKMARK)
				end
				tooltip:SetCell(line, 2, "|cff82c5ff" .. route_name)
				tooltip:SetLineScript(line, "OnMouseUp", Entry_OnMouseUp, route_name)
			end
		end

	end

	tooltip:UpdateScrolling()
	tooltip:Show()
end

function QuickRoutes:PLAYER_LOGIN()
	if not QuickRoutesDB then
		QuickRoutesDB = {}
	end

	if not QuickRoutesDB.MinimapIcon then
		QuickRoutesDB.MinimapIcon = {
			hide = false,
			minimapPos = 220,
			radius = 80,
		}
	end

	if LDBIcon then
		LDBIcon:Register("QuickRoutes", LDB, QuickRoutesDB.MinimapIcon)
	end
end

QuickRoutes:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
QuickRoutes:RegisterEvent("PLAYER_LOGIN")
