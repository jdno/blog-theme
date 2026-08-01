# Design Brief

This document captures the intent behind the custom theme for [jdno.dev][blog]:
what the site is for, what the design should feel like, and which decisions are
settled versus still open. It was distilled from an analysis of the current
site and four inspiration themes ([Beaumont][beaumont], [Oaknut][oaknut],
[Array][array], and [Dawn][dawn]).

## Purpose

The site is a journal with a quiet profile. Writing comes first: the design
optimizes the reading experience for essays, and calls to action (subscribe,
sign in) stay soft. But visitors should be able to figure out who the author
is without leaving the site — a compact profile presence and a proper about
page are part of the design, without turning the site into a portfolio or a
sales page.

The content it serves: essay-leaning posts of roughly 3–7 minutes, published
about monthly, by a single author. Topics currently center on AI-era software
engineering practice, with a back catalog spanning infrastructure, side
projects, and career reflections.

## Design Principles

All four inspiration themes, despite different moods, agree on these — treat
them as the taste baseline:

1. Text-forward and image-starved. Post lists are text; imagery is an
   occasional interlude inside posts, never the structure.
2. A single centered column. No sidebars, and no card grids.
3. Hairline rules and whitespace are the primary graphic devices.
4. At most one accent color. Restraint everywhere else.
5. Personality lives in typography, not decoration. The design earns its
   character through one or two deliberate typographic moves, not ornament.

The mood on top of that baseline: minimal with a playful edge. The center of
gravity is Array (calm, airy, editorial), seasoned with Oaknut's wit rather
than Beaumont's literary quietness or Dawn's sober digest feel.

## Settled Decisions

### Direction: Paper and Ember

Chosen from three rendered directions in the "jdno.dev Theme" project on
[Claude Design][claude-design], which serves as the visual spec:

- **Palette:** warm literary paper. Light mode on `#F7F4EF` paper with
  `#211D18` ink and a `#C9451B` ember accent; dark mode on `#211E19` warm
  charcoal with `#EAE5DC` text and `#E86A3C` ember. Exact values may still be
  tuned during the build.
- **Display type:** Bricolage Grotesque (extra bold) for titles and headings —
  warm and literary with enough eccentricity to carry the playful edge. Syne
  was rejected as too compressed to read comfortably at title sizes; the cool
  blue "Blueprint" direction did not resonate.
- **Playful details:** borrowed from the rejected "Daylight" exploration and
  recolored in ember — thick accent-colored link underlines, pill buttons and
  image frames with hard offset shadows, highlight marks, and uppercase kicker
  meta. The `components/ember-details.html` card catalogs the vocabulary.

### Homepage

A small profile band above the feed: avatar, two or three lines of bio, and
social links — the "quiet profile" made visible. Below it, the post feed as a
single-column list with hairline separators. Each row shows the title, a
one-or-two-line excerpt, and meta (date, reading time). No feed thumbnails.

### Post Page

A centered reading column (around 680–720px). Feature images are contained
within the column and optional, never dominant heroes. Prose is set in the
body sans. Both a sans and a text serif were prototyped and read side by side
with real essays; the sans won, so the serif was removed rather than kept as
a setting. This was the one Beaumont question the brief left to empiricism.

### Color and Dark Mode

Dark mode ships from day one: automatic via `prefers-color-scheme`, plus a
manual toggle with a remembered preference. Both palettes are designed
together, not retrofitted, and both are defined by the Paper and Ember
direction above. The current blue accent (`#1b3de3`) does not survive the
redesign.

### Sections

First-class templates for:

- An about page — the most glaring gap on the current site.
- Topics/tags — posts get tagged (for example AI, infrastructure, projects,
  and career), and tag pages get a real design so readers can navigate.

Explicitly out of scope for v1: a now page and a projects page. They can be
added later without fighting the theme.

### Reader Features

No strong preference was expressed, so v1 defaults to the cheap and quiet
ones: Ghost's native search and a "read next" block at the end of posts.
Comments, a table of contents, and a reading-progress bar are deferred — all
are easy to add later if the writing or the readership starts demanding them.

## Open Questions for the Design Phase

- How far the hard-shadow vocabulary extends: buttons and image frames only,
  or also cards and other surfaces. Restraint is the default.
- How the profile band and the dark-mode toggle share the header without
  clutter.

[array]: https://array.brightthemes.com/
[claude-design]: https://claude.ai/design
[beaumont]: https://beaumont.andersnoren.se/
[blog]: https://jdno.dev
[dawn]: https://dawn.ghost.io/
[oaknut]: https://oaknut.andersnoren.se/
