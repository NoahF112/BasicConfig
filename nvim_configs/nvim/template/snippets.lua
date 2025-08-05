local ls = require("luasnip")

-- clear all previous snippets
ls.cleanup()

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets(
    "markdown", -- language
    {
        -- s(
        --     "prefix", --prefix
        --     {
        --         t("["),
        --         i(0, "text"), -- insert node and placeholder
        --         t("]", ""), -- "" means return this line
        --         t("abc"),
        --     }
        -- ),
        s("\\oper",
            fmt("\\operatorname*{{{}}}", {i(0, "arg min")})
        ),
        -- s("\\align",
        --     fmt("\\begin(aligned)\n{}\n\\end{aligned}")
        -- )
    }
)
