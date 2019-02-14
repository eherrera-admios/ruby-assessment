UPPERCASE = ('A'..'Z').to_a
LOWERCASE = ('a'..'z').to_a
NUMBER = ('0'..'9').to_a

CONDITIONS = [UPPERCASE, LOWERCASE, NUMBER]

def generate_password
  size = rand(10 - 6) + 6
  pass = " " * size

  conditions_missing = Set.new(0...CONDITIONS.length)

  for i in (0...size - CONDITIONS.length - 1)
    condition_index = rand(CONDITIONS.length - 1)
    condition = CONDITIONS[condition_index]
    conditions_missing.delete(condition_index)

    pass[i] = condition.sample
  end

  for missing_condition in conditions_missing
    condition = CONDITIONS[missing_condition]
    pass[i] = condition.sample
    i += 1
  end

  while i < size
    pass[i] = CONDITIONS.sample.sample
    i += 1
  end

  pass
end
