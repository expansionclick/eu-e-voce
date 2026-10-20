# Eu e Você — GitHub + Cloudflare Pages + Supabase

## O que está pronto
- `index.html`: adaptação inicial para login por e-mail/password, estado do álbum na tabela `album_state`, consulta de sincronização periódica e uploads privados para `album-fotos`.
- `config.js.example`: modelo para criar `config.js`.
- `supabase/schema.sql`: tabela e políticas de segurança iniciais.
- `index-original-backup.html`: cópia do HTML original sem alterações.

**Este é um scaffold de integração que exige configuração e testes antes do lançamento.** Não foi testado contra o teu projeto Supabase, porque não temos a URL, chave, utilizador e políticas reais. Não coloques credenciais secretas em mensagens.

## 1 — Supabase
1. Extrai este ZIP no computador.
2. Copia `config.js.example` para `config.js`.
3. Em `config.js`, preenche a Project URL e a chave publicável `anon`/`publishable` em Supabase > Project Settings > API.
4. Preenche `allowedEmails` com o teu e-mail real. Quando souberes o segundo e-mail, adiciona-o também.
5. Em `supabase/schema.sql`, substitui `O-TEU-EMAIL-AQUI` pelo teu e-mail (minúsculas). Deixa o segundo placeholder temporariamente, e substitui-o quando tiveres o segundo e-mail.
6. Executa o SQL em Supabase > SQL Editor.
7. Em Storage, cria `album-fotos` como bucket **Private**.
8. Em Authentication > Users, cria manualmente o utilizador com o teu e-mail e uma palavra-passe forte. Não atives inscrição pública.
9. Em Authentication > URL Configuration, configura o URL de produção Cloudflare Pages como Site URL e Redirect URL.

## 2 — GitHub
1. Cria um repositório **privado** chamado `eu-e-voce`.
2. Envia `index.html`, `config.js`, `README.md` e a pasta `supabase`.
3. Não envies cópias de segurança com memórias pessoais para um repositório público.
4. A chave publicável pode estar no frontend com RLS corretamente configurada; nunca coloques `service_role`/secret no HTML ou GitHub.

## 3 — Cloudflare Pages
1. Cloudflare Dashboard > Workers & Pages > Create > Pages > Connect to Git.
2. Liga o repositório GitHub.
3. Framework preset: None; build command vazio; output directory `.` ou `/` conforme o formulário.
4. Publica e copia o URL `*.pages.dev`.
5. Acrescenta o URL às URLs autorizadas do Supabase.

## 4 — Testar
1. Sem sessão, a página deve mostrar apenas o conteúdo de demonstração, não o álbum real.
2. Entra com o e-mail autorizado.
3. Adiciona uma fotografia pequena e uma história.
4. Abre o mesmo URL no segundo telemóvel e entra com o mesmo utilizador; confirma que as alterações aparecem em cerca de 5 segundos.
5. Testa com uma conta não autorizada. Não deve ler nem alterar a tabela ou os ficheiros.
6. Usa “Exportar cópia (.json)” para fazer cópias de segurança regulares.

## Limitações desta primeira integração
- Sincronização por consulta de 5 em 5 segundos, não instantânea.
- Edições simultâneas podem entrar em conflito; não editem ao mesmo tempo em dois dispositivos.
- Os URLs assinados para ficheiros duram 7 dias e são renovados ao carregar o estado.
- Backups automáticos, recuperação de palavra-passe, convites e tratamento avançado de erros ainda precisam de ser concluídos e testados.
- Os utilizadores devem ser criados manualmente no painel.

## Documentação oficial
- Supabase Auth: https://supabase.com/docs/guides/auth/passwords
- Supabase Storage privado: https://supabase.com/docs/guides/storage/buckets/fundamentals
- Segurança e RLS: https://supabase.com/docs/guides/database/secure-data
- Cloudflare Pages com Git: https://developers.cloudflare.com/pages/configuration/git-integration/
