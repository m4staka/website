---
title: "Cursor Scales Coding Agents"
date: 2026-01-15T22:00:00+01:00
draft: false
description: "Cursor experiments with hundreds of parallel coding agents. The results are impressive – but all examples have clear success criteria."
summary: "Cursor shows impressive results with hundreds of parallel agents"
tags: ["ai", "agents", "coding", "cursor"]
---

**Link:** [Scaling long-running autonomous coding](https://cursor.com/blog/scaling-agents)

Cursor experimented for weeks with hundreds of parallel coding agents running autonomously over extended periods—some for several weeks straight. After failed attempts with self-coordination, they landed on a Planner/Worker model: Planners create tasks, Workers execute them, a Judge decides whether to continue.

## The Examples

- **Web Browser from scratch** (1M+ LoC, ~1 week) → Web Platform Conformance Tests as success criterion
- **Solid→React Migration** (+266K/-193K edits, 3+ weeks) → existing code must work the same
- **Java LSP** (550K LoC) → Language Server Protocol Spec
- **Windows 7 Emulator** (1.2M LoC) → known behavior
- **Excel Clone** (1.6M LoC) → known behavior

## My Take

These are all projects with clear success criteria—either there's a spec (Browser, LSP), a test suite, or known behavior to replicate. Coding agents are good at solving "implement the spec." What I don't see: how well does this work for a novel product?

## Interesting Quote

> "The right amount of structure is somewhere in the middle. Too little structure and agents conflict, duplicate work, and drift. Too much structure creates fragility."

Funny enough, I read the same thing in Sutherland's Scrum handbook—about human teams. The challenges in agent coordination are apparently the same as with humans.
