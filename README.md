# Docker image with AStyle V3.1

## To Build

	docker build --no-cache ..\docker_astyle_v3_1 -t astyle_v3_1


## To Run

	Windows CMD
  
		docker run -it -v %cd%:/data astyle_v3_1 --options=/data/stylefile.astyle /data/src/*.c /data/src/*.h

	where:
		stylefile.astyle  is the name of your style file (in the example assumed to be in the current directory)
		src               is the folder where the source files are located (relative to the current directory)
	
	If the --option=filename is not provided then a style file within the container is used which has:

		--formatted
		--recursive
		--style=allman
		--indent=tab=8
		--indent-switches
		--break-blocks
		--align-pointer=type
		--add-braces
		--attach-closing-while
		--lineend=windows
		--suffix=none	

## Notes
	The docker build file amends AStyle source file astyle_main.cpp to also #include <limits.h>
	If the file is not amended, the source file does not compile due to PATH_MAX not being available.
	
## Testing with a small file set:

	0.22 secs     Windows 10 CMD
	2.46 secs     Docker running on Windows 10
	
## Testing with a large file set

	29.28 secs   Windows 10 CMD
	78.22 secs   Docker running on Windows 10
	
        which might suggest a ~1sec Docker startup time, and ~2.5x increase per file
