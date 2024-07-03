local M = {}

local function hex_to_rgb(hex)
    hex = hex:gsub("#", "")
    return tonumber("0x" .. hex:sub(1, 2)) / 255,
           tonumber("0x" .. hex:sub(3, 4)) / 255,
           tonumber("0x" .. hex:sub(5, 6)) / 255
end

local function rgb_to_hex(r, g, b)
    return string.format("#%02x%02x%02x", math.floor(r * 255), math.floor(g * 255), math.floor(b * 255))
end

local function rgb_to_hsl(r, g, b)
    local max, min = math.max(r, g, b), math.min(r, g, b)
    local h, s, l = 0, 0, (max + min) / 2

    if max ~= min then
        local d = max - min
        s = l > 0.5 and d / (2 - max - min) or d / (max + min)
        if max == r then
            h = (g - b) / d + (g < b and 6 or 0)
        elseif max == g then
            h = (b - r) / d + 2
        elseif max == b then
            h = (r - g) / d + 4
        end
        h = h / 6
    end

    return h, s, l
end

local function hsl_to_rgb(h, s, l)
    local function hue2rgb(p, q, t)
        if t < 0 then t = t + 1 end
        if t > 1 then t = t - 1 end
        if t < 1 / 6 then return p + (q - p) * 6 * t end
        if t < 1 / 2 then return q end
        if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
        return p
    end

    if s == 0 then
        return l, l, l
    else
        local q = l < 0.5 and l * (1 + s) or l + s - l * s
        local p = 2 * l - q
        return hue2rgb(p, q, h + 1 / 3), hue2rgb(p, q, h), hue2rgb(p, q, h - 1 / 3)
    end
end

local function clamp(value, min, max)
    if value < min then return min end
    if value > max then return max end
    return value
end

-- desat/darken between 0 and 1
function M.adjust_color(hex, desat, darken)
    local r, g, b = hex_to_rgb(hex)
    local h, s, l = rgb_to_hsl(r, g, b)
    s = clamp(s * desat, 0, 1)
    l = clamp(l * darken, 0, 1)
    r, g, b = hsl_to_rgb(h, s, l)
    return rgb_to_hex(r, g, b)
end

return M
