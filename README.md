# Eu e Você — integração Supabase (versão corrigida)

## Conteúdo
- `index.html`: site com cliente Supabase carregado antes do código do álbum e leitura/gravação cloud.
- `config.js.example`: modelo de configuração; copiar para `config.js`.
- `supabase/schema.sql`: tabela e políticas RLS para apenas os e-mails autorizados.
- `index-original-backup.html`: cópia do HTML original para recuperação.

**Importante:** esta versão corrige a falta dos scripts que carregam o cliente Supabase e `config.js`, mas ainda precisa de configuração e teste no teu projeto real. Não consigo verificar o estado interno do teu Supabase/Cloudflare apenas pelo ficheiro.

## 1. Configurar Supabase
1. Abre `config.js.example` e cria uma cópia chamada exatamente `config.js`.
2. Em `config.js`, substitui a URL do projeto e a chave publicável (`sb_publishable_...` ou `anon`). Essa chave pública pode estar no navegador; **nunca uses `service_role` ou uma chave `secret`**.
3. Substitui os e-mails de exemplo pelos e-mails das duas pessoas autorizadas, em minúsculas.
4. Abre `supabase/schema.sql`, substitui os mesmos placeholders pelos mesmos e-mails reais e executa o SQL no Supabase SQL Editor. Se já executaste uma versão anterior, este SQL atualiza as políticas com os nomes definidos aqui.
5. Em Storage, confirma que existe o bucket `album-fotos` e que está **Private** (Public desativado).
6. Em Authentication > Users, cria os utilizadores autorizados com palavras-passe fortes. Não atives inscrição pública.
7. Em Authentication > URL Configuration, adiciona o URL público do site às URLs autorizadas.

## 2. Atualizar o GitHub
No repositório `expansionclick/eu-e-voce`, envia/atualiza estes ficheiros na raiz:
- `index.html` (deste pacote)
- `config.js` (criado a partir do exemplo e preenchido)
- `supabase/schema.sql`
- `README.md`

Não publiques `index-original-backup.html` se contiver memórias pessoais. Recomenda-se manter o repositório **privado**. A chave publicável não é a senha da base de dados, mas as políticas RLS têm de estar corretas.

## 3. Cloudflare
O endereço que tinhas indicado anteriormente termina em `workers.dev`, portanto é um Worker. A integração pode funcionar se o Worker estiver a servir estes ficheiros estáticos corretamente. Depois do push, confirma que o deploy atualizou e que `https://TEU-SITE/config.js` abre o ficheiro de configuração (não deve mostrar erro 404). Se o projeto estiver configurado como Pages, usa o URL `pages.dev` e configura esse mesmo URL no Supabase.

## 4. Teste obrigatório
1. Abre o site e confirma que aparece o texto para iniciar sessão.
2. Entra com o primeiro e-mail autorizado e adiciona uma nota de teste.
3. Abre o mesmo site noutro telefone/navegador e entra com o segundo e-mail autorizado; confirma que a nota aparece em até cerca de 5 segundos.
4. Testa um e-mail não autorizado: não deve conseguir ler nem escrever o álbum.
5. Se aparecer erro, abre as ferramentas de programador/Console ou envia uma captura do erro — sem partilhar palavras-passe nem chaves secretas.

## Limitações atuais
- A sincronização é consultada aproximadamente a cada 5 segundos, não é instantânea.
- Edições simultâneas podem sobrepor alterações; evitem editar ao mesmo tempo.
- Fotos e outros ficheiros são enviados para o bucket privado; os links temporários são renovados ao carregar o álbum.
- Recuperação de palavra-passe, convites e resolução avançada de conflitos não estão implementados.
