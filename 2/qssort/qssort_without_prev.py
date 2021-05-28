import resource

import sys
f = open(sys.argv[1])

N = f.readline()
l = f.readline().split()
l = [int(i) for i in l]

from collections import deque

Q = deque(l)
S = deque()
StateQ = deque()

def sorted(Q):
	for i in range(len(Q)-1):
		if Q[i] > Q[i+1]:
			return False
	return True

init = (Q, S)
StateQ.append(init)

prev = {str(init): None}
movestr = deque(["empty"])

solved = False

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

while StateQ:
	(Q1, S1) = StateQ.popleft()
	ms = movestr.popleft()

	if ms == "empty":
		ms = ""

	if sorted(Q1) and not S1:
		solved = True
		break

	if Q1:
		(Q1next, S1next) = nextQ(Q1, S1)
		state = str((Q1next, S1next))
		if state not in prev:
			StateQ.append((Q1next, S1next))
			movestr.append(ms + "Q")
			prev[state] = (Q1, S1)
	if S1:
		(Q1next, S1next) = nextS(Q1, S1)
		state = str((Q1next, S1next))
		if state not in prev:
			StateQ.append((Q1next, S1next))
			movestr.append(ms + "S")
			prev[state] = (Q1, S1)

if solved:
	if ms == "":
		ms = "empty"
	print(ms)

f.close()

print(resource.getrusage(resource.RUSAGE_SELF).ru_maxrss)
