{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  [
    ckb-next
  ];
}