# remotion-video


# Remotion Video Production

Best practices for building programmatic videos with Remotion — animations, transitions, charts, and rendering.

## Core Capabilities

- Spring animation presets (bouncy, smooth, crisp, staggered)
- Interpolation patterns (camera zoom, parallax, scroll simulation)
- SVG draw-on animations (path tracing, stroke reveal)
- Scene transitions via TransitionSeries
- AbsoluteFill layering for compositing
- Chart animations (bar grow, line draw-on, pie reveal, count-up numbers)
- Audio integration and sync
- Rendering configuration

## Spring Presets

Use `spring()` from Remotion for physics-based animations:

| Preset | Config | Use Case |
|--------|--------|----------|
| Bouncy | `mass: 0.5, damping: 8, stiffness: 120` | Playful reveals, logo bounces |
| Smooth | `mass: 1, damping: 15, stiffness: 80` | UI transitions, slide-ins |
| Crisp | `mass: 0.8, damping: 20, stiffness: 200` | Snappy interactions, toggles |
| Staggered | Any preset with frame offset per item | List reveals, grid animations |

```tsx
import { spring, useCurrentFrame, useVideoConfig } from "remotion";

const frame = useCurrentFrame();
const { fps } = useVideoConfig();

const scale = spring({
  frame,
  fps,
  config: { mass: 0.5, damping: 8, stiffness: 120 },
});
```

## Interpolation Patterns

### Camera Zoom

```tsx
import { interpolate } from "remotion";

const zoom = interpolate(frame, [0, 30], [1, 1.5], {
  extrapolateRight: "clamp",
});
```

### Parallax Layers

```tsx
const bgX = interpolate(frame, [0, 100], [0, -50]);
const fgX = interpolate(frame, [0, 100], [0, -150]);
```

### Scroll Simulation

```tsx
const scrollY = interpolate(frame, [0, 90], [0, -800], {
  extrapolateRight: "clamp",
});
```

## SVG Draw-On

Animate `strokeDashoffset` to reveal SVG paths:

```tsx
const pathLength = 500;
const draw = interpolate(frame, [0, 60], [pathLength, 0], {
  extrapolateRight: "clamp",
});

<path
  d="..."
  strokeDasharray={pathLength}
  strokeDashoffset={draw}
/>
```

## Chart Animation Patterns

| Pattern | Technique |
|---------|-----------|
| Bar grow | Animate height from 0 to target, stagger each bar by 3-5 frames |
| Line draw-on | SVG path with strokeDashoffset animation |
| Pie/donut reveal | Animate conic-gradient stop or SVG arc path |
| Count-up numbers | Interpolate from 0 to target, `Math.round()` for display |

## Scene Transitions

```tsx
import { TransitionSeries, linearTiming } from "@remotion/transitions";
import { fade } from "@remotion/transitions/fade";

<TransitionSeries>
  <TransitionSeries.Sequence durationInFrames={90}>
    <SceneOne />
  </TransitionSeries.Sequence>
  <TransitionSeries.Transition
    timing={linearTiming({ durationInFrames: 15 })}
    presentation={fade()}
  />
  <TransitionSeries.Sequence durationInFrames={90}>
    <SceneTwo />
  </TransitionSeries.Sequence>
</TransitionSeries>
```

## Performance Rules

1. **No `useEffect` for animations.** Use `useCurrentFrame()` + `interpolate()`.
2. **Memoize static components.** `React.memo` for anything that does not depend on frame.
3. **Preload assets.** `staticFile()` for local, `prefetch()` for remote URLs.
4. **Keep compositions under 30s** for fast render iteration during development.
5. **Test at target resolution** (1920x1080 or 1080x1080) before final render.

## Anti-Patterns

- No CSS `transition` or `animation` — use Remotion `interpolate()` and `spring()`
- No `setTimeout` or `setInterval` — frame-based timing only
- No absolute pixel positioning for responsive layouts — use `AbsoluteFill` + flex
- No inline `style` objects recreated every frame — extract to constants or `useMemo`
- No uncontrolled audio — always set explicit `volume` and `startFrom`

For complete code examples and composition templates, see [REFERENCE.md](REFERENCE.md).

---

# Remotion Video — Reference

## Project Setup

```bash
npx create-video@latest my-video
cd my-video
npm start
```

## Composition Template

```tsx
import { Composition } from "remotion";
import { MyVideo } from "./MyVideo";

export const RemotionRoot: React.FC = () => {
  return (
    <Composition
      id="MyVideo"
      component={MyVideo}
      durationInFrames={150}
      fps={30}
      width={1920}
      height={1080}
    />
  );
};
```

## Common Resolutions

| Format | Width | Height | Use Case |
|--------|-------|--------|----------|
| Landscape HD | 1920 | 1080 | YouTube, presentations |
| Square | 1080 | 1080 | Instagram feed, LinkedIn |
| Portrait | 1080 | 1920 | TikTok, Reels, Stories |
| Twitter | 1280 | 720 | Twitter/X video |

## Spring Configuration Reference

