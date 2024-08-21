default:
    @just --list

# Run hoogle
docs:
    echo http://127.0.0.1:8888
    hoogle serve -p 8888 --database=.local.hoo -v

# update hoogle
docs-build:
    hoogle generate --database=.local.hoo --local --download

# Run cabal repl
repl *ARGS:
    cabal repl {{ARGS}}

# Autoformat the project tree
fmt:
    treefmt

# Run ghcid -- auto-recompile and run `main` function
run:
    ghcid -c "cabal repl exe:haskell-template" --warnings -T :main
