local naughty   = require('naughty')

-- check for errors during startup and fall back to default config
if awesome.startup_errors then
    naughty.notify({
        preset  = naughty.config.presets.critical,
        title   = 'Opa! There were errors during startup!',
        text    = awesome.startup_errors
    })
end

-- handle runtime errors after startup
do
    local in_error  = false

    awesome.connect_signal('debug::error', function (err)
        if in_error then return end
        in_error    = true

        naughty.notify({
            preset  = naughty.config.presets.critical,
            title   = 'Opa! An error occurred!',
            text    = tostring(err)
        })
        in_error    = false
    end)
end
