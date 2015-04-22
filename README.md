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
GC but it's still taking quite a bit of time on the game loop.

To avoid fingerprinting controllers, browsers only show them when a first
button is pressed.

Tested under Firefox 37.

Chrome is also supposed to work but I only managed to make the controller
appear once.

Ideas
-----

It might be helpful to translate the above signal to a single gamepad.
The Gamepad would have an additional connected property to signal when it
comes and goes.

```elm
Gamepad.gamepad1 : Signal Gamepad
```

License
-------

MIT 2015 zimbatm

