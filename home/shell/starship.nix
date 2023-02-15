{ config, pkgs, lib, ... }: {

	programs.starship = {
		enable = true;
		enableZshIntegration = true;

		settings = {
			add_newline = false;
			line_break.disabled = true;
			
			format = "$directory$git_branch$git_metrics$git_commit$git_state$git_status$all";
		};
	};
}
