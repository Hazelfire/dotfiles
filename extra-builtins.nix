# extra-builtins.nix
{ exec, ... }: 
let
  passwords = 
    builtins.fetchGit {                                                         
      url = "git@github.com:Hazelfire/passwords.git";                           
      ref = "main";                                                           
      rev = "6e18dd56cda4f8a411198086187be3faa92a6be9";                         
    };
in
{
  pass = name: exec [./nix-pass.sh "${passwords}" name];
}

