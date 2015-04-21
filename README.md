Elm Gamepad
===========

Wrapper around the [W3C Gamepad API
(draft)](https://w3c.github.io/gamepad/gamepad.html). It's still all very
experimental.

Usage
-----

```elm
-- Get a list of gamepads whenever one of them changes
Gamepad.gamepads : Signal List Gamepad
```

Current limitations
-------------------

Because the Gamepad API is missing controller update events we're forced to
poll. The current implementation depends on requestAnimationFrame which might
or might not conflict with Elm's reactor loop. I've put some effort to limit
GC but it's still all very taxing.

To avoid fingerprinting controllers only appear when some buttons are pressed
on them.

Tested under Firefox 37.

Chrome is also supposed to work but I only managed to make the controller
appear once.

License
-------

MIT 2015 zimbatm

