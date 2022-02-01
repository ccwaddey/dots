;; https://poolp.org/posts/2019-09-14/setting-up-a-mail-server-with-opensmtpd-dovecot-and-rspamd/
;; https://blog.cavelab.dev/2021/03/unbound-local-dns/
(server-start)
(toggle-frame-fullscreen)
(iconify-frame)
;; (desktop-read "~/.emacs.d/")

(setq display-time-default-load-average nil)
(setq display-time-day-and-date nil)
(setq confirm-kill-emacs 'yes-or-no-p)
(display-time)
;;(semantic-mode)

;;(autoload 'wl "wl" "wanderlust" t)

(defun ccw-exit ()
  "Exit function that calls desktop-save first."
  (interactive)
  (desktop-save "~/.emacs.d/")
  (save-buffers-kill-terminal))
(global-set-key (kbd "C-x C-c") 'ccw-exit)

(defun latex-frac (numer denom)
  "Makes a \\frac{}{} command by prompting the user."
  (interactive "sEnter numerator: \nsEnter denominator: ")
  (setq oldsize (buffer-size))
  (save-excursion
    (insert "\\frac{" numer "}{" denom "}")
    )
  (forward-char (- (buffer-size) oldsize))
  )

(defun latex-sum (low-bound up-bound)
  "Makes a \\sum_{}^{} command by prompting the user."
  (interactive "sEnter lower bound: \nsEnter upper bound: ")
  (setq oldsize (buffer-size))
  (save-excursion
    (insert "\\sum_{" low-bound "}^{" up-bound "}")
    )
  (forward-char (- (buffer-size) oldsize))
  )

(defun latex-integral (low-bound up-bound)
  "Makes an \\int_{}^{} command by prompting the user."
  (interactive "sEnter lower bound: \nsEnter upper bound: ")
  (setq oldsize (buffer-size))
  (save-excursion
    (insert "\\int_{" low-bound "}^{" up-bound "}")
    )
  (forward-char (- (buffer-size) oldsize))
  )

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



(add-hook 'apropos-mode-hook
	  (lambda ()
	    (define-key apropos-mode-map "j" 'scroll-up-line)
	    (define-key apropos-mode-map "k" 'scroll-down-line)))

(add-hook 'Info-mode-hook
	  (lambda ()
	    (define-key Info-mode-map "j" 'scroll-up-line)
	    (define-key Info-mode-map "k" 'scroll-down-line)))

(add-hook 'help-mode-hook
	  (lambda ()
	    (define-key help-mode-map "j" 'scroll-up-line)
	    (define-key help-mode-map "k" 'scroll-down-line)))

(add-hook 'Man-mode-hook
	  (lambda ()
	    (define-key Man-mode-map "j" 'scroll-up-line)
	    (define-key Man-mode-map "k" 'scroll-down-line)))

(add-hook 'pdf-view-mode-hook
	  (lambda ()
	    (define-key pdf-view-mode-map "j" 'pdf-view-next-line-or-next-page)
	    (define-key pdf-view-mode-map "k"
	      'pdf-view-previous-line-or-previous-page)
	    (define-key pdf-view-mode-map "h" 'image-backward-hscroll)
	    (define-key pdf-view-mode-map "l" 'image-forward-hscroll)
	    (pdf-view-themed-minor-mode 1)))

(add-hook 'eww-mode-hook
	  (lambda ()
	    (define-key eww-mode-map "j" 'scroll-up-line)
	    (define-key eww-mode-map "k" 'scroll-down-line)))

(add-hook 'c-mode-hook
	  (lambda ()
	    (hs-minor-mode)
	    (define-key c-mode-map (kbd "C-c p") 'insert-pointer)))

(add-hook 'rust-mode-hook
	  (lambda ()
	    (define-key rust-mode-map (kbd "C-c p") 'insert-pointer)))

(define-key global-map (kbd "C-c r") 'vc-refresh-state)
(define-key global-map (kbd "C-c c") 'compile)

(setq c-default-style
      '((other . "bsd")))

(setq view-read-only t)
(add-hook 'view-mode-hook
	  (lambda ()
	    (define-key view-mode-map "j" 'scroll-up-line)
	    (define-key view-mode-map "k" 'scroll-down-line)
	    (define-key view-mode-map (kbd "C-p") 'previous-line)
	    (define-key view-mode-map (kbd "C-n") 'next-line)))

(add-hook 'shell-mode-hook
	  (lambda ()
	    (setq comint-process-echoes t)
	    (setq comint-scroll-show-maximum-output nil)
	    (define-key shell-mode-map (kbd "C-c q") 'view-mode)
	    (define-key shell-mode-map (kbd "C-p") 'comint-previous-input)
	    (define-key shell-mode-map (kbd "M-p") 'previous-line)
	    (define-key shell-mode-map (kbd "C-n") 'comint-next-input)
	    (define-key shell-mode-map (kbd "M-n") 'next-line)))

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(setq url-cookie-confirmation 't)
(rcirc-track-minor-mode 1)
(setq select-enable-clipboard 't) ;; default
;;(setq select-enable-primary 't)
;;(setq mouse-drag-copy-region 't)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method 'pushy)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(auth-source-save-behavior nil)
 '(backup-directory-alist '(("." . "/home/me/.emacs.d/backups")))
 '(c-offsets-alist
   '((statement-cont . +)
     (arglist-intro . +)
     (arglist-cont c-lineup-gcc-asm-reg 0)
     (arglist-cont-nonempty c-lineup-gcc-asm-reg c-lineup-arglist)))
 '(column-number-mode t)
 '(custom-enabled-themes '(tango-dark))
 '(desktop-files-not-to-save nil)
 '(dired-use-ls-dired nil)
 '(display-line-numbers-type nil)
 '(fringe-mode 0 nil (fringe))
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice nil)
 '(initial-scratch-message
   "(set-face-attribute \\='default nil :height 350)")
 '(menu-bar-mode nil)
 '(org-catch-invisible-edits 'show-and-error)
 '(package-selected-packages
   '(markdown-mode pdf-tools gh-md rust-mode multiple-cursors smex))
 '(pdf-view-continuous t)
 '(rcirc-authinfo nil)
 '(rcirc-server-alist '(("chat.freenode.net" :channels ("#openbsd"))))
 '(rcirc-track-minor-mode t)
 '(revert-without-query '("resume\\.pdf"))
 '(safe-local-variable-values '((eval set-fill-column 80)))
 '(save-place-mode t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#2e3436" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 200 :width normal :foundry "PfEd" :family "DejaVu Sans Mono"))))
 '(mouse ((t (:background "#ce5c00"))))
 '(term-color-blue ((t (:background "#8cc4ff" :foreground "#8cc4ff"))))
 '(term-color-cyan ((t (:background "#fcaf3e" :foreground "#fcaf3e"))))
 '(term-color-magenta ((t (:background "#e090d7" :foreground "#e090d7"))))
 '(term-color-red ((t (:background "#ff4b4b" :foreground "#ff4b4b"))))
 '(term-color-white ((t (:background "#eeeeec" :foreground "#eeeeec"))))
 '(term-color-yellow ((t (:background "#fce94f" :foreground "#fce94f")))))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(require 'ido)
(ido-mode t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(pdf-tools-install)

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require 'multiple-cursors)
(define-prefix-command 'mc-map)
(global-set-key (kbd "C-c m") 'mc-map)
(define-key mc-map (kbd "e") 'mc/edit-lines)
(define-key mc-map (kbd "m") 'mc/mark-next-like-this)
(define-key mc-map (kbd "p") 'mc/mark-previous-like-this)

(load "~/.priv/.emacs")

(split-window-right)
(other-window 1)
(shell)
