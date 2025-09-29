# ✅ TODO do Projeto Integrador

## 🏠 Home

-   [ ] Adicionar dados reais ao Card de Chamados Abertos (quando
    disponíveis)
-   [ ] Adicionar dados reais aos Gráficos (quando
    disponíveis)
-   [ ] Adicionar o Log de Atividades Recentes (quando
    disponíveis)

## 📊 Dashboard

-   [x] Conectar chamadas da API com token de autenticação
-   [x] Exibir cards de resumo (Alunos, Psicólogos, Admins, Usuários)
-   [x] Adicionar estados de **loading** e **erro**
-   [ ] Atualizar gráficos para usar dados reais da API (quando
    disponíveis)
-   [ ] Adicionar o Log de Atividades Recentes (quando
    disponíveis)

## 🛠 Management

-   [x] Criar layout base (título centralizado, cores seguindo o Theme)
-   [ ] Implementar aba **Psicólogos Pendentes** com **informação da API**.
    -   [ ] Listar psicólogos aguardando aprovação
    -   [ ] Permitir abrir o PDF do documento enviado
    -   [ ] Habilitar botão de aprovação somente após leitura do PDF
-   [ ] Implementar aba **Admins Pendentes** com **informação da API**.
    -   [ ] Criar tela para exibir informações do cadastro
    -   [ ] Botão para aprovar/rejeitar conta
-   [ ] Criar mensagens de sucesso/erro (Snackbars ou Dialogs)

## 🚨 Reported

-   [x] Criar layout com Toggle (Reportados / Banidos)
-   [x] Exibir detalhes do usuário e reports
-   [x] Adicionar botões de Banir/Desbanir/Resolver
-   [ ] Conectar com API para trazer lista de usuários reportados
-   [ ] Implementar ações reais de banimento/desbanimento

## 📬 Support

-   [x] Criar layout com lista de chamados + painel de detalhes
-   [x] Adicionar estatísticas (Resolvidos, Abertos, Pendentes)
-   [x] Adicionar botões para **Marcar como Concluído/Pendente**
-   [ ] Conectar com API para receber chamados reais
-   [ ] Adicionar filtro (por status ou data)

## 📥 Reports

-   [ ] Adicionar mais filtros especificos pro tipo de usuario.
-   [ ] Filtros para Alunos:
    -   [ ] Periodo
    -   [ ] Ano
    -   [ ] Idade
    -   [ ] Ativo

-   [ ] Filtros para Psicologos:
    -   [ ] Tempo
    -   [ ] Carga Horaria
    -   [ ] Quantidade de Alunos

## 🔐 Autenticação e Sessão

-   [x] Recuperar token do `SharedPreferences`
-   [x] Adicionar tratamento para token expirado (deslogar automático)
-   [x] Criar botão de logout funcional (limpar token + redirecionar
    para login)
-   [ ] Recuperar senha funcional
-   [ ] Cadastrar Administrador Funcional

## 🎨 UI/UX Geral

-   [x] Padronizar cores de todos os screens com o `ThemeData`
-   [x] Criar componentes reutilizáveis (ex: botão padrão, card padrão)
-   [x] Adicionar animações sutis (Fade, Slide, Hero) para transições
-   [x] Garantir responsividade para telas menores

## 🧪 Testes

-   [ ] Testar fluxo de aprovação de psicólogos
-   [ ] Testar fluxo de suporte (marcar concluído, pendente)
-   [x] Testar login/logout e proteção de rotas
-   [x] Testar com diferentes tamanhos de tela
