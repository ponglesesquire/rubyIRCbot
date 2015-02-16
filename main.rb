require 'socket'
require 'irc.rb'

bot = IRC.new('PingBot', 'irc.durd.net')


while line = bot.getData()
	puts line
	if !line.match('NOTICE AUTH').nil? then
		bot.sendRaw("NICK #{bot.nick}")
		bot.sendRaw("USER #{bot.nick} 8 * : #{bot.nick}")
	end
	if !line.match('PING :').nil? then
		pong = line.delete('PING :')
		bot.sendPong(pong)
	end
	if !line.match("#{bot.nick} MODE #{bot.nick}") then
		bot.sendJoin("#gmc")
	end
end


