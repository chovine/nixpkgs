{ lib, stdenv, fetchurl, jre, makeWrapper }:

let version = "2.7.1"; in

stdenv.mkDerivation {
  pname = "logisim";
  inherit version;

  src = fetchurl {
    url = "mirror://sourceforge/project/circuit/2.7.x/${version}/logisim-generic-${version}.jar";
    sha256 = "1hkvc9zc7qmvjbl9579p84hw3n8wl3275246xlzj136i5b0phain";
  };

  dontUnpack = true;

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    mkdir -pv $out/bin
    makeWrapper ${jre}/bin/java $out/bin/logisim --add-flags "-jar $src"
  '';

  meta = {
    homepage = "http://ozark.hendrix.edu/~burch/logisim";
    description = "Educational tool for designing and simulating digital logic circuits";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.unix;
  };
}
