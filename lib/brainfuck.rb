require "./input/input"
require "./interpreter/interpreter"

def Usage()
	usageString = "[file path] brainfuck file\n"
	return usageString
end

def Main()
	if ARGV.length != 1
		puts Usage()
	else
		fileReader = Input::TextSourceFile.new(ARGV[0])
		brainfuckString = fileReader.ReadFile
		interpreter = Interpreter::BrainFuckInterpreter.new(brainfuckString)
		interpreter.ProcessTokens() do |output|
			print output
		end
	end
end

Main()
