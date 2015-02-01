module Interpreter
	def self.ProcessTokens(brainFuckString)
		brainFuckString.each_char do |token|
			case token
			when '>'
				yield '>'
			when '<'
				yield '<'
			when '+'
				yield '+'
			when '-'
				yield '-'
			when '.'
				yield '.'
			when '.'
				yield '.'
			when '['
				yield '['
			when ']'
				yield ']'
			end
		end
	end
end
