(require 'package)
(package-initialize)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(defvar packages
  '(ac-cider
    ack-and-a-half
    auto-complete
    bm
    cider
    cljsbuild-mode
    clojure-cheatsheet
    clojure-mode
    clojure-snippets
    clojure-test-mode
    color-theme
    color-theme-solarized
    ctable
    dash
    dash-functional
    datomic-snippets
    deft
    epl
    ess
    ess-R-data-view
    ess-R-object-popup
    expand-region
    f
    floobits
    flx
    flx-ido
    flycheck
    flymake
    flymake-jshint
    flymake-cursor
    git-commit-mode
    git-rebase-mode
    gist
    haml-mode
    helm
    highlight
    javap-mode
    js2-mode
    jsx-mode
    kibit-mode
    latest-clojure-libraries
    magit
    markdown-mode
    multiple-cursors
    package+
    pkg-info
    popup
    prodigy
    pt
    rainbow-delimiters
    rainbow-mode
    rvm
    s
    sass-mode
    scss-mode
    simple-httpd
    skewer-mode
    sublimity
    typed-clojure-mode
    yasnippet
    zenburn-theme)
  "A list of packages to ensure are installed at launch.")

(defun packages-installed-p ()
  (loop for p in packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'packages)
