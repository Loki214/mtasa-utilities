-- Vector library by mrsimb
local Vector = {}           -- Vector namespace
Vector.protomt = {}   -- Vector base metatable
Vector.mt = {}        -- Vector derived objects metatable
  
-- to create new vectors by calling Vector object like self: a = Vector(1, 2, 3)
function Vector.protomt.__call(t, x, y, z)
  return Vector.new(x, y, z)
end
  
-- [] operator (get)
function Vector.mt:__index(k)
  if (type(k) == 'number') then
    if (k == 1) then return self.x
    elseif (k == 2) then return self.y
    elseif (k == 3) then return self.z
    end
  end
  rawget(self, k)
end
  
-- [] operator (set)
function Vector.mt:__newindex(k, v)
  if (type(k) == 'number') then
    if (k == 1) then self.x = v
    elseif (k == 2) then self.y = v
    elseif (k == 3) then self.z = v
    end
  else
    rawset(self, k, v)
  end
end
  
-- + operator
function Vector.mt:__add(v)
  return Vector.add(Vector.copy(self), v)
end
  
-- - operator (binary)
function Vector.mt:__sub(v)
  return Vector.sub(Vector.copy(self), v)
end
  
-- - operator (unary)
function Vector.mt:__unm()
  return Vector.new(-self.x, -self.y, -self.z)
end
  
-- * operator
function Vector.mt:__mul(n)
  return Vector.mul(Vector.copy(self), n)
end
  
-- / operator
function Vector.mt:__div(n)
  return Vector.div(Vector.copy(self), n)
end
  
-- ^ operator
function Vector.mt:__pow(n)
  return Vector.pow(Vector.copy(self), n)
end
  
-- == operator
function Vector.mt:__eq(v)
  return Vector.eq(self, v)
end
  
-- < operator (compare magnitude)
function Vector.mt:__lt(v)
  return Vector.lt(self, v)
end
  
-- <= operator (compare magnitude)
function Vector.mt:__le(v)
  return Vector.le(self, v)
end
  
-- tostring()
function Vector.mt:__tostring()
  return Vector.toString(self)
end
  
-- sets components of self vector to the given values
-- you can pass array or another Vector
function Vector:set(x, y, z)
  if (type(x) == 'table') then
    if (Vector.isVector(x)) then
      self.x = x.x or 0
      self.y = x.y or 0
      self.y = x.z or 0
      return self
    end
    self.x = x[1] or 0
    self.y = x[2] or 0
    self.z = x[3] or 0
    return self
  end
  self.x = x or 0
  self.y = y or 0
  self.z = z or 0
  return self
end
  
-- returns copy of self vector
function Vector:copy()
  return Vector.new(self.x, self.y, self.z)
end
  
-- returns string representation of self vector
function Vector:toString()
  return self.x .. ', ' .. self.y .. ', ' .. self.z
end
-- returns array with components of self vector
function Vector:toArray()
  return {self.x or 0, self.y or 0, self.z or 0}
end
  
-- adds values to self vector and returns it
-- you can pass array or another Vector
function Vector:add(x, y, z)
  if (type(x) == 'table') then
    if (Vector.isVector(x)) then
      self.x = self.x + (x.x or 0)
      self.y = self.y + (x.y or 0)
      self.y = self.y + (x.z or 0)
      return self
    end
    self.x = self.x + (x[1] or 0)
    self.y = self.y + (x[2] or 0)
    self.z = self.z + (x[3] or 0)
    return self
  end
  self.x = self.x + (x or 0)
  self.y = self.y + (y or 0)
  self.z = self.z + (z or 0)
  return self
end
  
-- substracts values from self vector and returns it
-- you can pass array or another Vector
function Vector:sub(x, y, z)
  if (type(x) == 'table') then
    if (Vector.isVector(x)) then
      self.x = self.x - (x.x or 0)
      self.y = self.y - (x.y or 0)
      self.z = self.z - (x.z or 0)
      return self
    end
    self.x = self.x - (x[1] or 0)
    self.y = self.y - (x[2] or 0)
    self.z = self.z - (x[3] or 0)
    return self
  end
  self.x = self.x - (x or 0)
  self.y = self.y - (y or 0)
  self.z = self.z - (z or 0)
  return self
end
  
-- multiplicates self vector by given value and returns it
function Vector:mul(x,y,z)
  if (type(x) == 'table') then
    if (Vector.isVector(x)) then
      self.x = self.x * (x.x or 0)
      self.y = self.y * (x.y or 0)
      self.z = self.z * (x.z or 0)
      return self
    end
    self.x = self.x * (x[1] or 0)
    self.y = self.y * (x[2] or 0)
    self.z = self.z * (x[3] or 0)
    return self
  end
  self.x = self.x * (x or 0)
  self.y = self.y * (x or 0)
  self.z = self.z * (x or 0)
  return self
end
  
-- divides self vector by given value and returns it
function Vector:div(n)
  self.x = self.x / (n or 0)
  self.y = self.y / (n or 0)
  self.z = self.z / (n or 0)
  return self
end
  
-- powers self vector by given value and returns it
function Vector:pow(n)
  self.x = self.x ^ (n or 0)
  self.y = self.y ^ (n or 0)
  self.z = self.z ^ (n or 0)
  return self
end
  
