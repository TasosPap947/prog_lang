#include <iostream>
#include <fstream>
#include <vector>
using namespace std;

int sum(int a[], int begin, int end) {
  int sum = 0;
  for (int i = begin; i < end; ++i)
    sum += a[i];
  return sum;
}

int main(int argc, char **argv) {
  ifstream file;
  int M, N;

  file.open(argv[1]);
  file >> M;
  file >> N;
  int a[M];

  //cout << "M = " << M << endl;
  //cout << "N = " << N << endl;

  //int c;
  for (int i = 0; i < M; ++i) {
    file >> a[i];
    //cout << "a[" << i << "] = " << a[i] << endl;
  }

  double average = 0;
  int k = 0; // maximum good days
  for (int range = 1; range < M+1; ++range) {
    //cout << "range = " << range << endl;
    bool found = false;
    for (int start = 0; start + range < M+1; ++start) {
      //cout << "start = " << start << endl;
      average = (double) sum(a, start, start + range)/(N*range);
      cout << average << " ";
        if (average <= -1) {
          found = true;
          break;
       }
    }
    if (found) k = range;
  }
  cout << k << endl;
}
