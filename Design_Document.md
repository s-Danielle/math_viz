# Paradox Lab — App Design Document

Interactive Android App for Mathematical Paradoxes and Philosophical Problems

## 1. Project Concept

**Paradox Lab** is an interactive Android app that lets users experience mathematical paradoxes and philosophical problems through short simulations, visual storytelling, and decision-based interactions.

Instead of presenting paradoxes as static explanations, the app places the user inside a digital “lab” where each paradox becomes an experiment. The goal is for users to first rely on intuition, then test that intuition, and finally understand why the paradox produces an unexpected result.

The app should feel like a mix between:

* a neon science lab,
* a cosmic experiment room,
* an interactive educational game,
* and a visual simulation tool.

The tone should be curious, mysterious, playful, and intelligent.

## 2. Core Design Identity

### App Name

**Paradox Lab**

### Design Theme

A dark neon laboratory where abstract mathematical ideas become experiments.

### Visual Keywords

Dark
Neon
Cosmic
Experimental
Glowing
Playful
Scientific
Interactive
Mysterious
Abstract

### User Feeling

The user should feel like they are entering a strange research lab where reality, logic, probability, infinity, and identity are being tested.

The app should not feel like a normal school worksheet or quiz app. It should feel more like an interactive experience.

## 3. Main User Experience Goal

The app should guide the user through this sequence:

1. **Curiosity** — “What is this paradox?”
2. **Prediction** — “What do I think will happen?”
3. **Interaction** — “Let me test my intuition.”
4. **Surprise** — “Wait, why did that happen?”
5. **Explanation** — “Now I understand the logic.”
6. **Replay** — “Let me try again with different conditions.”

The most important design principle is:

**Let the user experience the paradox before explaining it.**

The explanation should usually come after the interaction, not before.

## 4. Target Platform

The app is designed for:

**Android mobile devices**

Development stack:

* Flutter
* Dart
* Android Studio
* Cursor for code generation and development assistance

The design should be modular and adaptable so that new paradoxes can be added later without rebuilding the app structure.

## 5. Visual Style

### General Look

The app should use a dark background with glowing neon elements. Screens should feel immersive, with abstract lab and space-inspired shapes.

The visual references suggest a strong direction:

* deep navy and purple backgrounds,
* glowing cyan and blue elements,
* neon green experimental highlights,
* magenta/pink accents,
* bright yellow for surprise or insight moments,
* rounded cards and buttons,
* animated floating objects,
* soft glows and gradients.

### Background Style

Backgrounds should not be plain black. They should use dark gradients, subtle particles, abstract shapes, or soft blurred blobs.

Possible background elements:

* stars,
* particles,
* floating lab bubbles,
* abstract planets,
* glowing grids,
* faint mathematical symbols,
* laboratory glass shapes,
* neon liquid effects.

### Shape Language

Use:

* rounded rectangles,
* circles,
* floating capsules,
* glass containers,
* abstract blobs,
* glowing outlines,
* soft shadows,
* curved paths.

Avoid:

* sharp corporate UI,
* flat white backgrounds,
* plain textbook diagrams,
* overly realistic illustrations.

## 6. Color Palette

### Primary Palette

**Deep Space Navy**
Used for main backgrounds.
Example: `#09002E`

**Dark Violet**
Used for cards, panels, and background gradients.
Example: `#1B0B5A`

**Electric Blue**
Used for primary actions and active states.
Example: `#145CFF`

**Cyan Glow**
Used for highlights, outlines, and selected objects.
Example: `#37D9E8`

**Neon Green**
Used for experimental confirmation, success, active lab elements.
Example: `#20E889`

**Magenta / Hot Pink**
Used for surprise, warning, paradox tension, important accents.
Example: `#F000D8`

**Insight Yellow**
Used for explanation reveals, “aha” moments, probability highlights.
Example: `#F4FF1E`

### Suggested Usage

Backgrounds should mostly use navy and violet.

Buttons should use electric blue, cyan, or magenta depending on action type.

Correct or confirmed results can use neon green.

Important insight moments can use yellow.

Warnings, failed intuition, or paradox tension can use magenta/pink.

## 7. Typography

The typography should be readable but slightly futuristic.

### Font Direction

Use a clean sans-serif font. It should feel modern and friendly, not too formal.

Recommended options:

* Inter
* Space Grotesk
* Poppins
* Nunito Sans
* Rubik

### Text Hierarchy

**Large titles**
Bold, high contrast, used for paradox names and screen titles.

**Medium headings**
Used for steps like “Choose a door” or “What do you predict?”

**Body text**
Short, readable explanations.

**Small labels**
Used for level numbers, probability chips, stats, and buttons.

### Writing Style

Text should be short and direct.

Prefer:

“Choose your door.”

Instead of:

“Please select one of the following doors in order to proceed with the experiment.”

Explanations should be simple but accurate.

## 8. App Structure

The app should be structured around a main hub and individual paradox modules.

### Main Screens

