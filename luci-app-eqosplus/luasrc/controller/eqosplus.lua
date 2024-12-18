module("luci.controller.eqosplus", package.seeall)
-- Copyright 2022-2023 sirpdboy <herboy2008@gmail.com>
function index()
    if not nixio.fs.access("/etc/config/eqosplus") then return end

    local e = entry({"admin", "services", "eqosplus"}, cbi("eqosplus"), _("Eqosplus"), 125)
    e.dependent=false
    e.acl_depends = { "luci-app-eqosplus" }
    entry({"admin", "services", "eqosplus", "status"}, call("act_status")).leaf = true
end

function act_status()
    local sys  = require "luci.sys"
    local e = {} 
     e.status = sys.call(" busybox ps -w | grep eqosplus | grep -v grep  >/dev/null ") == 0  
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end
