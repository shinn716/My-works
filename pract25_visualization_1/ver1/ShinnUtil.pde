//  ver3
// example: Array Value   0, 1, 2, 3, 4, 5, 6, 7, 8, 9
//          shiftToCenter 9, 7, 5, 3, 1, 0, 2, 4, 6, 8

class ShinnUtil {

  int[] shiftToCenter(int[] array) {
    int[] data1 = new int[array.length/2];
    int[] data2 = new int[array.length/2];

    for (int i=0; i<array.length/2; i++) {
      data1[i] = array[i*2];
      //println(i + " value: " + data1[i]);
    }

    for (int j=array.length/2; j>0; j--) {
      data2[(array.length/2-j)] = array[j*2-1];
      //println(j+ " value: " + data2[j]);
    }

    for (int i=0; i<array.length; i++) {
      if (i<array.length/2) {
        array[i] = data2[i];
      } else {
        array[i] = data1[i-array.length/2];
      }
    }

    return array;
  }


  float[] shiftToCenter(float[] array) {
    float[] data1 = new float[array.length/2];
    float[] data2 = new float[array.length/2];

    for (int i=0; i<array.length/2; i++) {
      data1[i] = array[i*2];
      //println(i + " value: " + data1[i]);
    }

    for (int j=array.length/2; j>0; j--) {
      data2[(array.length/2-j)] = array[j*2-1];
      //println(j+ " value: " + data2[j]);
    }

    for (int i=0; i<array.length; i++) {
      if (i<array.length/2) {
        array[i] = data2[i];
      } else {
        array[i] = data1[i-array.length/2];
      }
    }

    return array;
  }
  
}