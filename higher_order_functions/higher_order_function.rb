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

# reduce
prices_list = [2.0, 1, 2.5, 10, 14.5]

sum_of_all = 0

prices_list.each { |price| sum_of_all += price }

sum_of_all # 30.0

prices_list.reduce(:+) # 30.0
prices_list.reduce(70, :+) # 100.0

orders = [
  { title: 'P1', price: 10 },
  { title: 'P2', price: 30 },
  { title: 'P3', price: 20 },
  { title: 'P4', price: 60 }
]

orders.reduce(0) do |sum, order|
  sum + order[:price]
end

square = -> object {
  object * object
}

[1, 2, 3].map(&square)
