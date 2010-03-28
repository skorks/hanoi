class IterativeHanoi
  include HanoiHelpers
  EVEN_PARITY = "even"
  ODD_PARITY = "odd"
  
  def initialize(options={:discs => 8})
    @discs = options[:discs]
    @pegs = {:from => [], :to => [], :pivot => []}
    @peg_array = [@pegs[:from], @pegs[:to], @pegs[:pivot]]
    @discs.downto(1) do |num|
      @pegs[:from] << num
    end
    @disc_parities = assign_parities
    @move_rules_by_parity = movement_rules_by_parity
  end

  def solve
    puts "SOLVING ITERATIVELY!!!"
    print_special_state "Initial State"
    source_peg = nil
    destination = nil
    while @pegs[:to].length != number_of(@discs)
      source_peg = next_source_peg(destination)
      destination = @move_rules_by_parity[parity_of(source_peg.last)][source_peg.object_id]
      shift(1.disc, :from => source_peg, :to => destination)
      raise unless state_valid
      print_state
    end
    print_special_state "Final State"
  end

  def next_source_peg(off_limits_peg)
    source_peg = nil
    @peg_array.each do |array|
      next if array == off_limits_peg
      next if array.length == 0
      source_peg = array if source_peg == nil || array.last < source_peg.last
    end
    source_peg
  end

  # when there is an odd number of disc the parity of the first is odd i.e. parity of 1 is odd, parity of 2 is even and so forth
  # when there is an even number of discs parity of 1 is even, parity of 2 is odd etc.
  # an odd parity disc always moves in the following fashion A -> B -> C -> A -> B etc.i.e. source_peg -> destination_peg -> pivot_peg -> source_peg
  # an even parity disc always moves in the following fashion A -> C -> B -> A etc. i.e. source_peg -> pivot_peg -> destination_peg -> source_peg
  def movement_rules_by_parity
    odd_move_rules = {}
    even_move_rules = {}
    
    odd_move_rules[@pegs[:from].object_id] = @pegs[:to]
    odd_move_rules[@pegs[:to].object_id] = @pegs[:pivot]
    odd_move_rules[@pegs[:pivot].object_id] = @pegs[:from]

    even_move_rules[@pegs[:from].object_id] = @pegs[:pivot]
    even_move_rules[@pegs[:pivot].object_id] = @pegs[:to]
    even_move_rules[@pegs[:to].object_id] = @pegs[:from]

    {ODD_PARITY => odd_move_rules, EVEN_PARITY => even_move_rules}
  end

  def assign_parities
    disc_parities = {}
    parity = starting_parity
    @pegs[:from].reverse_each do |disc|
      disc_parities[disc] = parity
      parity = toggle_parity(parity)
    end
    disc_parities
  end

  def starting_parity
    @discs % 2 == 0 ? EVEN_PARITY : ODD_PARITY
  end

  def toggle_parity(parity)
    parity == ODD_PARITY ? EVEN_PARITY : ODD_PARITY
  end

  def parity_of(disc)
    @disc_parities[disc]
  end
end