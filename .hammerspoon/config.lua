-- defaultInput --
appInputMethod = {
    {'/Applications/Xcode.app', 'English'},
    {'/Applications/Visual Studio Code.app', 'English'},
    {'/Applications/Hyper.app', 'English'},
}

-- Clipboard --
frequency = 1.0 -- Speed in seconds to check for clipboard changes. If you check too frequently, you will loose performance, if you check sparsely you will loose copies
hist_size = 10  -- How many items to keep on history
label_length = 70 -- How wide (in characters) the dropdown menu should be. Copies larger than this will have their label truncated and end with "…" (unicode for elipsis ...)
honor_clearcontent = false --asmagill request. If any application clears the pasteboard, we also remove it from the history https://groups.google.com/d/msg/hammerspoon/skEeypZHOmM/Tg8QnEj_N68J
pasteOnSelect = false -- Auto-type on click