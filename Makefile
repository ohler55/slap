BIN = $(GOPATH)/bin
APPBIN = $(shell basename `pwd`)

LDFLAG = '-s -w \
-X main.version=$(shell git describe --tags --always --dirty)'

all: build

clean:
	rm -f slap
	make -C slapper clean

build:
	go build -ldflags $(LDFLAG) -a -installsuffix nocgo -o slap *go
	make -C slapper

.PHONY: all clean build
