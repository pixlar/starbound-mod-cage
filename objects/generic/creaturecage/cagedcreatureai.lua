function init()
	entity.setDropPool(nil)
	entity.setDeathParticleBurst(nil)
	entity.setDeathSound(nil)
	--self.die()
end

function updage(dt)

end

function die()
	self.dead = true
end

function kill()
	self.dead = true
end


function shouldDie()
  return self.dead
end