1. **Splash / Intro Screen**
2. **Home / Lab Hub**
3. **Paradox Selection Screen**
4. **Paradox Intro Screen**
5. **Interactive Simulation Screen**
6. **Result Screen**
7. **Explanation / Insight Screen**
8. **Progress / Stats Screen**
9. **About / Credits Screen**

## 9. Home Screen / Lab Hub

The home screen should feel like the entrance to the lab.

Possible layout:

* App title: **Paradox Lab**
* Subtitle: **Test your intuition. Break your assumptions.**
* Floating glowing paradox cards
* Background with abstract lab/cosmic shapes
* Main button: **Enter the Lab**
* Secondary button: **Choose Experiment**

The home screen should immediately communicate that this is an interactive experience, not just a reading app.

## 10. Paradox Cards

Each paradox should appear as a reusable card.

Each card should include:

* paradox title,
* short one-line description,
* icon or visual symbol,
* difficulty/complexity indicator,
* status: locked, available, completed,
* action button.

Example cards:

### Monty Hall

**Can switching choices beat your first instinct?**

Visual: glowing doors / probability symbol.

### Zeno’s Paradox

**Can motion be impossible if every journey has infinite steps?**

Visual: runner, path, shrinking intervals.

### Prisoner’s Dilemma

**What happens when trust and self-interest collide?**

Visual: two decision panels.

### Ship of Theseus

**Is an object still the same after every part is replaced?**

Visual: ship pieces, replacement animation.

## 11. General Paradox Module Flow

Each paradox should follow the same structure:

### 1. Intro

Short explanation of the scenario.

Goal: give enough context to interact, but not the full answer.

### 2. Prediction

Ask the user what they think will happen.

Example:

“Do you think switching improves your chances?”

Options:

* Yes
* No
* Not sure

### 3. Simulation

The user interacts with the paradox.

### 4. Result

The app shows what happened in this round.

### 5. Pattern

After multiple rounds or levels, the app shows the larger statistical pattern.

### 6. Explanation

The app explains the mathematical or philosophical idea.

### 7. Replay / Next Level

The user can replay or move to a harder version.

## 12. Monty Hall Module Design

Monty Hall should be the first fully developed prototype.

### Purpose

To let users experience why switching doors gives a better probability of winning.

### Core Interaction

The user is shown several doors.

One door hides the prize.

The user chooses one door.

The host removes losing doors.

The user chooses whether to stay or switch.

The result is revealed.

The app tracks whether staying or switching performs better over repeated trials.

### Level Progression

Level 1: 3 doors
Level 2: 5 doors
Level 3: 10 doors
Level 4: 30 doors
Level 5: custom number of doors

The key design moment should happen at higher levels.

When there are 30 doors and the host removes 28 losing doors, switching should visually feel much more convincing.

### Visual Behavior

Doors should glow when selected.

Eliminated doors should fade, dissolve, or collapse.

The remaining switch option should pulse or glow.

The prize reveal should feel satisfying but not too childish.

### Important UI Elements

* Door grid
* Selected door indicator
* Host message panel
* Stay button
* Switch button
* Round result panel
* Stay wins counter
* Switch wins counter
* Probability explanation card

### Example Monty Hall Screen Flow

Screen message:

**Choose one door.**

User chooses door 7.

Message:

**The host knows where the prize is. Watch what gets eliminated.**

Doors fade away.

Message:

**Only two choices remain: your original door, or the other unopened door.**

Buttons:

**Stay**
**Switch**

After result:

**You switched and won.**

or

**You stayed and lost.**

Then later:

**With 30 doors, your first choice had only a 1/30 chance. The remaining unopened door carries the probability from the eliminated doors.**

## 13. Explanation Design

Explanations should be visual and short.

Avoid large blocks of text.

Use:

* cards,
* probability bars,
* icons,
* small diagrams,
* step-by-step reveal,
* animated highlights.

For Monty Hall, show:

Original choice: `1 / number of doors`

Switching chance: `(number of doors - 1) / number of doors`

For 3 doors:

Stay: `1/3`
Switch: `2/3`

For 30 doors:

Stay: `1/30`
Switch: `29/30`

The design should make this visually obvious.

## 14. Reusable UI Components

To keep the Flutter code adaptable, the design should be based on reusable components.

### Core Components

#### LabBackground

Reusable dark gradient background with optional particles or abstract shapes.

#### ParadoxCard

Reusable card for each paradox in the hub.

#### LabButton

Reusable glowing button.

Button variants:

* primary,
* secondary,
* danger,
* success,
* disabled.

#### InsightCard

Used for explanations after simulations.

#### ResultPanel

Used to show win/loss/result summaries.

#### ProgressChip

Small chip showing level, doors, round number, or status.

#### SimulationFrame

A reusable container for the interactive part of each paradox.

#### ProbabilityBar

Used to compare probabilities visually.

#### LabDialog

Reusable modal for short explanations or decisions.

