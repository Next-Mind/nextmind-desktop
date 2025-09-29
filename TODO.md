# ✅ TODO do Projeto Integrador

## 📊 Dashboard

-   [x] Conectar chamadas da API com token de autenticação
-   [x] Exibir cards de resumo (Alunos, Psicólogos, Admins, Usuários)
-   [x] Adicionar estados de **loading** e **erro**
-   [ ] Atualizar gráficos para usar dados reais da API (quando
    disponíveis)

## 🛠 Management

-   [x] Criar layout base (título centralizado, cores seguindo o Theme)
-   [ ] Criar **cards de gerenciamento** em arquivo separado
    (`management_cards.dart`)
-   [ ] Implementar aba **Psicólogos Pendentes**
    -   [ ] Listar psicólogos aguardando aprovação
    -   [ ] Permitir abrir o PDF do documento enviado
    -   [ ] Habilitar botão de aprovação somente após leitura do PDF
-   [ ] Implementar aba **Admins Pendentes**
    -   [ ] Exibir informações do cadastro
    -   [ ] Botão para aprovar/rejeitar conta
-   [ ] Criar mensagens de sucesso/erro (Snackbars ou Dialogs)

## 📬 Support

-   [x] Criar layout com lista de chamados + painel de detalhes
-   [x] Adicionar estatísticas (Resolvidos, Abertos, Pendentes)
-   [x] Adicionar botões para **Marcar como Concluído/Pendente**
-   [ ] Conectar com API para receber chamados reais
-   [ ] Adicionar filtro (por status ou data)

## 🚨 Reported

-   [x] Criar layout com Toggle (Reportados / Banidos)
-   [x] Exibir detalhes do usuário e reports
-   [x] Adicionar botões de Banir/Desbanir/Resolver
-   [ ] Conectar com API para trazer lista de usuários reportados
-   [ ] Implementar ações reais de banimento/desbanimento

## 🔐 Autenticação e Sessão

-   [x] Recuperar token do `SharedPreferences`
-   [ ] Criar botão de logout funcional (limpar token + redirecionar
    para login)
-   [ ] Adicionar tratamento para token expirado (deslogar automático)

## 🎨 UI/UX Geral

-   [ ] Padronizar cores de todos os screens com o `ThemeData`
-   [ ] Criar componentes reutilizáveis (ex: botão padrão, card padrão)
-   [ ] Adicionar animações sutis (Fade, Slide, Hero) para transições
-   [ ] Garantir responsividade para telas menores

## 🧪 Testes

-   [ ] Testar fluxo de aprovação de psicólogos
-   [ ] Testar fluxo de suporte (marcar concluído, pendente)
-   [ ] Testar login/logout e proteção de rotas
-   [ ] Testar com diferentes tamanhos de tela
