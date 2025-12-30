local busted = require('busted')
local assert = require('luassert')
local yaml   = require('tinyyaml')

busted.describe("numbers in nested seq:", function ()
    local parsed_yaml = yaml.parse('case: [["status", "==", 302]]')
    local parsed_yaml2 = yaml.parse('case: [["status", "==", "302"]]')
    busted.it("numbers", function ()
        assert.same(
            {
                case = {{"status", "==", 302}}
            },
            yaml.parse([[
                case:
                - - "status"
                  - "==" 
                  - 302
                ]]
            )
        )
    end)

    busted.it("numbers in inline nested seq:", function ()
        assert.same(
            {
                case = {{"status", "==", 302}}
            },
            yaml.parse([[
                case:
                - 
                  - "status"
                  - "==" 
                  - 302
                ]]
            )
        )
    end)

    busted.it("number inside [] brackets", function ()
        assert.same(
            {
                case = {{"status", "==", 302}}
            }, parsed_yaml
        )
    end)

    busted.it("number inside [] brackets in double quotes", function ()
        assert.same(
            {
                case = {{"status", "==", "302"}}
            }, parsed_yaml2
        )
    end)
end)
