NL = {}
local LAM = LibStub("LibAddonMenu-1.0")
local db
local defaults = {

	ITEM_QUALITY_ARCANE = "keep",
	ITEM_QUALITY_ARTIFACT = "keep",
	ITEM_QUALITY_LEGENDARY = "keep",
	ITEM_QUALITY_MAGIC = "keep",
	ITEM_QUALITY_NORMAL = "keep",
	ITEM_QUALITY_TRASH = "keep",
	
	CRAFTING_TYPE_ALCHEMY = "keep",
	CRAFTING_TYPE_BLACKSMITHING = "keep",
	CRAFTING_TYPE_CLOTHIER = "keep",
	CRAFTING_TYPE_ENCHANTING = "keep",
	CRAFTING_TYPE_INVALID = "keep",
	CRAFTING_TYPE_PROVISIONING = "keep",
	CRAFTING_TYPE_WOODWORKING = "keep",
	
	ITEMTYPE_LURE = "keep",
	ITEMTYPE_TRASH = "keep",
	
	ALCHEMY_USER="@NONE",
	SMITHING_USER="@NONE",
	CLOTHIER_USER="@NONE",
	ENCHANTING_USER="@NONE",
	PROVISIONING_USER="@NONE",
	WOODWORKING_USER="@NONE",
	
	
}
local function sendDebug(message)
	if(CHAT_SYSTEM)
	then
		CHAT_SYSTEM:AddMessage(tostring(message))
	end
end

function ListBag()
	sendDebug("Hello World")
	local bagSize = GetMaxBags()
	sendDebug("BagSize is " .. bagSize)
end

SLASH_COMMANDS["/nirnloot"] = function()
   sendDebug("Slash Activated")
   ListBag()
end

EVENT_MANAGER:RegisterForEvent("NirnLoot", EVENT_ADD_ON_LOADED, function(event, addon)


	if(addon=="NirnLoot") then
		EVENT_MANAGER:RegisterForEvent("NirnLoot", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, LF.OnLootReceived)
		EVENT_MANAGER:RegisterForEvent("NirnLoot", EVENT_OPEN_STORE, LF.SellJunk)
		sendDebug("NirnLoot Activated")
	end
	end)
