# Changelog

All notable changes to this project will be documented in this file.

## Unreleased

### Added

- Web UI: added an `all.zip outputs` input in the task options panel to let users set the `outputs` form field (for example `["opensfm"]`) without modifying code.
- Web UI: added client-side validation for `outputs` to ensure it is valid JSON and a JSON array before task submission.
- Web UI: added a reset button for the new `outputs` input.
- Docs: added `docs/task-form-guide.md` to explain the built-in task submission form and the default `all.zip` packaging behavior.
- Docs: added `docs/api-examples.md` with `curl` examples for creating tasks, querying task info and downloading `all.zip`.
- Docs: added `docs/archive-2026-03.md` to summarize the current phase, scope and handoff notes for this fork.

### Changed

- README: reorganized the project entry page around the current fork goals, GPU usage flow and document navigation.
