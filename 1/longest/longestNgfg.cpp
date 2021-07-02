#include <bits/stdc++.h>
#include <fstream>
#include <iostream>
using namespace std;

/* For a given array arr[],
returns the maximum j – i such that
arr[j] > arr[i] */
int maxIndexDiff(int arr[], int n)
{
	int maxDiff;
	int i, j;

	int* LMin = new int[(sizeof(int) * n)];
	int* RMax = new int[(sizeof(int) * n)];

	/* Construct LMin[] such that
	LMin[i] stores the minimum value
	from (arr[0], arr[1], ... arr[i]) */
	LMin[0] = arr[0];
	for (i = 1; i < n; ++i)
		LMin[i] = min(arr[i], LMin[i - 1]);

	/* Construct RMax[] such that
	RMax[j] stores the maximum value from
	(arr[j], arr[j+1], ..arr[n-1]) */
	RMax[n - 1] = arr[n - 1];
	for (j = n - 2; j >= 0; --j)
		RMax[j] = max(arr[j], RMax[j + 1]);

	/* Traverse both arrays from left to right
	to find optimum j - i. This process is similar to
	merge() of MergeSort */
	i = 0, j = 0, maxDiff = -1;
	while (j < n && i < n) {
		if (LMin[i] <= RMax[j]) {
			maxDiff = max(maxDiff, j - i);
			j = j + 1;
		}
		else
			i = i + 1;
	}

	return maxDiff;
}

// Driver Code
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

  partial_sum[0] = a[0];
  for (int i = 1; i < M; ++i) {
    partial_sum[i] = partial_sum[i-1] + a[i];
  }

	int maxDiff = maxIndexDiff(partial_sum, M);
	cout << maxDiff << endl;
	return 0;
}

// This code is contributed by rathbhupendra
