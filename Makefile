all:
	docker build -t oldweather .
cli:
	docker run -it oldweather:latest /bin/bash
