library = room 'Library' do
  description 'You find yourself in a white room. Somehow, it feels like a library. A door to the north opens into a dungeon.'

  thing 'book' do
    description 'An ordinary book'
  end
  thing 'desk' do
    description 'An ordinary desk'
    attribute :heavy
  end

  link 'Dungeon', :north
end

room 'Dungeon' do
  description 'You find yourself in a pitch-black room. There is no visible exit.'
end

player.location = library
player.description 'You look the same as ever'

