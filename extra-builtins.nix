# extra-builtins.nix
{ exec, ... }: 
let
  passwords = 
    builtins.fetchGit {                                                         
      url = "git@github.com:Hazelfire/passwords.git";                           
      ref = "main";                                                           
      rev = "e79c37032d2032849f14c365637006db97ea9c2a";                         
    };
in
{
  pass = name: exec [./nix-pass.sh "${passwords}" name];
}

