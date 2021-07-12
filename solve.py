"""
Author: Ryan
Date: 02/18/20

BFS search on a matrix representation of a maze.
"""

import sys
import collections
import numpy


def bfs (maze, q, seen):

	if len(q) == 0:
		print "\n\n"
		return False

	path = q.pop()
	tile = path[len(path) - 1]
	x = tile[0]
	y = tile[1]

	if (x == maze.shape[0] - 1 and y == maze.shape[1] - 1):
		print path
		print "\n\n"
		return path

	if (check_up(maze, x, y, seen) is True):
		seen.append([x - 1, y])
		new_path = list(path)
		new_path.append([x - 1, y])
		q.append(new_path)

	if (check_down(maze, x, y, seen) is True):
		seen.append([x + 1, y])
		new_path = list(path)
		new_path.append([x + 1, y])
		q.append(new_path)

	if (check_left(maze, x, y, seen) is True):
		seen.append([x, y - 1])
		new_path = list(path)
		new_path.append([x, y - 1])
		q.append(new_path)

	if (check_right(maze, x, y, seen) is True):
		seen.append([x, y + 1])
		new_path = list(path)
		new_path.append([x, y + 1])
		q.append(new_path)

	bfs(maze, q, seen)



def check_up (maze, x, y, seen):
	if (x == 0 or (seen.count([x - 1, y]) != 0)):
		return False
	elif (maze[x - 1, y] == 0 or maze[x - 1, y] == 2):
		return True
	else:
		return False


def check_down (maze, x, y, seen):
	if (x == maze.shape[0] - 1 or (seen.count([x + 1, y]) != 0)):
		return False
	elif (maze[x, y] == 0 or maze[x, y] == 2):
		return True
	else:
		return False


def check_left (maze, x, y, seen):
	if (y == 0 or (seen.count([x, y - 1]) != 0)):
		return False
	elif (maze[x, y - 1] == 0 or maze[x, y - 1] == 1):
		return True
	else:
		return False

def check_right (maze, x, y, seen):
	if (y == maze.shape[1] - 1 or (seen.count([x, y + 1]) != 0)):
		return False
	elif (maze[x, y] == 0 or maze[x, y] == 1):
		return True
	else:
		return False


if __name__ == '__main__':
	
	maze1 = numpy.matrix([
			[0, 0, 3, 0, 0],
			[3, 2, 0, 3, 1],
			[0, 2, 2, 1, 0],
			[3, 1, 2, 0, 1],
			[0, 0, 0, 0, 0]])

	maze = numpy.matrix([
		[2, 0, 0, 3, 1, 1, 0],
  		[1, 3, 0, 3, 0, 1, 1],
  		[2, 0, 0, 3, 0, 0, 1],
  		[1, 3, 0, 3, 2, 2, 0],
  		[0, 1, 1, 0, 3, 1, 0],
  		[0, 0, 3, 0, 2, 2, 1],
  		[2, 0, 2, 2, 0, 0, 0]])

	print "\n\n"
	print maze
	print "\n\n"

	q = []
	q.append([[0, 0]])

	seen = []

	bfs(maze, q, seen)
