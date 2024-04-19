#!lua

local home = os.getenv "HOME"
local slang_home = os.getenv "SLANG_HOME"


local includedirs = ""

local function add_includedirs(dir)
    includedirs = includedirs .. "-I" .. dir .. ",\n"
end


local function gen_clangd(name)
    local name = name or ".clangd"
    local file, err = io.open(name, "w")

    if not file then
        assert(false, "Cannot open .clangd! err: "..err)
    end

    assert(file ~= nil)

    file:write(string.format([[
If:
    PathMatch: src/.*
CompileFlags:
    Add: [
        -std=c++20,
        -Wno-implicit-function-declaration, -Wno-int-conversion, -ferror-limit=500,
        -xc++, 
%s
        -std=c++20
    ]
    Remove: -W*
    Compiler: gcc
InlayHints:
    BlockEnd: No
    Designators: Yes
    Enabled: Yes
    ParameterNames: Yes
    DeducedTypes: Yes
Diagnostics:
    IgnoreWarnings:
      - "-Wall"
      - "-Wextra"
]], includedirs))

    file:close()
end


add_includedirs(home .. "/miniconda/envs/cppenv/include")
add_includedirs(home .. "/miniconda3/envs/cppenv/x86_64-conda-linux-gnu/include/c++/13.2.0")
-- add_includedirs(slang_home .. "/include")
add_includedirs(slang_home .. "/install/include")
add_includedirs(slang_home .. "/install/include/parsing")


gen_clangd(".clangd")

