#This code is evaluated in the game's context, just like user-written code.

verb 'quit' do
  quit
end

alias_verb 'quit' => 'q'

if true
  directions = [
    :north, :northeast, :east, :southeast,
    :south, :southwest, :west, :northwest,
    :up, :down,
  ]
  directions_abbrev = [
    :n, :ne, :e, :se,
    :s, :sw, :w, :nw,
    :u, :d,
  ]

  directions.each_index do |index|
    direction = directions[index]
    direction_str = direction.to_s
    verb direction_str do
      player.go direction
    end
    alias_verb direction_str => directions_abbrev.to_s
  end
end

