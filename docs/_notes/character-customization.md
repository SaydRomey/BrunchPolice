Character Customization

System in C++98 for Godot.

This example includes a basic setup for customizing the player's
appearance, including gender-neutral options such as skin tone, hair
color, and outfit. The implementation assumes integration with Godot's
C++ API.

---

Directory Structure

/src/

CharacterCustomizer.cpp

CharacterCustomizer.hpp

PlayerCharacter.cpp

PlayerCharacter.hpp

/inc/

CharacterCustomizer.tscn

CharacterCustomizerUI.tscn

---

CharacterCustomizer.hpp

#ifndef CHARACTER_CUSTOMIZER_HPP

#define CHARACTER_CUSTOMIZER_HPP

#include <Node.hpp>

#include <Dictionary.hpp>

#include <String.hpp>

#include <Ref.hpp>

#include <Sprite.hpp>

class CharacterCustomizer : public godot::Node {

GODOT_CLASS(CharacterCustomizer, godot::Node)

private:

godot::Dictionary customization_options; // Holds options like hair
color, skin tone, outfit

godot::Ref<godot::Sprite> player_sprite; // Reference to the player's
sprite

public:

static void _register_methods();

CharacterCustomizer();

~CharacterCustomizer();

void _init(); // Godot-specific constructor

void set_player_sprite(godot::Ref<godot::Sprite> sprite);

void set_customization_option(const godot::String &key, const
godot::String &value);

godot::String get_customization_option(const godot::String &key) const;

void apply_customizations();

};

#endif // CHARACTER_CUSTOMIZER_HPP

---

CharacterCustomizer.cpp

#include "CharacterCustomizer.hpp"

using namespace godot;

void CharacterCustomizer::_register_methods() {

register_method("_init", &CharacterCustomizer::_init);

register_method("set_player_sprite",
&CharacterCustomizer::set_player_sprite);

register_method("set_customization_option",
&CharacterCustomizer::set_customization_option);

register_method("get_customization_option",
&CharacterCustomizer::get_customization_option);

register_method("apply_customizations",
&CharacterCustomizer::apply_customizations);

}

CharacterCustomizer::CharacterCustomizer() {}

CharacterCustomizer::~CharacterCustomizer() {}

void CharacterCustomizer::_init() {

// Initialize customization options

customization_options["skin_tone"] = "default";

customization_options["hair_color"] = "default";

customization_options["outfit"] = "default";

}

void CharacterCustomizer::set_player_sprite(Ref<Sprite> sprite) {

player_sprite = sprite;

}

void CharacterCustomizer::set_customization_option(const String &key,
const String &value) {

if (customization_options.has(key)) {

customization_options[key] = value;

} else {

Godot::print("Invalid customization key: " + key);

}

}

String CharacterCustomizer::get_customization_option(const String &key)
const {

if (customization_options.has(key)) {

return customization_options[key];

}

return "Invalid Key";

}

void CharacterCustomizer::apply_customizations() {

if (player_sprite.is_valid()) {

// Apply skin tone

if (customization_options["skin_tone"] == "light") {

player_sprite->set_modulate(Color(1.0, 0.8, 0.6));

} else if (customization_options["skin_tone"] == "dark") {

player_sprite->set_modulate(Color(0.4, 0.3, 0.2));

} else {

player_sprite->set_modulate(Color(1.0, 1.0, 1.0)); // Default

}

// Apply hair color and outfit (simplified example)

// These would be linked to specific textures or sprite frames

Godot::print("Applying hair color: " +
customization_options["hair_color"]);

Godot::print("Applying outfit: " + customization_options["outfit"]);

}

}

---

PlayerCharacter.hpp

#ifndef PLAYER_CHARACTER_HPP

#define PLAYER_CHARACTER_HPP

#include <Sprite.hpp>

class PlayerCharacter : public godot::Sprite {

GODOT_CLASS(PlayerCharacter, godot::Sprite)

public:

static void _register_methods();

PlayerCharacter();

~PlayerCharacter();

void _init(); // Godot-specific constructor

};

#endif // PLAYER_CHARACTER_HPP

---

PlayerCharacter.cpp

#include "PlayerCharacter.hpp"

using namespace godot;

void PlayerCharacter::_register_methods() {

register_method("_init", &PlayerCharacter::_init);

}

PlayerCharacter::PlayerCharacter() {}

PlayerCharacter::~PlayerCharacter() {}

void PlayerCharacter::_init() {

// Initialize player character here

}

---

Godot Scene Setup

1. CharacterCustomizerUI.tscn

Create a UI with dropdowns for options like Skin Tone, Hair Color, and
Outfit.

Connect signals from UI elements (like on_selection_changed) to methods
in CharacterCustomizer.

2. CharacterCustomizer.tscn

Attach CharacterCustomizer as a script to this node and link it to the
UI and player sprite.

---

Connecting Customization to Gameplay

1. Assign the PlayerCharacter sprite to the CharacterCustomizer node.

2. Call set_customization_option from the UI when a player selects an
option.

3. Call apply_customizations to update the player sprite with the
selected options.

---

This structure allows you to:

1. Dynamically update player appearance in real-time.

2. Save and load customization options using a Dictionary.

3. Expand options easily for future features like accessories or
animations.
