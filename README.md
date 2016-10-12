# Basic OpenGL with GLFW: Vertex Array Objects

State changes can be slow with OpenGL, so avoiding them as much as possible can increase performance.
In OpenGL, Vertex Array Objects (vao for short) are used to contain the configuration of our buffers.
In this example, we set up vertex attribute pointers once with a vao, and can just bind the vao before calling draw.

# Setup

You will need to have CMake installed on your computer, and properly added to your path.
In order to setup, run the following in a shell, then open the project in your preferred editor.
Windows setup has been configured for use with Visual Studio.

Windows:
```
cd path/to/folder
setup.cmd
```
Linux:
```
cd path/to/folder
./setup
```
