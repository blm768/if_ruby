library = room 'Library' do
  description 'You find yourself in a white room. Somehow, it feels like a library.'

  thing 'book' do
    description 'An ordinary book'
  end
  thing 'desk' do
    description 'An ordinary desk'
  end
end

verb 'quit' do |words|
  quit
end

player.location = library

display.puts library.room_description

