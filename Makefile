
build:
	docker build -t myapp .

build_no_cache:
	docker build -f nocache.dockerfile -t myapp .

run: build
	docker run -it --rm myapp