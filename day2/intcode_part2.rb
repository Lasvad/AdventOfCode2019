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

def calculate_memory_for_expected_result(memory, expected_result)
  for noun in 1..99 do
    for verb in 1..99 do
      test_memory = memory.dup
      test_memory[1] = noun
      test_memory[2] = verb

      process_intcode(test_memory)

      result_found = true if test_memory[0] == expected_result

      break if result_found
    end
    break if result_found
  end

  return test_memory if result_found

  return [0]
end

def calculate_gravity_assist_output(noun, verb)
  (100*noun) + verb
end

def test_suite
  assert_equal([2,0,0,0,99], process_intcode([1,0,0,0,99]))
  assert_equal([2,3,0,6,99], process_intcode([2,3,0,3,99]))
  assert_equal([2,4,4,5,99,9801], process_intcode([2,4,4,5,99,0]))
  assert_equal([30,1,1,4,2,5,6,0,99], process_intcode([1,1,1,4,99,5,6,0,99]))

  # Part 2 Test
  initial_memory = read_file("puzzle_input.txt")
  calculated_memory = calculate_memory_for_expected_result(initial_memory, 4138658)
  assert_equal(12, calculated_memory[1])
  assert_equal(2, calculated_memory[2])

  assert_equal(1202,calculate_gravity_assist_output(12,2))
end

# run test suite
test_suite

begin
  memory = read_file("puzzle_input.txt")
  calculated_memory = calculate_memory_for_expected_result(memory, 19690720)
  
  print("0:#{calculated_memory[0]}, 1:#{calculated_memory[1]} , 2:#{calculated_memory[2]} \n\n")

  gravity_assist_output = calculate_gravity_assist_output(calculated_memory[1], calculated_memory[2])

  print("Gravity Assist Output: #{gravity_assist_output}\n\n")

rescue StandardError => e
  print "Exception Caught: #{e.message}"
else
  print "after: #{calculated_memory}\n"
end


