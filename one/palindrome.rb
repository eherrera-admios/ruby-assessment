class String
  # # possibly the simplest solution,
  # # yet not efficient since it creates
  # # a new short-lived string
  # def palindrome?
  #     self == self.reverse
  # end

  # More 'manual' approach without
  # without copies
  def palindrome?
    (0..self.length / 2).all? do |i|
      self[i] == self[-i - 1]
    end
  end
end
