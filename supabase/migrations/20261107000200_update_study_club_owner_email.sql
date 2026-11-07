-- Update Study Club's verified owner identity.
-- Run after 20261107000100_cloud_accounts_progress_feedback.sql.
-- This changes only the owner allow-list; it does not create or reset a Supabase Auth user.

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
      and lower(coalesce(u.email, '')) = 'narsingbeesetti006@gmail.com'
      and u.email_confirmed_at is not null
  );
$$;

revoke all on function public.is_study_club_owner() from public;
grant execute on function public.is_study_club_owner() to authenticated;
