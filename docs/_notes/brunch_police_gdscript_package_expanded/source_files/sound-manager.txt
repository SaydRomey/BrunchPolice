Sound Manager

A central class to manage audio:

Background music (BGM) and sound effects (SFX).

Adjustable volume and playback settings.

Crossfades for smooth transitions between tracks.

Sound Manager

The Sound Manager centralizes audio handling, including:

1. Background Music (BGM) Management: Play, stop, or loop level-specific
music.

2. Sound Effects (SFX) Management: Play individual sounds for
actions/events.

3. Volume Control: Adjust global volume for music and effects.

---

1. Sound Manager Implementation

Header File (SoundManager.h)

#ifndef SOUND_MANAGER_H

#define SOUND_MANAGER_H

#include <godot_cpp/classes/node.hpp>

#include <godot_cpp/classes/audio_stream_player.hpp>

#include <map>

#include <string>

using namespace godot;

class SoundManager : public Node {

GDCLASS(SoundManager, Node);

private:

Ref<AudioStreamPlayer> bgm_player; // Handles background music

std::map<std::string, Ref<AudioStream>> sound_effects; // Cache for
sound effects

float music_volume;

float sfx_volume;

public:

void _init();

void set_music_volume(float volume);

void set_sfx_volume(float volume);

void play_bgm(const String &path, bool loop = true);

void stop_bgm();

void preload_sound(const String &key, const String &path);

void play_sfx(const String &key);

};

#endif // SOUND_MANAGER_H

---

Implementation File (SoundManager.cpp)

#include "SoundManager.h"

void SoundManager::_init() {

bgm_player = AudioStreamPlayer::_new();

add_child(bgm_player);

music_volume = 1.0f;

sfx_volume = 1.0f;

sound_effects.clear();

}

void SoundManager::set_music_volume(float volume) {

music_volume = volume;

bgm_player->set_volume_db(20.0f * Math::log(music_volume));

}

void SoundManager::set_sfx_volume(float volume) {

sfx_volume = volume;

for (std::map<std::string, Ref<AudioStream>>::iterator it =
sound_effects.begin(); it != sound_effects.end(); ++it) {

// Optional: Update volume-related logic for preloaded SFX if needed

}

}

void SoundManager::play_bgm(const String &path, bool loop) {

Ref<AudioStream> music = ResourceLoader::get_singleton()->load(path);

if (music.is_valid()) {

bgm_player->set_stream(music);

bgm_player->set_loop(loop);

bgm_player->play();

} else {

Godot::print("Failed to load BGM: " + path);

}

}

void SoundManager::stop_bgm() {

bgm_player->stop();

}

void SoundManager::preload_sound(const String &key, const String &path)
{

Ref<AudioStream> sound = ResourceLoader::get_singleton()->load(path);

if (sound.is_valid()) {

sound_effects[key.utf8().get_data()] = sound;

Godot::print("Preloaded sound: " + path);

} else {

Godot::print("Failed to preload sound: " + path);

}

}

void SoundManager::play_sfx(const String &key) {

if (sound_effects.find(key.utf8().get_data()) != sound_effects.end()) {

Ref<AudioStreamPlayer> sfx_player = AudioStreamPlayer::_new();

sfx_player->set_stream(sound_effects[key.utf8().get_data()]);

sfx_player->set_volume_db(20.0f * Math::log(sfx_volume));

add_child(sfx_player);

sfx_player->play();

sfx_player->connect("finished", sfx_player, "queue_free"); // Clean up
after playback

} else {

Godot::print("Sound effect not found: " + key);

}

}

---

Usage

Global Setup

Add SoundManager to your main scene (autoload it for global access):

Ref<SoundManager> sound_manager =
get_node<SoundManager>("/root/SoundManager");

Play Background Music

sound_manager->play_bgm("res://music/level1.ogg", true);

Play Sound Effects

sound_manager->preload_sound("jump", "res://sounds/jump.ogg");

sound_manager->play_sfx("jump");

Adjust Volumes

sound_manager->set_music_volume(0.8f); // 80% volume for music

sound_manager->set_sfx_volume(0.5f); // 50% volume for sound effects

Stop Music

sound_manager->stop_bgm();

---

Summary

Centralized control of BGM and SFX.

Preload and cache sound effects for efficiency.

Adjustable global music and effect volumes.
