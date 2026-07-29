# Run all recipes inside the Flox environment
set shell := ["flox", "activate", "--", "sh", "-cu"]

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

# Lint GitHub Actions workflows
lint-github-actions:
    zizmor -p .

# Lint Markdown files
lint-markdown:
    markdownlint **/*.md

# Lint the Ghost theme using Ghost's gscan tool
lint-theme:
    pnpm zip
    pnpm gscan {{ if env("GITHUB_ACTIONS", "") != "" { "--fatal --verbose" } else { "" } }} -z ghost-starter-theme.zip

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
