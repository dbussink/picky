require File.expand_path '../../../server/lib/picky', __FILE__

Person = Struct.new :id, :first, :last

# Loading the Picky index without a source,
# but purely by adding (replacing) items.
#
data = Picky::Index.new :people do
  category :first
  category :last
end

data.replace Person.new(1, 'Donald', 'Knuth')
data.replace Person.new(2, 'Niklaus', 'Wirth')
data.replace Person.new(3, 'Donald', 'Worth')
data.replace Person.new(4, 'Peter', 'Niklaus')

people = Picky::Search.new data

results = people.search 'donald'

# p results.allocations
fail __FILE__ unless results.ids == [3, 1]