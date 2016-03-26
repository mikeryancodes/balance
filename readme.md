Problem:

Given a sequence of DNA nucleotides ("a", "c", "g", "t"), return the smallest window such that if we make the right substitutions on this window, the number of nucleotides of each variety will be equal.

Idea:

- First, make sure that the string is of a length divisible by 4.
- Next, figure out what the counts of the nucleotides are.  If the counts are already equal, we are done and can return [0, 0] as our window.

- If the nucleotide counts are different, we need to get creative.
  - First, calculate the length of the string / 4 to figure out what the counts all have to be equal to.
  - Next, go through the nucleotides and figure out which ones have too many, and how many these have in excess.  This information gets stored to differentials, which is a hash.  If differentials == {"c" => 1, "t" => 6}, we know that we're looking for the smallest window containing 1 "c" and 6 "t"s
  - Now, we're going to create a hash, count_to_position, that takes a hash of the same format of differentials, and returns the last position in the original string where the counts of those nucleotides occurred in the beginning part of the string up to and including that position.  For example, if count_to_position[{"c" => 0, "t" => 0}] == 0, we know that position 0 of the original string was the last position where the counts of "c" and "t" were 0.  (This would imply that either an "a" or "g" was at position 0 and that either a "c" or a "t" was at position 1.)
  - We're going to also create a hash key_of_window_start that's the same format as differentials and "trails" the key reflecting the counts at the current position of the nucleotides we need, and trails them by exactly the counts needed in our window.
  - As we iterate through the string, we will lookup count_to_position[key_of_window_start], and this will return the latest position in the string where those counts had occurred in the previous part, implying that the characters needed for us to make our window occurred between that index and our current index and that that part of the string between these positions is in fact a valid window.
  - We can perform the usual routine where we keep track of our minimal window and check it, updating if necessary, every time we find a new window, which is every time count_to_position[key_of_window_start] returns a position in the array.
  - We update count_to_position[key_of_window_start] at every position as we iterate through the array.
  - count_to_position defaults to -Infinity to spare us a nested if.
