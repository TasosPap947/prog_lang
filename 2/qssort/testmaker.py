import random
random.seed(3)

N = 42
for i in range(6,N+1):
    buffer = ""
    buffer += str(N) + "\n"
    for j in range(i):
        buffer += str(random.randint(0,N)) + " "
    f = open("txt/qs" + str(i) +".txt", "w")
    f.write(buffer)
