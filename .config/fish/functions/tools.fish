function wttr -d "Just show the weather."
    curl -L "https://wttr.in/chengdu?format=3"
end

function proxy -d "You know what the GFW is."
    set -gx http_proxy  http://127.0.0.1:7890
    set -gx https_proxy http://127.0.0.1:7890
end

function geoip -d "Update the Country.mmdb."
    curl -o $HOME/.config/clash/Country.mmdb -L "https://github.com/Hackl0us/GeoIP2-CN/raw/release/Country.mmdb"
end

function brewfile -d "Backup applications installed by HomeBrew."
    brew bundle dump --global -f
end

