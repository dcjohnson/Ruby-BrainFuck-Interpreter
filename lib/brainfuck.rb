require "./input/input"
require "./interpreter/interpreter"

def Usage()
	usageString = "-t textual [file path] brainfuck file\n"
	usageString << "-i graphical [file path] brainfuck file\n"
	usageString << "-h help"
	return usageString
end

def Main()
	if ARGV.length != 2
		puts Usage()
	else
		if ARGV[0] == "-t"
			fileReader = Input::TextSourceFile.new(ARGV[1])
			brainfuckString = fileReader.ReadFile
			interpreter = Interpreter::BrainFuckInterpreter.new()
			interpreter.ProcessTokens(brainfuckString) do |output|
				puts output
			end
		elsif ARGV[0] == "-i"
			puts Usage()
		else
			puts Usage()
		end
	end
end

Main()
