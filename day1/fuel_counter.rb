require "test/unit/assertions"
include Test::Unit::Assertions

def total_fuel(module_masses)
	total_fuel = 0

	module_masses.each do |module_mass|
		total_fuel += calculate_total_fuel_for_mass(module_mass)
	end
	
	total_fuel
end

def calculate_total_fuel_for_mass(mass)
	fuel_required = fuel_required_for_mass(mass)
	
	return 0 if fuel_required <= 0

	# Currently every 1 Unit of Fuel == 1 Unit of mass.
	fuel_mass = fuel_required # Change here if required.
 	fuel_required += calculate_total_fuel_for_mass(fuel_mass)

	fuel_required
end

# This method is only required for Part 1
def calculate_total_fuel_for_modules(module_mass_list)
	total_fuel = 0

	module_mass_list.each do |module_mass|
		total_fuel += fuel_required_for_mass(module_mass)
	end

	total_fuel
end

def fuel_required_for_mass(mass)
	((mass.to_f/3).to_i) - 2
end

def read_module_mass_file(file_name)
	file = File.open(file_name)
	file_data = file.readlines.map(&:chomp)
	file.close

	file_data
end


def test_logic
	# -----------------Methods-----------------
	# fuel_required_for_mass test
	assert_equal(654, fuel_required_for_mass(1969))
	assert_equal(33583, fuel_required_for_mass(100756))
	assert_equal(33583, fuel_required_for_mass("100756"))
	assert_equal(33583, fuel_required_for_mass(100756.0))

	# read_module_mass_file test
	assert(!read_module_mass_file("puzzle_input.txt").empty?)

	# -----------------Problem Tests-----------------
	# Part 1 test
	# 14->2, 12->2
	assert_equal(calculate_total_fuel_for_modules([14, 12]), 4)
	
	# Part 2 test
	assert_equal(50346, total_fuel([100756]))
	assert_equal(4843011, total_fuel([9686114]))

	assert_equal(7, total_fuel([12,14,16]))
end

test_logic

modules = read_module_mass_file("puzzle_input.txt")

print("Part 1 Answer: Total Fuel required for modules: #{calculate_total_fuel_for_modules(modules)}\n")
print("Part 2a Answer: Total Fuel required for module + fuel: #{total_fuel(modules)}\n")
