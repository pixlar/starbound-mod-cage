function init(args)
	--world.logInfo("cage exists")
	self.initialized = false
	if storage.monsterReference ~= nil then 
		world.logInfo("I know my creature")
	else
		--world.logInfo("I do not know my creature")
	end
end

function update(args)
	if not self.initialized then
		if storage.monsterReference ~= nil then
			monsters = world.monsterQuery(entity.position(), 10, { order = "nearest" })
			for i,v in ipairs(monsters) do
				world.logInfo(i)
				world.logInfo(type(v))
				world.logInfo("==============")
			end
			if monsters[1] ~= nil then
				self.initialized = true
				storage.monsterReference = monsters[1]
			end
		else
			self.initialized = true
		end
	end
	--world.logInfo("cage still exists")
	heldCreature = readStoredCreature()
	if heldCreature == nil then
		--world.logInfo("got nil for heldCreature")
		--world.logInfo("the cage is empty")
		--world.logInfo( type(storage.monsterConfig) )
		if storage.monsterConfig ~= nil then 
			world.logInfo("get rid of this")
			removeCagedCreature()
		end
		
	elseif not compareCreatures(storage.monsterConfig, heldCreature) then
		world.logInfo("new creature")
		removeCagedCreature()
		storage.monsterConfig = heldCreature
		storage.monsterReference = spawnDisplay(heldCreature)
		world.logInfo(storage.monsterReference)
	end
end

function die()
	world.logInfo("cage destroyed")
	storage.monsterConfig = removeCagedCreature(storage.monsterConfig)
end

function readStoredCreature()
	--world.logInfo("read Stored Creature")
	heldItems = world.containerItems(entity.id())
	creature = nil
	if heldItems == nil then
		return nil
	end
	for i,item in ipairs(heldItems) do
		if item ~= nil then
			--world.logInfo("found Stored Creature")
			creature = {}
			for index, value in pairs(item.parameters.projectileConfig.actionOnReap[1]) do
				creature[index] = value
			end
			creature["arguments"]["scripts"] = {"/objects/generic/creaturecage/cagedcreatureai.lua"}
		else
			--world.logInfo("found no Stored Creature")
		end
	end
	return creature
end

function compareCreatures(compCreature, heldCreature)
	--world.logInfo("comparing creatures")
	match = false
	if type(compCreature) == "table" and 
			heldCreature["type"] == compCreature["type"] and 
			heldCreature["arguments"]["seed"] == compCreature["arguments"]["seed"] then
		--world.logInfo("creatures match")
		match = true
	else
		world.logInfo("caged creature is not tabled")
		world.logInfo( type(compCreature) )
	end
	return match
end

function spawnDisplay(creature)
	world.logInfo("**************spawn creature display*************")
	storage.monsterConfig = creature
	newCreature = world.spawnMonster(creature["type"], {entity.position()[1], entity.position()[2] + 1}, creature["arguments"])
	--world.logInfo( storage.monsterConfig["arguments"]["seed"] )
	world.logInfo(newCreature)
	return newCreature
end

function removeCagedCreature()
	if not (storage.monsterReference == nil) then
		world.logInfo("--------destroyed creature display-----------")
		world.logInfo(storage.monsterReference)
		world.callScriptedEntity(storage.monsterReference, "die")
	end
	storage.monsterReference = nil
	storage.monsterConfig = nil
	return nil
end

--heldCreature refers to creature stored in the capturepod in the cage
--storage.monsterConfig refers to the display
--storage.monsterReference is the entityID of the display