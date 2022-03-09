// PSUEDO C CODE

struct Student {
    int sid;          // 0 
    int grade[4];     // 4, 8, 12, 16
    int average;      // 20, this is computed by your program
                      // 24
};

int n;              // number of students
int m;              // you store the median student's id here
struct Student* s;  // a dynamic array of n students

// Computer average grade
int compute_avg(struct Student* s) {
    // i >= n
    // i - n >= 0
    for (int i=0; i<s.size; i++) {
        int sum = s.grade[0] + s.grade[1] + s.grade[2] + s.grade[3];
        int avg = sum/4;
    }
}

void sort (int* a, int n) {
  // outer loop  
  for (int i=n-1; i>0; i--) { // bgt: -i >= 0
    // inner loop
    for (int j=1; j<=i; j++) { // j - i > 0
      // if statement 
      if (a[j-1] > a[j]) { // bgt 0 > a[j] - a[j-1]
        int t = a[j];
        a[j] = a[j-1];
        a[j-1] = t;
      }
    // return to inner
    }
    // return to outer
  }
  // end loop
}