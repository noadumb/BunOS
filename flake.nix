{
  description = "noelle's silly hyperfixation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-pkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{
    self,
    nixpkgs,
    home-manager,
    agenix,
      ...
  }:
  let
    system = "x86_64-linux";
    sys = hostname: ./host/${hostname}/system.nix;
#    pkgs = import nixpkgs {
#      inherit system;
#	    config.allowUnfree = true;
#    };
    lib = nixpkgs.lib;

    args =
      { hostname, user }:
      {
        inherit self;
        inherit inputs;
        inherit system;
        inherit user;
        inherit hostname;
      };
      hmSettings =
        {
          self,
          user,
          hostname,
          system,
          inputs,
          ...
        }:
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";
          home-manager.sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];
          home-manager.users.${user} = import ./host/${hostname}/${user}.nix;
          #home-manager.users.noa = import ./home.nix;            //delete
          home-manager.extraSpecialArgs = {
            inherit self;
            inherit system;
            inherit hostname;
            inherit user;
            inherit inputs;
          };
        };
  in
  {
    nixosConfigurations.g14-nixos = nixpkgs.lib.nixosSystem (
      let
        user = "noa";
        hostname = "g14-nixos";
      in
      {
        inherit system;

        modules = [
          inputs.impermanence.nixosModules.impermanence
          inputs.agenix.nixosModules.default
          inputs.disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          hmSettings
          (sys hostname)
        ];
        specialArgs = args {
          inherit hostname;
          inherit user;
        };
      }
    );
  };
}

