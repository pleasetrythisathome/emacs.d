;;
;; clojure-mode
;;
(require 'clojure-mode)
(require 'cider-test)

(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(defun replacement-region (replacement)
  (compose-region (match-beginning 1) (match-end 1) replacement))

(setq auto-mode-alist (append '(("\\.cljs$" . clojure-mode)
                                ("\\.cljx$" . clojure-mode)
                                ("\\.boot$" . clojure-mode)
                                ("\\.edn$" . clojure-mode)
                                ("\\.dtm$" . clojure-mode))
                              auto-mode-alist))

(defun core-logic-config ()
  "Update the indentation rules for core.logic"
  (put-clojure-indent 'run* 'defun)
  (put-clojure-indent 'fresh 'defun)
  (put-clojure-indent 'conde 'defun))
(add-hook 'clojure-mode-hook 'core-logic-config)

(define-clojure-indent
  (defroutes 'defun)
  (fnk 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2))

(put 'implement 'clojure-backtracking-indent '(4 (2)))
(put 'letfn 'clojure-backtracking-indent '((2) 2))
(put 'proxy 'clojure-backtracking-indent '(4 4 (2)))
(put 'reify 'clojure-backtracking-indent '((2)))
(put 'deftype 'clojure-backtracking-indent '(4 4 (2)))
(put 'defrecord 'clojure-backtracking-indent '(4 4 (2)))
(put 'defprotocol 'clojure-backtracking-indent '(4 (2)))
(put 'extend-type 'clojure-backtracking-indent '(4 (2)))
(put 'extend-protocol 'clojure-backtracking-indent '(4 (2)))
(put 'specify 'clojure-backtracking-indent '(4 (2)))
(put 'specify! 'clojure-backtracking-indent '(4 (2)))

;;
;; cider
;;
(require 'cider)
;;(require 'cider-decompile)
;;(require 'cider-tracing)

(add-hook 'clojure-mode-hook 'cider-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

(setq nrepl-hide-special-buffers nil)
(setq cider-repl-pop-to-buffer-on-connect nil)

(setq cider-popup-stacktraces t)
(setq cider-repl-popup-stacktraces t)
(setq cider-auto-select-error-buffer t)

(setq cider-repl-print-length 100)
(setq cider-repl-history-file (expand-file-name "cider-history" user-emacs-directory))

(setq cider-repl-use-clojure-font-lock t)
(setq cider-switch-to-repl-command 'cider-switch-to-relevant-repl-buffer)

(add-to-list 'same-window-buffer-names "*cider*")

(add-hook 'cider-connected-hook 'cider-enable-on-existing-clojure-buffers)

(defun cider-insert (fs)
  (save-some-buffers)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    (insert fs)
    (cider-repl-return)))

(defun cider-repl-reset ()
  (interactive)
  (cider-insert "(reset)"))
(defun cider-brepl ()
  (interactive)
  (cider-insert "(start-repl)"))
(defun cider-brepl-stop ()
  (interactive)
  (cider-insert ":cljs/quit"))

(global-set-key (kbd "C-c r") 'cider-repl-reset)
(global-set-key (kbd "C-c M-b") 'cider-brepl)
(global-set-key (kbd "C-c c") 'cider-brepl-stop)

(global-set-key (kbd "C-=") 'er/expand-region)
