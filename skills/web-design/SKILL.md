---
name: web-design
description: Use when building or improving a website's frontend UI in React/Next.js — landing pages, marketing sites, hero sections, or any user-facing web layout. Combines clean UI/UX layout principles, 21st.dev-sourced hero section patterns, and Framer Motion animation patterns. Trigger: website, landing page, hero section, UI layout, Framer Motion, animations, marketing site.
---

# web-design

Guidance for building polished, professional website UI in React/Next.js: clean layout first, a strong hero section, then animation. Auto-triggers whenever website/landing-page/UI work is detected — not a manual command.

## When to use
- Building a new landing page, marketing site, or website UI
- Redesigning or improving an existing site's layout
- Adding or improving a hero section
- Adding entrance/scroll/hover animations to a web UI

## Workflow

1. **Layout pass** — before writing markup, run through `references/layout-principles.md` (hierarchy, spacing, alignment, typography, contrast, responsive breakpoints). Fix structural issues before polishing anything else.
2. **Hero section** — if the page needs one, follow `references/hero-sections.md` to source and adapt a pattern (prefers Magic MCP/21st.dev when available, falls back to fetching 21st.dev directly).
3. **Animation pass** — once layout and content are settled, apply `references/framer-motion-patterns.md` for entrance/scroll/hover motion. Animation comes last; it never substitutes for a fix that belongs in the layout pass.

## Common mistakes
- Reaching for animation to fix a problem that's actually in the layout — fix hierarchy/spacing first.
- Hand-rolling a hero section from scratch when a vetted 21st.dev pattern would be faster and more consistent.
- Animating everything on the page — motion should draw attention to one or two key elements, not compete for attention everywhere.
- Ignoring `prefers-reduced-motion` — see `references/framer-motion-patterns.md` for the accessible default.
