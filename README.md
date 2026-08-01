# jdno.dev

The Ghost theme for [my personal blog][blog], a journal about software
engineering. It started as a fork of Ghost's [starter template][starter] and
has since grown its own design, which is described in the [design brief].

## Development

The repository manages its own toolchain with [Flox][flox], and every task runs
through [just][just]:

```bash
just --list          # show every recipe
just ghost-install   # one-time: install a local Ghost into ghost/
just ghost-start     # build the theme, copy it in, and start Ghost
just theme-sync      # rebuild and copy the theme after a change
just ghost-stop      # stop Ghost again
just pre-commit      # run the checks that guard a commit
```

The local Ghost instance lives in the gitignored `ghost/` directory and serves
the site at <http://localhost:2368>. The theme is copied into it rather than
symlinked, because Ghost's theme validation rejects symlinks.

[blog]: https://jdno.dev
[design brief]: ./DESIGN.md
[flox]: https://flox.dev
[just]: https://just.systems
[starter]: https://github.com/TryGhost/Starter
