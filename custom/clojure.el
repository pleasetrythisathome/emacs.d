;;
;; clojure-mode
;;
(require 'clojure-mode)
(require 'cider-test)
(require 'clojure-mode-extra-font-locking)

(setq auto-mode-alist (append '(("\\.cljs$" . clojure-mode)
                                ("\\.cljx$" . clojure-mode)
                                ("\\.cljc$" . clojure-mode)
                                ("\\.boot$" . clojure-mode)
                                ("\\.edn$" . clojure-mode)
                                ("\\.dtm$" . clojure-mode))
                              auto-mode-alist))

(dolist (x '(scheme emacs-lisp lisp clojure cider cider-repl))
  (add-hook (intern (concat (symbol-name x) "-mode-hook")) 'subword-mode)
  (add-hook (intern (concat (symbol-name x) "-mode-hook")) 'rainbow-delimiters-mode)
  (add-hook (intern (concat (symbol-name x) "-mode-hook")) 'paredit-mode)
  (add-hook (intern (concat (symbol-name x) "-mode-hook")) 'smartparens-strict-mode)
  (add-hook (intern (concat (symbol-name x) "-mode-hook")) 'rainbow-delimiters-mode))

;; refactor
(require 'clj-refactor)
(add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               (cljr-add-keybindings-with-prefix "C-c C-m")))

(add-hook 'clojure-mode-hook (lambda () (yas/minor-mode 1)))

(define-key clojure-mode-map (kbd "C-:") 'clojure-toggle-keyword-string)
(define-key clojure-mode-map (kbd "C->") 'cljr-cycle-coll)

(add-hook 'clojure-mode-hook 'typed-clojure-mode)

(setq clj-add-ns-to-blank-clj-files t)
(setq cljr-sort-comparator 'cljr--semantic-comparator)

(defun replacement-region (replacement)
  (compose-region (match-beginning 1) (match-end 1) replacement))

;; spacing

(defun core-logic-config ()
  "Update the indentation rules for core.logic"
  (put-clojure-indent 'run* 'defun)
  (put-clojure-indent 'fresh 'defun)
  (put-clojure-indent 'conde 'defun))
(add-hook 'clojure-mode-hook 'core-logic-config)

(setq clojure-indent-style nil)

(define-clojure-indent
  (defroutes :defn)
  (defnk :defn)
  (fnk :defn)
  (s/defn :defn)
  (s/defschema :defn)
  (match 1)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2)
  (d/let-flow        '(1 ((:defn)) nil))
  (let-flow        '(1 ((:defn)) nil))
  (for-map        '(1 ((:defn)) nil))
  (s/defrecord       '(2 nil nil (1)))
  (defprotocolschema '(1 nil (:defn)))
  (defui '(1 nil (:defn))))

;;
;; cider
;;
(require 'cider)

(add-hook 'clojure-mode-hook 'cider-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

(setq cider-repl-use-pretty-printing t)

(setq nrepl-hide-special-buffers nil)
(setq cider-repl-pop-to-buffer-on-connect t)

(setq cider-popup-stacktraces t)
(setq cider-repl-popup-stacktraces t)
(setq cider-auto-select-error-buffer t)

(setq cider-repl-print-length 100)
(setq cider-repl-history-file (expand-file-name "cider-history" user-emacs-directory))

(setq cider-repl-use-clojure-font-lock t)

(add-to-list 'same-window-buffer-names "*cider*")

(add-hook 'cider-connected-hook 'cider-enable-on-existing-clojure-buffers)

(global-set-key (kbd "C-=") 'er/expand-region)

(defun warn-when-cider-not-connected ()
      (interactive)
      (message "nREPL server not connected. Run M-x cider or M-x cider-jack-in to connect."))

(define-key clojure-mode-map (kbd "C-M-x")   'warn-when-cider-not-connected)
(define-key clojure-mode-map (kbd "C-M-s-x") 'warn-when-cider-not-connected)
(global-set-key (kbd "C-M-s-x") 'cider-eval-defun-at-point)
(define-key clojure-mode-map (kbd "C-x C-e") 'warn-when-cider-not-connected)
(define-key clojure-mode-map (kbd "C-c C-e") 'warn-when-cider-not-connected)
(define-key clojure-mode-map (kbd "C-c C-l") 'warn-when-cider-not-connected)
(define-key clojure-mode-map (kbd "C-c C-r") 'warn-when-cider-not-connected)

;;Treat hyphens as a word character when transposing words
(defvar clojure-mode-with-hyphens-as-word-sep-syntax-table
  (let ((st (make-syntax-table clojure-mode-syntax-table)))
    (modify-syntax-entry ?- "w" st)
    st))

(defun live-transpose-words-with-hyphens (arg)
  "Treat hyphens as a word character when transposing words"
  (interactive "*p")
  (with-syntax-table clojure-mode-with-hyphens-as-word-sep-syntax-table
    (transpose-words arg)))

(define-key clojure-mode-map (kbd "M-t") 'live-transpose-words-with-hyphens)

(defun nrepl-set-print-length ()
  (nrepl-send-string-sync "(set! *print-length* 100)" "clojure.core"))

(add-hook 'nrepl-connected-hook 'nrepl-set-print-length)
