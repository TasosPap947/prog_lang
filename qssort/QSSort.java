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
  public ArrayDeque<Integer> queue;
  public ArrayDeque<Integer> stack;
  public String moves;
  public HashSet<QSState> seen;
  public int duplicates, uniques;

  public QSState(ArrayDeque<Integer> queue, ArrayDeque<Integer> stack, String moves, HashSet<QSState> seen, int duplicates, int uniques) {
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

  public void next(ArrayDeque<QSState> states) {
    // Q-Move
    if (!queue.isEmpty()) {
      ArrayDeque<Integer> queueCopy1 = new ArrayDeque<Integer>(queue);
      ArrayDeque<Integer> stackCopy1 = new ArrayDeque<Integer>(stack);
      int q = queueCopy1.remove();
      stackCopy1.add(q);
      QSState stateQ = new QSState(queueCopy1, stackCopy1, moves + "Q", seen, duplicates, uniques);
      if (stateQ.isFinal()) {
        System.out.println(stateQ);
        System.exit(0);
      }
      if (!seen.contains(stateQ)) {
        // System.out.println("Queue: " + stateQ.queue + "\n" + "Stack: " + stateQ.stack + "\n");
        states.add(stateQ);
        seen.add(stateQ);
      }
    }
    // S-Move
    if (!stack.isEmpty()) {
      ArrayDeque<Integer> queueCopy2 = new ArrayDeque<Integer>(queue);
      ArrayDeque<Integer> stackCopy2 = new ArrayDeque<Integer>(stack);
      int s = stackCopy2.removeLast();
      queueCopy2.add(s);
      QSState stateS = new QSState(queueCopy2, stackCopy2, moves + "S", seen, duplicates, uniques);
      if (stateS.isFinal()) {
        System.out.println(stateS);
        System.exit(0);
      }
      if (!seen.contains(stateS)) {
        // System.out.println("Queue: " + stateS.queue + "\n" + "Stack: " + stateS.stack + "\n");
        states.add(stateS);
        seen.add(stateS);
      }
    }
  }

  @Override
  public String toString() {
    return moves;
  }

  @Override
  public boolean equals(Object o) {
    // Check elements one-by-one

    QSState other = (QSState) o;

    // Check queue for equality

    Iterator<Integer> iteratorThis = this.queue.iterator();
    Iterator<Integer> iteratorOther = other.queue.iterator();

    while (true) {
      if (!iteratorThis.hasNext() && !iteratorOther.hasNext()) break;
      if (!iteratorThis.hasNext() && iteratorOther.hasNext()) return false;
      if (iteratorThis.hasNext() && !iteratorOther.hasNext()) return false;
      if (iteratorThis.next() != iteratorOther.next()) return false;
    }

    // Check stack for equality

    iteratorThis = this.stack.iterator();
    iteratorOther = other.stack.iterator();

    while (true) {
      if (!iteratorThis.hasNext() && !iteratorOther.hasNext()) break;
      if (!iteratorThis.hasNext() && iteratorOther.hasNext()) return false;
      if (iteratorThis.hasNext() && !iteratorOther.hasNext()) return false;
      if (iteratorThis.next() != iteratorOther.next()) return false;
    }

    // for (int i = 0; i < this.stack.size(); i++) {
    //   if (i >= other.stack.size() || this.stack.get(i) != other.stack.get(i)) return false;
    // }

    return true;
  }

  //============================================================================
  // Διάφορες δοκιμαστικές συναρτήσεις hashCode
  // Αν δεν κάνεις καμία uncomment, παίζει μέχρι το q16.txt
  // Μπορείς να δοκιμάσεις όποια θες από τις παρακάτω, ή να φτιάξεις μία δικιά σου.
  //============================================================================



  // Stupid hashCode for performance comparison
  // @Override
  // public int hashCode() {
  //   return 1;
  // }

  // HashCode using Objects.hashCode immediately upon queue and stack
  // @Override
  // public int hashCode() {
  //   int hash1 = Objects.hashCode(this.queue);
  //   int hash2 = Objects.hashCode(this.stack);
  //   int hash = hash1 + hash2;
  //   // System.out.println(hash);
  //   return hash;
  // }

  // HashCode using arrayFromQueue and arrayFromStack before Objects.hash
  // @Override
  // public int hashCode() {
  //   int[] arrayFromQueue = queue.stream().mapToInt(i->i).toArray();
  //   int[] arrayFromStack = stack.stream().mapToInt(i->i).toArray();
  //   int hash = Objects.hash(Arrays.hashCode(arrayFromQueue), Arrays.hashCode(arrayFromStack));
  //   // System.out.println(hash);
  //   return hash;
  // }

  // // hashCode using sum of above method
  // public int hashCode() {
  //   int[] arrayFromQueue = queue.stream().mapToInt(i->i).toArray();
  //   int[] arrayFromStack = stack.stream().mapToInt(i->i).toArray();
  //   // int hash = Objects.hash(Arrays.hashCode(arrayFromQueue), Arrays.hashCode(arrayFromStack));
  //   // System.out.println(hash);
  //   int hash = Arrays.hashCode(arrayFromQueue) + Arrays.hashCode(arrayFromStack);
  //   return hash;
  // }

  // public int hashCode() {
  //   return Objects.hashCode(queue);
  // }


  public String moves() {
    return moves;
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
      // System.out.println(s);
        s.next(remaining);
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

      QSState initial = new QSState(initialQueue, new ArrayDeque<Integer>(), "", new HashSet<QSState>(), 0, 0);

      if (initial.isFinal()) {
        System.out.println("empty");
        System.exit(0);
      }

      // System.out.println(initial.equals(initial));
      QSState initialCopy = new QSState(initial.queue, initial.stack, initial.moves, initial.seen, initial.duplicates, initial.uniques);
      // System.out.println(initial.equals(initialCopy));

      QSState result = initial.solve();

      printSolution(result);

    }
    catch(IOException e) {}
  }

  private static void printSolution(QSState s) {
    System.out.println(s);
  }
}
