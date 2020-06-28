{ mkDerivation, base, dhall, lucid, stdenv, text }:
mkDerivation {
  pname = "lucid-lego";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base dhall lucid text ];
  executableHaskellDepends = [ base dhall lucid text ];
  testHaskellDepends = [ base dhall lucid text ];
  homepage = "https://github.com/githubuser/lucid-lego#readme";
  license = stdenv.lib.licenses.bsd3;
}
