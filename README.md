# Project_Homework_Assembly
  This is my first project in Assembly language, which consists of 3 exercises. Here, I have attached the solutions to the 3 exercises and the original project requirements (from "Arhitectura Sistemelor de Calcul (ASC) - Tema Laborator 2023", starting from page 4 to page 6 for the context of the project and from page 7 to page 9 for the requirements). Additionally, I have written the translated requirements in English below.

  Moreover, "Arhitectura Sistemelor de Calcul (ASC) - Tema Laborator 2023" includes the context from which the requirements started, too.
## Context
Conway’s Game of Life is a two-dimensional zero-player game, invented by mathematician John Horton Conway in 1970. The purpose of this game is to observe the evolution of a system of cells, starting from an initial configuration, by introducing rules regarding the death or creation of new cells in the system. This evolving system is Turing-complete.

The state of a system is described by the cumulative state of its component cells, and for these, we have the following rules:

1. Underpopulation: Any cell (that is alive in the current generation) with fewer than two live neighbors dies in the next generation.
2. Continuity of live cells: Any cell (that is alive in the current generation) with two or three live neighbors will survive into the next generation.
3. Overpopulation: Any cell (that is alive in the current generation) with more than three live neighbors dies in the next generation.
4. Creation: A dead cell with exactly three live neighbors will be brought to life in the next generation.
5. Continuity of dead cells: Any other dead cell that does not meet the creation rule remains a dead cell.
   
The neighbors of a cell are considered to be the following 8 cells in a two-dimensional matrix:

	a00      a01     a02
	
	a10 current cell a12
	
	a20      a21     a22

We define the state of a system at generation n as being a matrix Sn ∈ Mm×n({0, 1}) (where m is the number of rows and n is the number of columns), where the element 0 represents a dead cell, and 1 represents a live cell (in the current generation).

We define a k-evolution (k ≥ 0) of the system as an iteration S0 → S1 → · · · → Sk, where each Si+1 is obtained from Si by applying the five rules mentioned above.

Note: For cells located on the first row, first column, last row, or last column, the extension to 8 neighbors is considered by treating those not within the matrix as dead cells.

Example: Consider the following initial configuration S0:

	0 1 1 0
	1 0 0 0
	0 0 1 1

First, we extend this S0 matrix of size 3 × 4 into an extended matrix S0 of size 5 × 6, as follows:

	0 0 0 0 0 0
	0 0 1 1 0 0
	0 1 0 0 0 0
	0 0 0 1 1 0
	0 0 0 0 0 0

In the following, we will work only within the main matrix, but considering the extension for the correct processing of the neighbors. We will go through each element and see which evolutionary rule we can apply. For example, for the element at position (0,0) in the initial matrix, we will apply the rule for the continuity of dead cells, as it is a dead cell and does not have exactly three live neighbors.

The next cell is alive and has exactly two live neighbors, so the rule for the continuity of live cells applies.

For the cell at position (0,2) in S0, we see that it has only one neighbor, so the rule of underpopulation applies—the cell will die in the next generation.

Following the same reasoning for all the cells, the configuration of the system after one iteration (in S1) will be:

	0 0 0 0 0 0
	0 0 1 0 0 0
	0 0 0 0 1 0
	0 0 0 0 0 0
	0 0 0 0 0 0

Symmetric Encryption Scheme: We define an encryption key (starting from an initial configuration S0 and a k-evolution) as the operation < S0, k >, which represents the one-dimensional data array (understood as a bit string) obtained by concatenating the rows from the extended matrix Sk.

For example, starting from the previous configuration S0 and applying only a 1-evolution, the extended matrix S1 described above is obtained, which will result in the following one-dimensional array (understood as a bit string) when applying the operation < S0, 1 >:

	0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0

Consider m as a plaintext message (a string of characters without spaces). The encryption {m}<S0,k> means XORing the plaintext message m with the result of < S0, k >. There are the following cases:

* If the message and the key are of the same length, they are XORed element by element until the result is obtained;
* If the message is shorter than the key, only the first part of the key, corresponding to the length of the message, is used;
* If the message is longer than the key, the key is repeated as many times as necessary to encrypt the entire message.

Let's consider m = parola and use < S0, 1 > as the key, where S0 is the initial configuration described above. We saw that the result obtained is the bit string:

	0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0

which we will consider without spaces:

	000000001000000010000000000000

To perform the encryption, we need to analyze the string to be encrypted, namely parola. We will look at the binary ASCII encoding of each character in this string:

	p 01110000
	a 01100001
	r 01110010
	o 01101111
	l 01101100
	a 01100001

Thus, the string parola will be the following binary string:

	011100000110000101110010011011110110110001100001

In this case, we notice that the string to be encrypted is longer than the encryption key, so if we try to XOR them now, we would have the following situation:

	message = 011100000110000101110010011011110110110001100001
	key = 000000001000000010000000000000

In this case, we will concatenate the key again to the initial key:

	message = 011100000110000101110010011011110110110001100001
	key = 000000001000000010000000000000000000001000000010000000000000

Then we will keep only as much of the new key as we need to encrypt the message:

	message = 011100000110000101110010011011110110110001100001
	key = 000000001000000010000000000000000000001000000010

The encrypted message will be obtained by XORing each element, knowing that 0 XOR 0 = 1 XOR 1 = 0, and 0 XOR 1 = 1 XOR 0 = 1. In this case:

	message = 011100000110000101110010011011110110110001100001
	key = 000000001000000010000000000000000000001000000010
	cipher = 011100001110000111110010011011110110111001100011

The encrypted message will be displayed in hexadecimal (to avoid character display issues), and in this case, we will have:

	cipher = 0111 0000 1110 0001 1111 0010 0110 1111 0110 1110 0110 0011
	= 7 0 E 1 F 2 6 F 6 E 6 3
	= 0x70E1F26F6E63

For decryption, the same mechanism applies—the encrypted message will be XORed with the calculated key, and in the end, we will have m XOR k XOR k = m (since k XOR k = 0, and m XOR 0 = m, due to the associativity of XOR and the calculation rules). During decryption, the message will not be displayed in hexadecimal but in plain text.

## Requirement 0x00

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

## Requirement 0x01

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

In this case, the result is: 

	0x70E1F26F6E63

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
 
The result is:
	
 	parola

Note: The same conditions as in the first requirement are guaranteed, namely the correctness of the input data. The messages to be encrypted will be messages without spaces, composed of alphanumeric characters (digits, lowercase letters, uppercase letters), and the messages to be decrypted will be hexadecimal strings that start with 0x and contain symbols from the set {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F}. The messages (considered in plaintext) will have a maximum of 10 characters!

## Requirement 0x02

  Reimplement requirement 0x00 in a separate source file (named according to section 1.4), such that the input is read from a file named in.txt, and the output is written to a file named out.txt, using functions from the C language.
