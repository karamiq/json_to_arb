# AGENTS.md

Project notes for future agents working in this repository.

## Scope
- This package is a Dart CLI tool that converts locale-specific JSON files into Flutter ARB files.
- Keep changes minimal and focused on the requested behavior.
- Preserve existing naming, logging style, and file structure unless a change requires otherwise.

## Useful Commands
- `flutter pub get`
- `flutter test`
- `dart run bin/json_to_arb.dart` if you need to exercise the CLI manually

## Behavior Notes
- Skip warnings for invalid or empty JSON files should be reported once per file, not repeated across multiple passes.
- The consistency checker should not re-log skip exceptions that were already reported by the reader.
- Prefer updating README.md when user-visible behavior changes.

## Editing Notes
- Use apply_patch for code and documentation edits.
- Avoid unrelated refactors or formatting-only churn.
- If tests fail due to existing fixture or workspace issues outside the change, mention that clearly instead of widening the fix.
