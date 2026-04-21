-- Keep profiles in sync with auth.users metadata on insert/update.
-- Never overwrites existing non-empty profile values; only fills gaps.
CREATE OR REPLACE FUNCTION public.sync_profile_from_auth()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  raw jsonb := COALESCE(NEW.raw_user_meta_data, '{}'::jsonb);
  clean_gh text;
BEGIN
  -- Clean github_id: strip URL prefix, @ prefix, trim, reject email-like
  clean_gh := TRIM(REPLACE(REPLACE(COALESCE(raw->>'github_id',''), 'https://github.com/', ''), '@', ''));
  IF clean_gh LIKE '%.%' OR clean_gh = '' THEN clean_gh := NULL; END IF;

  INSERT INTO public.profiles (id, email, name, role, bio, avatar, github_id, discord, twitter, telegram, linkedin, website, preferred_model)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NULLIF(raw->>'name',''), split_part(NEW.email, '@', 1)),
    NULLIF(raw->>'role',''),
    NULLIF(raw->>'bio',''),
    NULLIF(raw->>'avatar',''),
    clean_gh,
    NULLIF(raw->>'discord',''),
    NULLIF(raw->>'twitter',''),
    NULLIF(raw->>'telegram',''),
    NULLIF(raw->>'linkedin',''),
    NULLIF(raw->>'website',''),
    NULLIF(raw->>'preferred_model','')
  )
  ON CONFLICT (id) DO UPDATE SET
    email = COALESCE(NULLIF(public.profiles.email,''), EXCLUDED.email),
    name  = COALESCE(NULLIF(public.profiles.name,''),  EXCLUDED.name),
    role  = COALESCE(NULLIF(public.profiles.role,''),  EXCLUDED.role),
    bio   = COALESCE(NULLIF(public.profiles.bio,''),   EXCLUDED.bio),
    avatar = COALESCE(NULLIF(public.profiles.avatar,''), EXCLUDED.avatar),
    github_id = COALESCE(NULLIF(public.profiles.github_id,''), EXCLUDED.github_id),
    discord = COALESCE(NULLIF(public.profiles.discord,''), EXCLUDED.discord),
    twitter = COALESCE(NULLIF(public.profiles.twitter,''), EXCLUDED.twitter),
    telegram = COALESCE(NULLIF(public.profiles.telegram,''), EXCLUDED.telegram),
    linkedin = COALESCE(NULLIF(public.profiles.linkedin,''), EXCLUDED.linkedin),
    website = COALESCE(NULLIF(public.profiles.website,''), EXCLUDED.website),
    preferred_model = COALESCE(NULLIF(public.profiles.preferred_model,''), EXCLUDED.preferred_model);
  RETURN NEW;
END;
$$;

-- Replace old handle_new_user trigger with the new richer one
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
DROP TRIGGER IF EXISTS on_auth_user_updated ON auth.users;
DROP TRIGGER IF EXISTS on_auth_user_sync    ON auth.users;

CREATE TRIGGER on_auth_user_sync
AFTER INSERT OR UPDATE OF email, raw_user_meta_data, email_confirmed_at
ON auth.users
FOR EACH ROW EXECUTE FUNCTION public.sync_profile_from_auth();
