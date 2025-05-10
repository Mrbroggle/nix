{ inputs, ... }:
{
  imports = [ (inputs.import-tree ../modules) ];
  kde6.enable = false;
}
