(use-modules (guix packages))

(packages->manifest
 (list
  ;;; Essensial tools
  (specification->package "clang")
  (specification->package "cmake")
  (specification->package "gcc-toolchain")
  (specification->package "git")
  (specification->package "make")
  (specification->package "unzip")))
