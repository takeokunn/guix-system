(define-public emacs-exwm
  (package
   (name "emacs-exwm")
   (version "0.26")
   (synopsis "Emacs X window manager")
   (source
    (origin
     (method url-fetch)
     (uri (string-append "https://elpa.gnu.org/packages/"
                         "exwm-" version ".tar"))
     (sha256
      (base32 "03pg0r8a5vb1wc5grmjgzql74p47fniv47x39gdll5s3cq0haf6q"))))
   (build-system emacs-build-system)
   (propagated-inputs
    (list emacs-xelb))
   (inputs
    (list xhost dbus))
   ;; The following functions and variables needed by emacs-exwm are
   ;; not included in emacs-minimal:
   ;; scroll-bar-mode, fringe-mode
   ;; x-display-pixel-width, x-display-pixel-height
   (arguments
    `(#:emacs ,emacs-native-comp
              #:phases
              (modify-phases %standard-phases
                             (add-after 'build 'install-xsession
                                        (lambda* (#:key inputs outputs #:allow-other-keys)
                                                 (let* ((out (assoc-ref outputs "out"))
                                                        (xsessions (string-append out "/share/xsessions"))
                                                        (bin (string-append out "/bin"))
                                                        (exwm-executable (string-append bin "/exwm")))
                                                   ;; Add a .desktop file to xsessions
                                                   (mkdir-p xsessions)
                                                   (mkdir-p bin)
                                                   (make-desktop-entry-file
                                                    (string-append xsessions "/exwm.desktop")
                                                    #:name ,name
                                                    #:comment ,synopsis
                                                    #:exec exwm-executable
                                                    #:try-exec exwm-executable)
                                                   ;; Add a shell wrapper to bin
                                                   (with-output-to-file exwm-executable
                                                     (lambda _
                                                       (format #t "#!~a ~@
                     ~a +SI:localuser:$USER ~@
                     exec ~a --exit-with-session ~a \"$@\" --eval '~s' ~%"
                                                               (search-input-file inputs "/bin/sh")
                                                               (search-input-file inputs "/bin/xhost")
                                                               (search-input-file inputs "/bin/dbus-launch")
                                                               (search-input-file inputs "/bin/emacs")
                                                               '(cond
                                                                 ((file-exists-p "~/.exwm")
                                                                  (load-file "~/.exwm"))
                                                                 ((not (featurep 'exwm))
                                                                  (require 'exwm)
                                                                  (require 'exwm-config)
                                                                  (exwm-config-default)
                                                                  (message (concat "exwm configuration not found. "
                                                                                   "Falling back to default configuration...")))))))
                                                   (chmod exwm-executable #o555)
                                                   #t))))))
   (home-page "https://github.com/ch11ng/exwm")
   (description
    "EXWM is a full-featured tiling X window manager for Emacs built on top of XELB.")
   (license license:gpl3+)))
