with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "hactoolnet";

  buildInputs = [
    autoPatchelfHook
    makeWrapper
    gcc.cc
    zlib
  ];

  src = fetchzip {
    url = "https://github.com/Thealexbarney/LibHac/releases/download/v0.19.0/hactoolnet-0.19.0-linux.zip";
    sha256 = "njlIFsAjyKErYatbP+3fmjP5dv3DhJ7G1+KvC2ZPdso=";
  };

  installPhase = ''
    mkdir -p $out/bin
    chmod +x hactoolnet
    cp hactoolnet $out/bin/
    wrapProgram $out/bin/hactoolnet --set DOTNET_SYSTEM_GLOBALIZATION_INVARIANT 1 --set LD_LIBRARY_PATH ${lib.makeLibraryPath [ openssl ]}
  '';
}


