import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Collection;
import java.util.Iterator;
import java.util.Objects;
import java.util.Arrays;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.FileReader;

class QSState {
  private ArrayDeque<Integer> queue;
  private ArrayList<Integer> stack;
  private String moves;
  private HashSet<QSState> seen;
  private int duplicates, uniques;

  public QSState(ArrayDeque<Integer> queue, ArrayList<Integer> stack, String moves, HashSet<QSState> seen, int duplicates, int uniques) {
    this.queue = queue;
    this.stack = stack;
    this.moves = moves;
    this.seen = seen;
    this.duplicates = duplicates;
    this.uniques = uniques;
  }

  public boolean isFinal() {
    return stack.isEmpty() && isSorted();
  }

  public Collection<QSState> next() {
    Collection<QSState> states = new ArrayList<>();
    ArrayDeque<Integer> queueCopy1 = new ArrayDeque<Integer>(queue);
    ArrayDeque<Integer> queueCopy2 = new ArrayDeque<Integer>(queue);
    ArrayList<Integer> stackCopy1 = new ArrayList<Integer>(stack);
    ArrayList<Integer> stackCopy2 = new ArrayList<Integer>(stack);

    // Q-Move
    if (!queueCopy1.isEmpty()) {
      int q = queueCopy1.remove();
      stackCopy1.add(q);
      QSState stateQ = new QSState(queueCopy1, stackCopy1, moves + "Q", seen, duplicates, uniques);
      if (stateQ.isFinal()) {
        // System.out.println("Duplicates: " + duplicates);
        // System.out.println("Uniques: " + uniques);
        System.out.println(stateQ);
        System.exit(0);
      }
      if (!seen.contains(stateQ)) {
        states.add(stateQ);
        seen.add(stateQ);
      }
    }
    // S-Move
    if (!stackCopy2.isEmpty()) {
      int s = stackCopy2.remove(stackCopy2.size() - 1);
      queueCopy2.add(s);
      QSState stateS = new QSState(queueCopy2, stackCopy2, moves + "S", seen, duplicates, uniques);
      if (stateS.isFinal()) {
        // System.out.println("Duplicates: " + duplicates);
        // System.out.println("Uniques: " + uniques);
        System.out.println(stateS);
        System.exit(0);
      }
      if (!seen.contains(stateS)) {
        states.add(stateS);
        seen.add(stateS);
      }
    }
    return states;
  }

  @Override
  public String toString() {
    return moves;
  }

  @Override
  public boolean equals(Object o) {
    // Easy cases
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;

    // Check elements one-by-one

    QSState other = (QSState) o;

    // Check queue for equality

    Iterator<Integer> iteratorO = queue.iterator();
    Iterator<Integer> iteratorOther = other.queue.iterator();

    while (true) {
      if (!iteratorO.hasNext() && !iteratorOther.hasNext()) break;
      if (!iteratorO.hasNext() && iteratorOther.hasNext()) return false;
      if (iteratorO.hasNext() && !iteratorOther.hasNext()) return false;
      if (iteratorO.next() != iteratorOther.next()) return false;
    }

    // Check stack for equality

    for (int i = 0; i < this.stack.size() - 1; i++) {
      if (i >= other.stack.size() || this.stack.get(i) != other.stack.get(i)) return false;
    }

    return true;
  }

  @Override
  public int hashCode() {
    int[] arrayFromQueue = queue.stream().mapToInt(i->i).toArray();
    int[] arrayFromStack = stack.stream().mapToInt(i->i).toArray();
    return Objects.hash(Arrays.hashCode(arrayFromQueue), Arrays.hashCode(arrayFromStack));
  }

  public boolean isSorted() {
    int element1, element2;
    Iterator<Integer> queueIterator = queue.iterator();
    if (!queueIterator.hasNext()) return true;
    element1 = queueIterator.next();
    if (!queueIterator.hasNext()) return true;
    element2 = queueIterator.next();
    while(true) {
      if (element1 > element2) return false;
      if (!queueIterator.hasNext()) return true;
      element1 = element2;
      element2 = queueIterator.next();
    }
  }

  public QSState solve() {
    ArrayDeque<QSState> remaining = new ArrayDeque<QSState>();
    remaining.add(this);
    seen.add(this);
    while (!remaining.isEmpty()) {
      QSState s = remaining.remove();
      for (QSState n : s.next()) {
        remaining.add(n);
      }
    }

    return null;
  }
}

public class QSSort {
  // The main function.
  public static void main(String args[]) {
    try {
      BufferedReader in = new BufferedReader(new FileReader(args[0]));
      String line = in.readLine();
      String[] a = line.split(" ");
      int N = Integer.parseInt(a[0]);
      line = in.readLine();
      String [] initialQueueInStrings = line.split(" ");
      ArrayDeque<Integer> initialQueue = new ArrayDeque<Integer>();


      for (int i = 0; i < N; i++)
        initialQueue.add(Integer.parseInt(initialQueueInStrings[i]));

      in.close();

      QSState initial = new QSState(initialQueue, new ArrayList<Integer>(), "", new HashSet<QSState>(), 0, 0);
      QSState result = initial.solve();

      printSolution(result);
    }
    catch(IOException e) {}
  }

  // A recursive function to print the states from the initial to the final.
  private static void printSolution(QSState s) {
    System.out.println(s);
  }
}
