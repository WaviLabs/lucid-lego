{ mkDerivation, base, lucid, stdenv, text }:
mkDerivation {
  pname = "lucid-lego";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base lucid text ];
  executableHaskellDepends = [ base lucid text ];
  testHaskellDepends = [ base lucid text ];
  homepage = "https://github.com/githubuser/lucid-lego#readme";
  license = stdenv.lib.licenses.bsd3;
}
