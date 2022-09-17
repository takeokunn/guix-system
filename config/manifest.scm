;; This "manifest" file can be passed to 'guix package -m' to reproduce
;; the content of your profile.  This is "symbolic": it only specifies
;; package names.  To reproduce the exact same profile, you also need to
;; capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.


(specifications->manifest
 '(
   ;; for build essensial
   "autoconf"
   "automake"
   "bison"
   "cmake"
   "gcc"
   "gcc-toolchain"
   "libiconv"
   "make"
   "oniguruma"
   "re2c"
   "unzip"

   ;; for gpg
   "gnupg"
   "pinentry"
   "pinentry-tty"

   ;; for git
   "git"
   "ghq"

   ;; for search
   "the-silver-searcher"
   "ripgrep"

   ;; for keyboard
   "xmodmap"

   ;; for volue
   "bluez-alsa"
   "pavucontrol"

   ;; for utility
   "curl"
   "direnv"
   "ffmpeg"
   "graphviz"
   "jq"
   "nkf"
   "openssh"

   ;; for develop
   "editorconfig-core-c"
   "docker"
   "mysql"

   ;; for language
   "go"
   "node-latest"
   "ruby"
   "rust"
   "php-latest"

   ;; for font
   "font-dejavu"
   "font-google-noto"
   "font-gnu-freefont"
   "font-adobe-source-han-sans"

   ;; for application
   "firefox"
   "gimp"
   "nyxt"
   "wireshark"))
