require 'net/http'
require 'clap'

module CLI
  class << self
    attr_accessor :home_team
    attr_accessor :away_team
  end
end

class Scraper
  def self.run(home_team, away_team)
    url = 'http://www.livescore.com/'
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    data  = xml_data.match(/<td class="fh">\s(#{home_team})\s<\/td>.*(\d+) - (\d+).*<td class="fa">\s(#{away_team})\s<\/td>/)
    p "#{data[1]} #{data[2]} - #{data[3]} #{data[4]}" if data
  end

end

Clap.run ARGV,
  "-h" => CLI.method(:home_team=),
  "-a" => CLI.method(:away_team=)

Scraper.run(CLI.home_team, CLI.away_team)
