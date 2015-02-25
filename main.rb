require 'socket'
require 'json'
require './irc.rb'
require './config.rb'
require './logging.rb'

config = Configuration.new('config.json')
serverColor = '\e[37m'
botColor = '\e[90m'
cons = Array.new

#config.networks.length do |num|
#    cons.push(IRC.new(config.getNickname(num), config.getAddress(num)))
#end

#TODO: Add multiserver support (threads?)

con = IRC.new(config.getNickname(0), config.getAddress(0))

stillAlive = true

while stillAlive
    line = con.getData()
    log(line, config.networks[0]['label'], serverColor)
    if line.match('Looking up your hostname') then
        log('AUTHing to server', "BOT", botColor)
        con.sendRaw("NICK #{con.nick}")
        con.sendRaw("USER #{con.nick} 8 * : #{con.nick}")
    end
    if line.match('PING :') then
        pong = line.delete('PING :')
        con.sendPong(pong)
    end
    if line.match("#{con.nick} MODE #{con.nick}") then
        log('Found MODE line, connecting to channels')
        log("There are #{config.networks[0]['channel'].length} channels for me to connect to.")
        config.networks[0]['channel'].each do |chan|
            log("JOINING #{chan}", "BOT", botColor)
            con.sendJoin(chan)
        end
    end
end
    

