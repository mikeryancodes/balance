def balance(s)
  return nil if s.size % 4 != 0

  counts = {"a" => 0, "c" => 0, "g" => 0, "t" => 0}

  s.chars.each do |char|
    counts[char] += 1
  end

  average = s.size / 4

  return [0, 0] if counts["a"] == average && counts["c"] == average && counts["g"] == average && counts["t"] == average

  differentials = {}
  key = {}
  key_of_window_start = {}

  counts.each do |k, v|
    if v - average > 0
      differentials[k] = v - average
      key[k] = 0
      key_of_window_start[k] = average - v
    end
  end

  # by now, differentials should be a list of the characters we need to replace.
  # The window we are looking for will be the smallest window containing the characters
  # in differentials and their counts.

  # count_to_position takes a hash of the counts of the characters we need to find in our window,
  # and returns the position within the string where the counts of those character occurred
  # in the string up to and including that position.

  count_to_position = Hash.new(-1.0 / 0.0)

  best_window_positions = nil
  best_window_size = 1.0 / 0.0

  s.chars.each_with_index do |char, idx|
    if key[char]
      key[char] += 1
      key_of_window_start[char] += 1
      window_size = idx - count_to_position[key_of_window_start] - 1
      if window_size < best_window_size
        best_window_size = window_size - 1
        best_window_positions = [count_to_position[key_of_window_start] + 1, idx]
      end
    end
    # Subtract the differentials from the counts and find the position where those counts occurred.
    # The difference between that index and this index is a window
    key_copy = key.dup
    count_to_position[key_copy] = idx
  end

  best_window_positions
end

input_strings = [
  "aaaaaaaaaaaccccccccccccccggggggggggttttttttttttttttttttc",
  "aaaaaaaaaaacccccccccccccccggggggggggtttttttttttttttttttt",
  "cccccccccccccccaaaaaaaaaaaggggggggggtttttttttttttttttttt"
]

input_strings.each do |input_string|
  result = balance(input_string)
  p result
  p input_string[result[0] .. result[1]]
  gets
end
