;; require the main file containing common functions
(require 'eval-in-repl)
y
;; Uncomment if no need to jump after evaluating current line
;; (setq eir-jump-after-eval nil)

;; Uncomment if you want to always split the script window into two.
;; This will just split the current script window into two without
;; disturbing other windows.
;; (setq eir-always-split-script-window t)

;; Uncomment if you always prefer the two-window layout.
;; (setq eir-delete-other-windows t)

;; Place REPL on the left of the script window when splitting.
(setq eir-repl-placement 'left)


;;; ielm support (for emacs lisp)
(require 'eval-in-repl-ielm)
;; Evaluate expression in the current buffer.
(setq eir-ielm-eval-in-current-buffer t)
;; for .el files
(define-key emacs-lisp-mode-map (kbd "<C-return>") 'eir-eval-in-ielm)
;; for *scratch*
(define-key lisp-interaction-mode-map (kbd "<C-return>") 'eir-eval-in-ielm)
;; for M-x info
(define-key Info-mode-map (kbd "<C-return>") 'eir-eval-in-ielm)

;;; cider support (for Clojure)
(require 'cider) ; if not done elsewhere
(require 'eval-in-repl-cider)
(define-key clojure-mode-map (kbd "<C-return>") 'eir-eval-in-cider)

;;; SLIME support (for Common Lisp)
(require 'slime) ; if not done elsewhere
(require 'eval-in-repl-slime)
(add-hook 'lisp-mode-hook
		  '(lambda ()
		     (local-set-key (kbd "<C-return>") 'eir-eval-in-slime)))

;;; Python support
(require 'python) ; if not done elsewhere
(require 'eval-in-repl-python)
(setq python-shell-interpreter "python3")
(add-hook 'python-mode-hook
          '(lambda ()
             (setq py-python-command "python3")))
(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "<C-return>") 'eir-eval-in-python)))

;;; Ruby support
;; (require 'ruby-mode) ; if not done elsewhere
;; (require 'inf-ruby)  ; if not done elsewhere
(require 'eval-in-repl-ruby)
(define-key ruby-mode-map (kbd "<C-return>") 'eir-eval-in-ruby)

;;(require 'js3-mode)  ; if not done elsewhere
(require 'js2-mode)  ; if not done elsewhere
;;(require 'js-comint) ; if not done elsewhere
(with-eval-after-load 'js2-mode
  (require 'eval-in-repl-javascript)
  (define-key js2-mode-map (kbd "<C-return>") 'eir-eval-in-javascript))

;; Shell support
(require 'eval-in-repl-shell)
(add-hook 'sh-mode-hook
          '(lambda()
             (local-set-key (kbd "C-<return>") 'eir-eval-in-shell)))
;; Version with opposite behavior to eir-jump-after-eval configuration
(defun eir-eval-in-shell2 ()
  "eval-in-repl for shell script (opposite behavior)

This version has the opposite behavior to the eir-jump-after-eval
configuration when invoked to evaluate a line."
  (interactive)
  (let ((eir-jump-after-eval (not eir-jump-after-eval)))
       (eir-eval-in-shell)))
(add-hook 'sh-mode-hook
          '(lambda()
             (local-set-key (kbd "C-M-<return>") 'eir-eval-in-shell2)))
