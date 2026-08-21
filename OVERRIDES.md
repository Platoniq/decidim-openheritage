# decidim-openheritage — gem overrides

_Generated 2026-08-21. Currently on Decidim **0.31.4**._

This app patches files that live inside the decidim gems. `spec/lib/overrides_spec.rb` stores an MD5 of each upstream original, so the suite fails the moment upstream changes one — that is the signal that a local copy has drifted from the version it was forked from.

**12 guarded file(s).**

## Ruby classes (4)

Copied or patched via an `*Override` concern. Needs a real diff of upstream old-vs-new and the customisation re-applied.

| package | file | recorded checksum |
|---|---|---|
| `decidim-forms` | `/app/queries/decidim/forms/questionnaire_user_responses.rb` | `d9a56ef2…` |
| `decidim-forms` | `/app/commands/decidim/forms/response_questionnaire.rb` | `dcac7f5a…` |
| `decidim-participatory_processes` | `/app/models/decidim/participatory_process.rb` | `7a5d16b6…` |
| `decidim-surveys` | `/app/controllers/decidim/surveys/surveys_controller.rb` | `78f24548…` |

## Views (8)

Full copies of gem templates. Re-copy the 0.31 version and re-apply the local change.

| package | file | recorded checksum |
|---|---|---|
| `decidim-admin` | `/app/views/decidim/admin/static_pages/index.html.erb` | `debf4d3a…` |
| `decidim-conferences` | `/app/views/decidim/conferences/conferences/_conference_hero.html.erb` | `c49e3bfd…` |
| `decidim-conferences` | `/app/views/decidim/conferences/conferences/show.html.erb` | `16ff68b3…` |
| `decidim-proposals` | `/app/views/decidim/proposals/proposals/show.html.erb` | `e2c0adf5…` |
| `decidim-core` | `/app/views/layouts/decidim/footer/_mini.html.erb` | `c67cc97d…` |
| `decidim-core` | `/app/views/decidim/pages/index.html.erb` | `1f4f2c10…` |
| `decidim-core` | `/app/views/layouts/decidim/mailer.html.erb` | `6a08103c…` |
| `decidim-core` | `/app/views/devise/mailer/invite_private_user.html.erb` | `f978eddb…` |

## Override concerns

- `app/commands/concerns/decidim/forms/response_questionnaire_override.rb`
- `app/models/concerns/decidim/participatory_process_override.rb`

## Wiring

- `config/initializers/decidim_overrides.rb`
- `config/initializers/survey_hacks.rb`

## For the 0.31 upgrade

Every guarded file has to be checked against 0.31. Three outcomes:

- **Upstream unchanged** — only the checksum needs re-recording.
- **Upstream renamed** — update the path in the spec as well (0.31 renames Answer→Response across forms/surveys).
- **Upstream changed** — diff 0.30.x→0.31.4 and re-apply the local customisation.

Compare with:

```console
gh api repos/decidim/decidim/contents/<package><file>?ref=v0.30.9 -q .sha
gh api repos/decidim/decidim/contents/<package><file>?ref=v0.31.4 -q .sha
```

Same sha = category 1. 404 on the 0.31 side = category 2.

Conventions worth following (from [decidim-barcelona](https://github.com/AjuntamentdeBarcelona/decidim-barcelona) `.agent/skills/decidim-overrides/SKILL.md`):

- `.include` when the concern **adds** methods, `.prepend` when it **replaces** them, so `super` still reaches upstream.
- decidim_awesome applies Deface overrides by virtual path, so they compose on top of app-level view copies — if a copied view renders differently than it reads, check for a Deface override before hunting a bug.
