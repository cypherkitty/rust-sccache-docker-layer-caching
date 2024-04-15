
build:
	docker build -t myapp .

run: build
	docker run -it --rm myapp