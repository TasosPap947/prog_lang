import sys

grader = True
import timeit

if not grader:

	files = []

	i = 1
	while True:
		try:
			name = "txt/qs" + str(i) + ".txt"
			f = open(name, "r")
			files.append(f)
			# print(i)
			i += 1
		except FileNotFoundError:
			break

	# N = len(files)
		N = 9
else:
	files = []
	name = sys.argv[1]
	f = open(name)
	files = [f]
	N = 1


for file_num in range(0, N):


	starttime = timeit.default_timer()

	N = files[file_num].readline()
	l = files[file_num].readline().split()
	l = [int(i) for i in l]
#     print(l)

	from collections import deque

	Q = deque(l)
	S = deque()
	StateQ = deque()

	def sorted_dummy(Q):
		return 0

	def sorted(Q):
		for i in range(len(Q)-1):
			if Q[i] > Q[i+1]:
				return False
		return True

	def sorted_except_first(Q):
		for i in range(1, len(Q)-1):
			if Q[i] > Q[i+1]:
				return False
		return True

	def sorted_except_second(Q):
		for i in range(2, len(Q)-1):
			if Q[i] > Q[i+1]:
				return False
		return True

	ssf = sorted(Q)
	ssff = sorted_except_first(Q)
	ssfs = sorted_except_second(Q)

	debugsrt = sorted(Q)
	init = (Q, S, ssf, ssff, ssfs, debugsrt)
	StateQ.append(init)

	prev = {str(init): None}
	movestr = deque(["empty"])

	solved = False

	def sorted_last(L):
		if len(L) == 0 or len(L) == 1:
			return True
		return L[-2] <= L[-1]

	def cheap_sort(L, c):
		if c == "S":
			if len(L) == 0 or len(L) == 1:
				return True
			return L[-2] <= L[-1]
		if c == "Q":
			if len(L) == 0 or len(L) == 1:
				return True
			return L[0] <= L[1]

	def next(Q, S, ssf, ssff, ssfs, c):
		Q1 = deque(Q)
		S1 = deque(S)
		if c == "Q":
			x = Q1.popleft()
			S1.append(x)
			ssf1 = ssff
			ssff1 = sorted_except_second(Q1)
			ssfs1 = 0
			return (Q1, S1, ssf1, ssff1, ssfs1, sorted_dummy(Q1))
		else:
			x = S1.pop()
			Q1.append(x)
			ssf1 = ssf and cheap_sort(Q1, "S")
			ssff1 = ssff and cheap_sort(Q1, "S")
			ssfs1 = 0
			return (Q1, S1, ssf1, ssff1, ssfs1, sorted_dummy(Q1))


	duplicate_count = 0
	unique_count = 0
	total_count = 0



	while StateQ and movestr:
		(Q1, S1, ssf1, ssff1, ssfs1, srt1) = StateQ.popleft()
		ms = movestr.popleft()

		# print((Q1, S1, ssf1, ssff1, srt1), ms)

		if ms == "empty":
			ms = ""
#         print(Q1, S1)
#         print(ms)

		if ssf1 and not S1:
			solved = True
			break

		for R, c in [(Q1, "Q"), (S1, "S")]:
			if R:
				(Q1next, S1next, ssf1next, ssff1next, ssfs1next, srt1next) = next(Q1, S1, ssf1, ssff1, 0, c)
				state = str((Q1next, S1next, ssf1next, ssff1next, ssfs1next, srt1next))
				if state in prev:
					# print("Wow! Stopped a duplicate.")
					duplicate_count += 1
					# next 3 lines must be deleted later
					StateQ.append((Q1next, S1next, ssf1next, ssff1next, ssfs1next, srt1next))
					movestr.append(ms + c)
					prev[state] = (Q1, S1, ssf1, ssff1next, ssfs1, srt1)
				if state not in prev:
					# print("This is unique.")
					unique_count += 1
					StateQ.append((Q1next, S1next, ssf1next, ssff1next, ssfs1next, srt1next))
					movestr.append(ms + c)
					prev[state] = (Q1, S1, ssf1, ssff1next, ssfs1, srt1)

	if not grader:
		if solved:
			print("Solved qs{}. Solution:".format(file_num+1), end = " ")

			if ms == "":
				ms = "empty"
			print(ms, end = " ")
		else:
			print("Failed qs{}.".format(file_num+1), end = " ")

		endtime = timeit.default_timer()

		print("Time:", round(endtime - starttime, 3), end = " ")

		print("Duplicates:", duplicate_count, "Uniques:", unique_count)

	else:
		if solved:
			if ms == "":
				ms = "empty"
			print(ms)

for f in files:
	f.close()
