let
  personal_key = "ssh-rsa AAAA....";
  remote_server_key = "ssh-rsa AAAA....";
  keys = [personal_key remote_server_key];
in {
  "guest_accounts.json.age".publicKeys = keys;
}
