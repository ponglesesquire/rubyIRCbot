require 'json'

class Configuration
	attr_reader :config
	attr_reader :networks

	def initialize(filepath)
		#TODO: Validate filepath
		@config = JSON.parse(File.read(filepath))
		@networks = @config['networks']
	end

	def getAddress(network, num=0)
		if @networks[network]['address'].is_a? String then
			return @networks[network]['address'];
		else
			unless @networks[network]['address'][num].nil?
				return @networks[network]['address'][num];
			else
				raise "Network #{network} does not have that many addresses"
			end
		end
	end

	def countAddress(network)
		if @networks[network]['address'].is_a? Array then
			return @networks[network]['address'].length
		else
			return 1;
		end
	end

	def getNetworkFromLabel(label)
		until i > @networks.length do
			if @networks[i]['label'] = label then
				return i
			end
		end
	end

	def getNickname(network, num=0)
		if @networks[network]['nickname'].is_a? String then
			return @networks[network]['nickname'];
		else
			unless @networks[network]['nickname'][num].nil?
				return @networks[network]['nickname'][num];
			else
				raise "Network #{network} does not have that many nicknames"
			end
		end
	end
end