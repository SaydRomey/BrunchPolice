# Enemy Asset Pipeline

## Required sprite groups

For each enemy, produce:

```text
idle
patrol / walk
chase / run
attack
stunned
wrapped
defeat
```

Flying enemies usually use:

```text
hover
aim
swoop
recover
stunned
wrapped
defeat
```

## Pixel prompt style

Use this shared prefix:

```text
Clean pixel art game enemy sprite, bold readable silhouette, crisp outlines, simple shaded highlights, food-themed platformer enemy, expressive face, no text, no UI, no background.
```

## Small Angry Pig prompt

```text
Clean pixel art game enemy sprite, bold readable silhouette, crisp outlines, simple shaded highlights, food-themed platformer enemy, expressive face, no text, no UI, no background. Angry little pig enemy with round pink body, short legs, tiny hooves, scrunched eyebrows, bacon-grease shine on snout, small tusk or tooth detail, compact charging silhouette.
```

Recommended animations:

```text
idle snort
patrol walk
charge windup with hoof scrape
fast charge
stunned wobble
wrapped bacon/freeze loop
defeat pop
```

## Flying Sausage Link prompt

```text
Clean pixel art game enemy sprite, bold readable silhouette, crisp outlines, simple shaded highlights, food-themed platformer enemy, expressive face, no text, no UI, no background. Flying sausage-link enemy with small flapping wings, linked sausage body, reddish-brown casing, angry face, tiny grease droplets, hovering swoop-attack silhouette.
```

Recommended animations:

```text
hover flap
aim pause
swoop dive
recovery rise
stunned spin
wrapped loop
defeated spin-fall
```

## Import notes

In Godot:

1. Import sprites with filter disabled for pixel art.
2. Create SpriteFrames.
3. Name animations exactly as expected by the script.
4. Replace placeholder Sprite2D with AnimatedSprite2D.
5. Set the exported animation names if you choose different names.
