# extra-builtins.nix
{ exec, ... }: 
let
  passwords = 
    builtins.fetchGit {                                                         
      url = "git@github.com:Hazelfire/passwords.git";                           
      ref = "main";                                                           
      rev = "1a64301afe24ae1906c39bf67e9b30362183fcaa";
    };
in
{
  pass = name: exec [./nix-pass.sh "${passwords}" name];
}

