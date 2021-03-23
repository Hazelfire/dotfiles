# extra-builtins.nix
{ exec, ... }: 
let
  passwords = 
    builtins.fetchGit {                                                         
      url = "git@github.com:Hazelfire/passwords.git";                           
      ref = "main";                                                           
      rev = "380bbec04fb0084717ef5420b77ce35ca16a39e0";                         
    };
in
{
  pass = name: exec [./nix-pass.sh "${passwords}" name];
}

