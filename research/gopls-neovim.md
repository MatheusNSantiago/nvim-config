# gopls e esta configuração do Neovim

`gopls` é o servidor oficial de linguagem Go e oferece recursos LSP de completamento, diagnósticos/análises, navegação e refatoração. A documentação consultada é a do lançamento mais recente em [go.dev/gopls](https://go.dev/gopls/) e seu [índice de recursos](https://go.dev/gopls/features/).

## Inlay hints

Inlay hints são anotações inline retornadas pelo LSP (`textDocument/inlayHint`); não alteram o código. O `gopls` documenta estes tipos ([lista oficial](https://github.com/golang/tools/blob/master/gopls/doc/inlayHints.md); visão geral em [Passive features](https://go.dev/gopls/features/passive#inlay-hint)):

- `parameterNames`: nomes dos parâmetros em chamadas;
- `functionTypeParameters`: argumentos de tipo inferidos em chamadas genéricas;
- `assignVariableTypes` e `rangeVariableTypes`: tipos inferidos das variáveis em atribuições e `range`;
- `compositeLiteralFields` e `compositeLiteralTypes`: nomes de campos omitidos e tipos de literais compostos;
- `constantValues`: valores computados de constantes;
- `ignoredError`: indica chamadas cujo resultado `error` foi descartado implicitamente.

O mapa `gopls.hints` seleciona os tipos individualmente; o padrão é `{}` (nenhum tipo habilitado). A opção aparece como experimental na [referência de settings](https://go.dev/gopls/settings#hints). Por exemplo, uma configuração LSP Neovim pode incluir `settings = { gopls = { hints = { parameterNames = true, ignoredError = true } } }`; a [página oficial para Vim/Neovim](https://go.dev/gopls/editor/vim#neovim-config) documenta o formato `settings.gopls`.

**Aplicação nesta config:** `gopls` está na lista de servidores (`lua/lsp/init.lua:4-25`) e `lua/lsp/servers/gopls.lua` habilita `compositeLiteralFields`, `compositeLiteralTypes`, `functionTypeParameters`, `ignoredError` e `parameterNames`; os outros três tipos seguem desabilitados/comentados. O `on_attach` comum chama `vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })` quando o servidor anuncia `inlayHintProvider` (`lua/lsp/init.lua:46-55`), completando a configuração do lado do cliente.

## Outros recursos e o que está ligado

- **Completamento:** gopls oferece completamento LSP. A config combina `vim.lsp.protocol.make_client_capabilities()` com `blink.cmp` (`lua/lsp/init.lua:34-41`), anunciando as capacidades do cliente ao servidor; isso não substitui settings específicos do gopls. [Índice oficial de recursos](https://go.dev/gopls/features/).
- **Diagnósticos e análises:** gopls reporta erros de compilação/tipagem e achados de analisadores ([Diagnostics](https://go.dev/gopls/features/diagnostics)). A config mostra diagnósticos com virtual text, sinais e sublinhado e define atalhos para navegar/consultar diagnósticos (`gl`, `[e`/`]e`, `[E`/`]E`, `<leader>sd`; `lua/lsp/init.lua:75-96,142-157`).
- **Navegação e refatoração:** gopls fornece hover, definição, referências, rename e code actions, entre outros ([Navigation](https://go.dev/gopls/features/navigation), [Code transformations](https://go.dev/gopls/features/transformation)). Esta config mapeia `K` para hover, `gd`/`gD` para definição, `gr` para rename e `<leader>ca` para code actions. `gf` é primeiro mapeado a referências e depois remapeado a `Lspsaga finder`; o segundo mapeamento é o efetivo (`lua/lsp/init.lua:72-96`).
- **Símbolos, code lenses e folding:** o `on_attach` liga o Navbuddy se houver `documentSymbolProvider`; habilita code lenses e folding somente se o servidor anunciar, respectivamente, `codeLensProvider` e `foldingRangeProvider` (`lua/lsp/init.lua:50-70`). O gopls documenta code lenses para tarefas como `go generate` e operações de módulo ([Code lenses](https://go.dev/gopls/codelenses)); a disponibilidade visual ainda depende do suporte do cliente.
- **Semântica e formatação:** semantic tokens são recurso possível, mas `gopls` os desativa por padrão (`semanticTokens` false; [settings](https://go.dev/gopls/settings#semanticTokens)) e esta config não os habilita. gopls também oferece `gofmt` e `source.organizeImports` ([transformações](https://go.dev/gopls/features/transformation)); nesta config, o formatador Go está separado, no Conform (`goimports`, `gofmt`, `<leader>ff`; `lua/plugins/lsp/conform.lua:3-14,21-42`), não como setting do gopls.

Em suma: a integração LSP base e vários atalhos estão configurados; recursos anunciados condicionalmente podem ser usados pelo `on_attach`. Os inlay hints, em particular, exigem ainda habilitar `gopls.hints` explicitamente — ativar a exibição no Neovim não basta.
