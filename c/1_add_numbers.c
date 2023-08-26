#include <stdio.h>

// Main Function
int main() {
  // Declare variables
	int a, b, number, addition;

  // Ask for first number
	printf("Hello!  Please enter a number: ");
	scanf("%d", &a);

  // Ask for second number
	printf("Please enter another number: ");
	scanf("%d" , &b);

  // Add two numbers and display result
	addition = a + b;
	printf("The sum of the two numbers is %d.\n", addition);

  // Program exits successfully
  return 0;
}
