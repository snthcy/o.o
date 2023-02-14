{ config, pkgs, lib, ... }: {
	
	programs.git = {
		enable = true;
	
		aliases = {
			a = "add";
			b = "branch";
			c = "commit";
			ca = "commit --amend";
			cm = "commit -m";
			co = "checkout";
			d = "diff";
			ds = "diff --staged";
			p = "push";
			pl = "pull";
			forgor = "commit --amend --no-edit";
			graph = "log --all --decorate --graph --oneline";
			oops = "checkout --";
		};

    	ignores = ["node_modules"];
	};
}
