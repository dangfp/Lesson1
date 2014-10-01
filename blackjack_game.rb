# initialize cards

# deal two cards to the player and dealer

# calculator the total of cards for the player and dealer

# check for a winer or tie

# loop player hit cards until stay or busts
#    hit/stay(player select)
# 	 calculator the total of cards for the player
#    check for a winer


# loop dealer hit cards until stay or busts
#    hit/stay(automatic)
#    calculator the total of cards for the dealer
#    check for a winer

# check for a winer or tie

# if there's a winer
# 	show the winer
# or else
# 	it's a tie

require 'pry'

cards = []
@player_cards = []
@dealer_cards = []
@player_total = 0
@dealer_total = 0
winter = nil

def initialize_cards(cards)
	4.times do
		(1..13).each do |i|
			cards << i
		end
	end
end

def first_deal_cards(cards)
	@player_cards = cards.sample(2)
	@dealer_cards = cards.sample(2)
end

def replace_greater_than_10_card(cards)
	cards.map do |card|
		if card >10
			card = 10
		else
			card = card
		end
	end
end

def a_equal_11_calculator(cards)
	sum = 0
	cards.each do |num|
		if num == 1
			sum += 11
		else
			sum += num
		end
	end
	return sum
end

def a_equal_1_calculator(cards)
	sum = 0
	cards.each do |num|
		sum += num
	end
	return sum
end

def has_greater_than_10_cards?(cards)
	if cards.include?(11) || cards.include?(12) || cards.include?(13)
		return true
	else
		return false
	end
end

def calculate_total(cards)
	temp_cards = has_greater_than_10_cards?(cards) ? replace_greater_than_10_card(cards) : cards
	temp_total = a_equal_11_calculator(temp_cards)

	if temp_cards.include?(1)
		if temp_total > 21
			temp_total = a_equal_1_calculator(temp_cards)
		else
			temp_total
		end
	else
		temp_total
	end
end

def check_winter(player_stay, dealer_stay)
	@player_total = calculate_total(@player_cards)
	@dealer_total = calculate_total(@dealer_cards)

	if @player_total > 21
		return "Dealer"
	elsif @dealer_total > 21
		return "Player"
	elsif @player_total == 21 && @dealer_total < 21
		return "Player"
	elsif @player_total < 21 && @dealer_total == 21
		return "Dealer"
	elsif player_stay && dealer_stay && @player_total < 21 && @player_total > @dealer_total
		return "Player"
	elsif player_stay && dealer_stay && @dealer_total < 21 && @player_total < @dealer_total
		return "Dealer"
	end
	
end

def show_cards_message
	puts "#Player'cards is #{@player_cards} and total is #{@player_total}."
	puts "#Dealer'cards is #{@dealer_cards} and total is #{@dealer_total}."
end

def show_winter_message(winter)
	puts "#{winter} won!"
	show_cards_message
end

initialize_cards(cards)

first_deal_cards(cards)

player_stay = false
dealer_stay = false


winter = check_winter(player_stay, dealer_stay)

if winter
	show_winter_message(winter)
else
	begin
		puts "#Player'cards is #{@player_cards} and total is #{@player_total}."

		begin
			puts "Hit or stay?(h/s)"
			player_selection = gets.chomp.downcase
		end until ['h', 's'].include?(player_selection)

		if player_selection == 'h'
			@player_cards << cards.sample
			winter = check_winter(player_stay, dealer_stay)
		end
	end until @player_total >= 21 || player_selection == 's'

	player_stay = true

	while  @dealer_total < 17
		@dealer_cards << cards.sample
		winter = check_winter(player_stay, dealer_stay)
	end

	dealer_stay = true

	winter = check_winter(player_stay, dealer_stay)

	if @player_total == @dealer_total
		puts "It's tie."
		show_cards_message
	end

	if winter
		show_winter_message(winter)
	end
end
