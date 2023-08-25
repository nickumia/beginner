#include <stdio.h>

// Main Function
int main() {
  // Declare variables
	int a, b, number, addition;

  // Ask for first number
	printf("hello please enter a number\n");
	scanf("%d", &a);

  // Ask for second number
	printf("place another number \n");
	scanf("%d" , &b);

  // Add two numbers and display result
	addition=a+b;
	printf("the answer in addition is %d", addition);

  // Program exits successfully
  return 0;
}
