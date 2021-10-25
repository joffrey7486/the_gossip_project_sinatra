
  
require 'csv'

class Gossip
    attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  # sauvegarder une lige de donnée dans la BD
  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = [] 
  
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips 
  end
  
  
  # méthode pour trouver ID
  def self.find(id) 
    all_gossips = self.all
    return all_gossips[id]
  end

  # méthode pour modifier une ligne de donnée
  def self.update(new_author, new_content, id)
    all_gossips = self.all
    all_gossips[id].content = content
    all_gossips[id].author = author
    File.open("./db/gossip.csv", "w") {|file| file.truncate(0)}
    all_gossips.each do |gossip|
      gossip.save
    end
  end
end
