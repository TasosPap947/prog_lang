import java.io.*;

public class Round {
  public static void main (String[] args) {
    try {
      BufferedReader in = new BufferedReader(new FileReader("r1.txt"));
      String line = in.readLine();
      String[] a = line.split(" ");
      int N = Integer.parseInt(a[0]);
      int K = Integer.parseInt(a[1]);
      line = in.readLine();
      int [] initial = ;

      in.close();

      for (int i = 0; i < K; i++)
        System.out.print(initial[i] + " ");

    }
    catch(IOException e) {
      e.printStackTrace();
    }
  }
}
