#===============================================================================
# IMPORTS
#===============================================================================

from sys import argv
from collections import deque

#===============================================================================
# FUNCTIONS
#===============================================================================

def sorted(Q):
	for i in range(len(Q)-1):
		if Q[i] > Q[i+1]:
			return False
	return True

def nextQ(Q, S, string):
	Q1 = deque(Q)
	S1 = deque(S)
	string1 = ''.join([string , "Q"])
	x = Q1.popleft()
	S1.append(x)
	return (Q1, S1, string1)

def nextS(Q, S, string):
	Q1 = deque(Q)
	S1 = deque(S)
	string1 = ''.join([string, "S"])
	x = S1.pop()
	Q1.append(x)
	return (Q1, S1, string1)

#===============================================================================
# INPUT
#===============================================================================

with open(argv[1]) as f:
	f.readline() # Toss out N
	l = [int(i) for i in f.readline().split()]


#===============================================================================
# INIT
#===============================================================================

State_Q = deque()
Q_init = deque(l)
S_init = deque()

State_Q.append((Q_init, S_init, ""))
seen = set()

#===============================================================================
# BFS
#===============================================================================

duplicates = 0
uniques = 0

if sorted(Q_init):
	print("empty")
else:
	while State_Q:

		(Q, S, string) = State_Q.popleft()

		if Q:
			(Q_next, S_next, string_next) = nextQ(Q, S, string)

			if not S_next and sorted(Q_next):
				print(string_next)
				print("Duplicates = {}".format(duplicates))
				print("Uniques = {}".format(uniques))
				break

			state = str((Q_next, S_next))

			if state in seen:
				duplicates += 1
			if not state in seen:
				uniques += 1
				State_Q.append((Q_next, S_next, string_next))
				seen.add(state)

		if S:
			(Q_next, S_next, string_next) = nextS(Q, S, string)

			if not S_next and sorted(Q_next):
				print(string_next)
				print("Duplicates = {}".format(duplicates))
				print("Uniques = {}".format(uniques))
				break

			state = str((Q_next, S_next))

			if state in seen:
				duplicates += 1
			if not state in seen:
				uniques += 1
				State_Q.append((Q_next, S_next, string_next))
				seen.add(state)
