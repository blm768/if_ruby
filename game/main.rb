room 'Library' do
  thing 'book' do
    description 'An ordinary book'
  end
end

puts rooms.find_unique('Library').things

