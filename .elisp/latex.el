;; -*- eval: (view-mode); -*-
(defun latex-frac (numer denom)
  "Makes a \\frac{}{} command by prompting the user."
  (interactive "sEnter numerator: \nsEnter denominator: ")
  (let ((oldsize (buffer-size)))
    (save-excursion
      (insert "\\frac{" numer "}{" denom "}"))
    (forward-char (- (buffer-size) oldsize))))

(defun latex-sum (low-bound up-bound)
  "Makes a \\sum_{}^{} command by prompting the user."
  (interactive "sEnter lower bound: \nsEnter upper bound: ")
  (let ((oldsize (buffer-size)))
    (save-excursion
      (insert "\\sum_{" low-bound "}^{" up-bound "}"))
    (forward-char (- (buffer-size) oldsize))))

(defun latex-integral (low-bound up-bound)
  "Makes an \\int_{}^{} command by prompting the user."
  (interactive "sEnter lower bound: \nsEnter upper bound: ")
  (let ((oldsize (buffer-size)))
    (save-excursion
      (insert "\\int_{" low-bound "}^{" up-bound "}"))
    (forward-char (- (buffer-size) oldsize))))

(defun latex-lr (container)
  "Inserts \\lcontainer \\rcontainer into the text."
  (interactive "sEnter container: ")
  (save-excursion
    (insert "\\l" container "   \\r" container))
  (forward-word)
  (forward-char))

(defun latex-begin-end (env)
  "Creates beginning and end of environment."
  (interactive "sEnter environment: ")
  (save-excursion
    (insert "\\begin{" env "}")
    (newline)
    (insert "\\end{" env "}")
    (indent-for-tab-command))
  (move-end-of-line nil))
