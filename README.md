# Project_Homework_Assembly
This is my first project in Assembly language, which consists of 3 exercises. Here, I have attached the solutions to the 3 exercises and the original project requirements (starting from page 7 to page 9 of "Arhitectura Sistemelor de Calcul (ASC) - Tema Laborator 2023"). Additionally, I have written the translated requirements in English below.

##Requirement 0x00

The number of rows m, the number of columns n, the number of living cells p, the positions of the living cells in the matrix, and an integer k are read from the keyboard (STDIN). Attention! When reading the input, the initial, non-extended matrix is considered: the initial configuration S0 is read, and NOT the extended S0!. For example, for the matrix in the task description, the input would be as follows:

3  // m - the number of rows
4  // n - the number of columns
5  // p - the number of living cells
0
1  // the first living cell is at (0,1)
0
2  // the second living cell is at (0,2)
1
0  // the third living cell is at (1,0)
2
2  // the fourth living cell is at (2,2)
2
3  // the fifth living cell is at (2,3)
5  // the integer k

At this step, you are required to print to STDOUT the configuration of the system after a k-evolution. Attention! The state of the system Sk will be displayed and NOT the extended matrix Sk!. The matrix will be displayed in the usual way, and in this case, the result is:

0 0 0 0
0 0 0 0
0 0 0 0

(All cells die after the second iteration).

Note: The elements in each row will be displayed with a space between them, and at the end of each row, you will print a \n character. After the last row, you will also print that \n character!

It is guaranteed that:

• 1 ≤ m ≤ 18
• 1 ≤ n ≤ 18
• p ≤ n · m
• k ≤ 15

##Requirement 0x01

The number of rows m, the number of columns n, the number of living cells p, the positions of the living cells in the matrix, an integer k, and an integer o that can be 0 or 1 (0 for encryption, 1 for decryption), and a message m which can be in plaintext for encryption (a string in the form 0x... for decryption) are read from the keyboard (STDIN). You are required to encrypt/decrypt the received message according to the key that must be calculated based on the specifications given in the assignment.

An example input could be as follows:

3  // m - the number of rows
4  // n - the number of columns
5  // p - the number of living cells
0
1  // the first living cell is at (0,1)
0
2  // the second living cell is at (0,2)
1
0  // the third living cell is at (1,0)
2
2  // the fourth living cell is at (2,2)
2
3  // the fifth living cell is at (2,3)
1  // the integer k
0  // ENCRYPTION will be performed
parola  // the plaintext message to be encrypted

In this case, the result is 0x70E1F26F6E63.

For the input:

3  // m - the number of rows
4  // n - the number of columns
5  // p - the number of living cells
0
1  // the first living cell is at (0,1)
0
2  // the second living cell is at (0,2)
1
0  // the third living cell is at (1,0)
2
2  // the fourth living cell is at (2,2)
2
3  // the fifth living cell is at (2,3)
1  // the integer k
1  // DECRYPTION will be performed
0x70E1F26F6E63  // the hexadecimal string to be decrypted

The result is parola.

Note: The same conditions as in the first requirement are guaranteed, namely the correctness of the input data. The messages to be encrypted will be messages without spaces, composed of alphanumeric characters (digits, lowercase letters, uppercase letters), and the messages to be decrypted will be hexadecimal strings that start with 0x and contain symbols from the set {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F}. The messages (considered in plaintext) will have a maximum of 10 characters!

##Requirement 0x02

Reimplement requirement 0x00 in a separate source file (named according to section 1.4), such that the input is read from a file named in.txt, and the output is written to a file named out.txt, using functions from the C language.
