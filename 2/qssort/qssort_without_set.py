#===============================================================================
# IMPORTS
#===============================================================================

import resource
import sys
from collections import deque

#===============================================================================
# FUNCTIONS
#===============================================================================

def sorted(Q):
	for i in range(len(Q)-1):
		if Q[i] > Q[i+1]:
			return False
	return True

def nextQ(Q, S):
	Q1 = deque(Q)
	S1 = deque(S)
	x = Q1.popleft()
	S1.append(x)
	return (Q1, S1)

def nextS(Q, S):
	Q1 = deque(Q)
	S1 = deque(S)
	x = S1.pop()
	Q1.append(x)
	return (Q1, S1)

#===============================================================================
# INPUT
#===============================================================================

with open(sys.argv[1]) as f:
	f.readline() # Toss out N
	l = [int(i) for i in f.readline().split()]


#===============================================================================
# INIT
#===============================================================================

Q = deque(l)
S = deque()
StateQ = deque()

init = (Q, S)
StateQ.append(init)

prev = {str(init): None}
moveprev = {str(init): None}

solved = False

final_state = None

#===============================================================================
# BFS
#===============================================================================

while StateQ:

	if resource.getrusage(resource.RUSAGE_SELF).ru_maxrss > 4194304:
		print("Exceeded grader memory limit")
		sys.exit()

	(Q1, S1) = StateQ.popleft()

	if not S1 and sorted(Q1):
		final_state = str((Q1, S1))
		solved = True
		break

	if Q1:
		(Q1next, S1next) = nextQ(Q1, S1)
		state = str((Q1next, S1next))
		if state not in prev:
			StateQ.append((Q1next, S1next))
			prev[state] = (Q1, S1)
			moveprev[state] = "Q"
	if S1:
		(Q1next, S1next) = nextS(Q1, S1)
		state = str((Q1next, S1next))
		if state not in prev:
			StateQ.append((Q1next, S1next))
			prev[state] = (Q1, S1)
			moveprev[state] = "S"

#===============================================================================
# PRINT SOLUTION
#===============================================================================

res = deque()

if solved:
	if final_state == str(init):
		print("empty", end = "")
	else:
		while moveprev[final_state] != None:
			res.appendleft(moveprev[final_state])
			final_state = str(prev[final_state])

for letter in res:
	print(letter, end = "")

print()

f.close()
