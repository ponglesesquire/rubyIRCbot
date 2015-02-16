#File for the IRC class
require 'socket'

#module PingBot

class IrcCon
	#Initalization and connection functions
	def initialize(nick, host, port=6667, pass=nil, verbose = false)
		@host = host
		@port = port
		@nick = nick
		unless pass.nil? then
			@pass = pass
			@needPass = true
		else
			@pass = nil
			@needPass = false
		end
		verbose = false ? @verbose = false : @verbose = true

		@con = openConnection()
	end

	def openConnection()
		typeCheck(@host, String)
		typeCheck(@port, Fixnum)
		verbose?('Starting Connection')
		return TCPSocket.new(@host, @port)
	end

	def closeConnection(quitMessage = nil)
		verbose?('Closing Connection')
		quitMessage.nil? ? sendQuit('Bot shutting down, goodbye.') : sendQuit(quitMessage)
		return @con.close()
	end

	#Command functions
	def sendRaw(rawMsg)
		@con.puts rawMsg
	end

	def sendMessage(to, msg)
		raw = "PRIVMSG #{to} :#{msg}"
		sendRaw(raw)
	end

	def sendPong(str)
		raw = "PONG #{str}"
		sendRaw(raw)	
	end

	def sendJoin(channel)
		raw = "JOIN #{channel}"
		sendRaw(raw)
	end

	def sendPart(channel)
		raw = "PART #{channel}"
		sendRaw(raw)
	end

	def sendQuit(str)
		raw = "QUIT :#{str}"
		sendRaw(raw)
	end

	#utlity functions
	def shout(str)
		return str.to_s.upcase
	end

	def typeCheck(var, type)
		unless (var.class == type) then raise "Expected type '#{type._to_s.upcase!}' for parameter host, got type '#{var.class.upcase!}' instead." end
		return true
	end

	def verbose?(str)
		puts str
	end

end

#end
