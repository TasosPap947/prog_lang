#include <iostream>
#include <fstream>
using namespace std;

// int Max(int **a, int rows, int cols) {
//   int Max = 0;
//   for (int i = 0; i < rows; )
// }

void clear(int b[], int M) {
  for (int i = 0; i < M; ++i) {
    b[i] = 0;
  }
}

void print1D (int *a, int n) {
  for (int i = 0; i < n; ++i) {
    cout << a[i] << " ";
  }
  cout << endl;
}

void print2D(int *a, int rows, int cols) {
  for (int i = 0; i < rows; ++i) {
    for (int j = 0; j < cols; ++j) {
      cout << a[i*rows+j] << " ";
    }
    cout << endl;
  }
}

int main(int argc, char **argv) {
  ifstream file;
  int M, N;

  file.open(argv[1]);
  file >> M;
  file >> N;
  int a[M];
  int b[M];
  //cout << "M = " << M << endl;
  //cout << "N = " << N << endl;

  //int c;
  for (int i = 0; i < M; ++i) {
    file >> a[i];
    //cout << "a[" << i << "] = " << a[i] << endl;
  }

  clear(b,M);
  #if 1
  int length = 0;
  double average;
  for (int i = 0; i < M; ++i) {
    // b[0] = a[i];
    // cout << b[0] << " ";
    // average = (double) b[0]/(N);
    for (int j = 0; j < M-i; ++j) {
      b[j] = (j == 0) ? a[i] : b[j-1] + a[i+j];
      average = (double) b[j]/(N*(j+1));
      // cout << "(" << b[j] << "," << average << ") ";
      if (average <= -1 && j+1 > length) length = j+1;
    }
    clear(b,M);
    // cout << endl;
  }

  // print_array(b,M,M);
  cout << length << endl;
  #endif
}
