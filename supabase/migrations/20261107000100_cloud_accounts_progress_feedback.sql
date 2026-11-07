-- Study Club cloud foundation
-- Apply in the Supabase SQL Editor after creating a Supabase project.
-- The browser may use only the publishable/anon key. Never expose a secret/service-role key.

create extension if not exists pgcrypto;

create or replace function public.is_study_club_owner()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1
    from auth.users u
    where u.id = (select auth.uid())
      and lower(coalesce(u.email, '')) = 'narsingbeesetti22@gmail.com'
      and u.email_confirmed_at is not null
  );
$$;

revoke all on function public.is_study_club_owner() from public;
grant execute on function public.is_study_club_owner() to authenticated;

create table if not exists public.parent_profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null default '',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.learner_profiles (
  id uuid primary key default gen_random_uuid(),
  parent_id uuid not null references public.parent_profiles(id) on delete cascade,
  nickname text not null check (char_length(nickname) between 1 and 40),
  class_level text not null check (class_level in ('Nursery','LKG','UKG','Class 1','Class 2','Class 3','Class 4','Class 5','Class 6','Class 7','Class 8','Class 9','Class 10')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (id, parent_id)
);

create table if not exists public.learning_progress (
  id uuid primary key default gen_random_uuid(),
  parent_id uuid not null references public.parent_profiles(id) on delete cascade,
  learner_id uuid not null,
  progress jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  unique (learner_id),
  foreign key (learner_id, parent_id)
    references public.learner_profiles(id, parent_id) on delete cascade
);

create table if not exists public.study_club_feedback (
  id uuid primary key default gen_random_uuid(),
  parent_id uuid not null references public.parent_profiles(id) on delete cascade,
  learner_nickname text not null default '',
  learner_class text not null default '',
  submitter_label text not null default '',
  rating smallint not null check (rating between 1 and 5),
  category text not null default 'general',
  message text not null default '' check (char_length(message) <= 3000),
  reviewed boolean not null default false,
  admin_note text not null default '',
  created_at timestamptz not null default now()
);

create index if not exists learner_profiles_parent_id_idx on public.learner_profiles(parent_id);
create index if not exists learning_progress_parent_id_idx on public.learning_progress(parent_id);
create index if not exists study_club_feedback_created_at_idx on public.study_club_feedback(created_at desc);

alter table public.parent_profiles enable row level security;
alter table public.learner_profiles enable row level security;
alter table public.learning_progress enable row level security;
alter table public.study_club_feedback enable row level security;

-- Remove broad defaults before granting the minimum client privileges.
revoke all on public.parent_profiles, public.learner_profiles,
  public.learning_progress, public.study_club_feedback from anon, authenticated;

grant select, insert, update on public.parent_profiles to authenticated;
grant select, insert, update, delete on public.learner_profiles to authenticated;
grant select, insert, update, delete on public.learning_progress to authenticated;
grant insert, select, update, delete on public.study_club_feedback to authenticated;

drop policy if exists "parents read own profile or owner reads all" on public.parent_profiles;
create policy "parents read own profile or owner reads all"
on public.parent_profiles for select to authenticated
using (id = (select auth.uid()) or (select public.is_study_club_owner()));

drop policy if exists "parents create own profile" on public.parent_profiles;
create policy "parents create own profile"
on public.parent_profiles for insert to authenticated
with check (id = (select auth.uid()));

drop policy if exists "parents update own profile or owner" on public.parent_profiles;
create policy "parents update own profile or owner"
on public.parent_profiles for update to authenticated
using (id = (select auth.uid()) or (select public.is_study_club_owner()))
with check (id = (select auth.uid()) or (select public.is_study_club_owner()));

drop policy if exists "parents manage own learners and owner reads" on public.learner_profiles;
create policy "parents manage own learners and owner reads"
on public.learner_profiles for all to authenticated
using (parent_id = (select auth.uid()) or (select public.is_study_club_owner()))
with check (parent_id = (select auth.uid()) or (select public.is_study_club_owner()));

drop policy if exists "parents manage own progress and owner reads" on public.learning_progress;
create policy "parents manage own progress and owner reads"
on public.learning_progress for all to authenticated
using (parent_id = (select auth.uid()) or (select public.is_study_club_owner()))
with check (parent_id = (select auth.uid()) or (select public.is_study_club_owner()));

drop policy if exists "authenticated parents submit own feedback" on public.study_club_feedback;
create policy "authenticated parents submit own feedback"
on public.study_club_feedback for insert to authenticated
with check (parent_id = (select auth.uid()));

drop policy if exists "only owner reads feedback" on public.study_club_feedback;
create policy "only owner reads feedback"
on public.study_club_feedback for select to authenticated
using ((select public.is_study_club_owner()));

drop policy if exists "only owner updates feedback" on public.study_club_feedback;
create policy "only owner updates feedback"
on public.study_club_feedback for update to authenticated
using ((select public.is_study_club_owner()))
with check ((select public.is_study_club_owner()));

drop policy if exists "only owner deletes feedback" on public.study_club_feedback;
create policy "only owner deletes feedback"
on public.study_club_feedback for delete to authenticated
using ((select public.is_study_club_owner()));

-- Important: Supabase Auth email confirmation must remain enabled.
-- The owner email is authorized by a confirmed Auth identity, not by a client-side email field.
