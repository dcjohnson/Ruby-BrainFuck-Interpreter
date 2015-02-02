module Interpreter
	class BrainFuckInterpreter
		def initialize()
			@byteArray = [0]
			@pointer = 0
			@instructionPointer = 0
			@rightBracketStack = []
		end

		def ProcessTokens(brainFuckString)
			while true
				case brainFuckString[@instructionPointer]
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
					ProcessRightBracket()
				when ']'
					ProcessLeftBracket()
				else
					raise TypeError
				end
				if @instructionPointer == brainFuckString.length - 1
					break
				end
				@instructionPointer += 1
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

		def MoveToLeftFacingBracket()
			tempPointer = @instructionPointer
			while tempByte = @byteArray[tempPointer]
				if tempByte.chr != ']'
					tempPointer += 1
					next
				end
				break
			end
			@instructionPointer = tempPointer
			@instructionPointer += 1
		end

		def ProcessRightBracket()
			if @byteArray[@pointer] == 0
				MoveToLeftFacingBracket()
			else
				@rightBracketStack << @instructionPointer
			end
		end

		def ProcessLeftBracket()
			if @byteArray[@pointer] != 0
				@instructionPointer = @rightBracketStack.last
			else
				@rightBracketStack.pop
			end
		end
	end
end
