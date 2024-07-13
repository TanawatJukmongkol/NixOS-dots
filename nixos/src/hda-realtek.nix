{
  stdenv,
  kernel,
  ...
}:

let
  modPath = "sound/pci/hda";
  modDestDir = "$out/lib/modules/${kernel.modDirVersion}/kernel/${modPath}";

in stdenv.mkDerivation {
  name = "realtek-${kernel.version}";

  inherit (kernel) src version;

  postPatch = ''
    cd ${modPath}
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = kernel.makeFlags ++ [
    "-C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "M=$(PWD)"
    "modules"
  ];

  enableParallelBuilding = true;

  installPhase = ''
    runHook preInstall

    mkdir -p ${modDestDir}
    find . -name '*.ko' -exec cp --parents '{}' ${modDestDir} \;
    find ${modDestDir} -name '*.ko' -exec xz -f '{}' \;

    runHook postInstall
  '';

  meta = {
    description = "HP Transcend 16-uxxx Realtek HDA drivers";
    inherit (kernel.meta) license platforms;
  };
}

