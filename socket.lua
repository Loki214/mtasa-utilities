
local sockets = {}

local Socket = {}
Socket.__index = Socket

function Socket.new(address, port)
    local self = setmetatable({}, Socket)
    self.events = {}
    self.socket = exports.socket_connect:connect(address, port)
    sockets[self.socket] = self
    return self
end

function Socket:write(data)
    sockWrite(self.socket, data)
end

function Socket:close()
    sockClose(self.socket)
end

function Socket:on(eventName, cb)
    local event = self.events[eventName]

    if not event then
        self.events[eventName] = {}
        event = self.events[eventName]
    end

    table.insert(event, cb)
end

function Socket:emit(eventName, ...)
    local event = self.events[eventName]

    if event then
        for i=1, #event do
            event[i](...)
        end
    end
end

addEventHandler('onSockOpened', root, function(socket)
    local sock = sockets[socket]

    if sock then
        sock:emit('ready')
    end
end)

addEventHandler('onSockClosed', root, function(socket)
    local sock = sockets[socket]

    if sock then
        sock:emit('close')
    end
end)

addEventHandler('onSockData', root, function(socket, data)
    local sock = sockets[socket]

    if sock then
        sock:emit('data', data)
    end
end)

addEventHandler('onResourceStop', resourceRoot, function()
    local sock = sockets[socket]

    for _, socket in pairs(sockets) do
        socket:close()
    end
end)

setmetatable(Socket, {__call = function(_, ...) return Socket.new(...) end})

return Socket