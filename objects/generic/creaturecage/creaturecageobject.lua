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
		for i,item in ipairs(storage.heldItems) do
			if item ~= nil then
				print("attributes")
				for index, value in pairs(item.parameters.projectileConfig.actionOnReap[1]) do
					print(index)
				end
				print(item.name)
				print(item.parameters.projectileConfig.actionOnReap)
				print(item.parameters.projectileConfig.actionOnReap[1].type)
			end
		end
	end
end
function update(dt)

	
	if ~ self.hasPrepped then
		prep()
	end	
end
