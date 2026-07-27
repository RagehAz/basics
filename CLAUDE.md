# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`basics` is a pure Dart/Flutter **package** — a library of reusable widgets and utility classes that the `bldrs` app depends on. It is never run as a standalone project; there is no app entry point to launch. Changes here are validated via `flutter analyze` / `flutter test` and by consumption from the depending app, not by running this repo directly.

Not published to pub.dev (`publish_to: "none"`); consumed via path/git dependency instead.

## Structure

- `lib/components/` — Flutter widget library (animators, buttons, dialogs, layers, sensors, texting, zoomers, etc.)
- `lib/helpers/` — non-widget static utility classes (strings, nums, colors, time, checks, maps, rest, etc.)
- `lib/exports/` — one barrel file per third-party package, re-exporting/wrapping its API (e.g. `exports/http.dart`, `exports/intl.dart`) — prefer importing through these barrels rather than the raw package when one exists.
- `lib/ldb` / `lib/ldbob/` — ObjectBox-backed local DB layer.

## Commands

- Run tests: `flutter test` (whole suite). Test coverage only mirrors `lib/helpers/**` and `lib/bldrs_theme` — most of `lib/components`, `lib/av`, `lib/ldb`, `lib/models` has no tests today; don't assume untested code paths are covered.
- Lint: `flutter analyze` (rules defined in `analysis_options.yaml`).

## Code style

Lints in `analysis_options.yaml` deliberately deviate from Flutter defaults — follow the existing code, not generic Dart conventions:

- Single quotes required (`prefer_single_quotes: true`).
- Underscore-prefixed **local variables** are allowed and used throughout (e.g. `final BorderRadius _corners = ...` inside `build()`), not just for private members — `no_leading_underscores_for_local_identifiers` is explicitly disabled.
- `missing_required_param` and `parameter_assignments` are escalated to hard analyzer **errors**, not warnings.
- Utility classes are `abstract class` with all-static members (namespace style), e.g. `TextCheck`, `TextMod` — not top-level functions.
- Widget families are split across multiple files sharing one `library`/`part`/`part of` declaration (e.g. `tap_layer.dart` declares `library tap_layer;` with `part 'src/tap_box.dart';` etc.). Follow this pattern when splitting a widget into sub-widgets/states rather than creating separate libraries.
- Private sub-widget/state classes use descriptive leading-underscore names (e.g. `_TapStateNoUpsAndDowns`, `_TapInkLayer`) rather than branching inside one widget.
- Nullable-heavy API: prefer `Type?` with explicit null checks over assuming non-null; existing code uses explicit `== true` / `== false` comparisons on nullable bools — match this style in surrounding code rather than "fixing" it to idiomatic bare-bool checks.
- `/// AI TESTED` is a project-specific doc-comment marker (not standard Dart) indicating a method has been validated — preserve it when present, and feel free to add it after verifying a method's behavior.

## ObjectBox codegen

`lib/ldbob/src/generated/objectbox.g.dart` and `objectbox-model.json` are **generated and committed to git**. Never hand-edit them. After changing an `@Entity` model, regenerate with `dart run build_runner build` — don't write generated output manually.

## Git conventions

Commit messages follow `<version> : <freeform lowercase description>` (e.g. `7.2 : fixed the save to gallery on IOS`), matching the version being bumped in `pubspec.yaml`/`CHANGELOG.md`. Single branch (`master`); no CI/PR pipeline currently configured.