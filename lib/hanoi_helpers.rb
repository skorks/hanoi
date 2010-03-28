module HanoiHelpers
  def shift(disc, pegs={})
    raise if disc != 1.disc
    pegs.end_peg << pegs.start_peg.delete_at(pegs.start_peg.length - 1)
  end

  def print_special_state(message)
    puts "*************"
    puts message
    puts "*************"
    print_state
    puts "*************"
  end
  
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

  def number_of(num)
    num
  end
end

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
