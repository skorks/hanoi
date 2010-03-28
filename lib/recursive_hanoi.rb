class Integer
  def disc
    self
  end
  alias_method :discs, :disc
end

class Hash
  def start_peg
    self[:from]
  end

  def end_peg
    self[:to]
  end

  def pivot_peg
    self[:pivot]
  end
end

class RecursiveHanoi
  def initialize(options={:discs => 8})
    @discs = options[:discs]
    @pegs = {:from => [], :to => [], :pivot => []}
    @peg_array = [@pegs[:from], @pegs[:to], @pegs[:pivot]]
    @discs.downto(1) do |num|
      @pegs[:from] << num
    end
  end

  def solve
    print_special_state "Initial State"
    move(@discs, @pegs)
    print_special_state "Final State"
  end

  def print_special_state(message)
    puts "*************"
    puts message
    puts "*************"
    print_state
    puts "*************"
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

  def shift(disc, pegs={})
    raise if disc != 1.disc
    pegs.end_peg << pegs.start_peg.delete_at(pegs.start_peg.length - 1)
  end

  private
    
  def print_state
    puts "\n"
    puts "-------"
    current_index = @discs - 1
    while(current_index >= 0)
      row_value = [" "," "," "]
      @peg_array.each_with_index do |peg, peg_number|
        row_value[peg_number] = peg[current_index] if peg.length > current_index
      end
      puts " #{row_value.join(' ')} "
      current_index -= 1
    end
    puts "-------"
    puts " A B C "
    puts "-------"
    puts "\n"
  end
  
  def state_valid
    @peg_array.each do |peg|
      next if peg.empty?
      (0..peg.length - 2).each do |index|
        return false unless peg[index] > peg[index + 1]
      end
    end
    return true
  end
end