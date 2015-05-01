function init(args)
	world.logInfo("cage exists")
	cagedCreature = nil
end

function update(args)
	world.logInfo("cage still exists")
	storedCreature = loadStoredCreature()
	if storedCreature == nil then
		world.logInfo("the cage is empty")
		if not cagedCreature == nil then 
			cagedCreature = removeCagedCreature()
		end
	elseif not compareCreatures(cagedCreature, storedCreature) then
		cagedCreature = removeCagedCreature()
		cagedCreature = spawnDisplay()
	end
end

function die()
	world.logInfo("cage destroyed")
end

function loadStoredCreature()
	world.logInfo("load Stored Creature")
	storage.heldItems = world.containerItems(entity.id())
	creature = nil
	for i,item in ipairs(storage.heldItems) do
		if item ~= nil then
			world.logInfo("found Stored Creature")
			creature = {}
			for index, value in pairs(item.parameters.projectileConfig.actionOnReap[1]) do
				creature[index] = value
			end
		else
			world.logInfo("found no Stored Creature")
		end
	end
	return creature
end

function compareCreatures(cagedCreature, storedCreature)
	world.logInfo("comparing creatures")
	match = false
	if type(cagedCreature) == "table" then
		if storedCreature["type"] == cagedCreature["type"] then
			if storedCreature["arguments"]["seed"] == cagedCreature["arguments"]["seed"] then
				world.logInfo("creatures match")
				match = true
			end
		end
	else
		world.logInfo("caged creature is not tabled")
		world.logInfo( type(cagedCreature) )
	end
	return match
end

function spawnDisplay()
	--cagedCreature = storedCreature
	world.logInfo("**************spawn creature display*************")
	--world.logInfo( cagedCreature["arguments"]["seed"] )
	return storedCreature
end

function removeCagedCreature()
	world.logInfo("--------destroyed creature display-----------")
	return nil
end

--storedCreature refers to creature stored in the capturepod in the cage
--cagedCreature refers to the display