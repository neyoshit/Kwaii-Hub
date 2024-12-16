local http = game:GetService("HttpService")
local path = ""
lol = {}

local adapt = function(expected)
    if type(expected) == "string" then
        return '"' .. expected .. '"'
    elseif type(expected) == "number" or type(expected) == "boolean" then
        return tostring(expected)
    end
    return "null"
end

local function tableToJSON(tab)
    local str = "{"
    for i, v in pairs(tab) do
        if type(v) ~= "table" then
            str = str .. '"' .. i .. '"' .. ": " .. adapt(v) .. ","
        else
            local ohio = tableToJSON(v)
            str = str .. '"' .. i .. '"' .. ": " .. ohio .. ","
        end
    end
    if str:sub(-1) == "," then
        str = str:sub(1, -2)
    end
    str = str .. "}"
    return str
end

function lol:SetPath(newpath)
    if newpath ~= "" then
        path = newpath .. "/"
        return path
    end
end

function lol:SaveData(tab)
    local data
    if isfile(path .. "data") and pcall(function() data = http:JSONDecode(readfile(path .. "data")) end) then
        for i, v in pairs(tab) do
            data[i] = v
        end
    else
        data = tab
    end
    writefile(path .. "data", tableToJSON(data))
end

function lol:GetData()
    local suc, result = pcall(function()
        return http:JSONDecode(readfile(path .. "data"))
    end)
    if suc then
        return result
    else
        return {}
    end
end

return lol