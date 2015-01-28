(require 'color-theme)
(load-theme 'zenburn t)

(set-variable 'magit-emacsclient-executable "/usr/local/Cellar/emacs/HEAD/bin/emacsclient")

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

;; ffip
(setq ffip-limit 4096)
(setq ffip-patterns (append `("*.erb" "*.tpl" "*.php" "*.css" "*.ru" "*.json" "*.rb" "*.sass" "*.scss" "*.clj" "*.cljs") ffip-patterns))
(setq ffip-full-paths 1)

(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

(require 'ack-and-a-half)
;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

(defun split-window-vertical (&optional number)
  "Split the current window into `number' windows"
  (interactive "P")
  (setq number (if number
                   (prefix-numeric-value number)
                 2))
  (while (> number 1)
    (split-window-right)
    (setq number (- number 1)))
  (balance-windows))

(global-set-key (kbd "C-x C-3") 'split-window-vertical)
