/***********************************************************************
* Program:
*    Project 7, Sudoku (extra credit)  
*    Brother Helfrich, CS124
* Author:
*    Matthew Stradling
* Summary: 
*    This program is a game of Sudoku. A game where there is a 9x9
*    table of boxes. The table is separated into 9 sections. Within
*    each section, row, and column there can only be one of the 
*    numbers of 1-9. Some of the blocks will be already filled. It is
*    the user's duty to solve the puzzle and fill the remaining boxes
*    the appropriate numbers.
*
*    Estimated:  10.0 hrs   
*    Actual:     12.0 hrs
*      The hardest part was figuring out how to get the coordinates
*      and how to find the possible. Those two functions were the most
*      difficult.EXTRA: hardest part was the robust error checking.
* This was the final project for CS124 at Brigham Young University-Idaho
************************************************************************/

#include <iostream>
#include <fstream>
#include <iomanip>
#include <cassert>
#include <string>
#include <ctype.h>
#include <cstring>
#include <cstdlib>
#include <stdio.h>
#include <stdlib.h>
using namespace std;

#define MAX 9

// table of contents
void getGameFileName(char gameName[]);
bool readFile(char gameName[], int board[][9], int num);
void interact(int num, int board[][9]);
void displayOptions();
void displayBoard(int num, int board[][9]);
char getOption();
void getCoord(int &row, int &col, char coord[]);
int findPossible(int possible[], int board[][9], int row, int col, int num);
void editSquare(int board[][9], int num);
void displayPossible(int board[][9], int num);
void clearBoard(int board[][9], int num);
void solve(int board[][9], int num);
void finalize(int board[][9], int num);
void medium(int board[][9], int num);
void hard(int board[][9], int num);
void getSaveFileName(char gameName[]);
bool writeFile(char gameName[], int board[][9], int num);

/**********************************************************************
* calls the other functions to run the program of playing the game of
* sudoku.
*
* main()
*
*    getGameFileName(gameName)
*
*    IF !readFile(gameName, board, MAX)
*       SEND error message
*       RETURN 1
*
*    interact(MAX, board)
*
*    getSaveFileName(gameName)
*
*    IF !writeFile(gameName, board, MAX)
*       SEND error message
*       RETURN 1
*
*    RETURN 0
* END
***********************************************************************/
int main()
{
   char gameName[256];
   int board[MAX][MAX];

   // Get the source file name
   getGameFileName(gameName);

   // Read the board from file and check if it worked
   if (!readFile(gameName, board, MAX))
   {
      return 1;
   }

   // Power House action function
   interact(MAX, board);

   // Get the destination file name
   getSaveFileName(gameName);

   // Write the board to file and check if it worked
   if (!writeFile(gameName, board, MAX))
   {
      cout << "ERROR: cannot read file\n";

      return 1;
   }

   cout << endl << "Thank you for playing!\n";

   return 0;
}

/***************************************************************************
 * gets the source file file name.
 *
 * getGameFileName(gameName)
 *
 *    PROMPT gameName
 *    GET gameName
 * END
 ***************************************************************************/
void getGameFileName(char gameName[])
{
   cout << "Where is your board located? ";

   // Get the file name
   cin >> gameName;
}

/**********************************************************
 * reads in the game board from the file.
 *
 * readFile(gameName, board, num)
 *
 *    OPEN gameName
 *
 *    IF fin.fail()
 *       RETURN false
 *
 *    FOR row = 0 before num by 1s
 *       FOR col = 0 before num by 1s
 *          READ board[row][col]
 *
 *    CLOSE file
 *
 *    FOR row = 0 before num by 1s
 *       FOR col = 0 before num by 1s
 *          SET possible[] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
 * 
 *          findPossible(possible, board, row, col, num)
 *
 *          IF board[row][col] > 0 AND 
 *             board[row][col] != possible[board[row][col]]
 *             SEND error message
 *             RETURN false
 *
 *    RETURN true
 * END
 **********************************************************/
