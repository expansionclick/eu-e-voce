-- Eu e Você — execute no SQL Editor do Supabase.
-- Substitua os dois e-mails pelos e-mails reais autorizados (minúsculas).
-- Se só tem um por agora, use o seu no primeiro e deixe o segundo placeholder
-- até conhecer o segundo e-mail. Atualize a policy antes de adicionar a segunda pessoa.

create table if not exists public.album_state (
  id integer primary key check (id = 1),
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.album_state enable row level security;
grant select, insert, update on public.album_state to authenticated;

drop policy if exists "eu-e-voce-select" on public.album_state;
create policy "eu-e-voce-select" on public.album_state
for select to authenticated
using (lower(coalesce(auth.jwt() ->> 'email','')) in ('tomaseodmira@gmail.com','SUBSTITUIR-PELO-SEGUNDO-EMAIL'));

drop policy if exists "eu-e-voce-insert" on public.album_state;
create policy "eu-e-voce-insert" on public.album_state
for insert to authenticated
with check (lower(coalesce(auth.jwt() ->> 'email','')) in ('tomaseodmira@gmail.com','SUBSTITUIR-PELO-SEGUNDO-EMAIL'));

drop policy if exists "eu-e-voce-update" on public.album_state;
create policy "eu-e-voce-update" on public.album_state
for update to authenticated
using (lower(coalesce(auth.jwt() ->> 'email','')) in ('tomaseodmira@gmail.com','SUBSTITUIR-PELO-SEGUNDO-EMAIL'))
with check (lower(coalesce(auth.jwt() ->> 'email','')) in ('tomaseodmira@gmail.com','SUBSTITUIR-PELO-SEGUNDO-EMAIL'));

-- Crie um bucket album-fotos e marque como Private antes de usar.
drop policy if exists "eu-e-voce-storage-select" on storage.objects;
create policy "eu-e-voce-storage-select" on storage.objects for select to authenticated
using (bucket_id='album-fotos' and lower(coalesce(auth.jwt() ->> 'email','')) in ('tomaseodmira@gmail.com','SUBSTITUIR-PELO-SEGUNDO-EMAIL'));

drop policy if exists "eu-e-voce-storage-insert" on storage.objects;
create policy "eu-e-voce-storage-insert" on storage.objects for insert to authenticated
with check (bucket_id='album-fotos' and lower(coalesce(auth.jwt() ->> 'email','')) in ('tomaseodmira@gmail.com','SUBSTITUIR-PELO-SEGUNDO-EMAIL'));

drop policy if exists "eu-e-voce-storage-update" on storage.objects;
create policy "eu-e-voce-storage-update" on storage.objects for update to authenticated
using (bucket_id='album-fotos' and lower(coalesce(auth.jwt() ->> 'email','')) in ('tomaseodmira@gmail.com','SUBSTITUIR-PELO-SEGUNDO-EMAIL'))
with check (bucket_id='album-fotos' and lower(coalesce(auth.jwt() ->> 'email','')) in ('tomaseodmira@gmail.com','SUBSTITUIR-PELO-SEGUNDO-EMAIL'));

drop policy if exists "eu-e-voce-storage-delete" on storage.objects;
create policy "eu-e-voce-storage-delete" on storage.objects for delete to authenticated
using (bucket_id='album-fotos' and lower(coalesce(auth.jwt() ->> 'email','')) in ('tomaseodmira@gmail.com','SUBSTITUIR-PELO-SEGUNDO-EMAIL'));
