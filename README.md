# Maze Pathfinder
## Solve Maze

Solve Maze is a haskell program that uses a depth first search algorithm to find the path in a given n * m maze.

## Dependancies

Data.Matrix

To install the Data.Matrix dependancy, run the following command from within the solveMaze folder:

    stack install matrix
    

## Installation

First you need to ensure that you have

      /users/cs/fcsID/.local/bin

in your path in your .bash_profile file where fcsID is your faculty of computer science user name.

From within the solveMaze file enter the following commands to build the executable file.

     stack setup

     stack build && stack install


## Usage

The solveMaze-exe executable takes an encoded biniary representation of the maze as it's first argument and an output file to write the solves path to.

Usage:

    solveMaze-exe <input file name> <output file name>    
    
    solveMaze-exe sample_maze.bin sample_path.txt

