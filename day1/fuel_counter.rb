require "test/unit/assertions"
include Test::Unit::Assertions

def total_fuel_for_modules(module_mass_list)
	total_fuel = 0

	module_mass_list.each do |module_mass|
		total_fuel += fuel_required_for_module(module_mass)
	end

	total_fuel
end

def fuel_required_for_module(mass)
	((mass.to_f/3).to_i) - 2
end

def read_module_mass_file(file_name)
	file = File.open(file_name)
	file_data = file.readlines.map(&:chomp)
	file.close

	file_data
end	

modules = read_module_mass_file("puzzle_input.txt")

assert_equal(fuel_required_for_module(1969), 654)
assert_equal(fuel_required_for_module(100756), 33583)
assert_equal(fuel_required_for_module("100756"), 33583)
assert_equal(fuel_required_for_module(100756.0), 33583)

print("Total Fuel required: #{total_fuel_for_modules(modules)}\n")
