{ config, pkgs, lib, ... }: {

	programs.zsh = {
		enable = true;
		enableAutosuggestions = true;

		dirHashes = {
			dl = "$HOME/Downloads";
			docs = "$HOME/Documents";
			code = "$HOME/Documents/code";
			dots = "$HOME/dots";
			pics = "$HOME/Pictures";
		};

		dotDir = ".config/zsh";
		initExtra = "eval "$(starship init zsh)"";

		shellAliases = {
			".." = "cd ..";
			"..." = "cd ...";
			grep = "ripgrep";
			ls = "exa -l";
			la = "exa -la";
		};
	};
}
