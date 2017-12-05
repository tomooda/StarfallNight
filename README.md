# Starfall Night
I just hacked up a little game to learn how to use Bloc in Pharo 6.1. So, I share it here because I have no reason not to do that :-)

The rule is simple.
3 jewels drop from the top. You can move it left and right by left arrow key and right arrow key respectively. You can rotate the order of the jewels by the up arrow key. The down arrow key will drop the jewels on-to the floor.
If the pile of the jewels stack on the floor have 3 or more of the same kind of jewels in a row, column or diagonal, they will vanish out and the jewels on the vanished one will fall down to the floor (or another jewel), which may cause another vanish of jewels.

[![Demo Play](http://img.youtube.com/vi/92XQ9nuijMM/0.jpg)](http://www.youtube.com/watch?v=92XQ9nuijMM)

Please click the above image to see a demo movie.

A little documentation that explains the implementation in Japanese is found [here](https://qiita.com/tomooda/items/1b9f9cba95f5ec5b3f56).
