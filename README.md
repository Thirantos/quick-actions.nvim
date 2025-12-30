# quick-actions.nvim

A neovim plugin for workspace specific action.

## Usage

Searched for a file names `.nvimqa` (customizable) in the current working directory of the workspace. 
This is a yaml file where different actions can be defined, both normal actions and auto actions.

Normal actions can be defined with a keybind which, if pressed together with the `keybind_prefix` (default: `<leader>a`) runs the action.
Another way to run the action is using a vim command `:QuickAction <action name>` or through lua `require("quick-actions").run(<action name>)`

Auto actions will run on autocmd events, the auto actions defined are:

| Action  | Event        |
|---------|--------------|
| `onOpen`  | BufReadPost  |
| `onWrite` | BufWritePost |
| `onNew`   | BufNewFile   |
| `onExit`  | ExitPre      |

Actions can contain both cmd commands which runs a shell command and vim commands which runs a vim command.

An example of a `.nvimqa` is
```yaml
action:
  compile:
    keybind: "c"
    cmd:
      - "make all"
auto:
  onNew:
    cmd:
      - "git add ."
```

## Installation

### lazy.nvim

```lua 
{
    "thirantos/quick-actions.nvim",
    ---@module 'quick-actions'
    ---@type quick-actions.SetupOpts
    opts = {}
}
```

## Configuration

| Option           | Type   | Default     | Description                         |
|------------------|--------|-------------|-------------------------------------|
| actions_filename | string | `".nvimqa"`   | The file to use for the actions     |
| keybind_prefix   | string | `"<leader>a"` | The prefix for the defined keybinds |



