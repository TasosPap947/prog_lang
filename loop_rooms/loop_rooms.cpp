#include <iostream>
#include <fstream>
using namespace std;

int prev_room(char maz[], bool fl[], int n, int m, int k, int l, int &cnt){
  /*recursive function:we find the previous room of a good room. Previous with the given directions.
  "Good" is the room from which you can go outside*/
  int rows;
  rows=m+1;
  if((k==0) && (l==0)){  //Upper-Left
    //k=i;
    //l=j;
    if((maz[k*rows+(l+1)]=='L')&&(fl[k*rows+(l+1)]==0)){
      fl[k*rows+(l+1)]=1;
      cnt++;
      prev_room(maz,fl, n, m, k, l+1, cnt);
    }
    if((maz[(k+1)*rows+l]=='U')&&(fl[(k+1)*rows+l]==0)){
      fl[(k+1)*rows+l]=1;
      cnt++;
      prev_room(maz,fl, n, m, k+1, l,cnt);
    }
  }
  else if((k==0)&&(l==m)){  //Upper-Right
    //k=i;
    //l=j;
    if((maz[k*rows+(l-1)]=='R')&&(fl[k*rows+(l-1)]==0)){
      fl[k*rows+(l-1)]=1;
      cnt++;
      prev_room(maz,fl, n, m, k, l-1,cnt);
    }
    if((maz[(k+1)*rows+l]=='U')&&(fl[(k+1)*rows+l]==0)){
      fl[(k+1)*rows+l]=1;
      cnt++;
      prev_room(maz,fl, n, m, k+1, l,cnt);
    }
  }
  else if((k==n)&&(l==0)){  //Bottom-Left
    //k=i;
    //l=j;
    if((maz[k*rows+(l+1)]=='L')&&(fl[k*rows+(l+1)]==0)){
      fl[k*rows+(l+1)]=1;
      cnt++;
      prev_room(maz,fl, n, m, k, (l+1),cnt);
    }
    if((maz[(k-1)*rows+l]=='D')&&(fl[(k-1)*rows+l]==0)){
      fl[(k-1)*rows+l]=1;
      cnt++;
      prev_room(maz,fl, n, m, k-1, l,cnt);
    }
  }
  else if((k==n)&&(l==m)){ //Bottom-Right
    //k=i;
    //l=j;
    if((maz[k*rows+(l-1)]=='R')&&(fl[k*rows+(l-1)]==0)){
      fl[k*rows+(l-1)]=1;
      cnt++;
      prev_room(maz,fl, n, m, k, l-1,cnt);
    }
    if((maz[(k-1)*rows+l]=='D')&&(fl[(k-1)*rows+l]==0)){
      //k--;
      fl[(k-1)*rows+l]=1;
      cnt++;
      prev_room(maz,fl, n, m, k-1, l,cnt);
    }
  }
  else if(k!=0 && k!=n && l==0) { //Left side
    //k=i;
    //l=j;
    if((maz[k*rows+(l+1)]=='L')&&(fl[k*rows+(l+1)]==0)){
      fl[k*rows+(l+1)]=1;
      cnt++;
      prev_room(maz,fl, n, m, k, (l+1),cnt);
    }
    if((maz[(k-1)*rows+l]=='D')&&(fl[(k-1)*rows+l]==0)){
      fl[(k-1)*rows+l]=1;
      cnt++;
      prev_room(maz,fl, n, m, k-1, l,cnt);
    }
    if((maz[(k+1)*rows+l]=='U')&&(fl[(k+1)*rows+l]==0)){
      fl[(k+1)*rows+l]=1;
      cnt++;
      prev_room(maz,fl, n, m, k+1, l,cnt);
    }
  }
  else if(l==m && k!=0 && k!=n) { //Rifht side
    //k=i;
    //l=j;
    if((maz[k*rows+(l-1)]=='R')&&(fl[k*rows+(l-1)]==0)){
      fl[k*rows+(l-1)]=1;
      cnt++;
      prev_room(maz,fl, n, m, k, l-1,cnt);
    }
    if((maz[(k-1)*rows+l]=='D')&&(fl[(k-1)*rows+l]==0)){
      fl[(k-1)*rows+l]=1;
      cnt++;
      prev_room(maz,fl, n, m, k-1, l,cnt);
    }
    if((maz[(k+1)*rows+l]=='U')&&(fl[(k+1)*rows+l]==0)){
      fl[(k+1)*rows+l]=1;
      cnt++;
      prev_room(maz,fl, n, m, k+1, l,cnt);
    }
  }
  else if((k==0)&&(l!=0)&&(l!=m)){ //Upper side
    //k=i;
    //l=j;
    if((maz[k*rows+(l-1)]=='R')&&(fl[k*rows+(l-1)]==0)){
      fl[k*rows+(l-1)]=1;
      cnt++;
      prev_room(maz,fl, n, m, k, l-1,cnt);
    }
    if((maz[k*rows+(l+1)]=='L')&&(fl[k*rows+(l+1)]==0)){
      fl[k*rows+(l+1)]=1;
      cnt++;
      prev_room(maz,fl, n, m, k, l+1,cnt);
    }
    if((maz[(k+1)*rows+l]=='U')&&(fl[(k+1)*rows+l]==0)){
      fl[(k+1)*rows+l]=1;
      cnt++;
      prev_room(maz,fl, n, m, k+1, l,cnt);
    }
  }
  else if((k==n)&&(l!=0)&&(l!=m)){  //Bottom side
    //k=i;
    //l=j;
    if((maz[k*rows+(l-1)]=='R')&&(fl[k*rows+(l-1)]==0)){
      fl[k*rows+(l-1)]=1;
      cnt++;
      prev_room(maz,fl, n, m, k, l-1,cnt);
    }
    if((maz[k*rows+(l+1)]=='L')&&(fl[k*rows+(l+1)]==0)){
      fl[k*rows+(l+1)]=1;
      cnt++;
      prev_room(maz,fl, n, m, k, l+1,cnt);
    }
    if((maz[(k-1)*rows+l]=='D')&&(fl[(k-1)*rows+l]==0)){
      fl[(k-1)*rows+l]=1;
      cnt++;
      prev_room(maz,fl, n, m, k-1, l,cnt);
    }
  }
  else {      //inside
    if((maz[k*rows+(l-1)]=='R')&&(fl[k*rows+(l-1)]==0)){
      fl[k*rows+(l-1)]=1;
      cnt++;
      prev_room(maz,fl, n, m, k, l-1,cnt);
    }
    if((maz[k*rows+(l+1)]=='L')&&(fl[k*rows+(l+1)]==0)){
      fl[k*rows+(l+1)]=1;
      cnt++;
      prev_room(maz,fl, n, m, k, l+1,cnt);
    }
    if((maz[(k-1)*rows+l]=='D')&&(fl[(k-1)*rows+l]==0)){
      fl[(k-1)*rows+l]=1;
      cnt++;
      prev_room(maz,fl, n, m, k-1, l,cnt);
    }
    if((maz[(k+1)*rows+l]=='U')&&(fl[(k+1)*rows+l]==0)){
      fl[(k+1)*rows+l]=1;
      cnt++;
      prev_room(maz,fl, n, m, k+1, l,cnt);
    }
  }
  return cnt;
}



