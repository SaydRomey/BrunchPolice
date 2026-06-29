# Visual Feedback (Blinking Effect)

Purpose:

- Notify the player or user that the entity is invincible.

- Provide immediate feedback when damage is taken.

## Where to Implement?

Implement visual feedback in the entity's main script or Sprite node,
triggered by the HealthComponent.

## Implementation

Blinking Effect in BaseEnemy

```cpp

void BaseEnemy::_init() {

is_invincible = false;

}

void BaseEnemy::apply_visual_feedback() {

if (has_node("Sprite")) {

Sprite *sprite = cast_to<Sprite>(get_node("Sprite"));

if (sprite) {

Timer *blink_timer = Timer::_new();

blink_timer->set_wait_time(0.1f); // Blink every 0.1 seconds

blink_timer->set_one_shot(false);

add_child(blink_timer);

blink_timer->connect("timeout", this, [sprite]() {

sprite->set_visible(!sprite->is_visible());

});

blink_timer->start();

// Stop blinking after invincibility ends

Timer *end_timer = Timer::_new();

end_timer->set_wait_time(1.0f); // Duration of invincibility

end_timer->set_one_shot(true);

add_child(end_timer);

end_timer->connect("timeout", this, [blink_timer, sprite]() {

blink_timer->stop();

sprite->set_visible(true); // Ensure visibility is restored

});

end_timer->start();

}

}

}

```

Trigger Visual Feedback in take_damage

```cpp

void BaseEnemy::take_damage(float damage, Dictionary damage_source) {

if (!is_invincible) {

apply_visual_feedback();

HealthComponent::take_damage(damage, damage_source);

}

}

```

---
