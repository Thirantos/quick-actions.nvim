local busted = require 'busted'
local assert = require 'luassert'
local yaml = require 'tinyyaml'

busted.describe("empty lines", function()
  busted.it("multi-line scalar", function()
    assert.same(
      {
        abstract = "This is the abstract.\nIt consists of two paragraphs.\n"
      },
      yaml.parse([[
        abstract: |
          This is the abstract.
          It consists of two paragraphs.
      ]])
    )
    assert.same(
      {
        abstract = "This is the abstract.\n\nIt consists of two paragraphs.\n"
      },
      yaml.parse([[
        abstract: |
          This is the abstract.

          It consists of two paragraphs.
      ]])
    )
    assert.same(
      {
        abstract = "This is the abstract.\n\n\nIt consists of two paragraphs.\n"
      },
      yaml.parse([[
        abstract: |
          This is the abstract.


          It consists of two paragraphs.
      ]])
    )
  end)
end)
