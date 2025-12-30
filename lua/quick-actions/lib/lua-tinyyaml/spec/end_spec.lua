local busted = require 'busted'
local assert = require 'luassert'
local yaml = require 'tinyyaml'

busted.describe("example", function()

    local t = yaml.parse(io.open("spec/example.yaml"):read('*a'))

    busted.it("end", function()
        assert.same(
            null,
            t.after_end
        )
    end)
end)
