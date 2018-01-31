;; User pack init file
;;
;; Use this file to initiate the pack configuration.
;; See README for more information.


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'cask "/usr/local/Cellar/cask/0.7.2_1/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(add-to-list 'load-path "~/.emacs.d/lib")
(add-to-list 'load-path "~/.emacs.d/custom")
(load "general.el")
;; (load "clojure-repls.el")
(load "clojure.el")
(load "paredit-conf.el")
;; (load "prodigy.el")
(load "web.el")
(load "bindings.el")
(load "highlight.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("e56f1b1c1daec5dbddc50abd00fcd00f6ce4079f4a7f66052cf16d96412a09a9" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" default)))
 '(package-selected-packages
   (quote
    (zenburn-theme yaml-mode undo-tree typed-clojure-mode tagedit smex smartparens smart-mode-line-powerline-theme servant scss-mode scratch rvm request rainbow-mode rainbow-delimiters pt projectile project-explorer prodigy popup pallet noflet nodejs-repl nginx-mode neotree mode-compile markdown-mode magit less-css-mode latest-clojure-libraries jsx-mode js2-mode inf-ruby ido-vertical-mode ido-ubiquitous httprepl htmlize haml-mode google go-mode gist flymake-jshint flymake-cursor flx-ido find-file-in-project expand-region exec-path-from-shell eval-sexp-fu dockerfile-mode dash-functional dash-at-point company color-theme clojure-quick-repls clojure-mode-extra-font-locking clj-refactor browse-kill-ring bm ag ack-and-a-half ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
