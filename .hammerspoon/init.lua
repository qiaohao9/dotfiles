----------------------------------------------------------------------------------------------------

-- author: tinyRat
-- mail: me@tinyrat.me
-- github: https://github.com/tinyratp/dotfiles

----------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------
hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0

----------------------------------------------------------------------------------------------------
------------------------------------------ 配置设置 -------------------------------------------------
hsreload_keys = hsreload_keys or {{"cmd", "shift"}, "R"}
if string.len(hsreload_keys[2]) > 0 then
    hs.hotkey.bind(hsreload_keys[1], hsreload_keys[2], 'Reloading config...', function() hs.reload() end)
    hs.alert.show('Configuration has already been reloaded...')
end


----------------------------------------------------------------------------------------------------
---------------------------------------- Spoons 加载项 ----------------------------------------------
if not hspoon_list then
    hspoon_list = {
        'SpeedMenu',
    }
end

for _, v in pairs(hspoon_list) do
    hs.loadSpoon(v)
end

----------------------------------------------------------------------------------------------------
--------------------------------------- 快速打开应用 ---------------------------------------------
require('config')
require('Spoons.defaultInput')
require('Spoons.caffeine')

function open(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == 'Finder' then
            hs.appfinder.appFromName(name):activate()
        end
    end
end

for _, app in pairs(quickApps) do
    hs.hotkey.bind({'option'}, app[1], open(app[2]))
end


----------------------------------------------------------------------------------------------------
--------------------------------------- 快速打开应用 ---------------------------------------------
function keyStrokes(str)
    return function()
         hs.eventtap.keyStrokes(str)
    end
end

for _, strokes in pairs(autoKeys) do
    hs.hotkey.bind({'option'}, strokes[1], keyStrokes(strokes[2]))
end


----------------------------------------------------------------------------------------------------
--------------------------------------- 查看 App 信息 ---------------------------------------------
function showAppInfo()
        hs.alert.show("App path:     "
        ..hs.window.focusedWindow():application():path()
        .."\n"
        .."App name:     "
        ..hs.window.focusedWindow():application():name()
        .."\n"
        .."IM source id:  "
        ..hs.keycodes.currentSourceID())
end

hs.hotkey.bind({'ctrl', 'cmd'}, ".", showAppInfo)