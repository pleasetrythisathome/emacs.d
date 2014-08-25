;;
;; clojure-mode
;;
(require 'clojure-mode)
(require 'clojure-test-mode)
(require 'clojure-cheatsheet)
(require 'cljsbuild-mode)
(require 'typed-clojure-mode)

(require 'datomic-snippets)

;; (add-hook 'clojure-mode-hook
;;           (lambda ()
;;             (setq buffer-save-without-query t)
;;             (clojure-test-mode)))

(defun replacement-region (replacement)
  (compose-region (match-beginning 1) (match-end 1) replacement))

(setq auto-mode-alist (append '(("\\.cljs$" . clojure-mode)
                                ("\\.cljx$" . clojure-mode)
                                ("\\.edn$" . clojure-mode)
                                ("\\.dtm$" . clojure-mode))
                              auto-mode-alist))

(defun core-logic-config ()
  "Update the indentation rules for core.logic"
  (put-clojure-indent 'run* 'defun)
  (put-clojure-indent 'fresh 'defun)
  (put-clojure-indent 'conde 'defun))
(add-hook 'clojure-mode-hook 'core-logic-config)

;;
;; cider
;;
;; (require 'cider)
;; (require 'cider-decompile)
;; (require 'cider-tracing)

;; (add-hook 'clojure-mode-hook 'cider-mode)
;; (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; (setq nrepl-hide-special-buffers nil)
;; (setq cider-repl-pop-to-buffer-on-connect nil)

;; (setq cider-popup-stacktraces t)
;; (setq cider-repl-popup-stacktraces t)
;; (setq cider-auto-select-error-buffer t)

;; (setq cider-repl-print-length 100)
;; (setq cider-repl-history-file (expand-file-name "cider-history" user-emacs-directory))

;; (setq cider-repl-use-clojure-font-lock t)
;; (setq cider-switch-to-repl-command 'cider-switch-to-relevant-repl-buffer)

;; (add-to-list 'same-window-buffer-names "*cider*")

;; (add-hook 'cider-connected-hook 'cider-enable-on-existing-clojure-buffers)

;; using ac-nrepl-popup-doc for documentation
;; (require 'ac-nrepl)
;; (after 'cider
;;   (define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)
;;   (define-key cider-repl-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))

(defun cider-insert (fs)
  (save-some-buffers)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    (insert fs)
    (cider-repl-return)))

(defun cider-repl-reset ()
  (interactive)
  (cider-insert ":cljs/quit")
  (cider-insert "(user/reset)"))
(defun cider-brepl ()
  (interactive)
  (cider-insert "(user/browser-repl)"))
(defun cider-brepl-stop ()
  (interactive)
  (cider-insert ":cljs/quit"))

(global-set-key (kbd "C-c r") 'cider-repl-reset)
(global-set-key (kbd "C-c M-b") 'cider-brepl)
(global-set-key (kbd "C-c c") 'cider-brepl-stop)

;;
;; Kibit Mode
;;
(require 'kibit-mode)

;; (add-hook 'clojure-mode-hook
;;           (lambda () (when (buffer-file-name) (progn (kibit-mode) (flymake-mode-on)))))

;; Teach compile the syntax of the kibit output
(require 'compile)
(add-to-list 'compilation-error-regexp-alist-alist
             '(kibit "At \\([^:]+\\):\\([[:digit:]]+\\):" 1 2 nil 0))
(add-to-list 'compilation-error-regexp-alist 'kibit)

;; A convenient command to run "lein kibit" in the project to which
;; the current emacs buffer belongs to.
(defun kibit ()
  "Run kibit on the current project. Display the results in a hyperlinked *compilation* buffer."
  (interactive)
  (compile "lein kibit"))

;; (after 'kibit-mode
;;   ;; kibit mode overrides C-c C-n, which is needed for evaluating namespace forms
;;   (define-key kibit-mode-keymap (kbd "C-c C-n") nil))

;;
;; dependency management
;;
(require 'latest-clojure-libraries)

;; rainbow params
(global-rainbow-delimiters-mode)

(global-set-key (kbd "C-=") 'er/expand-region)
