GHC := ghc
BIN := ./book-bins
SRC := ./book-src
SRCS := $(shell fd --glob "*.hs" $(SRC))
EXES := $(patsubst $(SRC)/%.hs, $(BIN)/%, $(SRCS))
NEEDED_DIRS := $(foreach EXE,$(EXES), $(shell dirname $(EXE)))

all: $(EXES)

$(BIN)/%: $(SRCS)
	@mkdir -p $(BIN)
	mkdir -p $(NEEDED_DIRS)
	$(GHC) $< -o $@

clean:
	rm -rf $(BIN)
