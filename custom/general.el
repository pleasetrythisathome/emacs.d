;; appearance

(setq sml/no-confirm-load-theme t)
(load-theme 'zenburn t)
(require 'smart-mode-line)
(sml/setup)
(sml/apply-theme 'powerline)

(set-variable 'magit-emacsclient-executable "/usr/local/Cellar/emacs/HEAD/bin/emacsclient")

;; indentation

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq tab-width 2)
(setq c-basic-indent 2)
(setq c-basic-offset 2)
(setq js-indent-level 2)
(setq css-indent-level 2)
(setq css-indent-offset 2)

(setq js-indent-level 2)
(setq js2-always-indent-assigned-expr-in-decls-p t)
(setq js2-basic-offset 2)
(setq-default js2-basic-offset 2)
(setq js2-cleanup-whitespace t)
(setq js2-enter-indents-newline t)
(setq js2-highlight-external-variables nil)
(setq js2-indent-on-enter-key t)
(setq js2-mode-show-strict-warnings nil)
(setq js2-pretty-multiline-declarations (quote all))

;; autocomplete
(add-hook 'after-init-hook 'global-company-mode)

;; ffip
(setq ffip-limit 4096)
;; (setq ffip-patterns (append `("*.erb" "*.tpl" "*.php" "*.css" "*.ru" "*.json" "*.rb" "*.sass" "*.scss" "*.clj" "*.cljs") ffip-patterns))
(setq ffip-full-paths 1)

(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)
