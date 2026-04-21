-- Backfill profiles from auth.users.raw_user_meta_data where profile field is empty
-- Only fills missing fields; never overwrites existing profile data

UPDATE profiles p SET
  name = COALESCE(NULLIF(p.name, ''), u.raw_user_meta_data->>'name'),
  role = COALESCE(NULLIF(p.role, ''), NULLIF(u.raw_user_meta_data->>'role', '')),
  bio  = COALESCE(NULLIF(p.bio,  ''), NULLIF(u.raw_user_meta_data->>'bio',  '')),
  avatar = COALESCE(NULLIF(p.avatar, ''), NULLIF(u.raw_user_meta_data->>'avatar', '')),
  discord = COALESCE(NULLIF(p.discord, ''), NULLIF(u.raw_user_meta_data->>'discord', '')),
  twitter = COALESCE(NULLIF(p.twitter, ''), NULLIF(u.raw_user_meta_data->>'twitter', '')),
  telegram = COALESCE(NULLIF(p.telegram, ''), NULLIF(u.raw_user_meta_data->>'telegram', '')),
  linkedin = COALESCE(NULLIF(p.linkedin, ''), NULLIF(u.raw_user_meta_data->>'linkedin', '')),
  website = COALESCE(NULLIF(p.website, ''), NULLIF(u.raw_user_meta_data->>'website', '')),
  preferred_model = COALESCE(NULLIF(p.preferred_model, ''), NULLIF(u.raw_user_meta_data->>'preferred_model', '')),
  -- github_id: strip https://github.com/, @ prefix, trim, and reject anything with @ (email-like)
  github_id = CASE
    WHEN COALESCE(p.github_id, '') <> '' THEN p.github_id
    WHEN u.raw_user_meta_data->>'github_id' IS NULL THEN p.github_id
    ELSE (
      CASE
        WHEN TRIM(REPLACE(REPLACE(u.raw_user_meta_data->>'github_id', 'https://github.com/', ''), '@', '')) LIKE '%.%'
          OR TRIM(REPLACE(u.raw_user_meta_data->>'github_id', 'https://github.com/', '')) = ''
          THEN p.github_id
        ELSE TRIM(REPLACE(REPLACE(u.raw_user_meta_data->>'github_id', 'https://github.com/', ''), '@', ''))
      END
    )
  END
FROM auth.users u
WHERE u.id = p.id;

-- Report what's still incomplete
SELECT
  count(*) FILTER (WHERE email IS NOT NULL AND email <> '') AS email_filled,
  count(*) FILTER (WHERE name  IS NOT NULL AND name  <> '') AS name_filled,
  count(*) FILTER (WHERE role  IS NOT NULL AND role  <> '') AS role_filled,
  count(*) FILTER (WHERE github_id IS NOT NULL AND github_id <> '') AS gh_filled,
  count(*) FILTER (WHERE bio   IS NOT NULL AND bio   <> '') AS bio_filled,
  count(*) FILTER (WHERE discord IS NOT NULL AND discord <> '') AS discord,
  count(*) FILTER (WHERE twitter IS NOT NULL AND twitter <> '') AS twitter,
  count(*) FILTER (WHERE telegram IS NOT NULL AND telegram <> '') AS telegram,
  count(*) FILTER (WHERE linkedin IS NOT NULL AND linkedin <> '') AS linkedin,
  count(*) AS total
FROM profiles;
