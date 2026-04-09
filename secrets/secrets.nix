let
  vitrial = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE1WkxFofllU2mntGEyWzbw72MPK2M463srP4lYezii4";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE1WkxFofllU2mntGEyWzbw72MPK2M463srP4lYezii4";
  users = [ vitrial ];
  systems = [ system ];
in
{
  "spotifyd.age".publicKeys = users ++ systems;
}
