require 'bundler'

Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

class App
	def starting_game
		puts "-------------------------------------------------"
		puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
		puts "|Le but du jeu est d'être le dernier survivant !|"
		puts "-------------------------------------------------"
	end

	def enter_name
		puts "Quel est ton prénom misérable cloporte moldu?"
		HumanPlayer.new(gets.chomp)
	end

	def ennemies_init(player1, player2)
		player1 = Player.new(player1)
		player2 = Player.new(player2)
		ennemies = [player1, player2]
	end


	def attack_init(user,player1,player2)

		puts "Passons à la phase d'attaque"

		puts '',user.show_state, player1.show_state, player2.show_state
		selector = nil
		choices = ['a', 's', '1', '2']
		until choices.include?(selector)
		puts "Quelle action veux-tu effectuer ?"

		puts "a - chercher une meilleure arme"
		puts "s - chercher à se soigner"

		puts "attaquer un joueur en vue :"
		print "1 -"
		print  player1.show_state
		print "2 -"
		print player2.show_state

		selector = gets.chomp
		end
		selector
	end

	def attack_phase(user,selector,player1,player2)

	case selector
		when 'a' then user.attribute_weapon
		when 's' then user.search_health_pack
		when '1' then user.attacks(player1)
		when '2' then user.attacks(player2)
	end
	end

	def reply_phase(user, ennemies)
	puts "Voici la riposte"
	
	ennemies.each { |player| player.attacks(user) unless player.dead?}
	end

def fight(user, ennemies)
	until user.dead? || (ennemies[0].dead? && ennemies[1].dead?)
	selector = attack_init(user, ennemies[0], ennemies[1])
	attack_phase(user, selector, ennemies[0], ennemies[1])
	reply_phase(user,ennemies) unless ennemies[0].dead? && ennemies[1].dead?
	end
end

def ending_game(user)

	puts "La partie est terminée"
	if user.dead?
		puts "Sombre merde morte, réessaye encore !"
	else
		puts "Bravo... mais tu auras pas autant de chances la prochaine fois"
	end
end

def initialize

	starting_game
	user = enter_name
	ennemies = ennemies_init('José','Josiane')
	puts "C'est parti !"
	fight(user, ennemies)
	ending_game(user)
	end
end

App.new
