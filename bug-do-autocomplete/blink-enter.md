# Debug: Neovim blink/Copilot Enter deixa de aceitar completion

## Contexto inicial

Sintoma relatado:

```python
def foo(a, b):
    pass

fo<CURSOR>
```

- `blink.cmp` mostra completions; primeira costuma ser `foo`.
- `Enter` normalmente aceita a completion.
- `alt+[` dispara Copilot; aceitar sugestão normalmente completa corretamente.
- Intermitentemente, sem causa aparente, o `Enter` passa a inserir nova linha em vez de aceitar completion.
- O problema ocorreu em outro pane do tmux.
- Várias tentativas anteriores com agentes não resolveram.

## Regra desta investigação

Nenhuma correção será proposta ou aplicada antes de identificar root cause com evidência.

## Fase 1 — Root cause

### 2026-05-17 — Início

Ações planejadas:

1. Localizar configuração Neovim relevante (`blink.cmp`, Copilot, keymaps, autocmds, lazy specs).
2. Capturar estado do Neovim quando funciona e quando quebra.
3. Comparar handlers reais de `<CR>`/`<M-[>` e estado dos plugins nos dois momentos.
4. Só então formular hipótese.

### Evidências coletadas estaticamente

Arquivos relevantes:

- `~/.config/nvim/lua/plugins/dev/blink/init.lua`
- `~/.config/nvim/lua/plugins/dev/blink/mappings.lua`
- `~/.config/nvim/lua/plugins/dev/copilot.lua`
- `~/.config/nvim/lua/plugins/dev/luasnip.lua`
- `~/.local/share/nvim/lazy/blink.cmp/lua/blink/cmp/keymap/apply.lua`

Versões travadas em `lazy-lock.json`:

- `blink.cmp`: `78336bc89ee5365633bcf754d93df01678b5c08f`
- `copilot.lua`: `7e9c269bf40dea86b44e64bd746f1808e991e419`
- `LuaSnip`: `a62e1083a3cfe8b6b206e7d3d33a51091df25357`

Configuração observada:

- `blink.cmp` aplica keymaps como buffer-local mappings em modo insert/snippet.
- `<CR>` em `plugins/dev/blink/mappings.lua` tenta, nesta ordem:
  1. aceitar sugestão Copilot se `copilot.suggestion.is_visible()`;
  2. `cmp.accept()` se há snippet ativo;
  3. `cmp.select_and_accept()` caso contrário;
  4. `accept` builtin;
  5. `fallback` para comportamento normal do Enter.
- Copilot está com `suggestion.keymap.accept = false`; portanto aceite via `<CR>` depende do wrapper do blink.
- `blink.cmp/keymap/apply.lua` tem guarda global por buffer: se qualquer keymap insert com descrição começando por `blink.cmp` já existir, `keymap_to_current_buffer()` retorna sem aplicar os demais keymaps.
- Há bloco comentado em `blink/init.lua` descrevendo um problema parecido: “mappings sumirem após sair do multicursor mode”. Isso é evidência histórica, não root cause confirmado.

### Instrumentação criada

Script: `/home/matheus/.config/nvim/bug-do-autocomplete/blink-dump.lua`

Objetivo: capturar, dentro da sessão Neovim afetada, o estado real de:

- mappings de `<CR>`, `<Tab>`, `<S-Tab>`, `<C-space>`, `<M-[>`, `<M-]>` nos modos `i`, `s`, `n`;
- keymaps buffer-local relacionados ao blink;
- estado `blink.cmp`: `is_visible`, `is_active`, `snippet_active`;
- estado Copilot: `suggestion.is_visible()`;
- `filetype`, `buftype`, `vim.b.completion`.

Próximo passo necessário: rodar o dump tanto quando funciona quanto quando quebra, na própria instância Neovim em que o bug ocorreu.

### Dump quebrado recebido

Arquivo: `~/.config/nvim/bug-do-autocomplete/blink-dump-20260517-183523.log`

Observações:

- Buffer: `filetype=python`, `buftype=""`; o blink não deveria estar desabilitado por blacklist/prompt.
- Modo no momento do dump: normal (`mode="n"`), então o dump não prova o estado exato da janela de completion aberta.
- `maparg("<CR>", "i") = vim.empty_dict()`.
- `maparg("<CR>", "s")` existe e aponta para `desc = "blink.cmp: <Custom Fn>, Accept"`.
- Outros mappings insert do blink existem: `<C-space>`, `<Tab>`, `<S-Tab>`, `<C-k>`, `<C-l>`, etc.
- Mappings Copilot insert existem: `<M-[>` e `<M-]>`.

