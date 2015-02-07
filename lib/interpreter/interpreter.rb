module Interpreter
	class BrainFuckInterpreter
		def initialize(brainFuckString)
			@byteArray = [0]
			@rightBracketStack = []
			@pointer = 0
			@instructionPointer = 0
			@brainFuckString = brainFuckString
		end

		def SetConstants()
			@byteArray = [0]
			@rightBracketStack = []
			@pointer = 0
			@instructionPointer = 0
		end

		def ProcessTokens()
			SetConstants()
			loop do
				case @brainFuckString[@instructionPointer]
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
				end
				if @instructionPointer == @brainFuckString.length - 1
					break
				end
				@instructionPointer += 1
			end
		end

		private

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

		def GetLeftFacingBracket()
			tempPointer = @instructionPointer + 1
			leftBracketCount = 0
			loop do
				if @brainFuckString[tempPointer] == '['
					leftBracketCount += 1
				elsif leftBracketCount > 0
					if @brainFuckString[tempPointer] == ']'
						leftBracketCount -= 1
					end
				end
				tempPointer += 1
				if leftBracketCount == 0 && @brainFuckString[tempPointer] == ']'
					break
				end
			end
			return tempPointer
		end

		def ProcessRightBracket()
			if @byteArray[@pointer] == 0
				@instructionPointer = GetLeftFacingBracket()
			else
				@rightBracketStack << @instructionPointer
			end
		end

		def ProcessLeftBracket()
			if @byteArray[@pointer] == 0
				@rightBracketStack.pop
			else
				@instructionPointer = @rightBracketStack.last
			end
		end
	end
end
