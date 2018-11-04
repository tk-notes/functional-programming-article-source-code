list = [1, 2, 3, 4, 5]

def inc(value)
  value + 1
end

list.map { |value| inc(value) }

list.map(&method(:inc))

numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
even_numbers = []

numbers.each do |num|
  even_numbers << num if num.even?
end

even_numbers # [2, 4, 6, 8, 10]

numbers.select { |num| num.even? }
numbers.select(&:even?)

# map people
people = [
  { name: 'TK', age: 26 },
  { name: 'Kaio', age: 10 },
  { name: 'Kazumi', age: 30 }
]

people_sentences = []

def build_sentence(person)
  sentence = person[:name]
  sentence += ' is '
  sentence += person[:age].to_s
  sentence += ' years old'
  sentence
end

people.each do |person|
  people_sentences << build_sentence(person)
end

people_sentences
# ['TK has 26 years old', 'Kaio has 10 years old', 'Kazumi has 30 years old']

people.map { |person| build_sentence(person) }
