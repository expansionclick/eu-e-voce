EU E VOCÊ — VERSÃO COM CORREÇÕES

1. Substitui o index.html no repositório pelo index.html deste pacote.
2. Cria config.js na mesma pasta do index.html, usando config.js.example como modelo.
3. Em config.js, preenche o Project URL, a chave pública publishable/anon e os e-mails exatos autorizados.
4. Não publiques service_role/secret keys nem palavras-passe.
5. No Supabase Auth > Users, confirma que os utilizadores existem e que a palavra-passe está correta.
6. O site precisa da tabela album_state com id (integer, primary key), payload (jsonb) e updated_at (timestamptz), e políticas RLS que autorizem apenas os e-mails previstos.
7. O bucket album-fotos deve existir e ser privado; as políticas de Storage também têm de permitir uploads/leitura aos utilizadores autorizados.

O código agora mostra mensagens de erro de autenticação mais específicas, trata exceções de login/configuração e enfileira gravações na nuvem para reduzir perda de alterações rápidas. Isto não substitui a configuração correta do Supabase.
