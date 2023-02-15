{pkgs, ...}: {

    fonts = {
        fonts = lib.attrValues {
            inherit (pkgs) 
                # fonts will go here
                nerdfonts = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; }
        };

        fontconfig = {
            enable = true;

            defaultFonts = {
                monospace = "Fira Code";
            }
        };
    }
}