# The Pearl Thief
## A Ludum Dare 49 Compo Entry
### Gameplay
**Controls**: WASD Space
Shoot Kraken that want to steal pearls and try to keep as long as possible.

The more pearls are stolen, the less stable the gameplay becomes.

Eventually game crashes (by design) because of `NullPointerException`.

### Compiling
```
haxelib install lime\
 && haxelib install openfl\
 && haxelib install flixel\
 && haxelib install flixel-addons\
 && lime build html5
```

