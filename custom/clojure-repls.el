;;; clojure-repls.el --- Assign repls for clj and cljs eval

;; Copyright (C) 2015 Dylan Butman

(require 'cider)
(require 'dash)

(defvar clojure-repls-clj-con-buf nil)
(defvar clojure-repls-cljs-con-buf nil)

(defun clojure-repls-clear-con-bufs ()
  (setq clojure-repls-clj-con-buf nil)
  (setq clojure-repls-cljs-con-buf nil))

(add-hook 'nrepl-disconnected-hook #'clojure-repls-clear-con-bufs)

(defun clojure-repls-set-clj-buffer ()
  (interactive)
  (setq clojure-repls-clj-con-buf (current-buffer)))

(defun clojure-repls-set-cljs-buffer ()
  (interactive)
  (setq clojure-repls-cljs-con-buf (current-buffer)))

(defun clojure-repls-bound-truthy-p (s)
  (and (boundp s) (symbol-value s)))

(defun clojure-repls-buffer-extension (buffer)
  (let ((name (buffer-name buffer)))
    (-when-let (p-loc (string-match-p "\\." name))
      (substring name (1+ p-loc) nil))) )

(defun clojure-repls-set-connection (f h)
  (let ((ext (clojure-repls-buffer-extension (current-buffer))))
    (if (and (clojure-repls-bound-truthy-p 'clojure-repls-clj-con-buf)
             (clojure-repls-bound-truthy-p 'clojure-repls-cljs-con-buf)
             ext
             (or (string= ext "clj") (string= ext "boot") (string= ext "cljs")))
        (progn
          (if (string= ext "cljs")
              (nrepl-make-connection-default clojure-repls-cljs-con-buf)
            (nrepl-make-connection-default clojure-repls-clj-con-buf))
          (when f
            (funcall f)))
      (when h
        (funcall h)))))

(defun clojure-repls-switch-to-relevant-repl (arg)
  (interactive)
  (lexical-let ((a arg))
    (clojure-repls-set-connection (lambda () (cider-switch-to-current-repl-buffer a))
                                        (lambda () (cider-switch-to-relevant-repl-buffer a)))))

(if (version< emacs-version "24.4")
    (progn
      (defadvice cider-interactive-eval (before clojure-repls-nrepl-current-session activate)
        (clojure-repls-set-connection nil nil))
      (defadvice cider-tooling-eval (before clojure-repls-nrepl-current-session activate)
        (clojure-repls-set-connection nil nil))
      (defadvice cider-complete-at-point (before clojure-repls-nrepl-current-session activate)
        (clojure-repls-set-connection nil nil)))
  (defun clojure-repls-nrepl-current-session (&optional arg1 arg2)
    (clojure-repls-set-connection nil nil))
  (advice-add 'cider-interactive-eval :before #'clojure-repls-nrepl-current-session)
  (advice-add 'cider-tooling-eval :before #'clojure-repls-nrepl-current-session)
  (advice-add 'cider-complete-at-point :before #'clojure-repls-nrepl-current-session))

(global-set-key (kbd "C-c C-s c") 'clojure-repls-set-clj-buffer)
(global-set-key (kbd "C-c C-s b") 'clojure-repls-set-cljs-buffer)

(provide 'clojure-repls)
