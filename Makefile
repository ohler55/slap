BIN = $(GOPATH)/bin
APPBIN = $(shell basename `pwd`)

LDFLAG = '-s -w \
-X main.version=$(shell git describe --tags --always --dirty)'

all: build

clean:
	rm -f slap
	make -C slapr clean

build:
	go build -ldflags $(LDFLAG) -a -installsuffix nocgo -o slap *go
	make -C slapr

docker:
	make -C docker build

.PHONY: all clean build docker
