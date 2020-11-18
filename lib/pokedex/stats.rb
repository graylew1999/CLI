class pokedex::pokemon
    attr_accessor :name, :ref, :stats
    @@all = []
     
    def initialize(name, ref)
      @name = name
      @ref = ref
      @stats = []
      save
    end 
   
    def self.all
      pokedex::Scraper.scrape_pokemon if @@all.empty?
      @@all
    end
    
    def get_stats
      pokedex::Scraper.scrape_stats(self) if @stats.empty?
    end
    
    def save
      @@all << self
    end
  end 