#!/usr/bin/env bash
# PreToolUse hook for Write|Edit: reminds Claude to invoke the matching
# skill when the target file is a .note flashcard or .asy illustration.
set -euo pipefail

file_path=$(jq -r '.tool_input.file_path // empty')

context=""
case "$file_path" in
  *.note)
    context="This file is a flashcards .note source in this repo. Invoke the generate-flashcards skill via the Skill tool before writing or editing its content, per math-notes/CLAUDE.md."
    ;;
  *.asy)
    context="This file is an Asymptote illustration source in this repo. Invoke the generate-illustrations skill via the Skill tool before writing or editing it, per math-notes/CLAUDE.md."
    ;;
esac

if [ -n "$context" ]; then
  jq -n --arg context "$context" \
    '{hookSpecificOutput: {hookEventName: "PreToolUse", additionalContext: $context}}'
fi
