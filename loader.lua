local main = "https://raw.githubusercontent.com/neyoshit/Kwaii-Hub/refs/heads/main/loader.lua"
local debug = true
local loader = loadstring or load
local http = game.HttpGet
local reload = queue_on_teleport or fluxus.queue_on_teleport or syn.queue_on_teleport

local List = {
    RAF2 = "https://raw.githubusercontent.com/neyoshit/Kwaii-Hub/refs/heads/main/Supported/Raise%20a%20floppa%202.lua"
}

local Supporting = {
    [9772878203] = {Swift = true, Url = List.RAF2}
}

if reload and http then
    reload(http(main))()
end

if loader and type(loader) == "function" and http then
    local placeData = Supporting[game.PlaceId]
    if placeData then
        if placeData.Swift and string.find(identifyexecutor(), "Swift") then
            warn("Swift")
            loader(http(placeData.Url))()
        elseif placeData.Swift == false and string.find(identifyexecutor(), "Swift") then
            warn("Unsupported Executor")
            return
        end
        
        loader(http(placeData.Url))()
    end
end

if debug then
    print("--------------------\n--KWAII HUB DEBUG SECTION--\n")
    print("Executor: " .. identifyexecutor())
    print("Place Id: " .. game.PlaceId)
    print("JobID: " .. game.JobId)
    print("Script Executed: " .. (Supporting[game.PlaceId] and Supporting[game.PlaceId].Url or "None"))
    print("--------------------")
end
