Fallible
=======================

## Omit "PRIMARY KEY" of sql adapter
If you omit "PRIMARY KEY" in config of sql and save model many times, next time your collection fetch data from sql would spend more and more time.

## Forget debinding
- Call 'destroy' when you really wanna release the controller, if you use data-binding
- 'Ti.App.removeEventListener', don`t forget remove event listener especially 'Ti.app'
