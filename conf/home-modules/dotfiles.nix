{ config, lib, ... }: {
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles.d/nvim;
    };
    ".config/hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles.d/hypr;
    };
    ".config/matugen" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles.d/matugen;
    };
  };
}
