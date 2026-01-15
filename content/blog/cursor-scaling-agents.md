---
title: "Cursor skaliert Coding-Agents – aber nur für bekannte Probleme"
date: 2026-01-15T22:00:00+01:00
draft: false
description: "Cursor experimentiert mit hunderten parallelen Coding-Agents. Die Ergebnisse sind beeindruckend – aber alle Beispiele haben klare Erfolgskriterien."
tags: ["ai", "agents", "coding", "cursor"]
---

<!--more-->

**Link:** [Scaling long-running autonomous coding](https://cursor.com/blog/scaling-agents)

Cursor hat wochenlang mit hunderten parallelen Coding-Agents experimentiert, die autonom über längere Zeiträume liefen – teilweise mehrere Wochen am Stück. Nach gescheiterten Versuchen mit Self-Coordination landeten sie bei einem Planner/Worker-Modell: Planner erstellen Tasks, Worker arbeiten sie ab, ein Judge entscheidet ob's weitergeht.

## Die Beispiele

- **Web Browser from scratch** (1M+ LoC, ~1 Woche) → Web Platform Conformance Tests als Erfolgskriterium
- **Solid→React Migration** (+266K/-193K Edits, 3+ Wochen) → bestehender Code muss gleich funktionieren
- **Java LSP** (550K LoC) → Language Server Protocol Spec
- **Windows 7 Emulator** (1.2M LoC) → bekanntes Verhalten
- **Excel Clone** (1.6M LoC) → bekanntes Verhalten

## Mein Take

Das sind alles Projekte mit klaren Erfolgskriterien – entweder gibt es eine Spec (Browser, LSP), eine Test-Suite, oder bekanntes Verhalten zum Nachbauen. Coding-Agents sind gut darin, "implement the spec" zu lösen. Was ich nicht sehe: wie gut funktioniert das für ein neuartiges Produkt ohne Spec?

## Interessantes Zitat

> "The right amount of structure is somewhere in the middle. Too little structure and agents conflict, duplicate work, and drift. Too much structure creates fragility."

Das hab ich witzigerweise im Scrum Praxisbuch von Sutherland genauso gelesen – über menschliche Teams. Die Herausforderungen bei Agent-Koordination sind offenbar dieselben wie bei Menschen.
