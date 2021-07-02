#include <cstdlib>
#include <fstream>
#include <ctime>
using namespace std;

int main() {
  srand(time(nullptr));
  ofstream file;
  int M = 500000, N = 10;
  file.open("largefile");
  file << M << " " << N << endl;

  for (int i = 0; i < M; ++i) {
    int x = rand() % 1000;
    file << ((rand() % 2 == 0) ? x : -x) << " ";
  }
  file << endl;
}
