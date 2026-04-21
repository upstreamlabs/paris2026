CREATE OR REPLACE FUNCTION public.leave_team(p_team_id uuid)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_leader uuid;
  v_caller uuid := auth.uid();
BEGIN
  IF v_caller IS NULL THEN RAISE EXCEPTION 'Not authenticated'; END IF;
  SELECT leader_id INTO v_leader FROM public.teams WHERE id = p_team_id;
  IF v_leader IS NULL THEN RAISE EXCEPTION 'Team not found'; END IF;

  IF v_leader = v_caller THEN
    UPDATE public.profiles SET team_id = NULL WHERE team_id = p_team_id;
    DELETE FROM public.teams WHERE id = p_team_id;
  ELSE
    UPDATE public.profiles SET team_id = NULL WHERE id = v_caller AND team_id = p_team_id;
  END IF;
END;
$$;
GRANT EXECUTE ON FUNCTION public.leave_team(uuid) TO authenticated;
