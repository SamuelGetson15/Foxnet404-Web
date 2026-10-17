/*
 * Foxnet404 public-site configuration.
 * Replace both values with the URL and publishable key from your dedicated Supabase project.
 * A publishable/anon key is expected to be visible in browser code; it is only safe with the
 * insert-only Row Level Security rules in supabase/schema.sql. NEVER put a service_role or secret key here.
 */
window.FOXNET_SUPABASE_CONFIG = {
  url: "https://YOUR-PROJECT-REF.supabase.co",
  publishableKey: "YOUR-PUBLISHABLE-KEY"
};
