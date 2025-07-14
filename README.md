> W.I.P.

# Brunch Police

[Game Design Document](./docs/game-design/game-design-doc.md)  

[Character and Level Design Document](./docs/game-design/character-and-level-design.md)

[Weapons Ideas and Implementation Document](./docs/game-design/weapons/weapons.md)


---

## File Structure

```
brunch_police/
├── src/                         # C++ source files
│   ├── core/                    # Core game logic
│   │   ├── Game.cpp             # Main game logic
│   │   ├── Player.cpp           # Player logic
│   │   ├── Enemy.cpp            # Base enemy class
│   │   ├── Boss.cpp             # Base boss class
│   │   ├── Weapon.cpp           # Weapon logic
│   │   ├── Inventory.cpp        # Inventory system
│   │   ├── DialogueSystem.cpp   # Dialogue and interactions
│   │   ├── SaveSystem.cpp       # Save/load system
│   ├── utils/                   # Utility classes
│   │   ├── Timer.cpp            # Timer manager
│   │   ├── ResourceManager.cpp  # Resource management
│   │   ├── AudioManager.cpp     # Audio management
│   │   ├── VisualEffects.cpp    # Visual effects manager
│   ├── levels/                  # Level-specific logic
│   │   ├── GreaseCanyon.cpp
│   │   ├── PastryPalace.cpp
│   │   ├── StickySyrupSwamp.cpp
│   │   ├── KitchenMayhem.cpp
│   │   ├── CandyChaos.cpp
│   │   ├── EggFactoryFrenzy.cpp
│   │   ├── CitrusCascade.cpp
│   │   ├── BakeryBonanza.cpp
│   ├── main.cpp                 # Entry point (if needed)
├── inc/                         # C++ header files
│   ├── core/                    # Corresponding headers for core logic
│   │   ├── Game.hpp
│   │   ├── Player.hpp
│   │   ├── Enemy.hpp
│   │   ├── Boss.hpp
│   │   ├── Weapon.hpp
│   │   ├── Inventory.hpp
│   │   ├── DialogueSystem.hpp
│   │   ├── SaveSystem.hpp
│   ├── utils/                   # Corresponding headers for utilities
│   │   ├── Timer.hpp
│   │   ├── ResourceManager.hpp
│   │   ├── AudioManager.hpp
│   │   ├── VisualEffects.hpp
│   ├── levels/                  # Headers for level-specific logic
│   │   ├── GreaseCanyon.hpp
│   │   ├── PastryPalace.hpp
│   │   ├── StickySyrupSwamp.hpp
│   │   ├── KitchenMayhem.hpp
│   │   ├── CandyChaos.hpp
│   │   ├── EggFactoryFrenzy.hpp
│   │   ├── CitrusCascade.hpp
│   │   ├── BakeryBonanza.hpp
├── obj/                         # Compiled object files (auto-generated)
│   ├── core/
│   ├── utils/
│   ├── levels/
├── build/                       # Compiled output libraries (auto-generated)
│   ├── brunch_police.so         # Linux shared library
│   ├── brunch_police.dylib      # macOS shared library
│   ├── brunch_police.dll        # Windows DLL
├── gdnative/                    # Godot-specific files
│   ├── brunch_police.gdnlib     # GDNative library configuration
│   ├── Player.gdns              # GDNativeScript for Player
│   ├── Enemy.gdns               # GDNativeScript for Enemy
├── assets/                      # Game assets
│   ├── sprites/                 # 2D sprites
│   │   ├── player.png
│   │   ├── enemies/
│   │   │   ├── croissant_crook.png
│   │   │   ├── bacon_bandit.png
│   │   │   ├── syrup_scoundrel.png
│   │   │   ├── etc...
│   ├── audio/                   # Audio files
│   │   ├── music/
│   │   │   ├── theme.ogg
│   │   ├── sfx/
│   │   │   ├── jump.wav
│   │   │   ├── hit.wav
│   ├── backgrounds/             # Background images
│   │   ├── grease_canyon_bg.png
│   │   ├── pastry_palace_bg.png
├── scenes/                      # Godot scenes
│   ├── main.tscn                # Main menu scene
│   ├── levels/                  # Level scenes
│   │   ├── grease_canyon.tscn
│   │   ├── pastry_palace.tscn
│   │   ├── sticky_syrup_swamp.tscn
│   │   ├── etc...
│   ├── characters/              # Character-specific scenes
│   │   ├── player.tscn
│   │   ├── croissant_crook.tscn
│   │   ├── bacon_bandit.tscn
├── helpers/                     # Helper Makefiles for platform-specific builds
│   ├── Linux.mk
│   ├── macOS.mk
│   ├── Windows.mk
├── shaders/                     # Shaders for visual effects
│   ├── grease_shader.gdshader   # Grease Canyon effects
│   ├── syrup_shader.gdshader    # Sticky Syrup Swamp effects
├── Makefile                     # Main Makefile
├── README.md                    # Project documentation
├── LICENSE                      # License file
```

---

