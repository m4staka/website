---
title: "Coding Agents: Why Research Matters More Than Code"
date: 2026-01-08
draft: false
description: "A three-phase methodology for coding agents where the highest leverage lies in research, not implementation"
tags: ["ai", "coding-agents", "llm", "software-development"]
---

I watched a video about an implementation methodology for coding agents that I found fascinating.

<!--more-->

## The Three Phases

The workflow consists of three phases, each in a separate chat:

1. **Research:** Search the codebase, gather context about the problem, document everything in detail
2. **Plan:** Generate an implementation plan
3. **Implement:** Write the actual code

## Context Management Is the Core Idea

The underlying concept: Every model has a limited context window. The more of it you use, the worse the results—the rule of thumb is that quality degrades above 50% context utilization. By splitting work into separate chats, each phase stays "fresh."

## Where the Leverage Actually Lies

What surprised me: The highest leverage is in the research phase. Then comes the plan. The code itself? They sometimes don't even look at it anymore.

The review process reflects this: A colleague reviews research and plan—but usually not the code.

## Sub-Agents and Their Advantage

The big advantage of sub-agents: They have their own context. You give them a task, they complete it, and return only the result. All the tool calls they make along the way don't end up in the main agent's context.

---

*Video: [YouTube](https://youtu.be/42AzKZRNhsk)*
