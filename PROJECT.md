# Flow Drawer Project Status

Last reviewed: 2026-11-12

## Purpose

`flow_drawer` is a Flutter package that provides animated left- and right-docked navigation drawers. Consumers compose a `FlowDrawer` around their screen, provide drawer item widgets, and control its state with `FlowDrawerController`.

## Architecture

- `lib/flow_drawer.dart` is the public package barrel.
- `FlowDrawerController` owns the open/closed state through `ChangeNotifier`.
- `FlowDrawer` coordinates the background, transformed content card, gestures, menu timing, and optional top menu.
- `FlowDrawerListWidget` renders and animates the supplied drawer items.
- `FlowDrawerMenuItem` is an optional prebuilt menu row.
- `FlowTopMenu` provides animated leading and trailing controls.
- `example/` demonstrates both drawer positions; `assets/` contains demo GIFs.

## Current Status

- Package version: `0.0.3`.
- Git branch: `main`, tracking `origin/main`.
- Static analysis: passes with no issues on 2026-11-12.
- Tests: failing because `test/flow_drawer_test.dart` contains no active `main()`; there is currently no effective package test coverage.
- Repository hygiene: local `.env` variants are ignored (while `.env.example` may be tracked); no secrets were found in the reviewed source.

## Verified Risks and Gaps

1. The README installation version and usage example do not match the current package/API (`^1.0.0`, `drawer`, and `items` are invalid for version `0.0.3`).
2. Delayed item-state callbacks are not cancelled. Rapid toggles can apply stale state, and a callback may run after widget disposal.
3. The package has no active controller, widget, gesture, timing, or left/right layout tests.
4. Public API documentation contains numerous spelling errors and some descriptions do not match behavior.
5. The declared minimum Flutter version (`>=1.17.0`) is not validated against the modern APIs and Dart SDK constraint used by the implementation.
6. `FlowDrawerListWidget` exposes a required controller that it does not use.
7. Fixed pixel transforms and a 20-pixel edge gesture target may behave poorly across small screens, tablets, desktop, accessibility settings, and RTL layouts.

## Recommended Milestones

1. Restore a passing test baseline and cover controller state, left/right opening, gestures, tap-to-close, delayed callbacks, and disposal.
2. Make delayed transitions cancellation-safe and deterministic under rapid toggling.
3. Correct README examples, package version guidance, API names, and public documentation.
4. Validate and align Flutter/Dart compatibility constraints, then run package publishing checks.
5. Improve accessibility and adaptability: semantic buttons, keyboard/focus support, RTL behavior, and size-relative transforms.

## Decision Log

- 2026-11-12: Initial repository analysis completed. Added explicit local environment-file ignores; no production implementation changes were made and remediation remains pending.
