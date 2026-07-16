# Clean Layout Checklist

Run through this before adding any visual polish or animation. Layout problems don't get fixed by better colors or motion.

## Visual hierarchy
- One clear primary action per screen/section — if everything is emphasized, nothing is
- Heading sizes step down predictably (e.g. a type scale like 1.25x or 1.333x per level), never arbitrary pixel values
- The most important element is the first thing the eye lands on (size, contrast, or position — not just color)

## Spacing
- Use a consistent spacing scale (e.g. 4/8px base: 4, 8, 12, 16, 24, 32, 48, 64, 96) — never one-off values
- Related elements sit closer together than unrelated ones (proximity implies grouping)
- Section padding is generous — cramped sections read as unfinished, not efficient

## Alignment & grid
- Everything aligns to a consistent grid or baseline — no floating elements that don't line up with anything
- Text blocks have a max-width (~60-75 characters per line) — full-width text on wide screens is unreadable
- Consistent left/right edge alignment within a section

## Typography
- Max 2 typefaces (one for headings, one for body — or one family at multiple weights)
- Body text ≥16px, line-height 1.5-1.7 for readability
- Avoid centering long paragraphs — center short headlines/CTAs, left-align body copy

## Color & contrast
- Text meets WCAG AA contrast (4.5:1 for body text, 3:1 for large text) against its background
- One accent color used deliberately for CTAs/links, not scattered everywhere
- Don't rely on color alone to convey state (add icons/text for errors, success, etc.)

## Responsive behavior
- Design mobile-first breakpoints, don't just shrink a desktop layout
- Touch targets ≥44x44px on mobile
- Verify at 375px, 768px, 1280px, and 1920px widths — not just desktop

If a layout feels "off" but nothing above stands out, it's usually spacing inconsistency or too many competing focal points — check those two first.
