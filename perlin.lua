local random, randomseed = math.random, math.randomseed
local floor = math.floor
local max, min = math.max, math.min

local octaves = 3
local persistence = 0.8

function cos_interpolate(a, b, x)
	local ft = x * math.pi
	local f = (1 - math.cos(ft)) * .5

	return  a * (1 - f) + b * f
end

function noise_2d(x, y, i, seed)
	randomseed((x * seed + y * i ^ 1.1 + 14) / 789221 + 33 * x + 15731 * y * seed)

	random()

	return random(-1000, 1000) / 1000
end

function smooth_noise_2d(x, y, i, seed)
	local corners = (noise_2d(x - 1, y - 1, i, seed) + noise_2d(x + 1, y - 1, i, seed) + noise_2d(x - 1, y + 1, i, seed) + noise_2d(x + 1, y + 1, i, seed)) / 16
	local sides = (noise_2d(x - 1, y, i, seed) + noise_2d(x + 1, y, i, seed) + noise_2d(x, y - 1, i, seed) + noise_2d(x, y + 1, i, seed)) / 8
	local center = noise_2d(x, y, i, seed) / 4
	return corners + sides + center
end

function interpolate_noise_2d(x, y, i, seed)
	local int_x = floor(x)
	local frac_x = x - int_x

	local int_y = floor(y)
	local frac_y = y - int_y

	local v1 = smooth_noise_2d(int_x, int_y, i, seed)
	local v2 = smooth_noise_2d(int_x + 1, int_y, i, seed)
	local v3 = smooth_noise_2d(int_x, int_y + 1, i, seed)
	local v4 = smooth_noise_2d(int_x + 1, int_y + 1, i, seed)

	local i1 = cos_interpolate(v1, v2, frac_x)
	local i2 = cos_interpolate(v3, v4, frac_x)

	return cos_interpolate(i1, i2, frac_y)
end

function perlin_2d(x, y, seed)
	local total = 0
	local p = persistence
	local n = octaves - 1

	for i = 0, n do
		local frequency = 2 ^ i
		local amplitude = p ^ i

		total = total + interpolate_noise_2d(x * frequency, y * frequency, i, seed) * amplitude
	end

	return total
end

--[[
USAGE (generate a two-dimensional array of points):
local size = 50 --number of samples
local smoothiness = 8
local points = {}

for x = -size, size do
	points[x] = {}
	local ax = points[x]
	for y = -size, size do
		ax[y] = min(max(perlin_2d(x / smoothiness, y / smoothiness, 4923), -1), 1)
	end
end
]]