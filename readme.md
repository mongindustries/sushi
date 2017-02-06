# スシ
#sushi
----
_You read it as Su-Shi. Yes, that Japanese food…_

Game kernel that is written in Swift!

### Game Kernel?
~~I’M TIRED OF PEOPLE CALLING GAME ENGINES GAME ENGINES AND GAME ENGINES GAME ENGINES!~~ There is a difference between what a **Game Engine** does and a **Game Kernel** is:
#### Game Engine
A Game Engine is a set of software tools that lets people design and implement a game. It may be as simple as doing macros in a PowerPoint presentation or a complex Triple-A title made in Unreal Engine. Metaphorically, it is an engine that you place game design documents inside and pop outs a game (oh I wish there’s a machine that does that…)
#### Game Kernel
A Game Kernel is a software library that a programmer uses to implement a game. Its like Unreal Engine or Unity but without the editor, conversion tools, support libraries, etc. I can compare what I’m doing to those like SDL or GLFW.

So, to summarise. I’ll be designing and implementing a piece of software that lets me make games without using the full power of a game engine and at the same time avoiding to use boilerplate code on what game prototype I want to make in the future.

### Why Swift?
**I love* Swift!** I always use it in my day job and the elegance and eloquence of the language trumps over other compiled languages. Yes I know there are better compiled languages like C++, or Rust but this is what I’ve been using as my main programming language for the past 2 years so in a way it has a special place in my programming heart. Lastly, there are not much projects that uses Swift in regards to game development, and here I am wanting and eager to know more on how the gears and pulleys of how Swift works (like ARC, `Unsafe**Pointer`s, and more advanced generics concepts). So doing this serves a way to improve myself and my workflow into using Swift in my job and getting more experience in writing game development tools! 

### Design Considerations
So with that said, not only do I want my game engine be written in Swift, it should also satisfy the design considerations I have in mind:
* A flat node architecture
* Can be parallelised
* Compute only on demand

#### A Flat Node Architecture
Having a flat architecture simplifies the more complex code of managing a  Node Graph. In addition, I want my implementation to have the least amount of referencing with each other, that simplifies the memory model of the engine and (hopefully) I won’t have to deal much with doing `weak` references across the objects I’m going to design.

#### Can Be Parallelised
Modern processors have two or more cores, taking advantage of multiple processors cores opens the opportunity to split the work across those cores thus resulting in a more saturated and hopefully efficient use of that processor.

#### Compute Only On Demand
I want the engine to be reactive, that is, it will only recompute Node data if that Node is acted upon. No needless iteration of nodes means more processing time for cooler graphics or more advanced AI.

### Separation of Duties
With those design considerations, I’ll be splitting the project into three parts:
* **テマキ** *(te-ma-ki)* for the window, I/O, and file management. It also contains the core types that the other two will use.
* **ニギリ** *(ni-gi-ri)* for graphics rendering.
* **イナリ** *(i-na-ri)* for sound rendering.
