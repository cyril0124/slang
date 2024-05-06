#!lua

local includedirs = ""
local compiler = "gcc"

local function run_command(command)
    local handle = io.popen(command, 'r')
    if handle then
        local output = handle:read("*a")
        handle:close() 
        output = string.sub(output, 1, -2) -- strip("\n")
        return output
    else
        error("Failed to run command => " .. command)
    end
end

local function add_includedirs(dir)
    includedirs = includedirs .. "\t\t-I" .. dir .. ",\n"
end

local function set_compiler(x)
    compiler = run_command("realpath " .. x)
end

local function gen_clangd(name)
    name = name or ".clangd"
    local file, err = io.open(name, "w")

    if not file then
        assert(false, "Cannot open .clangd! err: "..err)
    end

    assert(file ~= nil)

    includedirs = string.sub(includedirs, 1, -2) -- strip "\n"

    file:write(string.format([[
CompileFlags:
    Add: [
        # -D_PSTL_PAR_BACKEND_TBB,
        # -D_PSTL_PAR_BACKEND_SERIAL,
        -Wno-implicit-function-declaration, -Wno-int-conversion, -ferror-limit=500,
%s
        -xc++, 
        -std=c++20
    ]
    Remove: -W*
    Compiler: %s 
InlayHints:
    BlockEnd: No
    Designators: Yes
    Enabled: Yes
    ParameterNames: Yes
    DeducedTypes: Yes
Diagnostics:
    Suppress: "*"
]], includedirs, compiler))

    file:close()
end


-- 
-- User settings
-- 
local pwd = os.getenv "PWD"
local home = os.getenv "HOME"
local slang_home = os.getenv "SLANG_HOME"

set_compiler(run_command("which gcc"))

add_includedirs(home .. "/miniconda3/envs/cppenv/include")
add_includedirs(home .. "/miniconda3/envs/cppenv/x86_64-conda-linux-gnu/include/c++/13.2.0")
-- add_includedirs(slang_home .. "/include")
add_includedirs(slang_home .. "/install/include")
add_includedirs(slang_home .. "/install/include/parsing")


-- 
-- Generate final ".clangd" file
-- 
gen_clangd(".clangd")