```tsx
// All spring configs
const SPRINGS = {
  bouncy:    { mass: 0.5, damping: 8,  stiffness: 120 },
  smooth:    { mass: 1,   damping: 15, stiffness: 80  },
  crisp:     { mass: 0.8, damping: 20, stiffness: 200 },
  gentle:    { mass: 1.2, damping: 18, stiffness: 60  },
  snappy:    { mass: 0.4, damping: 12, stiffness: 250 },
  elastic:   { mass: 0.6, damping: 6,  stiffness: 100 },
};
```

## Staggered Animation Pattern

```tsx
const items = ["Item 1", "Item 2", "Item 3", "Item 4"];
const STAGGER_DELAY = 5; // frames between each item

{items.map((item, i) => {
  const delay = i * STAGGER_DELAY;
  const scale = spring({
    frame: frame - delay,
    fps,
    config: SPRINGS.bouncy,
  });
  const opacity = interpolate(
    frame - delay,
    [0, 10],
    [0, 1],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
  );
  return (
    <div key={i} style={{ transform: `scale(${scale})`, opacity }}>
      {item}
    </div>
  );
})}
```

## Count-Up Number Component

```tsx
const CountUp: React.FC<{
  target: number;
  startFrame?: number;
  duration?: number;
  prefix?: string;
  suffix?: string;
}> = ({ target, startFrame = 0, duration = 45, prefix = "", suffix = "" }) => {
  const frame = useCurrentFrame();
  const value = interpolate(
    frame - startFrame,
    [0, duration],
    [0, target],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
  );
  return (
    <span>
      {prefix}{Math.round(value).toLocaleString()}{suffix}
    </span>
  );
};
```

## Bar Chart Animation

```tsx
const AnimatedBar: React.FC<{
  value: number;
  maxValue: number;
  color: string;
  label: string;
  delay: number;
}> = ({ value, maxValue, color, label, delay }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  const width = spring({
    frame: frame - delay,
    fps,
    config: { mass: 1, damping: 15, stiffness: 80 },
  });

  const targetWidth = (value / maxValue) * 100;

  return (
    <div style={{ display: "flex", alignItems: "center", gap: 12, marginBottom: 8 }}>
      <div style={{ width: 120, fontSize: 14, textAlign: "right" }}>{label}</div>
      <div style={{ flex: 1, background: "rgba(255,255,255,0.1)", borderRadius: 4, height: 32 }}>
        <div
          style={{
            width: `${targetWidth * Math.min(width, 1)}%`,
            height: "100%",
            background: color,
            borderRadius: 4,
          }}
        />
      </div>
      <CountUp target={value} startFrame={delay} prefix="$" />
    </div>
  );
};
```

## Audio Integration

```tsx
import { Audio, staticFile, Sequence } from "remotion";

// Background music
<Audio src={staticFile("bgm.mp3")} volume={0.3} />

// Sound effect at specific time
<Sequence from={30}>
  <Audio src={staticFile("whoosh.mp3")} volume={0.8} />
</Sequence>

// Volume fade out
<Audio
  src={staticFile("bgm.mp3")}
  volume={(f) =>
    interpolate(f, [0, 120, 130, 150], [0, 0.3, 0.3, 0], {
      extrapolateLeft: "clamp",
      extrapolateRight: "clamp",
    })
  }
/>
```

## AbsoluteFill Layering

```tsx
import { AbsoluteFill } from "remotion";

<AbsoluteFill>
  {/* Layer 0: Background */}
  <AbsoluteFill style={{ background: "#0a0a0a" }} />

  {/* Layer 1: Animated background element */}
  <AbsoluteFill style={{ opacity: 0.3 }}>
    <GradientOrb />
  </AbsoluteFill>

  {/* Layer 2: Main content */}
  <AbsoluteFill style={{ justifyContent: "center", alignItems: "center" }}>
    <Title />
  </AbsoluteFill>

  {/* Layer 3: Overlay/HUD */}
  <AbsoluteFill style={{ pointerEvents: "none" }}>
    <Watermark />
  </AbsoluteFill>
</AbsoluteFill>
```

## Rendering Commands

```bash
# Preview in browser
npx remotion preview src/index.ts

# Render MP4 (default codec: h264)
npx remotion render src/index.ts MyVideo out/video.mp4

# Render with custom settings
npx remotion render src/index.ts MyVideo out/video.mp4 \
  --codec=h264 \
  --crf=18 \
  --pixel-format=yuv420p

# Render GIF
npx remotion render src/index.ts MyVideo out/animation.gif \
  --codec=gif

# Render still frame (for thumbnails)
npx remotion still src/index.ts MyVideo out/thumb.png --frame=45

# Render with props
npx remotion render src/index.ts MyVideo out/video.mp4 \
  --props='{"title": "Hello World"}'
```

## CRF Quality Guide

| CRF | Quality | File Size | Use Case |
|-----|---------|-----------|----------|
| 15 | Near lossless | Very large | Master/archive |
| 18 | Excellent | Large | YouTube upload |
| 23 | Good (default) | Medium | General use |
| 28 | Acceptable | Small | Preview/draft |

Lower CRF = higher quality = larger file.
