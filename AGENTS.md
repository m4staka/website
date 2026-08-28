# Website (Hugo Blog)

- New posts: `hugo new blog/<slug>.md` (kebab-case slugs, e.g. `my-first-post.md`)
- Publish: set `draft: false`, commit, push → CI/CD builds and deploys automatically

## Gotchas

- **Never add a `# Title` heading in the content** — the frontmatter `title` is already rendered as H1.
- Always keep the `<!--more-->` marker after the frontmatter: everything above it is the list/summary excerpt.
- `date` must include the timezone offset (`+01:00` winter / `+02:00` summer, Berlin).

## Preview

- `make server` → http://localhost:1313/ (includes drafts via `-D`)
- `make serve` additionally exposes it via `tailscale serve`; `make stop` shuts both down.
