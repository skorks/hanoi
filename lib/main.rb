require "recursive_hanoi"
require "iterative_hanoi"

#main.rb -i 5 - iterative
#main.rb -r 3 - recursive

#towers1 = RecursiveHanoi.new(:discs => 3)
#towers1.solve

towers2 = IterativeHanoi.new(:discs => 3)
towers2.solve

#move(5.discs, :from => first, :to => second, :via => third)