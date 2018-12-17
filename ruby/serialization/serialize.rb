# JSON, the king of serialization on the web

require 'json'

a_ruby_object = {
  a: 'always',
  b: 'be',
  c: 'closing'
}

puts 'Ruby object literal:'
p a_ruby_object

a_json_object = a_ruby_object.to_json
puts "\nRuby object literal as JSON:"
p a_json_object

puts "\nRuby object literal as JSON, parsed:"
p JSON.parse(a_json_object)

# YAML, the prince of server-side Ruby
# Supports class deserializing

require 'yaml'

class Cat
  def initialize(name, age, city)
    @name = name
    @age = age
    @city = city
  end
end

felix = Cat.new('Felix da Housecat', 47, 'Chicago')

puts "\nRuby class instance:"
p felix

puts "\nRuby class as YAML:"
puts felix.to_yaml
