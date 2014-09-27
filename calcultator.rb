puts "Please input number1"
num1 = gets.chomp

puts "Please input number2"
num2 = gets.chomp

puts "Please select the serial number of the corresponding operator"
puts "1) add 2) subtract 3) multiplication 4) division"
operator = gets.chomp

case operator
when '1'
	result = num1.to_i + num2.to_i
	puts "#{num1} + #{num2} is #{result}"
when '2'
	result = num1.to_i - num2.to_i
	puts "#{num1} - #{num2} is #{result}"
when '3'
	result = num1.to_i * num2.to_i
	puts "#{num1} * #{num2} is #{result}"
when '4'
	result = num1.to_f / num2.to_f
	puts "#{num1} / #{num2} is #{result}"
else
	puts "you selected the serial number of corresponding operator is wrong"
end