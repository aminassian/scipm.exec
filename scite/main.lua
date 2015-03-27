-- -*- coding: utf-8 -

-- ----------------------------------------------------------------------------------------------
-- scipm_exec
-- ----------------------------------------------------------------------------------------------
-- Why :
--     if WIN then os.execute() flashing black box.
--     to avoid use scitedebug ``spawner-ex``
-- Usage :
--     local resultExec = scipm.exec("echo helloWorld")
--     if resultExec.code == 0 then
--         print(resultExec.content)
--     end
-- ----------------------------------------------------------------------------------------------
-- source :
--     * http://luaforge.net/projects/scitedebug/
--     * https://github.com/davidm/lua-inspect/blob/master/extman/extman.lua
-- ----------------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------------
-- load  scitedebug ``spawner-ex``
-- ----------------------------------------------------------------------------------------------
local fn,err, spawnDir;
if GTK then
    fn,err = package.loadlib(table.concat({scipm.data.path.scipmchild, "scipm.exec", "lib", "unix-spawner-ex.so"}, scipm.data.path.sep), 'luaopen_spawner')
else
    fn,err = package.loadlib(table.concat({scipm.data.path.scipmchild, "scipm.exec", "lib", "spawner-ex.dll"}, scipm.data.path.sep), 'luaopen_spawner')
end
if fn then
    fn() -- register spawner
else
    -- print('cannot load spawner '..err)
end

-- ----------------------------------------------------------------------------------------------
-- scipm.exec
-- -------------------------------------------------------------------------------
scipm.exec = function (cmd)

    -- temp file
    local tmpFilePath = os.tmpname();

    -- @TODO : how get return code ?

    -- popen
    local f;
    if spawner then
        f = spawner.popen(cmd);
    else
        cmd = cmd..' > '..tmpFilePath; -- redirect to temp file
        os.execute(cmd) -- io.popen is dodgy; don't use it!
        f = io.open(tmpFilePath)
    end

    -- return content
    if not f then
        return { ["code"] = 1, ["content"] = nil };
    else
        local content = f:read("*all");
        f:close(); -- close
        os.remove(tmpFilePath);
        return { ["code"] = 0, ["content"] = content };
    end

end