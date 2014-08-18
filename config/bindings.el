;; Place your bindings here.

(global-set-key (kbd "C-x C-o") 'ffip)
(global-set-key (kbd "C-x C-g") 'rgrep)

;; bookmarks
(global-set-key (kbd "C-c C-t") 'bm-toggle)
(global-set-key (kbd "C-c C-n") 'bm-next)
(global-set-key (kbd "C-c C-p") 'bm-previous)

(global-set-key (kbd "C-c C-m") 'git-commit-mode)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)



(defvar swap-paren-pairs '("()" "[]" "{}"))
(defun swap-parens-at-points (b e)
  (let ((open-char (buffer-substring b (+ b 1)))
        (paren-pair-list (append swap-paren-pairs swap-paren-pairs)))
    (while paren-pair-list
      (if (eq (aref open-char 0) (aref (car paren-pair-list) 0))
          (save-excursion
            (setq to-replace (cadr paren-pair-list))
            (goto-char b)
            (delete-char 1)
            (insert (aref to-replace 0))
            (goto-char (- e 1))
            (delete-char 1)
            (insert (aref to-replace 1))
            (setq paren-pair-list nil))
        (setq paren-pair-list (cdr paren-pair-list))))))

(defun swap-parens ()
  (interactive)
  (cond ((looking-at "\\s(")
         (swap-parens-at-points (point) (save-excursion (forward-sexp) (point))))
        ((and (> (point) 1) (save-excursion (forward-char -1) (looking-at "\\s)")))
         (swap-parens-at-points (save-excursion (forward-sexp -1) (point)) (point)))
        ((message "Not at a paren"))))

(global-set-key (kbd "C-c [") 'swap-parens)

(winner-mode 1)
(windmove-default-keybindings)
(setq org-replace-disputed-keys t)

;; kill buffer
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key [?\s-w] 'kill-current-buffer)

;; nrepl eval
(defun nrepl-eval-expression-at-point-in-repl ()
  (interactive)
  (let ((form (nrepl-expression-at-point)))
    ;; Strip excess whitespace
    (while (string-match "\\`\s+\\|\n+\\'" form)
      (setq form (replace-match "" t t form)))
    (set-buffer (nrepl-find-or-create-repl-buffer))
    (goto-char (point-max))
    (insert form)
    (nrepl-return)))

(global-set-key (kbd "C-`") 'nrepl-eval-expression-at-point-in-repl)

(defun cider-eval-expression-at-point-in-repl ()
  (interactive)
  (let ((form (cider-sexp-at-point)))
    ;; Strip excess whitespace
    (while (string-match "\\`\s+\\|\n+\\'" form)
      (setq form (replace-match "" t t form)))
    (set-buffer (cider-find-or-create-repl-buffer))
    (goto-char (point-max))
    (insert form)
    (cider-repl-return)))
