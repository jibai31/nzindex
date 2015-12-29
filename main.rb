# puts "Enter A"
# a = gets.chomp
# puts "Enter B"
# b = gets.chomp
# c = a.to_i + b.to_i
# puts c

@playing = true
@my_score = {L: 1, R: 1}
@ai_score = {L: 1, R: 1}

# attr_reader :my_score, :ai_score

def print_status
  if @my_score.values.inject(&:+) == 0
    puts "AI wins !!"
    @playing = false
  elsif @ai_score.values.inject(&:+) == 0
    puts "You win !!"
    @playing = false
  else
    puts "AI: #{hands @ai_score}"
    puts "ME: #{hands @my_score}"
  end
end

def hands(values)
  "#{hand values[:L]}   #{hand values[:R]}"
end

def hand(value)
  "#{'| ' * value}#{'. ' * (4-value)}"
end

def instructions
  "L: play left | R: play right | L2: move 2 from left to right"
end

def parse(input)
  raise "Invalid" unless input && [1, 2].include?(input.length)
  side = input[0].to_sym
  raise "Invalid" unless [:L, :R].include?(side)
  if input.length == 1
    return [side, nil]
  else
    nb = input[1].to_i
    raise "Invalid" unless nb > 0 && nb < 5
    return [side, nb]
  end
end

def move(player, side, nb)
  score = player == :me ? @my_score : @ai_score
  other_side = other_side(side)
  raise "Invalid" if nb > score[side] || score[other_side] + nb > 4
  nb = -nb if side == :L
  score[:L] += nb
  score[:R] -= nb
end

def attack(attacked, side)
  attacked_score, attacking_score = (attacked == :me) ? [@my_score, @ai_score] : [@ai_score, @my_score]
  raise "Cannot play with that hand" if attacking_score[side] == 0
  attacked_score[side] += attacking_score[side]
  attacked_score[side] = 0 if attacked_score[side] > 4
end

def random_side
  rand(2) == 0 ? :L : :R
end

def other_side(side)
  side == :L ? :R : :L
end

def other_player(player)
  player == :me ? :ai : :me
end

def ai_attack_or_defend(side, offensiveness = 2)
  other_side = other_side(side)
  if rand(offensiveness) == 0
    "#{other_side}#{1 + rand(@ai_score[other_side] - 1)}"
  else
    side
  end
end

def ai_attack_or_lighten(side, offensiveness = 2)
  if rand(offensiveness) == 0
    "#{side}#{1 + rand(@ai_score[side] - 1)}"
  else
    side
  end
end

def ai_play
  left, right = @ai_score.values
  other_left, other_right = @my_score.values
  if left > 0 && other_left + left > 4
    'L'
  elsif right > 0 && other_right + right > 4
    'R'
  elsif left == 0
    ai_attack_or_lighten(:R)
  elsif right == 0
    ai_attack_or_lighten(:L)
  elsif left == 1 && right == 1
    random_side
  elsif left == 1
    ai_attack_or_defend(:L)
  elsif right == 1
    ai_attack_or_defend(:R)
  else # all hands have 2 or more
    ai_attack_or_defend(random_side)
  end
end

def play(player, input)
  side, nb = parse(input)
  other_player = other_player(player)
  if nb
    move(player, side, nb)
  else
    attack(other_player, side)
  end
end

puts instructions

while @playing do
  print_status
  begin
    input = gets.chomp
    play(:me, input)
    print_status
    break unless @playing
  rescue => e
    puts e
    puts instructions
    retry
  end
  answer = ai_play
  sleep 3
  puts answer
  play(:ia, answer)
end

