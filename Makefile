BIN = $(GOPATH)/bin
APPBIN = $(shell basename `pwd`)

LDFLAG = '-s -w \
-X main.version=$(shell git describe --tags --always --dirty)'

all: build

clean:
	rm -f slap

build:
	go build -ldflags $(LDFLAG) -a -installsuffix nocgo -o slap *go

.PHONY: all clean build
