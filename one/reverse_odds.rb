def reverse_odds(text)
  raise TypeError.new("text should be a String") unless text.is_a? String

  return text if text.length < 3 # No changes required

  1.step(text.length / 2, 2) { |i| text[i], text[-(i + 1)] = text[-(i + 1)], text[i] }

  text
end