Conclusão factual:

- O problema observado não é “Enter escolheu fallback apesar do mapping existir”.
- No buffer quebrado, o mapping insert de `<CR>` simplesmente não existe.
- O fato de outros mappings blink existirem no mesmo buffer torna provável uma perda parcial/reaplicação parcial de keymaps, não falha completa do plugin.

Hipóteses ainda abertas:

1. Algum plugin/autocmd apaga especificamente o `<CR>` em modo insert depois que o blink aplica os mappings.
2. O blink aplica um conjunto incompleto por causa da guarda “se já existe qualquer mapping blink, não reaplica tudo”.
3. Um estado de snippet/multicursor/alguma transição de modo deixa mappings de modo insert e select inconsistentes.

### Dump quebrado adicional

Arquivo: `~/.config/nvim/bug-do-autocomplete/blink-dump-20260517-183944.log`

Observações:

- Buffer: `bufnr=2`, `filetype=python`, `buftype=""`.
- Nenhum mapping blink buffer-local em modo insert/select.
- `<Tab>` e `<S-Tab>` vêm de mapping global do `tabhula.nvim`, não do blink.
- `<M-[>` e `<M-]>` do Copilot estão presentes como buffer-local.

Esse dump indica outro estado possível: buffer Python válido onde o blink não aplicou mappings buffer-local. Como o dump foi feito em modo normal, ainda falta observar o evento `InsertEnter` seguinte nesse buffer com o tracer instalado.

### Evidência sobre `vim-visual-multi`

Arquivos relevantes:

- `~/.config/nvim/lua/plugins/edit/vim-visual-multi.lua`
- `~/.local/share/nvim/lazy/vim-visual-multi/autoload/vm/maps/all.vim`
- `~/.local/share/nvim/lazy/vim-visual-multi/autoload/vm/maps.vim`

Configuração local:

- `vim-visual-multi` está ativo com `<C-n>`, `<C-M-l>`, `<C-M-k>`.
- O bloco comentado em `blink/init.lua` já mencionava “mappings sumirem após sair do multicursor mode”.

Código do plugin:

- `autoload/vm/maps/all.vim` define `"I Return": ['<CR>', 'i']`.
- `autoload/vm/maps.vim` permite sobrescrever buffer-local insert mappings existentes:
  - se já existe mapping buffer-local e o modo é insert (`m == 'i'`), ele registra `Overwritten imap` e segue.
- O mesmo arquivo gera `silent! iunmap <buffer> <CR>` para limpeza posterior.

Conclusão provável:

- Quando `vim-visual-multi` inicia em um buffer onde o blink já instalou `<CR>` buffer-local, ele sobrescreve o `<CR>` do blink.
- Quando `vim-visual-multi` sai, ele executa `iunmap <buffer> <CR>` e não restaura o mapping anterior.
- Resultado esperado: `<CR>` desaparece em modo insert, enquanto outros mappings blink continuam presentes. Isso bate exatamente com o primeiro dump quebrado.

Evidência de confirmação:

Arquivo: `~/.config/nvim/bug-do-autocomplete/vm-dump-20260517-184726.log`

`b:VM_Debug.lines` contém:

```text
b1: Overwritten imap: <CR> (I Return)  ->  <Lua callback>
```

Também há sobrescrita de outros mappings insert do blink:

```text
b1: Overwritten imap: <C-b> (I CtrlB)  ->  <Lua callback>
b1: Overwritten imap: <C-d> (I CtrlD)  ->  <Lua callback>
b1: Overwritten imap: <C-f> (I CtrlF)  ->  <Lua callback>
b1: Overwritten imap: <C-u> (I CtrlU)  ->  <Lua callback>
b1: Overwritten imap: <BS> (I BS)  ->  <Lua callback>
b1: Overwritten imap: <Down> (I Down Arrow)  ->  <Lua callback>
b1: Overwritten imap: <Up> (I Up Arrow)  ->  <Lua callback>
```

`b:VM_unmaps` contém:

```text
silent! iunmap <buffer> <CR>
```

Estado final no mesmo dump:

```text
insert <CR> = vim.empty_dict()
```

Root cause confirmado:

- `vim-visual-multi` entrou em modo de seleção no buffer `1` em algum momento.
- Ao entrar, ele sobrescreveu o `<CR>` buffer-local do blink em modo insert.
- Ao sair, ele removeu o mapping `<CR>` buffer-local com `iunmap <buffer> <CR>`.
- Como o mapping original do blink não é restaurado, `Enter` volta ao comportamento nativo do Neovim: inserir nova linha.

Mitigação manual para recuperar um buffer quebrado sem reiniciar:

