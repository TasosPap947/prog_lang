import java.io.*;
import java.util.*;

class IntPair {
  private int first;
  private int second;

  public IntPair(int first, int second) {
    this.first = first;
    this.second = second;
  }

  public int first() {
    return first;
  }
  public int second() {
    return second;
  }
}

public class Round {

  public static int max(int a, int b) {
    return a > b ? a : b;
  }

  public static IntPair minList(ArrayList<IntPair> L) {
    int minimum = L.get(0).first();
    int minimumPosition = L.get(0).second();
    for (int i = 1; i < L.size(); i++) {
      if (L.get(i).first() < minimum) {
        minimum = L.get(i).first();
        minimumPosition = L.get(i).second();
      }
    }

    IntPair result = new IntPair(minimum, minimumPosition);
    return result;
  }

  public static int[] cityCost(int[] carList, int cityNum, int K, int N) {
    int sum = 0, maximum = 0;
    for (int i = 0; i < K; i++) {
      if (cityNum - carList[i] >= 0) {
        sum += cityNum - carList[i];
        maximum = max(maximum, cityNum - carList[i]);
      }
      else {
        sum += N + cityNum - carList[i];
        maximum = max(maximum, N + cityNum - carList[i]);
      }
    }

    int[] result = new int[2];
    result[0] = sum;
    result[1] = maximum;

    return result;
  }

  public static ArrayList<IntPair> allCityCosts(int[] carList, int K, int N) {

    int[] costAndMax;
    ArrayList<IntPair> result = new ArrayList<IntPair>();

    int cost, maximum;

    for (int cityNum = 0; cityNum < N; cityNum++) {
      costAndMax = cityCost(carList, cityNum, K, N);
      cost = costAndMax[0];
      maximum = costAndMax[1];
      if (maximum <= cost - maximum + 1) {
        result.add(new IntPair(cost, cityNum));
      }
    }

    return result;
  }

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

      // for (int i = 0; i < K; i++)
      //   System.out.print(initial[i] + " ");

      // System.out.println();
      //========================================================================
      // Now, you can use N, K and initial as in ML.
      //========================================================================

      ArrayList<IntPair> allCosts = allCityCosts(initial, K, N);

      IntPair result = minList(allCosts);

      System.out.print(result.first() + " ");
      System.out.println(result.second());

      // System.out.print("cityCost: ");
      //
      // int[] carList = new int[] {2,0,2,2};
      // int cityNum = 1;
      //
      // int[] cityCostResult = cityCost(carList, cityNum, K, N);
      //
      // System.out.println(cityCostResult[0] + " " + cityCostResult[1]);
      //
      // System.out.println("allCityCosts: ");
    }
    catch(IOException e) {
      e.printStackTrace();
    }
  }




}
