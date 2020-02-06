local function batteryNotify()
    batteryPercentage = hs.battery.percentage()
    if batteryPercentage == batteryLow then
        hs.notify.new({title="Battery Notify", informativeText="Battery will be lower than 10%"}):send()
    end
end

batteryState = hs.battery.watcher.new(batteryNotify)
batteryState:start()