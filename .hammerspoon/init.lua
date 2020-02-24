require('config')
require('Spoons.defaultInput')
require('Spoons.caffeine')
require('Spoons.speedMenu')


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
