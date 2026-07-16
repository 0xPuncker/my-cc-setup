# Hero Section Sourcing Workflow

A hero section needs to communicate the value proposition in under 5 seconds. Don't hand-build one from scratch when a vetted pattern exists — adapt one instead.

## What a strong hero needs
- **Headline** — states the specific value/outcome, not a generic tagline ("Ship features 2x faster", not "Welcome to our platform")
- **Subheadline** — one sentence expanding on the headline, answers "how" or "for whom"
- **Primary CTA** — one clear action, high contrast, above the fold
- **Visual anchor** — product screenshot, illustration, or short video; never decoration with no informational value
- **Mobile stacking** — visual anchor moves below the text on narrow viewports, never squeezed beside it

## Sourcing workflow

1. **Check for Magic MCP.** If the Magic MCP server (21st.dev integration) is connected, use it to generate/adapt a hero section component matching the project's existing design system (colors, spacing scale, typography from `references/layout-principles.md`). This is the fastest path and stays in sync with 21st.dev's current component patterns.

2. **No Magic MCP available — fall back to manual sourcing.** Use `WebFetch` on `https://21st.dev` (or search it) to browse hero section examples. Pick a layout pattern that fits the page's content shape (e.g. text-left/image-right, centered stack, split-screen), then hand-implement it in the project's actual stack — don't copy someone else's CSS/colors, just the structural pattern (layout, spacing rhythm, hierarchy).

3. **Adapt, don't transplant.** Whatever the source, re-theme it to the project's existing design tokens (colors, fonts, spacing scale) before treating it as done. A hero section that visually doesn't match the rest of the site is worse than a plain one.

## Common mistakes
- Copying a hero section's exact colors/fonts instead of just its structural pattern
- Skipping the mobile stacking check — a hero that looks great at 1440px and breaks at 375px isn't done
- A vague headline ("The best solution for your business") — always name the specific outcome
