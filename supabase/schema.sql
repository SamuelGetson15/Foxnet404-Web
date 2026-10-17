-- Foxnet404 dedicated contact database schema
-- Run this in the Supabase SQL Editor in a NEW project dedicated to Foxnet404 contacts.
-- Public website visitors can INSERT enquiries only. They cannot SELECT, UPDATE, or DELETE them.

create extension if not exists pgcrypto;

create table if not exists public.contact_submissions (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  name text not null check (char_length(trim(name)) between 1 and 120),
  email text not null check (
    char_length(email) between 3 and 254
    and email ~* '^[A-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?(?:\.[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?)+$'
  ),
  service text not null check (service in (
    'Penetration testing',
    'Vulnerability assessment',
    'Cloud & infrastructure',
    'Security awareness',
    'Incident readiness',
    'Security consulting',
    'Not sure yet'
  )),
  message text check (message is null or char_length(message) <= 4000),
  privacy_acknowledged boolean not null default false check (privacy_acknowledged = true),
  status text not null default 'new' check (status in ('new', 'in_progress', 'closed'))
);

alter table public.contact_submissions enable row level security;

-- Explicitly remove any default table privileges first.
revoke all on table public.contact_submissions from anon, authenticated;
grant insert on table public.contact_submissions to anon;

drop policy if exists "Public can submit Foxnet404 contact enquiries" on public.contact_submissions;
create policy "Public can submit Foxnet404 contact enquiries"
on public.contact_submissions
for insert
to anon
with check (
  char_length(trim(name)) between 1 and 120
  and char_length(email) between 3 and 254
  and email ~* '^[A-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?(?:\.[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?)+$'
  and service in (
    'Penetration testing',
    'Vulnerability assessment',
    'Cloud & infrastructure',
    'Security awareness',
    'Incident readiness',
    'Security consulting',
    'Not sure yet'
  )
  and (message is null or char_length(message) <= 4000)
  and privacy_acknowledged is true
);

-- Do not add public SELECT/UPDATE/DELETE grants or policies.
-- Read submissions through the Supabase Dashboard as an authorized project administrator.
