class EdenEvents::Event
    attr_accessor :name, :pokemon, :url, :key_info
    @@all = []
     
    def initialize(name, pokemon, url)
      @name = name
      @pokemon = pokemon
      @url = url
      @key_info = []
      # notify pokemon about the stats
      add_to_pokemon
      save
    end 
    
    def self.all 
      @@all 
    end
    
    def add_to_pokemon
      @pokemon.stats << self unless @pokemon.stats.include?(self)
    end 
    
    def get_stats_details
      pokedex::Scraper.scrape_key_info(self) if @key_info.empty?
    end 
    
    def save
      @@all << self
    end
  end 