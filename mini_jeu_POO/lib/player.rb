require 'pry'

class Player
		attr_accessor :name, :life_points

	def initialize(name, life_points = 10)
		@name = name
		@life_points = life_points
	end

	def show_state
		puts "#{@name} à #{@life_points} points de vie"
	end

	def gets_damage(damage)
		@life_points -= damage
	end

	def attacks(player)
		puts "#{self.name} attaque #{player.name}"
		damage = compute_damage
		player.gets_damage(damage)
		puts "#{self.name} inflige #{damage} points de dommage to #{player.name}"
		player.show_state
	end

	def compute_damage
		return rand(1..6)
	end

	def dead?
		@life_points <= 0
	end
end

class HumanPlayer < Player
		attr_accessor :weapon_level

	def initialize(name, life_points = 100, weapon_level = 1)
		@weapon_level = weapon_level
		super(name, life_points)
	end

	def show_state
		if dead?
			"Tu es mort(e)"
		else
			"Tu as #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
		end
	end

	def compute_damage
		rand(1..6) * @weapon_level
	end

	def attribute_weapon
		new_weapon = rand(1..6)
		puts "Tu as trouvé une arme de niveau #{new_weapon}"
		if new_weapon > @weapon_level
			@weapon_level = new_weapon
			puts "Youhou! elle est meilleure que ton arme actuelle : tu l'as prends"
		else
			puts "Saloperie, cette arme ne tuerait même pas un écureuil paraplégique"
		end
	end

	def search_health_pack
		health_pack = rand(1..6)
		case
		when health_pack == 1
			puts "desolé tu n'as rien trouvé"
		when health_pack > 1 && health_pack < 6
			@life_points + 50 > 100 ? @life_points = 100 : @life_points =+ 50
			puts "Bravo, tu as trouvé un pack de 50 points de vie"
		when health_pack == 6
			@life_points + 80 > 100 ? @life_points = 100 : @life_points =+ 80
			puts "Bravo, tu as trouvé un pack de 80 points de vie"
		end
	end
end