int main(int argc, char **argv) {
  ifstream file;
  int N,M;
  file.open(argv[1]);
  file >> N;
  file >> M;
  char maze[N*M];  //1D array with maze rooms and directions
  bool flag[N*M];  //1D flag array if this room is good
  int n1, m1,rows,res,counter=0,sum=0;
  rows=M;
  n1=N-1;
  m1=M-1;  //for recursive function
  for (int i=0;i<N;i++){
    for (int j=0;j<M;j++){
      file >> maze[i*rows+j];  //input from file
      flag[i*rows+j]=0;
    }
  }
  file.close();

  for (int i = 0; i < N; ++i) {
    for (int j = 0; j < M; ++j) {
      if ((j==0 && maze[i*rows+j]=='L') || (j == M-1 && maze[i*rows+j] == 'R') || (i == 0 && maze[i*rows+j] == 'U') || (i == N-1 && maze[i*rows+j] == 'D')) {
        flag[i*rows+j] = 1;   //mark the good rooms from the sides
        counter++;
      }
    }
  }

  for(int i=0; i<N; i++){
    for (int j=0; j<M; j++){
    if ((j==0 && maze[i*rows+j]=='L') || (j == M-1 && maze[i*rows+j] == 'R') || (i == 0 && maze[i*rows+j] == 'U') || (i == N-1 && maze[i*rows+j] == 'D')) {
        sum=prev_room(maze,flag,n1,m1,i,j,counter); //recursive function for good rooms
      }
    }
  }

  res=N*M-sum;
  cout<<res<<endl;

}
