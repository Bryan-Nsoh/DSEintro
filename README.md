# DSEintro

## About

- Name: Bryan Nsoh
- Personal detail: Fun fact — I had 2 sets of wisdom teeth.
- Favorite classes (pre‑UTK):
  - Creative Writing: Fiction
  - Creative Writing: Comedy
  - Computer Architecture

## Script

This repo includes a small PowerShell "virtual index card" script that prints a short profile, computes simple word/letter stats from the favorite classes, and generates a tiny study plan.

- Script: `profile.ps1`
- Run (Windows PowerShell): `powershell -File .\profile.ps1`
- Run (PowerShell 7+): `pwsh ./profile.ps1`
- Optional args: `-Days 7 -StudyMinutesPerDay 30 -Seed 42`

Example:

```
powershell -File .\profile.ps1 -Days 3 -StudyMinutesPerDay 40 -Seed 7
```
