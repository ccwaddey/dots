;; -*- eval: (view-mode); -*-
;; Don't show emacs until we alt-tab to it but be full screen then.
(toggle-frame-fullscreen)
(iconify-frame)

;; Load latex convenience functions
(load "~/.elisp/latex")
;; Load keybinding convenience functions (and their mappings)
(load "~/.elisp/convenience")
;; Load hooks for various modes (mostly j/k scroll up/down)
(load "~/.elisp/hooks")
;; Load private stuff
(load "~/.priv/.emacs")

;; Don't accidentally kill emacs
(setq confirm-kill-emacs 'yes-or-no-p)

;; Should I move this to convenience?
(define-key global-map (kbd "C-c r") 'vc-refresh-state)
(define-key global-map (kbd "C-c c") 'compile)
;; (global-set-key (kbd "C-c l") 'org-store-link)
;; (global-set-key (kbd "C-c a") 'org-agenda)
;; (global-set-key (kbd "C-c c") 'org-capture)

(setq c-default-style
      '((other . "bsd")))

(setq view-read-only t)

(setq url-cookie-confirmation 't)

(setq select-enable-clipboard 't) ;; default

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method 'pushy)
 '(backup-directory-alist '(("." . "~/.emacs.d/backups")))
 '(c-offsets-alist
   '((statement-cont . +)
     (arglist-intro . +)
     (arglist-cont c-lineup-gcc-asm-reg 0)
     (arglist-cont-nonempty c-lineup-gcc-asm-reg c-lineup-arglist)))
 '(column-number-mode t)
 '(custom-enabled-themes '(tango-dark))
 '(dired-use-ls-dired nil)
 '(display-buffer-base-action '((display-buffer-reuse-window display-buffer-same-window)))
 '(display-time-24hr-format t)
 '(display-time-default-load-average nil)
 '(display-time-mode t)
 '(fringe-mode 0 nil (fringe))
 '(inhibit-startup-screen t)
 '(initial-buffer-choice nil)
 '(initial-scratch-message nil)
 '(menu-bar-mode nil)
 '(org-catch-invisible-edits 'show-and-error)
 '(org-ctrl-k-protect-subtree t)
 '(package-selected-packages
   '(perspective markdown-mode pdf-tools gh-md rust-mode multiple-cursors smex))
 '(pdf-view-continuous t)
 '(pdf-view-resize-factor 1.1)
 '(revert-without-query '("resume\\.pdf" "coverletter\\.pdf"))
 '(safe-local-variable-values '((eval set-fill-column 80)))
 '(save-place-mode t)
 '(scroll-bar-mode nil)
 '(semantic-complete-inline-analyzer-displayer-class 'semantic-displayer-ghost)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))

(set-face-attribute 'default nil :height 200)
(set-face-attribute 'mouse nil :background "#ce5c00")

;; Package Configuration

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

(setq persp-state-default-file "~/.emacs.d/perspectives")
(setq persp-sort 'access)
(setq persp-modestring-short t)
(add-hook 'kill-emacs-hook #'persp-state-save)
(persp-state-load "~/.emacs.d/perspectives")
(global-set-key (kbd "C-x C-b") 'persp-ibuffer)

(server-start)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
