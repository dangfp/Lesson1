# 1. 绘制棋盘（显示井字）
# 2. 获取玩家输入
# 3. 获取电脑输入
# 4. 将输入结果绘制在棋盘上（重绘）
# 5. 按照规则判定游戏结果

ROW = 11
COLUMN = 17
tic_toc = {}

def initialize_tic_toc(tic_toc)
	for r in 1..ROW do
		for c in 1..COLUMN do
			if r % 4 == 0 && c % 6 == 0
				tic_toc[[r, c]] = '+'
			elsif r % 4 == 0
				tic_toc[[r, c]] = '-'
			elsif c % 6 == 0
				tic_toc[[r, c]] = '|'
			else
				tic_toc[[r, c]] = ' '
			end
		end
	end
end


def display_tic_toc(tic_toc)
	system 'clear'

	for r in 1..ROW do
		for c in 1..COLUMN do
			print tic_toc[[r, c]]
		end
		puts
 	end
end

choosing_positions = { '1' => [2, 3], '2' => [2, 9], '3' => [2, 15], 
	'4' => [6, 3], '5' => [6, 9], '6' => [6, 15], 
	'7' => [10, 3], '8' => [10, 9], '9' => [10, 15] }

def choice_is_validated?(choice, tic_toc, choosing_positions)
	optinos = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
	return optinos.include?(choice) && tic_toc[choosing_positions[choice]] == ' '
end

def compare(tic_toc)
	player_won_message = "Player won!"
	computer_won_message = "Computer won!"

	# 以行为单位进行验证
	[2, 6, 10].each do |r|
		if tic_toc[[r, 3]] != ' ' && tic_toc[[r, 3]] == tic_toc[[r, 9]] && tic_toc[[r, 3]] == tic_toc[[r, 15]]
			if tic_toc[[r, 3]] == 'X'
				return player_won_message
			elsif tic_toc[[r, 3]] == 'O'
				return computer_won_message
			end
		end
	end
	# 以列为单位进行验证
	[3, 9, 15].each do |c|
		if tic_toc[[2, c]] != ' ' && tic_toc[[2, c]] == tic_toc[[6, c]] && tic_toc[[2, c]] == tic_toc[[10, c]]
			if tic_toc[[2, c]] == 'X'
				return player_won_message
			elsif tic_toc[[2, c]] == 'O'
				return computer_won_message
			end
		end
	end

	# 以对角线为单位进行验证
	if (tic_toc[[2, 3]] == tic_toc[[6, 9]] && tic_toc[[2, 3]] == tic_toc[[10, 15]] && tic_toc[[2, 3]] != ' ') || 
		(tic_toc[[2, 15]] == tic_toc[[6, 9]] && tic_toc[[2, 15]] == tic_toc[[10, 3]] && tic_toc[[2, 15]] != ' ')
		if tic_toc[[2, 3]] == 'X'
			return player_won_message
		elsif tic_toc[[2, 3]] == 'O'
			return computer_won_message
		end
	end
	
end

puts "Start tic toc toe game!"

initialize_tic_toc(tic_toc)

loop do

	begin
		puts "Choose a positon (from 1 to 9) to place a piece:"
		player_choice = gets.chomp.downcase
	end until choice_is_validated?(player_choice, tic_toc, choosing_positions)
	tic_toc[choosing_positions[player_choice]] = 'X'
	display_tic_toc(tic_toc)
	
	# 评估游戏结果，如果已有胜者，打印ß结果，退出循环，否则由电脑进行选择
	compare_result = compare(tic_toc)

	if compare_result
		puts compare_result
		break
	else
		choosing_positions.delete(player_choice)
		computer_choice = choosing_positions.keys.sample
		tic_toc[choosing_positions[computer_choice]] = 'O'
		display_tic_toc(tic_toc)
	end
	
	# 再次评估游戏结果，如果已有胜者，给出结果，退出循环，否则继续循环（也就是由玩家进行选择）
	compare_result = compare(tic_toc)

	if compare_result
		puts compare_result
		break
	end

	choosing_positions.delete(computer_choice)

	if choosing_positions.empty?
		puts "It's tie."
		break
	end

end