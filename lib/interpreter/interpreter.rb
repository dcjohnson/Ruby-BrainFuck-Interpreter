module Interpreter
	class BrainFuckInterpreter
		def initialize()
			@byteArray = [0]
			@pointer = 0
		end

		def ProcessTokens(brainFuckString)
			brainFuckString.each_char do |token|
				case token
				when '>'
					IncrementPointer()
				when '<'
					DecrementPointer()
				when '+'
					IncrementPointerLocation()
				when '-'
					DecrementPointerLocation()
				when '.'
					yield GetPointerLocation()
				when ','
					GetByte()
				when '['
					yield '['
				when ']'
					yield ']'
				else
					raise TypeError
				end
			end
		end

		def IncrementPointer()
			if @pointer == @byteArray.length - 1
				@byteArray << 0
			end
			@pointer += 1
		end

		def DecrementPointer()
			if @pointer == 0
				raise IndexError
			else
				@pointer -= 1
			end
		end

		def IncrementPointerLocation()
			@byteArray[@pointer] += 1
		end

		def DecrementPointerLocation()
			@byteArray[@pointer] -= 1
		end

		def GetPointerLocation()
			pointerLocation = @byteArray[@pointer].chr
			return pointerLocation
		end

		def GetByte()
			input = STDIN.gets
			@byteArray[@pointer] = input.ord
		end
	end
end
