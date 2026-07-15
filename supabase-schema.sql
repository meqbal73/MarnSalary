create table if not exists public.dashboard_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.dashboard_data enable row level security;
drop policy if exists "Users read own dashboard" on public.dashboard_data;
drop policy if exists "Users insert own dashboard" on public.dashboard_data;
drop policy if exists "Users update own dashboard" on public.dashboard_data;
create policy "Users read own dashboard" on public.dashboard_data for select using (auth.uid() = user_id);
create policy "Users insert own dashboard" on public.dashboard_data for insert with check (auth.uid() = user_id);
create policy "Users update own dashboard" on public.dashboard_data for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
