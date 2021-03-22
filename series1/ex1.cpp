#include <iostream>
#include <fstream>
#include <vector>
using namespace std;

int main(int argc, char **argv) {
  ifstream infile;
  int M, N;
  vector<int> v;
  infile.open(argv[1]);
  infile >> M;
  infile >> N;

  int a;
  while (infile >> a) {
    v.push_back(a);
  }


  // for (int i : v)
  //   cout << i << ' ';
  // cout << endl;
}
