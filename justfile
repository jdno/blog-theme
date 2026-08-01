# Run all recipes inside the Flox environment
set shell := ["flox", "activate", "--", "sh", "-cu"]

# Name of the theme, taken from package.json
theme_name := "ghost-starter-theme"

# Location of the theme in the local Ghost instance
theme_dir := "ghost/content/themes" / theme_name

# Archive that pnpm zip produces, and that gscan checks
theme_zip := theme_name + ".zip"

[private]
default:
    @just --list

[private]
pre-commit-checks:
    #!/usr/bin/env -S parallel --shebang --ungroup --jobs {{ num_cpus() }}
    just prettier true
    just format-toml true
    just lint-github-actions
    just lint-markdown
    just lint-theme
    just lint-toml
    just lint-yaml

# Format JSON files
format-json fix="false": (prettier fix "{json,json5}")

# Format Markdown files
format-markdown fix="false": (prettier fix "md")

# Format TOML files
format-toml fix="false":
    taplo fmt {{ if fix != "true" { "--diff" } else { "" } }}

# Format YAML files
format-yaml fix="false": (prettier fix "{yaml,yml}")

# Install a local Ghost instance into ghost/ for theme development
ghost-install:
    cd ghost && pnpm exec ghost install local --no-start
    just theme-sync
    @echo "Run 'just ghost-start', then open http://localhost:2368/ghost to create an admin user and activate the theme"

# Start the local Ghost development server
ghost-start: theme-sync
    cd ghost && pnpm exec ghost start

# Stop the local Ghost development server
ghost-stop:
    cd ghost && pnpm exec ghost stop

# Lint GitHub Actions workflows
lint-github-actions:
    zizmor -p .

# Lint Markdown files
lint-markdown:
    markdownlint **/*.md

# Lint the Ghost theme using Ghost's gscan tool
lint-theme:
    # bestzip updates an existing archive rather than replacing it, so a
    # stale zip keeps serving files that were deleted from the source and
    # hides errors that a fresh checkout would catch.
    rm -f {{ theme_zip }}
    pnpm zip
    pnpm gscan -z {{ theme_zip }}

# Lint TOML files
lint-toml:
    taplo check

# Lint YAML files
lint-yaml:
    yamllint .

# Run a subset of checks as pre-commit hooks
pre-commit:
    @just pre-commit-checks

# Auto-format files with prettier
prettier fix="false" extension="*":
    prettier {{ if fix == "true" { "--write" } else { "--list-different" } }} --ignore-unknown "**/*.{{ extension }}"

# Build the theme and copy it into the local Ghost instance
theme-sync:
    pnpm build
    rm -rf {{ theme_dir }}
    mkdir -p {{ theme_dir }}
    cp -R assets members partials *.hbs package.json {{ theme_dir }}/
