# 2026-04-21 — Invite system, nudges, and data cleanup

One-day sprint: team invite system, three nudge popups, registration
validation, DNS redirect, data normalization, and two email campaigns.

## Database (Supabase)

### New table

- `team_invitations` — leader-initiated invites (separate from
  `teams.pending_joins[]` which handles user-initiated join requests)
  - `id, team_id, invited_user_id, invited_by, message, status, created_at, responded_at`
  - `status` ∈ `pending | accepted | declined | cancelled`
  - `UNIQUE (team_id, invited_user_id, status)` blocks duplicate
    pending invites
  - RLS: `SELECT` limited to invitee or inviter

### New security-definer RPCs

- `leave_team(p_team_id)` — leader leaving disbands the team (clears
  members' `team_id`, deletes row); non-leader leaving only clears
  their own `team_id`. Replaces the broken manual-leave flow that
  left orphaned teams.
- `invite_to_team(p_team_id, p_user_id, p_message)` — leader only, blocks
  invites to users already on the team or with a pending invite,
  returns the new invitation id.
- `respond_to_invite(p_invite_id, p_accept)` — invitee accepts or
  declines. Accepting also cancels that user's other pending invites.
- `cancel_invite(p_invite_id)` — inviter can withdraw a pending
  invitation.

## Supabase Edge Function

`supabase/functions/send_team_email` (Deno, denomailer, Lark SMTP).
Supports 7 email kinds with the GOSIM black-gold template:

- `invite` — invitee learns they were invited
- `accepted` / `declined` — inviter learns the outcome of their invite
- `join_request` — leader learns someone requested to join
- `join_approved` / `join_rejected` — applicant learns the outcome
- `pending_reminder` — nudge leaders with unreviewed join requests

Secrets: `LARK_SMTP_USER`, `LARK_SMTP_PASS`.

Payload hydration: pass `invite_id` (for invite flow) or
`team_id + user_id` (for join flow) — the function reads the rest
from the DB via service role.

## Frontend (site/)

### New components

- `components/effects/BuildersModal.vue` — "Browse all builders"
  floating button (bottom-center); detail overlay with "Invite to my
  team" button for leaders
- `components/effects/InvitationsModal.vue` — top-right pulsing pill
  when the logged-in user has pending invites; Accept/Decline in a
  card list
- `components/effects/ModelNudgeModal.vue` — popup for leaders whose
  team has no model; dismissible per-session
- `components/effects/NoTeamNudgeModal.vue` — popup for logged-in
  users who haven't joined a team; links to Teams section + can
  toggle Looking for Team in place

### Registration form

- Register button disabled until one of Looking for a team / Create
  a team now is toggled (with amber hint)
- `signUp` response inspected for `identities: []` to detect the
  already-registered case; surfaces a clear error instead of the
  misleading "confirmation sent" banner
- Both `site/` and `site-french/` updated with the same validation

### Header

- Red count badge on user avatar when the user leads a team with
  unreviewed join requests
- Existing `My Team` dropdown item already showed the count inside
  the dropdown; the avatar badge makes it visible without opening
  the menu

### useTeams composable

- `leaveTeam` now calls the `leave_team` RPC instead of flipping
  the caller's `profile.team_id`
- `inviteToTeam`, `respondToInvite`, `cancelInvite` added; all three
  fire the Edge Function email after the RPC succeeds
- `joinTeam` / `approveJoin` / `rejectJoin` now also fire their
  respective notification emails (`join_request`, `join_approved`,
  `join_rejected`)
- `myInvitations` / `sentInvitations` refs + realtime subscription
  on `team_invitations`

## Infra

- `paris.mofa.ai` — Cloudflare Redirect Rule, 301 to
  `https://create.gosim.org$path`. The macmini API backend is no
  longer used; everything runs on Supabase.

## Data cleanups

- Deleted 6 "three-none" auth users with no profile rows
  (`1@1.com`, `wu@mofa.ai`, `zonghuan.wu@gmail.com`,
  `zonghuanwu@qq.com`, `ufp_enterprise@yahoo.com`, `docs@mofa.ai`)
- Deleted two testing accounts (`li@mofa.ai`, `scholarliyao@gmail.com`)
- All 18 teams now have a `model` (8 were auto-assigned randomly)
  and a sponsor-logo `avatar` if they had none
- Unified all Kimi team avatars to `/sponsors/kimi-new-icon.svg`,
  MiniMax to `/sponsors/minimax.png`, GLM to `/sponsors/zhipu-new.svg`
- Replaced one broken `paris.mofa.ai/uploads/...` avatar
  (Unstoppable) with the MiniMax logo
- Normalized `profiles.github_id` values with leading `@`
- Fixed `weidongshao@gmai.com` → `weidongshao@gmail.com`
  (missing `l`) in both auth.users and profiles

## Email campaigns

- No-team reminder — 26 users without a team got a GOSIM-branded
  email asking them to join or create one
- Profile-completion nudge — 48 users with incomplete profiles got
  a 60-second "finish your profile" nudge

## Site-french

Parallel French workspace received the same registration-validation
fix. Its commit is preserved on the `french` branch of the origin
remote (it doesn't build/deploy from here, and merging onto `main`
would conflict with the English build).

## Backup

Pre-sprint snapshot saved at
`~/Desktop/supabase-backup-20260421-0155/` (profiles, teams, auth
users as JSON).
