local function batteryNotify()
    batteryPercentage = hs.battery.percentage()
    if batteryPercentage == batteryLow then
        hs.notify.new({title="Battery Notify", informativeText="Battery is " .. tostring(math.floort(batteryPercentage)) .. "% now!"}):send()
    end
end

batteryState = hs.battery.watcher.new(batteryNotify)
batteryState:start()
