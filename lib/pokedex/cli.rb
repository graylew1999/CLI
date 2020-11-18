class pokedex::CLI 
    @@muted="\e[1;31m"
    @@grn="\e[1;32m"
    @@blu="\e[1;34m"
    @@mag="\e[1;35m"
    @@cyn="\e[1;36m"
    @@white="\e[0m"
    
    def call 
      puts "\n#{@@grn}Welcome to The Pokedex!#{@@white}\n"
      @input = ""
      until @input == "exit"
        get_pokemon
        list_pokemon
        get_user_pokemon
        what_next
      end 
      goodbye
    end
    
    def get_pokemon
      @pokemon = pokedex::pokemon.all
    end
    
    def list_pokemon
      puts 'Choose a pokemon to see stats.'
      @pokemon.each.with_index(1) do |pokemon, index| 
        puts "#{index}. #{pokemon.name}"
      end
    end
    
    def get_user_pokemon
      chosen_pokemon = gets.strip.to_i
      show_stats_for(chosen_pokemon) if valid_input(chosen_pokemon, @pokemon)
    end 
    
    def valid_input(input, data)
      input.to_i <= data.length && input.to_i > 0
    end 
    
    def show_stats_for(chosen_pokemon)
      pokemon = @pokemon[chosen_pokemon - 1]
      pokemon.get_stats
      puts "Here are stats for #{pokemon.name}"
      pokemon.stats.each.with_index(1) do |stats, idx|
        puts "#{idx}. #{stats.name}"
      end
      get_user_stats(pokemon)
    end
    
    def get_user_stats(pokemon)
      puts "Choose a pokemon to see more details."
      input = gets.strip
      stats = pokemon.stats[input.to_i - 1]
      stats.get_stats_details
      show_stats_details(stats)
    end
    
    def show_stats_details(stats)
      puts stats.name
      stats.key_info.each {|i| puts "- #{i}"}
    end 
    
    def what_next
      puts "Are you done? Type 'exit' to exit or hit any key to see more stats."
      @input = gets.strip
    end 
    
    def goodbye
      puts "Enjoy the Pokedex!"
    end 
  end