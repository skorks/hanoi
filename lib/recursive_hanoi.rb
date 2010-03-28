class RecursiveHanoi
  include HanoiHelpers
  def initialize(options={:discs => 8})
    @discs = options[:discs]
    @pegs = {:from => [], :to => [], :pivot => []}
    @peg_array = [@pegs[:from], @pegs[:to], @pegs[:pivot]]
    @discs.downto(1) do |num|
      @pegs[:from] << num
    end
  end

  def solve
    puts "SOLVING RECURSIVELY!!!"
    print_special_state "Initial State"
    move(@discs, @pegs)
    print_special_state "Final State"
  end

  def move(n, pegs = {})
    move((n-1).discs, :from => pegs.start_peg, :to => pegs.pivot_peg,
      :pivot => pegs.end_peg) if n > 1
    shift(1.disc, :from => pegs.start_peg, :to => pegs.end_peg)
    print_state
    raise unless state_valid
    move((n-1), :from => pegs.pivot_peg, :to => pegs.end_peg, :pivot =>
        pegs.start_peg)  if n > 1
  end
end