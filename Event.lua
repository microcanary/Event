local Event = {}

Event.new = function()
    local obj = {
        
        Items = {};
        Queued = {};

        Invoke = function(self, ...)
            
            for i, v in ipairs(self.Queued) do
                coroutine.resume(v)
                table.remove(self.Queued, i)
            end

            for _, v in pairs(self.Items) do
                coroutine.wrap(v)(...)
            end
            
        end;

        Wait = function(self)
            local thread = coroutine.running()
            table.insert(self.Queued, thread)
            coroutine.yield()
        end;

        Connect = function(self, f)
            assert(type(f) == "function", "The callback provided is not a function.")
            
            local Owner = self
            local Connected = f

            local Connection
            Connection = {
                Disconnect = function(self)
                    Owner.Items[Connection] = nil
                end
            }

            self.Items[Connection] = f

            return Connection
        end;
        
    }
    
    local event = newproxy(true)
    
    local mt = getmetatable(event)
    
    mt.__index = obj
    
    return event
    
end

return Event
