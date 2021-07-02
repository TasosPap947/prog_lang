import java.io.*;

public class Round {
  public static void main (String[] args) {
    try {

      //========================================================================
      // Read from file.
      //========================================================================
      BufferedReader in = new BufferedReader(new FileReader(args[0]));
      String line = in.readLine();
      String[] a = line.split(" ");
      int N = Integer.parseInt(a[0]);
      int K = Integer.parseInt(a[1]);
      line = in.readLine();
      String [] initial_in_strings = line.split(" ");
      int [] initial = new int [K];

      for (int i = 0; i < K; i++)
        initial[i] = Integer.parseInt(initial_in_strings[i]);

      in.close();

      for (int i = 0; i < K; i++)
        System.out.print(initial[i] + " ");

      //========================================================================
      // Now, you can use N, K and initial as in ML.
      //========================================================================


    }
    catch(IOException e) {
      e.printStackTrace();
    }
  }
}
