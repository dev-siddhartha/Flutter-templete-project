# Contribution Model

## Ownership

- Design owner: To be assigned before Alpha handoff
- Product owner: To be assigned before Alpha handoff
- Development owner: To be assigned before Alpha handoff
- Package maintainers: To be assigned before Alpha handoff

No component passes handoff until design, product, and development owners sign off.

## SLAs

- P0 accessibility or build failures: same business day response.
- P1 component regressions: one business day response.
- P2 documentation or token questions: two business day response.
- Pull request first review: one business day.

## Required Checks

- `flutter analyze`
- `flutter test`
- Accessibility widget tests using Flutter guideline matchers.
- Visual regression tests.
- `lib/src/tokens/slds_tokens.dart` is the authoritative token source — there
  is no codegen step and no automated parity check against
  `tokens/slds_alpha.tokens.json` (a manually-maintained Figma reference that
  is known to have drifted from the live Dart tokens). If you change a token
  value, update the JSON by hand if you want it to stay representative, but
  do not treat it as a source of truth.

## Deprecations

Every deprecated API requires:

- `@Deprecated` annotation with removal target.
- Migration snippet in `docs/migration/`.
- Changelog entry.
- Named owner.
