#include <fstream>
#include <iostream>
using namespace std;

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
    a[i] = -a[i]-N;
    //cout << "a[" << i << "] = " << a[i] << endl;
  }

  int partial_sum[M];
  int left_min[M];
  int right_max[M];

  partial_sum[0] = a[0];
  for (int i = 1; i < M; ++i) {
    partial_sum[i] = partial_sum[i-1] + a[i];
  }

  left_min[0] = partial_sum[0];
  right_max[M-1] = partial_sum[M-1];
  for (int i = 1; i < M; ++i) {
    left_min[i] = min(left_min[i-1], partial_sum[i]);
    right_max[M-i-1] = max(right_max[M-i], partial_sum[M-i-1]);
  }

  for (int i = 0; i < M; ++i) {
    //cout << left_min[i] << " ";
  }
  //cout << endl;
  for (int i = 0; i < M; ++i) {
    //cout << right_max[i] << " ";
  }
  //cout << endl;

  int length = 0;
  for (int i = 0; i < M; ++i) {
    for (int j = 0; j < M; ++j) {
      if (left_min[i] >= right_max[j]) {
        while (j+1 < M && right_max[j+1] >= left_min[i]) {
          ++j;
        }
        length = max(length, j-i);
        //  cout << "left_min = " << left_min[i] << " > " << "right_max = " << right_max[j] << endl;
        ++i;
        ++j;
      }
      else if (i < j - 1) {
        ++i;
      }
      else {
        ++j;
      }
    }
  }
  cout << length << endl;
}