- Script: `/home/matheus/.config/nvim/bug-do-autocomplete/blink-restore.lua`
- Comando no Neovim:

```vim
:luafile ~/.config/nvim/bug-do-autocomplete/blink-restore.lua
```

O script remove mappings parciais do blink no buffer atual e reaplica `plugins.dev.blink.mappings`.

Observação importante:

- O usuário não lembra de ter usado multicursor. Portanto ainda há uma pergunta secundária: qual gatilho iniciou o `vim-visual-multi` nesse buffer? Isso não altera o root cause do `<CR>` sumir, mas importa para evitar recorrência inesperada.

### Opções de correção sem patchar plugin externo

O diretório `/home/matheus/.local/share/nvim/lazy/vim-visual-multi/` não deve ser editado diretamente.

Opções viáveis em `~/.config/nvim`:

1. Configuração do próprio `vim-visual-multi`: definir `g:VM_maps["I Return"] = ""` antes do plugin inicializar. Isso impede o VM de mapear `<CR>` em insert mode.
2. Self-healing no config do blink: ao entrar em insert/buffer, se `<CR>` não for um mapping buffer-local do blink, remover mappings parciais do blink e reaplicar `plugins.dev.blink.mappings`.
3. Combinação das duas: evitar o conflito conhecido e ter recuperação automática caso outro plugin apague o `<CR>`.

Recomendação atual: aplicar self-healing no config do blink. É o menos acoplado ao `vim-visual-multi` e também cobre o fato de o usuário não ter acionado multicursor conscientemente.

### Correção aplicada

Arquivo alterado: `/home/matheus/.config/nvim/lua/plugins/dev/blink/init.lua`

Implementado inicialmente:

- `M.repair_keymaps()`:
  - verifica se `blink.cmp.config.enabled()` permite completion no buffer atual;
  - verifica se `<CR>` em insert já é um mapping do blink;
  - não interfere se `<CR>` está temporariamente mapeado pelo `vim-visual-multi` (`<Plug>(VM-I-...)`);
  - remove mappings parciais do blink em modos `i` e `s`;
  - reaplica `plugins.dev.blink.mappings` via `blink.cmp.keymap.apply`.
- Autocmd `blink_cmp_keymap_repair` em `BufEnter` e `InsertEnter`.
- Comando manual `:BlinkRepairKeymaps`.

Ajuste após discussão:

- Removidos gatilhos genéricos `BufEnter` e `InsertEnter`.
- O reparo automático roda apenas em `User BlinkCmpMenuOpen`.
- Arquivo alterado adicional: `/home/matheus/.config/nvim/lua/plugins/dev/copilot.lua`.
- Os mappings nativos do Copilot para `next`/`prev` foram desabilitados (`false`).
- Foram criados wrappers próprios para `<M-]>` e `<M-[>` que reparam keymaps do blink antes de chamar `copilot.suggestion.next()`/`prev()`.

Validação executada:

```bash
luac -p /home/matheus/.config/nvim/lua/plugins/dev/blink/init.lua
luac -p /home/matheus/.config/nvim/lua/plugins/dev/copilot.lua
```

Resultado: sem erro de sintaxe.

Ajuste de organização:

- Funções auxiliares de reparo movidas para o final de `blink/init.lua`.
- Wrappers auxiliares do Copilot movidos para o final de `copilot.lua`.
- Revalidado com `luac -p` nos dois arquivos.

### Instrumentação adicional criada

Script: `/home/matheus/.config/nvim/bug-do-autocomplete/blink-trace.lua`

Objetivo: instalar um tracer na sessão Neovim para registrar futuras chamadas a:

- `vim.api.nvim_buf_set_keymap`
- `vim.api.nvim_buf_del_keymap`
- `vim.api.nvim_set_keymap`
- `vim.api.nvim_del_keymap`
- `vim.keymap.set`
- `vim.keymap.del`

O tracer registra stack trace quando a operação envolve `<CR>`, `<Tab>`, `<S-Tab>`, `<C-space>` ou uma descrição contendo `blink`.

Também registra eventos `InsertEnter`, `InsertLeave`, `ModeChanged`, `BufEnter` e eventos `User` relacionados a Blink, com o estado atual de `<CR>` insert.

Limitação: comandos Vimscript como `imap`/`iunmap`, usados por `vim-visual-multi`, não passam necessariamente pelos wrappers Lua instalados pelo tracer. Para essa trilha, foi criado também `/home/matheus/.config/nvim/bug-do-autocomplete/vm-dump.lua`, que captura `b:VM_Debug`, `b:VM_maps` e `b:VM_unmaps`.

