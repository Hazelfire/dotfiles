{ stdenv, fetchzip, kernel }:

stdenv.mkDerivation rec {
  pname = "v4l2loopback-dc";
  version = "0";

  src = fetchzip {
    url = "https://github.com/aramg/droidcam/archive/b49842a02611f8ddc6b9342ef74e299abd1c4090.zip";
    sha256 = "05kd5ihwb3fldmalv67jgpw4x0z0q39lfis69r7yh03qiqlviymk";
  };

  sourceRoot = "source/linux/v4l2loopback";

  KVER = "${kernel.modDirVersion}";
  KBUILD_DIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";

  nativeBuildInputs = kernel.moduleBuildDependencies;

  postPatch = ''
    sed -i -e 's:/lib/modules/`uname -r`/build:${KBUILD_DIR}:g' Makefile
  '';

  installPhase = ''
    mkdir -p $out/lib/modules/${KVER}/kernels/media/video
    cp v4l2loopback-dc.ko $out/lib/modules/${KVER}/kernels/media/video/
  '';

  meta = with stdenv.lib; {
    description = "DroidCam kernel module v4l2loopback-dc";
    homepage = https://github.com/aramg/droidcam;
  };
}
