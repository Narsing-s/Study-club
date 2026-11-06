-- Study Club parent-account cloud progress
-- Run this in Supabase SQL Editor after creating a Supabase project.
-- The parent signs in through Supabase Auth. A learner is represented by a
-- nickname and class inside the parent's private progress document.
create table if not exists public.student_progress (
  user_id uuid primary key references auth.users(id) on delete cascade,
  progress jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.student_progress enable row level security;
drop policy if exists "Parents can read their own learner progress" on public.student_progress;
create policy "Parents can read their own learner progress"
  on public.student_progress for select
  to authenticated using (auth.uid() = user_id);
drop policy if exists "Parents can create their own learner progress" on public.student_progress;
create policy "Parents can create their own learner progress"
  on public.student_progress for insert
  to authenticated with check (auth.uid() = user_id);
drop policy if exists "Parents can update their own learner progress" on public.student_progress;
create policy "Parents can update their own learner progress"
  on public.student_progress for update
  to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
