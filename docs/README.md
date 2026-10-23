# docs/

Replace this folder with your design repo as a git submodule:

    git rm -r docs && git submodule add <design-repo-url> docs

Suggested layout: `requirements/`, `architecture/`, `api/` (OpenAPI), `data/` (schemas), `events/` (AsyncAPI), `delivery/traceability.md`.
