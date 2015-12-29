# New Zealand game

## Instructions
Once you've downloaded the files, simply run the command:
```
ruby main.rb
```
You will be prompted with the following:
```
L: play left | R: play right | L2: move 2 from left to right
AI: | . . .    | . . .
ME: | . . .    | . . .
```
It shows you the 2 hands of your opponent (AI) and your own 2 hands. 
At the beginning of the game, you have one finger per hand, shown here with a `|`.

To play, you must type a command and press Enter. The following commands exist:
- `L`: you will hit the left hand of your opponent.
- `R`: you will hit the right hand of your opponent.
- `L3`: you will move 3 fingers from your left hand to your right hand. R1 would move one finger from right to left, and so on.

## Rules
- You cannot move more fingers than you have on one hand.
- You cannot move fingers leaving a hand empty.
- When you hit an opponent's hand, you will add to that hand as many fingers as you have on your hitting hand.
- A hand can only hit the hand directly opposed, not in diagonale.
- If a hand gets over 5 fingers or more, it loses all its fingers.
- A hand without finger cannot hit an opponent's hand.
- A player wins when both opponent's hands have no more fingers.
