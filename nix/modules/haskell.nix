{ inputs, ... }:
{
  imports = [
    inputs.haskell-flake.flakeModule
  ];
  perSystem = { self', lib, config, pkgs, ... }: {
    # Our only Haskell project. You can have multiple projects, but this template
    # has only one.
    # See https://github.com/srid/haskell-flake/blob/master/example/flake.nix
    haskellProjects.default = {
      # To avoid unnecessary rebuilds, we filter projectRoot:
      # https://community.flake.parts/haskell-flake/local#rebuild
      projectRoot = builtins.toString (lib.fileset.toSource {
        root = ../..;
        fileset = lib.fileset.unions [
          ../../src
          ../../haskell-template.cabal
          ../../LICENSE
          ../../README.md
        ];
      });

      # # BUG: causes infinite recursion
      # basePackages = pkgs.haskellPackages.override (old: {
      #   overrides = lib.composeExtensions (old.overrides or (_: _: {})) (self: super:
      #     {
      #       ghc = super.ghc // { withPackages = super.ghc.withHoogle; };
      #       ghcWithPackages = self.ghc.withPackages;
      #     }
      #   );
      # });

      # Packages to add on top of `basePackages`
      packages = {
        # Add source or Hackage overrides here
        # (Local packages are added automatically)
        /*
        aeson.source = "1.5.0.0" # Hackage version
        shower.source = inputs.shower; # Flake input
        */
      };

      # Add your package overrides here
      settings = {
        /*
        haskell-template = {
          haddock = false;
        };
        aeson = {
          check = false;
        };
        */
      };

      # Development shell configuration
      devShell = {
        hlsCheck.enable = false;
        hoogle = true;
        benchmark = true;
        mkShellArgs = {
          shellHook = ''
                # Re-generate .cabal files so HLS will work (per hie.yaml)
                ${pkgs.findutils}/bin/find -name package.yaml -exec hpack {} \;
              '';
        };
      };

      # What should haskell-flake add to flake outputs?
      autoWire = [ "packages" "apps" "checks" ]; # Wire all but the devShell
    };

    # Default package & app.
    packages.default = self'.packages.haskell-template;
    apps.default = self'.apps.haskell-template;
  };
}
