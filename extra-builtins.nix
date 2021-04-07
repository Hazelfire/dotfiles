# extra-builtins.nix
{ exec, ... }: 
let
  passwords = 
    builtins.fetchGit {                                                         
      url = "git@github.com:Hazelfire/passwords.git";                           
      ref = "main";                                                           
      rev = "63589a2b500a308375fe37c1ca57acd810fc0f90";                         
    };
in
{
  pass = name: exec [./nix-pass.sh "${passwords}" name];
}

