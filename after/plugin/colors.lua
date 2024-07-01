local highlightKeys = {
    'fg',
    'bg',
    'bold',
    'italic',
    'reverse',
    'standout',
    'underline',
    'undercurl',
    'strikethrough',
}

-- stole this
function InheritHighlight(name, source, settings)
    for _, key in ipairs(highlightKeys) do
        if not settings[key] then
            local v = vim.fn.synIDattr(vim.fn.hlID(source), key)
            if key == 'fg' or key == 'bg' then
                local n = tonumber(v, 10)
                v = type(n) == 'number' and n or v
            else
                v = v == 1
            end
            settings[key] = v == '' and 'NONE' or v
        end
    end
    vim.api.nvim_set_hl(0, name, settings)
end

-- Stole this too
function GetHl(name)
    local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
    if not ok then
        return
    end
    for _, key in pairs({ "foreground", "background", "special" }) do
        if hl[key] then
            hl[key] = string.format("#%06x", hl[key])
        end
    end
    return hl
end

function ApplyTheme(color, transparent_background)
    color = color or "tokyonight-night"

    vim.cmd.colorscheme(color)

    -- remove bg from borders
    InheritHighlight("FloatBorder", "FloatBorder", { bg = "none" })
    InheritHighlight("FloatTitle", "FloatBorder", { bg = "none" })
    InheritHighlight("TelescopeBorder", "FloatBorder", { bg = "none" })
    InheritHighlight("NormalFloat", "NormalFloat", { bg = "none" })

    if transparent_background == true then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end

    -- the ~'s
    InheritHighlight("EndOfBuffer", "LineNr", {})

    -- InheritHighlight("CmpItemMenu", "CmpItemAbbr", {})
end

local themes = {
    "catppuccin-latte",
    "catppuccin-mocha",
    "catppuccin-frappe",
    "catppuccin-macchiato",

    "kanagawa-wave",
    "kanagawa-dragon",

    "nordic",
    "gruvbox-material",
    "everforest",
    "sonokai",

    "tokyonight-moon",
    "tokyonight-night",
    "tokyonight-storm",

    "rose-pine-main",
    "rose-pine-moon",

    "codedark",
}

local currentThemeIndex = 1
local transparentBackground = 0

local path = os.getenv("HOME") .. "/.config/nvim/theme"
local file = io.open(path, "r")

if file then
    local index = file:read("*n")
    local bool = file:read("*n")

    if index then
        currentThemeIndex = index
    end

    transparentBackground = bool or 0

    file:close()
    file = nil
end

local function saveThemeData()
    if not file then
        file = io.open(path, "w+")
        if file then
            file:write(tostring(currentThemeIndex) .. "\n" .. tostring(transparentBackground))
            file:close()
            file = nil
        end
    end
end

function CycleTheme(direction)
    currentThemeIndex = currentThemeIndex + direction
    if currentThemeIndex > #themes then
        currentThemeIndex = 1
    elseif currentThemeIndex < 1 then
        currentThemeIndex = #themes
    end

    ApplyTheme(themes[currentThemeIndex])
    saveThemeData()
end

function ToggleTransparentBackground()
    if transparentBackground == 0 then
        transparentBackground = 1
        ApplyTheme(themes[currentThemeIndex], true)
    else
        transparentBackground = 0
        ApplyTheme(themes[currentThemeIndex], false)
    end

    saveThemeData()
end

vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
    callback = function()
        saveThemeData()
    end
})

vim.keymap.set("n", "<C-Right>", function()
    CycleTheme(1)
end)
vim.keymap.set("n", "<C-Left>", function()
    CycleTheme(-1)
end)

ApplyTheme(themes[currentThemeIndex], transparentBackground == 1)
