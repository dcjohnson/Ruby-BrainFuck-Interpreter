module Input
	class TextSourceFile
		def initialize(filePath)
			@filePath = filePath
		end

		def Path()
			puts @filePath
		end

		def NewPath(newPath)
			@filePath = newPath
		end

		def ReadFile()
			file = File.new(@filePath, "r")
			code = String.new()
			while line = file.gets
				code << line.strip
			end
			return code
		end
	end
end
