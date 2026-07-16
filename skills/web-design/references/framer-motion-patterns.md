# Framer Motion Patterns

Apply these only after layout and content are final — never use motion to distract from a layout problem.

## Setup
```bash
npm install framer-motion
```

## Accessible default — respect reduced motion
Always wrap animations to respect `prefers-reduced-motion`:

```tsx
import { useReducedMotion } from "framer-motion";

const shouldReduceMotion = useReducedMotion();
const variants = {
  hidden: { opacity: 0, y: shouldReduceMotion ? 0 : 20 },
  visible: { opacity: 1, y: 0 },
};
```

## Entrance: fade-in-up
```tsx
<motion.div
  initial={{ opacity: 0, y: 20 }}
  animate={{ opacity: 1, y: 0 }}
  transition={{ duration: 0.5, ease: "easeOut" }}
>
  {children}
</motion.div>
```

## Staggered list/grid children
```tsx
const container = {
  hidden: {},
  visible: { transition: { staggerChildren: 0.08 } },
};
const item = {
  hidden: { opacity: 0, y: 12 },
  visible: { opacity: 1, y: 0 },
};

<motion.ul variants={container} initial="hidden" animate="visible">
  {items.map((item) => (
    <motion.li key={item.id} variants={item}>{item.label}</motion.li>
  ))}
</motion.ul>
```

## Scroll-triggered reveal
```tsx
<motion.div
  initial={{ opacity: 0, y: 24 }}
  whileInView={{ opacity: 1, y: 0 }}
  viewport={{ once: true, margin: "-100px" }}
  transition={{ duration: 0.5 }}
>
  {children}
</motion.div>
```

## Hover/tap micro-interaction (buttons, cards)
```tsx
<motion.button
  whileHover={{ scale: 1.03 }}
  whileTap={{ scale: 0.97 }}
  transition={{ duration: 0.15 }}
>
  {label}
</motion.button>
```

## Page/route transitions
```tsx
import { AnimatePresence, motion } from "framer-motion";

<AnimatePresence mode="wait">
  <motion.div
    key={pathname}
    initial={{ opacity: 0 }}
    animate={{ opacity: 1 }}
    exit={{ opacity: 0 }}
    transition={{ duration: 0.2 }}
  >
    {children}
  </motion.div>
</AnimatePresence>
```

## Common mistakes
- Animating on every element — apply to 1-2 focal points per view (hero, primary CTA, section reveals), not every card/paragraph
- Durations over ~0.6s feel sluggish for UI (vs. marketing hero moments, which can go longer)
- Forgetting `viewport={{ once: true }}` — without it, scroll animations replay every time the element re-enters view, which reads as glitchy
- Skipping the reduced-motion check above
