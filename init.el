;; User pack init file
;;
;; Use this file to initiate the pack configuration.
;; See README for more information.

(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/lib/themes/")
(add-to-list 'load-path "~/.emacs.d/config")

(load "general.el")
(load "clojure.el")
(load "prodigy.el")
(load "web.el")
(load "bindings.el")