-- equality check againist self vector
-- you can pass array or another Vector
function Vector:eq(x, y, z)
  local a, b, c
  if (type(x) == 'table') then
    if (Vector.isVector(x)) then
      a = x.x or 0
      b = x.y or 0
      c = x.z or 0
    else
      a = x[1] or 0
      b = x[2] or 0
      c = x[3] or 0
    end
  else
    a = x or 0
    b = y or 0
    c = z or 0
  end
  return self.x == a and self.y == b and self.z == c
end
  
-- self vector's magnitude is less than value or another vector magnitude
function Vector:lt(x, y, z)
  if (type(x) == 'table') then
    return Vector.mag(self) < Vector.mag(x)
  end
  return Vector.mag(self) < x
end
  
-- self vector's magnitude is less or equals value or another vector magnitude
function Vector:le(x, y, z)
  if (type(x) == 'table') then
    return Vector.mag(self) <= Vector.mag(x)
  end
  return Vector.mag(self) <= x
end
  
-- returns magnitude (length) of self vector
function Vector:mag()
  return math.sqrt(Vector.magSq(self))
end
  
-- returns squared magnitude (length) of self vector (faster)
function Vector:magSq()
  return self.x ^ 2 + self.y ^ 2 + self.z ^ 2
end
  
-- returns distance beetween v and self vector
function Vector:dist(v)
  local d = Vector.distSq(self, v)
  return math.sqrt(d)
end
  
-- returns squared distance beetween v and self vector (faster)
function Vector:distSq(v)
  local d = Vector.sub(Vector.copy(self), v)
  return Vector.magSq(d)
end
  
-- returns cross product of v and self vector
function Vector:cross(v)
  return Vector.new(self.y * v.z - self.z * v.y, self.z * v.x - self.x * v.z, self.x * v.y - self.y * v.x)
end
  
-- returns dot product of v and self vector
function Vector:dot(v)
  return self.x * v.x + self.y * v.y + self.z * v.z
end
  
-- normalizes self vector and returns it
function Vector:norm()
  local m = Vector.mag(self)
  if (m == 0) then
    return self
  end
  return Vector.div(self, m)
end
  
-- limits magnitude of self vector to max value and returns it
function Vector:limit(max)
  return Vector.mul(Vector.norm(self), max)
end
  
-- returns angle of rotation for self vector (only 2D vectors)
function Vector:angle()
  return math.atan2(self.y, self.x)
end
  
-- calculates and returns angle between two vectors
function Vector:angleBetween(v)
  return math.acos(Vector.dot(self, v) / (Vector.mag(self) * Vector.mag(v)))
end
  
-- rotates self vector by angle (only 2D vectors) and returns it
function Vector:rotate(a)
  local na = Vector.angle(self) + a
  local m = Vector.mag(self)
  self.x = math.cos(na) * m
  self.y = math.sin(na) * m
  return self
end
  
-- linear interpolation of self vector
-- you can pass array or another Vector
function Vector:lerp(x, y, z, n)
  if (type(x) == 'table') then
    if (Vector.isVector(x)) then
      return self.lerp(self, x.x, x.y, x.z, y)
    end
    return self.lerp(self, x[1], x[2], x[3], y)
  end
  self.x = self.x + (x - self.x) * n
  self.y = self.y + (y - self.y) * n
  self.z = self.z + (z - self.z) * n
  return self
end
  
-- Static methods
  
-- returns new vector from given angle
function Vector.fromAngle(a)
  return Vector.new(math.cos(a), math.sin(a))
end
  
-- returns 2D vector from random angle
function Vector.random2d()
  local a = math.random() * math.pi * 2;
  return Vector.fromAngle(a)
end
  
-- returns 3D vector from random angle
function Vector.random3d()
  local a = math.random() * math.pi * 2;
  local vz = math.random() * 2 - 1;
  local vx = math.sqrt(1 - vz ^ 2) * math.cos(a);
  local vy = math.sqrt(1 - vz ^ 2) * math.sin(a);
  return Vector.new(vx, vy, vz)
end
  
-- checks if self is vector
function Vector.isVector(self)
  return getmetatable(self) == getmetatable(Vector)
end
  
function Vector.unpack(self)
  return self.x, self.y, self.z
end
  
-- returns new vector from given values
-- you can pass array or another Vector
function Vector.new(x, y, z)
  local this = {}
  
  if (type(x) == 'table') then
    if (Vector.isVector(x)) then
      this.x = x.x or 0
      this.y = x.y or 0
      this.y = x.z or 0
    else
      this.x = x[1] or 0
      this.y = x[2] or 0
      this.z = x[3] or 0
    end
  else
    this.x = x or 0
    this.y = y or 0
    this.z = z or 0
  end
  
  this.unpack = Vector.unpack
  this.set = Vector.set
  this.copy = Vector.copy
  this.toString = Vector.toString
  this.toArray = Vector.toArray
  this.add = Vector.add
  this.sub = Vector.sub
  this.mul = Vector.mul
  this.div = Vector.div
  this.eq = Vector.eq
  this.lt = Vector.lt
  this.le = Vector.le
  this.mag = Vector.mag
  this.magSq = Vector.magSq
  this.dist = Vector.dist
  this.distSq = Vector.distSq
  this.cross = Vector.cross
  this.dot = Vector.dot
  this.norm = Vector.norm
  this.limit = Vector.limit
  this.angle = Vector.angle
  this.angleBetween = Vector.angleBetween
  this.rotate = Vector.rotate
  this.lerp = Vector.lerp
  
  -- set Vector childrens metatable
  setmetatable(this, Vector.mt)
  
  return this
end
  
-- set base Vector parent metatable
setmetatable(Vector, Vector.protomt)

return Vector