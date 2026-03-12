# Semantic Search for Notes

**Date:** 2026-02-19

## The Problem

Grep/ripgrep is great for exact matches, and Claude can do a series of greps to find things — but that's keyword search, not meaning search. I want to also be able to search by *concept*, not just by string.

## What I Want

A low-friction way to do semantic search across my notes and captured material. Something that complements grep rather than replacing it.

## Open Questions

- What gets indexed? Just notes? Code too? Everything Will triages?
- How to keep the index fresh without manual steps?
- Local embeddings vs. API-based?
- What does the query interface look like? (NeoVim integration? CLI? Both?)
- How does this relate to Will and the triage system? (Will routes notes in → semantic search finds them later?)
