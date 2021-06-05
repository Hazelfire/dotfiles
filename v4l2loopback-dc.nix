{ stdenv, fetchFromGitHub, kernel }:

stdenv.mkDerivation rec {
  pname = "v4l2loopback-dc";
  version = "0";

  src = fetchFromGitHub {
    owner = "aramg";
    repo = "droidcam";
    rev = "v1.7.3";
    sha256 = "1rgi3if3v0hksvh6kpyqmwl8f4gk6sa09pwcinq6gklj0wkhakrs";
  };

  sourceRoot = "source/v4l2loopback";

  KVER = "${kernel.modDirVersion}";
  KBUILD_DIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ] ;

  installPhase = ''
    mkdir -p $out/lib/modules/${KVER}/kernels/media/video
    cp v4l2loopback-dc.ko $out/lib/modules/${KVER}/kernels/media/video/
  '';

  meta = with stdenv.lib; {
    description = "DroidCam kernel module v4l2loopback-dc";
    homepage = https://github.com/aramg/droidcam;
  };
}
