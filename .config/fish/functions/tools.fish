function wttr -d "Just show the weather."
    curl -L "https://wttr.in/chengdu?format=3"
end

function proxy -d "You know what the GFW is."
    set -gx http_proxy  http://127.0.0.1:7890
    set -gx https_proxy http://127.0.0.1:7890
end

