require "test/unit/assertions"
include Test::Unit::Assertions

require "pry-byebug"

def process_intcode(int_list)
  i = 0

  loop do
    int_code = int_list[i]
    break if int_code == 99

    value_a_index = int_list[i+1]
    value_b_index = int_list[i+2]
    store_index = int_list[i+3]

    case int_code
      when 1
        int_list[store_index] = int_list[value_a_index] + int_list[value_b_index]

      when 2
        int_list[store_index] = int_list[value_a_index] * int_list[value_b_index]

      else
        raise "Invalid format of int_list"
    end
    i += 4
  end

  int_list
end

def read_file(filename)
  file = File.open(filename)
  # file_data = file.readlines.map(&:chomp)

  file_data = file.read.split(",").map{|char| char.to_i}
  file.close

  file_data
end

def test_suite
  assert_equal([2,0,0,0,99], process_intcode([1,0,0,0,99]))
  assert_equal([2,3,0,6,99], process_intcode([2,3,0,3,99]))
  assert_equal([2,4,4,5,99,9801], process_intcode([2,4,4,5,99,0]))
  assert_equal([30,1,1,4,2,5,6,0,99], process_intcode([1,1,1,4,99,5,6,0,99]))
end

# run test suite
test_suite

begin
  int_list = read_file("puzzle_input.txt")

  # manual adjustments to restore computer to 1201 state
  int_list[1] = 12
  int_list[2] = 2 

  process_intcode(int_list)
rescue StandardError => e
  print "Exception Caught: #{e.message}"
else
  print "after: #{int_list}\n"
end


