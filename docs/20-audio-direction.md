# Audio Direction

## Identity

Brunch hub: relaxed jazz/lounge rhythms with light cutlery, chatter and buffet ambiance. Chase levels: playful, faster tracks emphasizing world material and movement rhythm. Boss encounters: energetic variations that preserve telegraph clarity; victory resolutions are brief celebratory stingers.

## Bus structure

`Master`, `Music`, `Ambience`, `SFX`, `Voice`, `UI`. The settings screen exposes saved sliders; audio middleware is not required for baseline implementation. Dynamic states should duck voice and essential warnings without muting all other buses.

## Required cue families

Footsteps/landings by surface, dash/jump, melee impact/block/parry, projectile launch/impact, pickup/evidence stamp, inspect focus, conversation tick/confirm, accusation result, checkpoint, boss phase, valve activation and low-health warning. UI focus/move/accept/back sounds should be subtle and distinct.

## Caffeine Craze cue palette

Espresso hiss, compressor spool, copper pipe rattle, steam burst and relief, ceramic clink, grinder teeth, froth bubble pop, coffee-bean bounce, boss overpressure siren and valve click. An upward vent must sound different from a damaging vent. Pressure warning cues scale with the gauge's phase without drowning NPC or accessibility audio.

## Accessibility and mix acceptance

All sound-critical mechanics have equivalent visuals; dialogue subtitles are independently enabled. Test volume range on speakers and headphones, voice intelligibility, warning priority when many emitters overlap and music continuity during scene routes.