## 15. Flutter Code Architecture Direction

The Flutter project should separate design, content, and logic.

Recommended structure:

```text
lib/
  main.dart
  app.dart

  core/
    theme/
      app_colors.dart
      app_text_styles.dart
      app_theme.dart
    widgets/
      lab_background.dart
      lab_button.dart
      paradox_card.dart
      insight_card.dart
      result_panel.dart
      progress_chip.dart
      probability_bar.dart

  features/
    home/
      home_screen.dart

    paradoxes/
      paradox_model.dart
      paradox_registry.dart

    monty_hall/
      monty_hall_screen.dart
      monty_hall_controller.dart
      monty_hall_state.dart
      monty_hall_models.dart
      widgets/
        door_widget.dart
        door_grid.dart
        monty_hall_stats_panel.dart
```

This structure makes the app easier to expand later.

## 16. Design Adaptability Requirements for Code

The code should not hardcode colors, spacing, text styles, or component styles directly inside screens.

Instead:

* all colors should come from `AppColors`,
* all text styles should come from `AppTextStyles`,
* common buttons should use `LabButton`,
* common cards should use `InsightCard` or `ParadoxCard`,
* paradox data should come from models/lists,
* Monty Hall levels should come from configurable data,
* animations should be optional and not required for core logic.

This makes the UI easier to redesign later.

## 17. Data-Driven Paradox Design

Each paradox should be represented by a model.

Example fields:

```text
id
title
shortDescription
longDescription
icon
difficulty
themeColor
route
isCompleted
```

This allows the home screen to generate paradox cards automatically.

Monty Hall levels should also be data-driven.

Example fields:

```text
levelNumber
doorCount
doorsToEliminate
explanationText
```

This lets the team adjust the learning progression without rewriting the entire screen.

## 18. Animation Direction

Animations should support understanding, not just decoration.

Useful animations:

* doors glowing on selection,
* eliminated doors fading out,
* probability bars filling,
* result card sliding in,
* background particles drifting slowly,
* insight card glowing when revealed,
* buttons pulsing gently when they are the next action.

Avoid too many animations at once. The app should feel alive, not chaotic.

## 19. Accessibility Requirements

The app should remain readable despite the dark neon style.

Requirements:

* strong text contrast,
* large enough buttons,
* clear selected states,
* do not rely only on color to show success/failure,
* include labels/icons/text,
* avoid flashing animations,
* allow animations to be subtle.

## 20. First Prototype Scope

The first prototype should focus only on the full Monty Hall experience.

Minimum prototype:

1. Home screen
2. Paradox card for Monty Hall
3. Monty Hall intro screen
4. 3-door simulation
5. 30-door simulation
6. Stay/switch result tracking
7. Final explanation screen

Do not try to fully build every paradox at first.

The first milestone should prove the app’s design language and interaction structure.

## 21. Possible Future Paradox Modules

### Zeno’s Paradox

Interaction: user tries to move a character toward a finish line, but each tap moves half the remaining distance.

Main idea: infinite steps can still have a finite limit.

### Achilles and the Tortoise

Interaction: two racers move along a path, with animated intervals showing Achilles reaching where the tortoise was.

Main idea: infinite subdivision does not prevent motion.

### Ship of Theseus

Interaction: user replaces parts of a ship one by one and is asked when it stops being the same ship.

Main idea: identity over time and replacement.

### Prisoner’s Dilemma

Interaction: user chooses cooperate or betray, then sees payoff depending on the other player.

Main idea: rational individual decisions can create worse collective outcomes.

### Hilbert’s Hotel

Interaction: user manages rooms in an infinite hotel.

Main idea: infinity behaves differently from finite quantities.

## 22. Open Questions

Before finalizing the design, the team should answer these:

1. Is the app more game-like, educational, or narrative-based?
2. How many paradoxes are required for the project submission?
3. Does each paradox need a full simulation, or can some be shorter visual stories?
4. Should the app track progress?
5. Should there be scores, badges, or completion states?
6. Should explanations be formal, simple, or mixed?
7. Should the app include formulas?
8. Should the user be allowed to replay simulations freely?
9. Should the visual theme be more “lab” or more “cosmic”?
10. Should the app include sound effects?
11. Should the app work fully offline?
12. Should animations be essential or optional?
13. How much time is available for implementation?
14. What is the minimum version that still feels impressive?
15. Which paradox should be built after Monty Hall?

## 23. Recommended Direction

The best direction is:

**A neon Paradox Lab with modular experiment screens.**

Build Monty Hall as the first complete vertical slice.

The app should prioritize interaction before explanation, because the strongest educational effect comes from letting the user experience the failure of intuition.

The final app does not need many fully developed paradoxes. It is better to have one or two polished, interactive paradoxes than five shallow ones.

A strong final version could include:

* polished home screen,
* full Monty Hall module,
* one additional smaller paradox module,
* visual explanation cards,
* consistent neon lab design system,
* clean reusable Flutter components.
