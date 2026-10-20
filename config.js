/*
 * Copia este ficheiro para config.js.
 * Supabase > Project Settings > API: Project URL e chave publicável (anon/publishable).
 * allowedEmails controla a interface; as políticas SQL também têm de conter estes e-mails.
 * A chave publicável pode estar no frontend com RLS correta. Nunca usar service_role/secret.
 */
window.EEU_SUPABASE_CONFIG = {
  url: "https://gjtrylsooumaedsvvggm.supabase.co",
  anonKey: "sb_publishable_NZZWgCZAWnyG9hZ8-fy7ug_Vp9-jC8XCOLOCA_A_CHAVE_PUBLICA_ANON_OU_PUBLISHABLE",
  allowedEmails: [
    "tomaseodmira@gmail.com",
    "SUBSTITUIR-PELO-SEGUNDO-EMAIL-QUANDO-EXISTIR"
  ]
};
