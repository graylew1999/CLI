class pokedex::Scraper 
    def self.scrape_pokemon 
      doc = Nokogiri::HTML(open("https://www.pokemon.com/us/pokedex/"))
      
      pokemon = doc.css("select#edit-date-filter-month option") 
      
      pokemon.each do |m|
         name = m.text
         ref = m.attr("value")
         pokedex::pokemon.new(name, ref)
      end 
    end 
    
    def self.scrape_stats(pokemon)
        url = "https://www.pokemon.com/us/pokedex/#{pokemon.ref}"
        doc = Nokogiri::HTML(open(url))
        
        stats = doc.css("ul.results li")
        stats.each do |e|
          title = e.css("li.animating").text.strip
          url = e.css("a").attr("href").value
          pokedex::stats.new(title, pokemon, url)
        end 
    end
    
    def self.scrape_key_info(stats)
      url = "https://www.pokemon.com/us/pokedex/#{stats.url}"
      doc = Nokogiri::HTML(open(url))
      lis = doc.css("div.pokemon-info li")
      lis.each do |li|
        info = li.text.strip
        stats.key_info << info
      end 
    end 
  end 