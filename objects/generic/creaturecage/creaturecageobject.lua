function init(args)
	self.hasPrepped = false
end

function prep()
	self.size = world.containerSize(entity.id())

	if self.size ~= nil then
		storage.heldItems = world.containerItems(entity.id())
		storage.knownPeers = {}
		self.pause = false
		self.hasPrepped = true
		world.logInfo("Hello, dear friends?")
		for i,item in ipairs(storage.heldItems) do
			if item ~= nil then
				creature = {}
				for index, value in pairs(item.parameters.projectileConfig.actionOnReap[1]) do
					creature[index] = value
				end
			end
			--world.spawnMonster(creature["type"], {entity.position()[1], entity.position()[2] + 1}, creature["arguments"])
		end
	end
end
function update(dt)

	
	if not self.hasPrepped then
		prep()
		--params = 
		--spawnMonster("smallbiped", {entity.position()[1], entity.position()[2] + 1}, params)
                                    
	end	
end
