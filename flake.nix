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
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.2.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
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
    sops-nix,
    lanzaboote,
    ...
  }:
  let
    system = "x86_64-linux";
    sys = hostname: ./host/${hostname}/system.nix;
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
    nixosConfigurations.buni = nixpkgs.lib.nixosSystem (
      let
        user = "noelle";
        hostname = "buni";
      in
      {
        inherit system;

        modules = [
          inputs.impermanence.nixosModules.impermanence
          inputs.agenix.nixosModules.default
          sops-nix.nixosModules.sops
          inputs.disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          lanzaboote.nixosModules.lanzaboote
          hmSettings
          (sys hostname)
        ];
        specialArgs = args {
          inherit hostname;
          inherit user;
        };
      }
    );

    nixosConfigurations.laptob = nixpkgs.lib.nixosSystem (
      let
        user = "noelle";
        hostname = "laptob";
      in
      {
        inherit system;

        modules = [
          inputs.impermanence.nixosModules.impermanence
          inputs.agenix.nixosModules.default
          sops-nix.nixosModules.sops
          inputs.disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          lanzaboote.nixosModules.lanzaboote
          hmSettings
          (sys hostname)
        ];
        specialArgs = args {
          inherit hostname;
          inherit user;
        };
      }
    );

    nixosConfigurations.kibity = nixpkgs.lib.nixosSystem (
      let
        user = "noelle";
        hostname = "kibity";
      in
      {
        inherit system;

        modules = [
          inputs.impermanence.nixosModules.impermanence
          inputs.agenix.nixosModules.default
          sops-nix.nixosModules.sops
          inputs.disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          lanzaboote.nixosModules.lanzaboote
          hmSettings
          (sys hostname)
        ];
        specialArgs = args {
          inherit hostname;
          inherit user;
        };
      }
    );

    nixosConfigurations.iso = nixpkgs.lib.nixosSystem (
      let
        user = "nixos";
        hostname = "iso";
      in
      {
        inherit system;

        modules = [
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

