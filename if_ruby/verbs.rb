#This code is evaluated in the game's context, just like user-written code.

verb 'quit' do
  quit
end

alias_verb 'quit' => 'q'

verb 'look' do
  display.puts player.location.room_description
end

alias_verb 'look' => 'l'

verb 'examine' do |words|
  name = words[0]
  unless name
    display.puts 'Examine what?'
    next
  end
  things = player.room.things.find_all(name)
  if things.length == 0
    display.puts "I don't see that here."
    next
  elsif things.length > 1
    display.puts 'I see multiple objects with that description.'
    next
  end
  things.each do |thing|
    display.puts(thing.description)
  end
end

alias_verb 'examine' => 'x'

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
    alias_verb direction_str => directions_abbrev[index].to_s
  end
end

