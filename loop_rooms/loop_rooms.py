import sys
sys.setrecursionlimit(10000) #too much, but we think enough for the larger test cases than grader :)
                             #for "maze17.txt:, sys.setrecursionlimit(3500) is OK

with open(sys.argv[1]) as f:
    lines = f.read().splitlines()

N,M = map(int, lines[0].split())
maze = list(map(list, lines[1:]))
counter=0;

for i in range (0,N,1):
    for j in range (0,M,1):
        if(j==0 and maze[i][j]=='L') or (j == M-1 and maze[i][j] == 'R') or (i == 0 and maze[i][j] == 'U') or (i == N-1 and maze[i][j] == 'D'):
            maze[i][j] = 'G'
            #counter=counter+1

n,m = N-1, M-1

def prev_room(maz, n, m, k, l):
    if(k==0 and l==0):                  #Upper-Left
        if maz[k][l+1]== 'L':
            maz[k][l+1]= 'G'
            prev_room(maz, n, m, k, l+1)
        if maz[k+1][l]=='U':
            maz[k+1][l]='G'
            prev_room(maz, n, m, k+1, l)
    elif k==0 and l==m :                #Upper-Right
        if maz[k][l-1]=='R':
            maz[k][l-1]='G'
            prev_room(maz, n, m, k, l-1)
        if maz[k+1][l]=='U':
            maz[k+1][l]='G';
            prev_room(maz, n, m, k+1, l)
    elif k==n and l==0 :                 #Bottom-Left
        if maz[k][l+1]=='L':
            maz[k][l+1]='G'
            prev_room(maz, n, m, k, l+1)
        if maz[k-1][l]=='D':
            maz[k-1][l]='G'
            prev_room(maz, n, m, k-1, l)
    elif k==n and l==m:                 #Bottom-Right
        if maz[k][l-1]=='R':
            maz[k][l-1]='G'
            prev_room(maz, n, m, k, l-1)
        if maz[k-1][l]=='D':
            maz[k-1][l]='G'
            prev_room(maz, n, m, k-1, l)
    elif k!=0 and k!=n and l==0:        #Left Side
        if maz[k][l+1]=='L':
            maz[k][l+1]='G'
            prev_room(maz, n, m, k, l+1)
        if maz[k-1][l]=='D':
            maz[k-1][l]='G'
            prev_room(maz, n, m, k-1, l)
        if maz[k+1][l]=='U':
            maz[k+1][l]='G'
            prev_room(maz, n, m, k+1, l)
    elif l==m and k!=0 and k!=n:        #Right Side
        if maz[k][l-1]=='R':
            maz[k][l-1]='G'
            prev_room(maz, n, m, k, l-1)
        if maz[k-1][l]=='D':
            maz[k-1][l]='G'
            prev_room(maz, n, m, k-1, l)
        if maz[k+1][l]=='U':
            maz[k+1][l]='G'
            prev_room(maz, n, m, k+1, l)
    elif k==0 and l!=0 and l!=m:        #Upper Side
        if maz[k][l-1]=='R':
            maz[k][l-1]='G'
            prev_room(maz, n, m, k, l-1)
        if maz[k][l+1]=='L':
            maz[k][l+1]='G'
            prev_room(maz, n, m, k, l+1)
        if maz[k+1][l]=='U':
            maz[k+1][l]='G'
            prev_room(maz, n, m, k+1, l)
    elif k==n and l!=0 and l!=m:        #Bottom Side
        if maz[k][l-1]=='R':
            maz[k][l-1]='G'
            prev_room(maz, n, m, k, l-1)
        if maz[k][l+1]=='L':
            maz[k][l+1]='G'
            prev_room(maz, n, m, k, l+1)
        if maz[k-1][l]=='D':
            maz[k-1][l]='G'
            prev_room(maz, n, m, k-1, l)
    else :                              #Inside
        if maz[k][l-1]=='R':
            maz[k][l-1]='G'
            prev_room(maz, n, m, k, l-1)
        if maz[k][l+1]=='L':
            maz[k][l+1]='G'
            prev_room(maz, n, m, k, l+1)
        if maz[k-1][l]=='D':
            maz[k-1][l]='G'
            prev_room(maz, n, m, k-1, l)
        if maz[k+1][l]=='U':
            maz[k+1][l]='G'
            prev_room(maz, n, m, k+1, l)





for i in range (0,N,1):
    for j in range (0,M,1):
        if ((j==0 or j == M-1 or i == 0 or i == N-1) and maze[i][j] == 'G') :
            prev_room(maze,N-1,M-1,i,j)

cnt=0

for i in range (0,N,1):
    for j in range (0,M,1):
        if maze[i][j]=='G':
            cnt=cnt+1
res=N*M-cnt
print(res)
