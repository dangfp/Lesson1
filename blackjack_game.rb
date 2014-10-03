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
cards = ['2', '3', '4', '5', '6', '7', '8', '10', 'J', 'Q', 'K', 'A']

deck = suits.product(cards)
deck.shuffle!

# Deal cards
playercards = []
dealercards = []

2.times do
	playercards << deck.pop
	dealercards << deck.pop
end

playertotal = calculate_total(playercards)
dealertotal = calculate_total(dealercards)

puts "Player cards is: #{playercards[0]} #{playercards[1]} and total is: #{playertotal}"
puts "Dealer cards is: #{dealercards[0]} #{dealercards[1]} and total is: #{dealertotal}"

if playertotal == 21 && dealertotal == 21
	puts "It's tie."
	exit
elsif playertotal > 21
	puts "Dealer won!You busts."
	exit
elsif dealertotal > 21
	puts "You won!Dealer busts."
	exit
end

# Player turn
while playertotal < 21
	puts "What would you like to do? 1) hit 2) stay"
  hit_or_stay = gets.chomp

  if !['1', '2'].include?(hit_or_stay)
    puts "Error: you must enter 1 or 2"
    next
  end

  if hit_or_stay == '2'
  	break
  end

  newcard = deck.pop
  puts "Dealing card to player: #{newcard}"
  playercards << newcard
  playertotal = calculate_total(playercards)
  puts "Now, your total is: #{playertotal}"

  if playertotal == 21
  	puts "You hit blackjack, you win!"
  	exit
  elsif playertotal > 21
  	puts "You busts, dealer win."
  	exit
	end

end

# Dealer turn
while dealertotal < 17
	newcard = deck.pop
	puts "Dealing card to dealer: #{newcard}"
	dealercards << newcard
	dealertotal = calculate_total(dealercards)
	puts "Now, dealer total is: #{dealertotal}"

	if dealertotal == 21
		puts "Dealer hit blackjack, dealer win."
		exit
	elsif dealertotal > 21
		puts "Dealer busts, you win!"
		exit
	end

end

#compare hands
puts "Your cards:"
playercards.each do |card|
	puts "=> #{card}"
end

puts "Dealer's cards: "
dealercards.each do |card|
	puts "=> #{card}"
end

if playertotal > dealertotal
	puts "You win."
elsif playertotal < dealertotal
	puts "Dealer win."
else
	puts "It's tie."
end