bool readFile(char gameName[], int board[][9], int num)
{
   ifstream fin;
   fin.open(gameName); // Open file

   // check for failure
   if (fin.fail())
      return false;

   // read in the board
   for (int row = 0; row < num; row++)
   {
      for (int col = 0; col < num; col++)
         fin >> board[row][col];
   }

   // close the file
   fin.close();

   // error file check. If there is a duplicate the file is corrupt.
   for (int row = 0; row < num; row++)
   {
      for (int col = 0; col < num; col++)
      {
         int possible[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

         int numPoss = findPossible(possible, board, row, col, num);

         if (board[row][col] > 0 &&
            (board[row][col] != possible[board[row][col]]))
         {
            cout << "ERROR: Duplicate value \'"
                 << abs(board[row][col])
                 << "\' in inside square"
                 << " represented by \'"
                 << (char)((char)col + 'A')
                 << row + 1
                 << "\'\n";
            return false;
         }
      }
   }
             
   return true;
}

/********************************************************
 * this is the powerhouse function. the actual playing
 * of the game is done through here as options are
 * selected and actions are carried out.
 *
 * interact(num, board)
 *    
 *    displayOptions()
 *    PUT end line
 *
 *    displayBoard(num, board)
 *
 *    SET option = getOption()
 *
 *    WHILE option != 'q' AND option != 'Q'
 *       SWITCH option
 *          CASE '?':
 *             displayOptions()
 *             SEND end line, end line
 *             BREAK
 *          CASE 'd':
 *          CASE 'D':
 *             displayBoard(num, board)
 *             BREAK
 *          CASE 'e':
 *          CASE 'E':
 *             editSquare(board, num)
 *             BREAK
 *          CASE 's':
 *          CASE 'S':
 *             displayPossible(board, num)
 *             BREAK
 *       SET option = getOption()
 *
 *    RETURN
 * END
 ********************************************************/
void interact(int num, int board[][9])
{
   // display the options
   displayOptions();

   cout << endl;

   // display the board and progress in the game
   displayBoard(num, board);

   // get the first option
   char option = getOption();

   // calls to different functions depending on option
   while (option != 'q' && option != 'Q') // If 'Q' then quit
   {
      switch (option)
      {
         case '?':
         {
            // display options again
            displayOptions();
            cout << endl << endl;
         }
         break;
         case 'd':
         case 'D':
            // displays the board and progress
            displayBoard(num, board);
            break;
         case 'e':
         case 'E':
            // edit a square on the board 
            editSquare(board, num);
            break;
         case 's':
         case 'S':
            // display the possible values in a given square
            displayPossible(board, num);
            break;
         case 'c':
         case 'C':
	    clearBoard(board, num);
            break;
         case 'f':
         case 'F':
	    finalize(board, num);
            break;
         case 'm':
         case 'M':
	    medium(board, num);
            break;
         case 'h':
         case 'H':
	    hard(board, num);
            break;
      }
      // get the option again
      option = getOption();
   }

   return;
}

/********************************************************
 * displays the options list.
 *
 * displayOptions()
 *
 *    PUT options header
 *    PUT question-mark option and description
 *    PUT "D" option and description
 *    PUT "E" option and description
 *    PUT "S" option and description
 *    PUT "Q" option and description
 * END
 ********************************************************/
void displayOptions()
{
   // the several options that the user is given
   cout << "Options:\n";
   cout << "   ?  Show these instructions\n";
   cout << "   D  Display the board\n";
   cout << "   E  Edit one square\n";
   cout << "   S  Show the possible values for a square\n";
   cout << "   C  Clear the board and start over\n";
   cout << "   F  Finalize and solve the easy board\n";
   cout << "   M  solve medium level board\n";
   cout << "   H  solve hard level board\n";
   cout << "   Q  Save and Quit\n";
}

/*********************************************************
 * displays the current sudoku game board.
 *
 * displayBoard(num, board)
 *
 *    PUT column header
 *
 *    FOR row = 0 before num by 1s
 *       PUT row header
 *       FOR col = 0 before num by 1s
 *          IF board[row][col] != 0
 *             IF board[row][col] > 0
 *                PUT board[row][col] in green
 *             ELSE
 *                PUT board[row][col] * -1
 *          ELSE
 *             PUT space
 *
 *          IF col == 2 OR col == 5
 *             PUT boarder line
 *          ELSE
 *             PUT ((col != 8) ? " " : "")
 *
 *       PUT end line
 *
 *       IF row ==2 OR row == 5
 *          PUT row boarder line
 *
 *    PUT end line
 * END
 *********************************************************/
void displayBoard(int num, int board[][9])
{
   // column header
   cout << "   A B C D E F G H I\n";

   for (int row = 0; row < num; row++)
   {  
      // row header
      cout << row + 1 << "  ";

      for (int col = 0; col < num; col++)
      {
         // if the square has a number, output it
         if (board[row][col] != 0)
         {
            if (board[row][col] > 0)
               cout << "\E[22;32m" << board[row][col] << "\E[0m";
            else
               cout << board[row][col] * -1;
         }
         // zeros are changed to spaces
         else
            cout << " ";

         // column breaks (helps with dividing into 9 big blocks)
         if (col == 2 || col == 5)
            cout << "|";
         // not time for a break, back to work with a space
         else
            cout << ((col != 8) ? " " : "");
      }

      cout << endl;

      // row breaks (helps with dividing into 9 big blocks)
      if ((row == 2 || row == 5))
      {
         cout << "   -----+-----+-----\n";
      }
   } 
   cout << endl;
}

/*************************************************************
 * gets the option of which action the user would like
 * to take throughout the program.
 *
 * getOption()
 *
 *    DO
 *       PROMPT option
 *       GET option
 *    WHILE option != '?' AND option != 'D' AND option != 'E'
 *          AND option != 'S' AND option != 'Q' AND
 *          option != 'd' AND option != 'e' AND option != 's'
 *          AND option != 'q'
 *
 *    RETURN option
 * END
 *************************************************************/
char getOption()
{
   char option;

   // every prompt tastes better with carrots
   cout << "> ";
   cin >> option;

   // While the input is wrong, send an error and prompt again
   while (option != '?' && option != 'D' && option != 'E'
          && option != 'S' && option != 'Q' &&
          option != 'd' && option != 'e' && option != 's'
          && option != 'q' && option != 'F' &&
          option != 'f' && option != 'C' && option != 'c'
          && option != 'm' && option != 'M' &&
          option != 'h' && option != 'H')
   {
      cout << "ERROR: Invalid command\n";
      cout << "> ";
      cin >> option;
   }

   return option;
}

/*********************************************************
 * prompts and gets the coordinates of the square that
 * the user desires to change.
 *
 * getCoord(row, col, coord)
 *
 *    SET keepProcessing = true
 *
 *    DO
 *       PROMPT coord
 *       GET coord[0], coord[1]
 *       IGNORE 256, '\n'
 *       SET coord[2] = '\0'
 *
 *       IF isdigit(coord[0])
 *          IF isalpha(coord[1])
 *             IF coord[0] >= '1' AND coord[0] <= '9' AND
 *                (coord[1] = toupper(coord[1])) >= 'A'
 *                AND coord[1] <= 'I'
 *                SET row = (int)(coord[0] - '1')
 *                SET col = (int)(coord[1] - 'A')
 *                SET keepProcessing = false
 *             ELSE
 *                PUT error message
 *          ELSE
 *             PUT error message
 *
 *       IF isalpha(coord[0])
 *          IF isdigit(coord[1])
 *             IF coord[1] >= '1' AND coord[1] <= '9' AND
 *                (coord[0] = toupper(coord[0])) >= 'A'
 *                AND coord[0] <= 'I'
 *                SET row = (int)(coord[1] - '1')
 *                SET col = (int)(coord[0] - 'A')
 *                SET keepProcessing = false
 *             ELSE
 *                PUT error message
 *          ELSE
 *             PUT error message
 *    WHILE keepProcessing
 * END
 *********************************************************/
void getCoord(int &row, int &col, char coord[])
{
   // to continue processing or not to continue processing
   bool keepProcessing = true;

   do
   {
      // Yeah, the prompt has a healthy colon
      cout << "What are the coordinates of the square: ";
      // what they input is accepted as two characters
      cin >> coord[0] >> coord[1];

      // ignore any new lines up to this point
      cin.ignore(256, '\n');
      // set the third character of the array to be the null character
      coord[2] = '\0';
      
      // if the first is a number and the second is a letter
      if (isdigit(coord[0]))
      {
         if (isalpha(coord[1]))
         {
            // check for acceptable range
            if ((coord[0] >= '1' && coord[0] <= '9' && 
                (coord[1] = toupper(coord[1])) >= 'A' &&
                 coord[1] <= 'I'))
            {
               // if it's all good, set row and col coordinates
               row = (int)(coord[0] - '1');
               col = (int)(coord[1] - 'A');
               // and stop processing
               keepProcessing = false;
            }

            // out of range, epic fail
            else
               cout << "ERROR: Square \'" << coord 
                    << "\' is invalid\n"; 
         }

         // two numbers, big epic fail
         else
            cout << "ERROR: Square \'" << coord 
                 << "\' is invalid\n";
      }
      
      // if first is a letter and second is a number
      if (isalpha(coord[0]))
      {
         if (isdigit(coord[1]))
         {
            // check for range
            if ((coord[1] >= '1' && coord[1] <= '9' && 
                (coord[0] = toupper(coord[0])) >= 'A' &&
                 coord[0] <= 'I'))
            {
               // if it's all good, set row and col coordinates
               col = (int)(coord[0] - 'A');
               row = (int)(coord[1] - '1');
               // and stop processing
               keepProcessing = false;
            }

            // out of range, epic fail
            else
               cout << "ERROR: Square \'" << coord 
                    << "\' is invalid\n"; 
         }  

         // two letters, big epic fail
         else
            cout << "ERROR: Square \'" << coord 
                 << "\' is invalid\n";         
      }
   }
   // continue processing if there are errors, 
   // stop if there's none
   while (keepProcessing);
}

/*************************************************************
 * finds the possible values that a square can have.
 *
 * findPossible(possible, board, row, col, num)
 *
 *    FOR i = 0 before num by 1s
 *       IF col != i
 *          SET possible[abs(board[row][i])] = 0
 *       IF row != i
 *          SET possible[abs(board[i][col])] = 0
 *
 *    FOR r = 0 before 3 by 1s
 *       FOR c = 0 before 3 by 1s
 *          IF r != (row % 3) AND c != (col % 3)
 *             SET megaRow = ((row / 3) * 3 + r)
 *             SET megaColumn = ((col / 3) * 3 + c)
 *             SET value = abs(board[megaRow][megaColumn])
 *             SET possible[value] = 0
 * END
 *************************************************************/
int findPossible(int possible[], int board[][9], 
                  int row, int col, int num)
{
   int number = 0;

   // look through the row and column of the desired square
   for (int i = 0; i < num; i++)
   {
      /*******************************************************
       * if a number is found take that number, find it in 
       * possible array and change the number in the array
       * to zero. meaning not possible for the desired square
       *******************************************************/

      if (col != i)
         possible[abs(board[row][i])] = 0;

      if (row != i)
         possible[abs(board[i][col])] = 0;
   }

   // searches through the block that the square lies in.
   for (int r = 0; r < 3; r++)
   {
      for (int c = 0; c < 3; c++)
      {
         // checks remaining squares in block for possibles
         if ((r != (row % 3)) && (c != (col % 3)))
         {         
            // if a number is found, it is not possible 
            //for the 1 square
            int megaRow = ((row / 3) * 3 + r);
            int megaColumn = ((col / 3) * 3 + c);
            int value = abs(board[megaRow][megaColumn]);

            possible[value] = 0;
         }
      }
   } 

   for (int i = 0; i < 10; i++)
   {
      if (possible[i] != 0)
	 number++;
   }

   return number;
}

/*****************************************************
 * Allows the input editing of a square on the sudoku
 * board that is not a read-only square.
 *
 * editSquare(board, num)
 *  
 *    SET row = MAX
 *    SET col = MAX
 *    SET possible[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
 *
 *    getCoord(row, col, coord)
 *
 *    WHILE board[row][col] > 0
 *       PUT error message part 1
 *       IF isalpha(coord[0]
 *          SEND coord
 *       ELSE
 *          SEND coord[1], coord[0]
 *       PUT error message part 2
 *       PUT end line
 *       RETURN
 *
 *    findPossible(possible, board, row, col, num)
 *
 *    PROMPT editedNum
 *
 *    IF isalpha(coord[0])
 *       SEND coord
 *
 *    ELSE
 *       SEND coord[1], coord[0]
 *
 *    GET editedNum
 *
 *    IF editedNum == 0
 *       SET board[row][col] = 0
 *       PUT end line
 *
 *    ELSE IF !(editedNum >= 1 AND editedNum <= 9) OR
 *       possible[editedNum] == 0
 *
 *       PUT error message
 *       PUT end line
 *       RETURN
 *
 *    ELSE
 *       SET board[row][col] = editedNum * -1
 *       PUT end line
 * END
 *****************************************************/
void editSquare(int board[][9], int num)
{
   int row = MAX;
   int col = MAX;
   char coord[3];
   // starts with all numbers possible
   int possible[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
   int editedNum;

   // get the coordinate of the square
   getCoord(row, col, coord);

   // if they pick a square that is read only, epic fail
   while (board[row][col] > 0)
   {
      cout << "ERROR: Square \'";

      if (isalpha(coord[0]))
         cout << coord;

      else
         cout << coord[1] << coord[0] << coord[2]; 

      cout << "\' is read-only\n";

      cout << endl;

      return;
   }

   // finds the possible input values
   int numberPoss = findPossible(possible, board, row, col, num);

   cout << "What is the value at \'";

   if (isalpha(coord[0]))
      cout << coord;

   else
      cout << coord[1] << coord[0];

   // every good prompt has a healthy colon
   cout << "\': ";

   cin >> editedNum;


   if (editedNum == 0)
   {
      board[row][col] = 0;

      cout << endl;
   }

   /*********************************************************
    * if the number they enter is out of range or not
    * possible for that particular square, epic fail...again
    *********************************************************/
   else if (!(editedNum >= 1 && editedNum <= 9) || 
            possible[editedNum] == 0)
   {
      cout << "ERROR: Value \'" << editedNum
           << "\' in square \'";

      if (isalpha(coord[0]))
         cout << coord;

      else
         cout << coord[1] << coord[0]; 

      cout << "\' is invalid\n";

      cout << endl;

      return;
   }

   // if it's all good, the number is placed in the square
   else 
   {
      board[row][col] = editedNum * -1;

      cout << endl;
   }
}

/******************************************************
 * displays the possible values for a given square
 *
 * displayPossible(board, num)
 *
 *    SET row = MAX
 *    SET col = MAX
 *    SET possible[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
 *    SET first = true
 *
 *    getCoord(row, col, coord)
 *
 *    findPossible(possible, board, row, col, num)
 *
 *    PUT possible values introduction
 *
 *    FOR i = 0 before 10 by 1s
 *       IF possible[i] != 0
 *          IF first == false
 *             PUT comma
 *          SEND possible[i]
 *          SET first = false
 *
 *    SEND end line, end line
 * END
 ******************************************************/
void displayPossible(int board[][9], int num)
{
   int row = MAX;
   int col = MAX;
   char coord[3];

   // all numbers start possible
   int possible[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
   bool first = true;

   // get coordinate of the square
   getCoord(row, col, coord);

   // find the possible input values
   int numberPoss = findPossible(possible, board, row, col, num);

   cout << "The possible values for \'";

   if (isalpha(coord[0]))
      cout << coord;

   else
      cout << coord[1] << coord[0];

   cout << "\' are: ";

   // output the possible values for the given square
   for (int i = 0; i < 10; i++)
   {
      if (possible[i] != 0)
      {
         if (first == false)
            cout << ", ";

         cout << possible[i];

         first = false;
      }
   }

   cout << endl << endl;
}

/*****************************************************
 * clears the board and allows the user to start over.
 *****************************************************/
void clearBoard(int board[][9], int num)
{
   for (int row = 0; row < num; row++)
      for (int col = 0; col < num; col++)
         if (board[row][col] < 0)
	    board[row][col] = 0;

   cout << "Board cleared\n" << endl;
}

/*****************************************************
 * goes through the process of solving the board.
 *****************************************************/
void solve(int board[][9], int num)
{
  int process = 0;

  for (int row = 0; row < num; row++)
    {
      for (int col = 0; col < num; col++)
	{
	  if (board[row][col] == 0)
            process++;

	  int possArray[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
	  int numberPoss = findPossible(possArray, board, row, col, num);

	  if (numberPoss == 1)
	    {
	      for (int i = 0; i < 10; i++)
		{
		  if (possArray[i] != 0)
		    if (board[row][col] <= 0)
		      board[row][col] = possArray[i] * -1;
		}
	    }
	}
    }

  if (process > 0)
    solve(board, num);
}

/*****************************************************
 * finalizes and solves the board
 *****************************************************/
void finalize(int board[][9], int num)
{
   solve(board, num);

   displayBoard(num, board);

   cout << "Please now clear the board.\n";   
   cout << endl;
}

/****************************************************
 * solves a medium board
 ****************************************************/
void medium(int board[][9], int num)
{
  cout << "Option coming soon..\n";
  cout << "Sorry, you're on your own.\n";
  cout << endl;
}

/*****************************************************
 * solves a hard board
 *****************************************************/
void hard(int board[][9], int num)
{
  cout << "Option coming soon..\n";
  cout << "Sorry, you're on your own.\n";
  cout << endl;
}

/*****************************************************
 * gets the file to which the program will save the
 * game board to.
 *
 * getSaveFileName(gameName)
 *
 *    PROMPT gameName
 *    GET gameName
 * END
 *****************************************************/
void getSaveFileName(char gameName[])
{
   // getting the file to save the game into.
   cout << "What file would you like to write your board to: ";
   cin >> gameName;
}

/*******************************************************
 * saves the game board to a file for future use.
 *
 * writeFile(gameName, board, num)
 *
 *    OPEN gameName
 *   
 *    IF fout.fail()
 *       RETURN false
 *
 *    FOR row = 0 before num by 1s
 *       FOR col = 0 before num by 1s
 *          WRITE board[row][col], space
 *       WRITE end line
 *
 *    CLOSE file
 * 
 *    SEND successful message
 *
 *    RETURN true
 * END
 *******************************************************/
bool writeFile(char gameName[], int board[][9], int num)
{
   ofstream fout;

   fout.open(gameName); // open file

   // check for failure
   if (fout.fail())
      return false;

   // write the board to the file
   for (int row = 0; row < num; row++)
   {
      for (int col = 0; col < num; col++)
         fout << board[row][col] << " ";

      fout << endl;
   }

   // close the file
   fout.close();

   // success! You are smarter than a 5th grader!
   cout << "Board written successfully\n";

   // be a good boy, return true.
   return true;
}
