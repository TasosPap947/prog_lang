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

while State_Q:

	(Q, S, string) = State_Q.popleft()

	dad_state = str((Q, S))

	if dad_state in seen:
		continue

	seen.add(dad_state)

	if not S and sorted(Q):
		print("empty" if string == "" else string)
		break

	if Q:
		(Q_next, S_next, string_next) = nextQ(Q, S, string)
		state = str((Q_next, S_next))
		if state not in seen:
			State_Q.append((Q_next, S_next, string_next))
	if S:
		(Q_next, S_next, string_next) = nextS(Q, S, string)
		state = str((Q_next, S_next))
		if state not in seen:
			State_Q.append((Q_next, S_next, string_next))
