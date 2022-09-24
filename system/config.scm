;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu)
             (nongnu packages linux)
             (nongnu system linux-initrd))

(use-service-modules cups
                     desktop
                     networking
                     ssh
                     xorg
                     docker
                     pm
                     sound
                     virtualization)

(operating-system (kernel linux)
                  (initrd microcode-initrd)
                  (firmware (list linux-firmware))
                  (locale "en_US.utf8")
                  (timezone "Asia/Tokyo")
                  (keyboard-layout
                   (keyboard-layout
                    "jp,us"
                    #:options
                    '("ctrl:nocaps")))
                  (host-name "takepc")
                  (users (cons* (user-account
                                 (name "take")
                                 (comment "take")
                                 (group "users")
                                 (home-directory "/home/take")
                                 (supplementary-groups '("wheel" "netdev" "kvm" "tty" "input" "lp" "audio" "video" "libvirt" "docker")))
                                %base-user-accounts))
                  (packages
                   (append
                    (list (specification->package "emacs")
                          (specification->package "emacs-exwm")
                          (specification->package "emacs-desktop-environment")
                          (specification->package "nss-certs")
                          (specification->package "alsa-utils")
                          (specification->package "pulseaudio"))
                    %base-packages))
                  (services
                   (append
                    (list
                     (service docker-service-type)
                     (service libvirt-service-type
                              (libvirt-configuration
                               (unix-sock-group "libvirt")))
                     (service tor-service-type)
                     (service tlp-service-type
                              (tlp-configuration
                               (cpu-scaling-governor-on-ac (list "performance"))
                               (cpu-scaling-governor-on-bat (list "disabled")) ;; disabled or performance
                               (cpu-boost-on-ac? #t)
                               (cpu-boost-on-bat? #f) ;; #f or #t
                               (sched-powersave-on-ac? #f)
                               (sched-powersave-on-bat? #t) ;; #f or #t
                               (energy-perf-policy-on-ac "performance")
                               (energy-perf-policy-on-bat "disabled") ;; disabled or performance
                               (sata-linkpwr-on-ac "max_erformance")
                               (sata-linkpwr-on-bat "min_erformance") ;; max_erformance or min_erformance
                               (pcie-aspm-on-ac "performance")
                               (pcie-aspm-on-bat "powersavef") ;; performance or powersave
                               (wifi-pwr-on-ac? #f)
                               (wifi-pwr-on-bat? #t) ;; #f or #t
                               (sound-power-save-on-ac 0)
                               (sound-power-save-on-bat 1) ;; 0 or 1
                               (runtime-pm-on-ac "on")
                               (runtime-pm-on-bat "off"))) ;; on or off
                     (set-xorg-configuration
                      (xorg-configuration
                       (keyboard-layout keyboard-layout))))
                    %desktop-services))
                  (bootloader
                   (bootloader-configuration
                    (bootloader grub-efi-bootloader)
                    (targets (list "/boot/efi"))
                    (keyboard-layout keyboard-layout)))
                  (mapped-devices
                   (list (mapped-device
                          (source
                           (uuid "6592d04a-e5bd-4dfe-982d-6c438496ef85"))
                          (target "cryptroot")
                          (type luks-device-mapping))))
                  (file-systems
                   (cons* (file-system
                           (mount-point "/boot/efi")
                           (device (uuid "9466-47F4" 'fat32))
                           (type "vfat"))
                          (file-system
                           (mount-point "/")
                           (device "/dev/mapper/cryptroot")
                           (type "ext4")
                           (dependencies mapped-devices))
                          %base-file-systems)))
