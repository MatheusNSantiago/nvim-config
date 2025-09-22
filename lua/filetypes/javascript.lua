local is_bb_project = function() return U.is_wsl() and vim.fs.find('gaw-reverse-conf.json', {}) end

return {
  picker = {
    keymap = '<leader><leader>o',
    title = 'Javascript',
    actions = {
      {
        name = 'Iniciar Projeto BB',
        handler = function()
          local pkg = U.fs.read_json('package.json')
          if not pkg then error('arquivo package.json não foi encontrado') end

          local node_version = pkg['engines']['node']
          node_version = node_version:match("%d+$")

          U.exec_cmd(('nvm use %s; npx grunt'):format(node_version))
          U.exec_cmd('gaw-rev', 2)

          vim.defer_fn(function() vim.cmd('wincmd k') end, 100)
        end,
        condition = function()
          return is_bb_project()
        end,
      },
    },
  },
  opt = {
    updatetime = 200,
  },
  mappings = {
    {
      'n',
      '<leader>ff',
      function()
        require('conform').format({ async = true })
      end,
    },
  },
}
