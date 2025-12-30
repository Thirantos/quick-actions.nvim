local busted = require('busted')
local assert = require('luassert')
local yaml   = require('tinyyaml')

busted.describe("multi line array", function()
  busted.it("multi-line array of string", function()
    assert.same(
      {
        abstract = {
            [[
This is the abstract.
First item
]],
            [[
This is the abstract.
Second Item
]],       
        },
      },
      yaml.parse([[
        abstract: 
        -   |
            This is the abstract.
            First item
        -   |
            This is the abstract.
            Second Item
      ]])
    )
  end)
end)
