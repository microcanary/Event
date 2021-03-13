# Event

Exact replicas of Roblox's event object.

Usage:  

Event.new  
`Returns EventObj.`  

EventObj:Connect(callback)  
`Connects a callback to a specific event. Returns ConnectionObj.`  

EventObj:Wait()  
`Yields the current thread until the event is invoked.`  

EventObj:Invoke()  
`Invokes the event. All yielding threads will be released, and all callbacks connected will be fired. This method is synchonous.`  

ConnectionObj:Disconnect() 
`Disconnects the connection.`  

***

Example:

```lua
local Event = require(dir)

local function newEntity(name)
  local Entity = {
   Name = name;
   Health = 100;
   Armor = 10;
   Attack = 10;
   
   Killed = Event.new();
   
   Attack = function(self, enemy)
   enemy.Health = enemy.Health - (self.Attack / (100 - enemy.Armor))
    
    if enemy.Health =< 0 then
      enemy.Killed:Invoke(self.Name)
    end
   end
  }
end

local plr = newEntity("Joe")

local monster = newEntity("Ghoul")

monster.Killed:Connect(function(by)
  print("Monster has been killed by "..by.."!")
end)

for i = 1, 10 do
  plr:Attack(monster)
end
```

***

### Footnotes:

This is compatible in normal lua with a few caveats. Lua 5.1 must be used, and the Wait() method only works inside coroutines.
