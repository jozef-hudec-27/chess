# Chess
This project is part of [The Odin Project's](https://theodinproject.com) Ruby curriculum.

I doubt you've never heard of Chess, but in case you need a quick refresher of the rules, [here](http://www.chessvariants.org/d.chess/chess.html#touch) is an excellent source with images. 

## Rules
The game is played exactly as you would expect, that is: The two players alternate between taking turns. On each turn, a player can make a valid move. If there are no possible moves, the player chooses another piece. Once a piece is selected, the player **MUST** use it (unless there are no possible moves for the selected piece). There are two scenarios that indicate the end of the game, they are:

1. One of the players gets **mated**. In this case, the player that mated him *wins*.
2. One of the players is **stalemated**. In a case of a stalemate, the game is a *draw*.

## How to play
On each turn, there are two things the current player needs to do in order to continue the game:

1. **Select a valid piece he wants to use** - the terminal will ask for the position of the piece the player wants to move, with this message: ```> Choose where you want to move selected piece```. It expects the player to enter a *valid board cordinate*. The way coordinates work here is the same they work in normal chess. Columns are labeled with letters, 'a' to 'h', from left to right, and rows are labeled with numbers 8 to 1, from top to bottom. The column goes first, preceding the row. Examples of valid coordinates: ```b5```, ```f1```, ```e4```.
2. **Select a valid position** for the selected piece to move to. Everything *(namely, the coordinate system)* here works the same as above.

Players repeat these two steps until the game is over, or the game is saved/quitted.

## Important notes
- When picking a piece to move, instead of entering piece position, the current player can enter ``` quit ``` or ``` save ``` to quit or save the game, respectively.
- Players can load a saved game, instead of starting a new one, by entering ``` 2 ``` into the terminal after the program is run.
- The program assumes the game is played on a *light background*. This is important, because on light background, the pieces at the bottom are white and pieces at the top are black, as they should be. But when played on a dark background, chances are, the top player will appear to be white, and the bottom player black. Be careful, because the top player will still be referred to *(in the terminal)* as black, and vice versa.
- The game currently does not implement these moves/rules: taking en-passant, castling, 50 moves rules, and some others. They might be implemented in the future.
- The game is not expected to be 100% bug-free, so if you encounter any bugs, please ***let me know!***