{ pkgs, ... }:

let
  nxGameInfoSrc = (pkgs.fetchFromGitHub {
    repo = "NX_Game_Info";
    owner = "garoxas";
    rev = "eeff075f616578af67ca760b3095bb8473eb0e2c";
    sha256 = "sz3NMuNS1rDbbm6HZ45hU3PIA5hytvicn1YDgs+oFQ4=";
    fetchSubmodules = true;
  }).overrideAttrs (_: {
    GIT_CONFIG_COUNT = 1;
    GIT_CONFIG_KEY_0 = "url.https://github.com/.insteadOf";
    GIT_CONFIG_VALUE_0 = "git@github.com:";
  });
in {
  packages = [ 
    pkgs.git
    pkgs.msbuild
  ];

  scripts.compile_nx_game_info.exec = ''
    cp -rf ${nxGameInfoSrc} nx_game_info_src
    chmod -R +rw nx_game_info_src
    cd nx_game_info_src
    msbuild /restore /p:RestorePackagesConfig=true /property:Configuration=Release cli.sln
    cp -rf cli/bin/Release ../nx_game_info
    cd ..
    rm -rf nx_game_info_src
  '';
}
