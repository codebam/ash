{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
            cargo
            vulkan-loader
        ];
      LD_LIBRARY_PATH="${pkgs.wayland}/lib:${pkgs.libxkbcommon}/lib:${pkgs.vulkan-loader}/lib:${pkgs.vulkan-validation-layers}/lib";
      VK_LAYER_PATH = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
      };
    }
  );
}
