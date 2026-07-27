---
name: bump-version
description: Bump the package version in pubspec.yaml following this repo's manual versioning convention. Use when the user asks to bump/release a new version (e.g. "bump version", "cut 7.3").
---

Bump the version for this package (a Dart/Flutter library, not a runnable app).

1. Read the current `version:` line in `pubspec.yaml`.
2. Ask the user (if not already stated) what the new version should be, and a short freeform lowercase description of what changed — commit messages in this repo follow the pattern `<major.minor> : <freeform lowercase description>` (e.g. `7.2 : fixed the save to gallery on IOS`). The version prefix used in commit messages is usually just `major.minor`, not the full semver in `pubspec.yaml`.
3. Update `version:` in `pubspec.yaml` to the new full semver (e.g. `7.2.3`).
4. Note: `CHANGELOG.md` exists but has **not** been kept up to date in practice (it stops at `6.0.0` even though `pubspec.yaml` is past `7.2`) — don't assume it needs an entry unless the user asks for one. If they do, prepend it in the same `### <version> : <description>` format used at the top of the file.
5. Do not create a git commit yourself unless the user explicitly asks — leave staging/committing to them, following their normal commit message convention.