{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
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
#          ./host/g14-nixos/noa.nix
          hmSettings
          home-manager.nixosModules.home-manager

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

