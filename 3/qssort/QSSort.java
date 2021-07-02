import java.io.*;

public class QSSort {
  public static void main(String[] args) {
    try {
      BufferedReader in = new BufferedReader(new FileReader(args[0]));
      String line = in.readLine();
      String[] a = line.split(" ");
      int N = Integer.parseInt(a[0]);
      line = in.readLine();
      String [] list_in_strings = line.split(" ");
      int [] list = new int [N];

      for (int i = 0; i < N; i++)
        list[i] = Integer.parseInt(list_in_strings[i]);

      in.close();

      for (int i = 0; i < N; i++)
        System.out.print(list[i] + " ");

    }
    catch(IOException e){
      e.printStackTrace();
    }
  }
}
