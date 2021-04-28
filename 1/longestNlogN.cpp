#include <iostream>
#include <fstream>
#include <algorithm>
using namespace std;

int binary_search(pair<int,int> a[], int x, int n) {
  int first = 0, last = n-1, mid;
  while (first <= last) {
    mid = (first + last) / 2;
    if (x < a[mid].first) last = mid-1;
    else if (x > a[mid].first) first = mid+1;
    else break;
  }
  if (first <= last) return mid;
  else return -1;
}

bool comparison (pair<int,int> a, pair<int,int> b) {
  if (a.first == b.first) return a.second < b.second;
  return a.first < b.first;
}

void swap(int &a, int &b) {
  int temp;
  temp = a;
  a = b;
  b = temp;
}

int partition (int a[][2], int first, int last) {
  int x = a[(first + last)/2][0];
  int i = first, j = last;

  while (true) {
    while (a[i][0] < x) ++i;
    while (x < a[j][0]) --j;
    if (i >= j) break;
    swap(a[i][0], a[j][0]);
    swap(a[i][1], a[j][1]);
    ++i; --j;
  }
  return j;
}

void quicksort(int a[][2], int first, int last) {
  int i;
  if (first >= last) return;
  i = partition(a, first, last);
  quicksort(a, first, i);
  quicksort(a, i+1, last);
}


int main(int argc, char **argv) {
  ifstream file;
  int M, N;

  file.open(argv[1]);
  file >> M;
  file >> N;
  int a[M];
  int k = -1;
  //cout << "M = " << M << endl;
  //cout << "N = " << N << endl;

  //int c;
  for (int i = 0; i < M; ++i) {
    file >> a[i];
    a[i] = -a[i]-N;
    //cout << "a[" << i << "] = " << a[i] << endl;
  }

  pair<int,int> partial_sum[M];

  partial_sum[0].first = a[0];
  partial_sum[0].second = 0;
  for (int i = 1; i < M; ++i) {
    partial_sum[i].first = partial_sum[i-1].first + a[i];
    partial_sum[i].second = i;
  }

  sort(partial_sum, partial_sum + M, comparison);

  int min_index_so_far[M];

  min_index_so_far[0] = partial_sum[0].second;

  for (int i = 1; i < M; ++i) {
    min_index_so_far[i] = min(min_index_so_far[i-1], partial_sum[i].second);
  }

  for (int i = 0; i < M; ++i) {
    //cout << "(" << partial_sum[i].first << "," << partial_sum[i].second << ") ";
  }
  //cout << endl;

  for (int i = 0; i < M; ++i) {
    //cout << min_index_so_far[i] << " ";
  }
  //cout << endl;

  int sum = 0;
  int length = 0;
  int x;
  int index;
  int min_index;

  for (int i = 0; i < M; ++i) {
    sum += a[i];
    if (sum > k) length = i+1;
    else {
      x = (k + 1 - sum);
      index = binary_search(partial_sum, -x, M);
      min_index = min_index_so_far[index];
      if (min_index > i) continue;
      else if (i-min_index > length) length = i-min_index;
    }
  }
  cout << length << endl;
//try sorting with arrays
}
