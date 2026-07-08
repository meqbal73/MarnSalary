-- Marn Web Dashboard - Supabase schema
-- Run this whole file once in Supabase SQL Editor.

create table if not exists public.dashboard_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{"version":2,"months":{}}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.dashboard_data enable row level security;

-- Re-create policies safely.
drop policy if exists "Users can read own dashboard" on public.dashboard_data;
drop policy if exists "Users can insert own dashboard" on public.dashboard_data;
drop policy if exists "Users can update own dashboard" on public.dashboard_data;
drop policy if exists "Users can delete own dashboard" on public.dashboard_data;

create policy "Users can read own dashboard"
on public.dashboard_data
for select
to authenticated
using ((select auth.uid()) = user_id);

create policy "Users can insert own dashboard"
on public.dashboard_data
for insert
to authenticated
with check ((select auth.uid()) = user_id);

create policy "Users can update own dashboard"
on public.dashboard_data
for update
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

create policy "Users can delete own dashboard"
on public.dashboard_data
for delete
to authenticated
using ((select auth.uid()) = user_id);

create or replace function public.set_dashboard_updated_at()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_dashboard_updated_at on public.dashboard_data;
create trigger set_dashboard_updated_at
before update on public.dashboard_data
for each row execute function public.set_dashboard_updated_at();
