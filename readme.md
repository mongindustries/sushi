# 🍣 スシ
#sushi
----
_You read it as Su-Shi. Yes, that Japanese food…_

A Game Kernel!

### Game Kernel?
~~I’M TIRED OF PEOPLE CALLING GAME ENGINES GAME ENGINES AND GAME ENGINES GAME ENGINES!~~ There is a difference between what a **Game Engine** does and a **Game Kernel** is:

#### Game Engine
A Game Engine is a set of software tools that lets people design and implement a game. It may be as simple as doing macros in a PowerPoint presentation or a complex Triple-A title made in Unreal Engine. Metaphorically, it is an engine that you place game design documents inside and pop outs a game (oh I wish there’s a machine that does that…)

#### Game Kernel
A Game Kernel is a software library that a programmer uses to implement a game. Its like Unreal Engine or Unity but without the editor, conversion tools, support libraries, etc. I can compare what I’m doing to those like SDL or GLFW.

So, to summarise. I’ll be designing and implementing a piece of software that lets me make games without using the full power of a game engine and at the same time avoiding to use boilerplate code on what game prototype I want to make in the future.

### Short-term goals
I'll be focusing first on building a skeleton API for application, window, graphics, and input management. Once the initial specifications for those things are set, I'll be moving onto improving and adding features. Notice that I haven't specified sound yet as because I don't have solid experience in programming with sound APIs (I hope they're similar with graphics APIs...)

### Features?

- 🐦 built using *the* latest Swift programming language
- 🛩 no-nonsense API, like the interior of a Subaru car
- 🍱 modular and cross-platform friendly: API consists of **drivers** that interacts with the OS and the actual api itself
