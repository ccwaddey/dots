;; -*- eval: (view-mode); -*-
(define-prefix-command 'ccw-key-map)
(global-set-key (kbd "C-c k") 'ccw-key-map)

(defun insert-pointer ()
  "Inserts a '->' into the buffer for my poor little pinky."
  (interactive)
  (insert "->"))
(define-key ccw-key-map "a" 'insert-pointer)

(defun insert-equals-pointer ()
  "Inserts a '=>' into the buffer for my poor little pinky."
  (interactive)
  (insert "=>"))
(define-key ccw-key-map "e" 'insert-equals-pointer)

(defun insert-parens ()
  "Inserts a matching pair of parentheses and puts the cursor between them."
  (interactive)
  (insert "()")
  (backward-char))
(define-key ccw-key-map "p" 'insert-parens)

(defun insert-braces ()
  "Inserts a matching pair of braces and puts the cursor between them."
  (interactive)
  (insert "{}")
  (backward-char))
(define-key ccw-key-map "f" 'insert-braces)

(defun insert-brackets ()
  "Inserts a matching pair of brackets and puts the cursor between them."
  (interactive)
  (insert "[]")
  (backward-char))
(define-key ccw-key-map "b" 'insert-brackets)

(defun insert-angle-brackets ()
  "Inserts a matching pair of angle-brackets and puts the cursor between them."
  (interactive)
  (insert "<>")
  (backward-char))
(define-key ccw-key-map "k" 'insert-angle-brackets)

(defun insert-quotes ()
  "Inserts a matching pair of `\"' and puts the cursor between them."
  (interactive)
  (insert "\"\"")
  (backward-char))
(define-key ccw-key-map "d" 'insert-quotes)

(defun insert-single-quotes ()
  "Inserts a matching pair of `'' and puts the cursor between them."
  (interactive)
  (insert "''")
  (backward-char))
(define-key ccw-key-map "s" 'insert-single-quotes)

(defun insert-string-function ()
  "Inserts a (\"\") for functions that take string arguments."
  (interactive)
  (insert-parens)
  (insert-quotes))
(define-key ccw-key-map "l" 'insert-string-function)

(defun begin-function-braces ()
  "Inserts a brace pair with indenting to begin a function."
  (interactive)
  (insert-braces)
  (newline)
  (indent-for-tab-command)
  (previous-line)
  (move-end-of-line nil)
  (newline)
  (indent-for-tab-command))
(define-key ccw-key-map "j" 'begin-function-braces)

(defun swap-windows ()
  "Swaps the other window's buffer with the current window's."
  (interactive)
  (save-excursion
    (let ((curbuf (current-buffer)))
      (other-window 1)
      (let ((otherbuf (current-buffer)))
	(switch-to-buffer curbuf)
	(other-window 1)
	(switch-to-buffer otherbuf)
	(other-window 1)))))

(setq ccw-font-is-big nil)
(defun make-font-big ()
  "Toggles the font size between 200 and 350 for recording purposes."
  (interactive)
  (if ccw-font-is-big
      (set-face-attribute 'default nil :height 200)
    (set-face-attribute 'default nil :height 350))
  (setq ccw-font-is-big (not ccw-font-is-big)))
