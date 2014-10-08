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

def calculate_total(cards)
	array = cards.map {|card| card[1]}
	total = 0

	array.each do |value|
		if value == 'A'
			total += 11
		elsif value == 'J' || value == 'Q' || value == 'k'
			total += 10
		else
			total += value.to_i
		end
	end

	# correct for A
	array.select{|value| value == 'A'}.count.times do
		if total > 21
			total -= 10
		end
	end

	total
end

# start  game
puts "Welcome to Blackjack!"

suits = ['H', 'D', 'S', 'C']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suits.product(cards)
deck.shuffle!

# Deal cards
player_cards = []
dealer_cards = []

2.times do
	player_cards << deck.pop
	dealer_cards << deck.pop
end

player_total = calculate_total(player_cards)
dealer_total = calculate_total(dealer_cards)

puts "Player cards is: #{player_cards[0]} #{player_cards[1]} and total is: #{player_total}"
puts "Dealer cards is: #{dealer_cards[0]} #{dealer_cards[1]} and total is: #{dealer_total}"

if player_total == 21 && dealer_total == 21
	puts "It's tie."
	exit
elsif player_total > 21
	puts "Dealer won!You busts."
	exit
elsif dealer_total > 21
	puts "You won!Dealer busts."
	exit
end

# Player turn
while player_total < 21
	puts "What would you like to do? 1) hit 2) stay"
  hit_or_stay = gets.chomp

  if !['1', '2'].include?(hit_or_stay)
    puts "Error: you must enter 1 or 2"
    next
  end

  if hit_or_stay == '2'
  	break
  end

  new_card = deck.pop
  puts "Dealing card to player: #{new_card}"
  player_cards << new_card
  player_total = calculate_total(player_cards)
  puts "Now, your total is: #{player_total}"

  if player_total == 21
  	puts "You hit blackjack, you win!"
  	exit
  elsif player_total > 21
  	puts "You busts, dealer win."
  	exit
	end

end

# Dealer turn
while dealer_total < 17
	new_card = deck.pop
	puts "Dealing card to dealer: #{new_card}"
	dealer_cards << new_card
	dealer_total = calculate_total(dealer_cards)
	puts "Now, dealer total is: #{dealer_total}"

	if dealer_total == 21
		puts "Dealer hit blackjack, dealer win."
		exit
	elsif dealer_total > 21
		puts "Dealer busts, you win!"
		exit
	end

end

#compare hands
puts "Your cards:"
player_cards.each do |card|
	puts "=> #{card}"
end

puts "Dealer's cards: "
dealer_cards.each do |card|
	puts "=> #{card}"
end

if player_total > dealer_total
	puts "You win."
elsif player_total < dealer_total
	puts "Dealer win."
else
	puts "It's tie."
end