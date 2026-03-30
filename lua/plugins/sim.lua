-- Simulation keymaps for SystemVerilog (iverilog + GTKWave)
-- Expects a sim/ directory at project root with a tb_<module>.sv testbench
--
-- Workflow:
--   <leader>sb  →  compile with iverilog
--   <leader>sr  →  compile + run simulation (generates dump.vcd)
--   <leader>sw  →  open dump.vcd in GTKWave

local function get_root()
  return vim.fn.getcwd()
end

local function sim_compile()
  local root = get_root()
  -- Compile all .sv files found under rtl/ and sim/
  local cmd = string.format(
    "iverilog -g2012 -I%s/rtl -o %s/sim/sim.out $(find %s/rtl %s/sim -name '*.sv' 2>/dev/null | tr '\\n' ' ')",
    root, root, root, root
  )
  require("toggleterm.terminal").Terminal:new({
    cmd = cmd,
    direction = "horizontal",
    close_on_exit = false,
  }):toggle()
end

local function sim_run()
  local root = get_root()
  local compile = string.format(
    "iverilog -g2012 -I%s/rtl -o %s/sim/sim.out $(find %s/rtl %s/sim -name '*.sv' 2>/dev/null | tr '\\n' ' ') && vvp %s/sim/sim.out",
    root, root, root, root, root
  )
  require("toggleterm.terminal").Terminal:new({
    cmd = compile,
    direction = "horizontal",
    close_on_exit = false,
  }):toggle()
end

local function open_waveform()
  local root = get_root()
  local vcd = root .. "/sim/dump.vcd"
  if vim.fn.filereadable(vcd) == 1 then
    vim.fn.jobstart({ "surfer", vcd }, { detach = true })
  else
    vim.notify("No waveform found at " .. vcd, vim.log.levels.WARN)
  end
end

vim.keymap.set("n", "<leader>sb", sim_compile,    { desc = "SV: compile" })
vim.keymap.set("n", "<leader>sr", sim_run,         { desc = "SV: compile + run sim" })
vim.keymap.set("n", "<leader>sw", open_waveform,   { desc = "SV: open waveform in GTKWave" })

return {}
