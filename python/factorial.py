
# Script to calculate n!

import sys

def factorial(n):
    output = 1
    for i in range(1, n+1):
        output *= i

    return output


if __name__ == '__main__':
    print(factorial(int(sys.argv[1])))
