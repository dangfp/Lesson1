PICKS = ['p', 'r', 's']

def player_picked
	gets.chomp.downcase
end

def computer_random_picked
	PICKS.sample.downcase
end

def comparison(picks)
	player_won_message = "You won!"
	computer_won_message = "Copmuer won!"
	tie_message = "It's tie."
	paper_wraps_rock = "Paper wraps Rock.\n"
	rock_breaks_scissors = "Rock breaks Scissors.\n"
	scissors_cuts_paper = "Scissors cuts Paper.\n"

	case picks
	when ['p', 'p']
		result = "Your picked Paper and computer picked Paper.\n" + tie_message
	when ['p', 'r']
		result = "Your picked Paper and computer picked Rock.\n" + paper_wraps_rock + player_won_message
	when ['p', 's']
		result = "Your picked Paper and computer picked Scissors.\n" + scissors_cuts_paper + computer_won_message
	when ['r', 'p']
		result = "Your picked Rock and computer picked Paper.\n" + paper_wraps_rock + computer_won_message
	when ['r', 'r']
		result = "Your picked Rock and computer picked Rock.\n" + tie_message
	when ['r', 's']
		result = "Your picked Rock and computer picked Scissors.\n" + rock_breaks_scissors + player_won_message
	when ['s', 'p']
		result = "Your picked Scissors and computer picked Paper.\n" + scissors_cuts_paper + player_won_message
	when ['s', 'r']
		result = "Your picked Scissors and computer picked Rock.\n" + rock_breaks_scissors + computer_won_message
	when ['s', 's']
		result = "Your picked Scissors and computer picked Scissors.\n" + tie_message
	end

	return result
end

puts "Play Paper Rock Scissors game!"

begin

	begin
	 	puts "Choose one: (P/R/S)"
	 	player_picked_result = player_picked
		computer_picked_result = computer_random_picked
		picks = [player_picked_result, computer_picked_result]
	end while !PICKS.include?(player_picked_result)

	puts comparison(picks)

	puts "Play again? (Y/N)"

	play_again = gets.chomp.downcase == 'y'

end while play_again


