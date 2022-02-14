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

;; Display time
(setq display-time-default-load-average nil)
(setq display-time-day-and-date nil)
(display-time)

;; Don't accidentally kill emacs
(setq confirm-kill-emacs 'yes-or-no-p)

;; Should I move this to convenience?
(define-key global-map (kbd "C-c r") 'vc-refresh-state)
(define-key global-map (kbd "C-c c") 'compile)

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
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(backup-directory-alist '(("." . "/home/me/.emacs.d/backups")))
 '(c-offsets-alist
   '((statement-cont . +)
     (arglist-intro . +)
     (arglist-cont c-lineup-gcc-asm-reg 0)
     (arglist-cont-nonempty c-lineup-gcc-asm-reg c-lineup-arglist)))
 '(column-number-mode t)
 '(custom-enabled-themes '(tango-dark))
 '(dired-use-ls-dired nil)
 '(display-buffer-base-action
   '((display-buffer-reuse-window display-buffer-same-window)
     (reusable-frames . t)))
 '(display-line-numbers-type nil)
 '(fringe-mode 0 nil (fringe))
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice nil)
 '(initial-scratch-message "(set-face-attribute \\='default nil :height 350)")
 '(menu-bar-mode nil)
 '(org-catch-invisible-edits 'show-and-error)
 '(package-selected-packages
   '(perspective markdown-mode pdf-tools gh-md rust-mode multiple-cursors smex))
 '(pdf-view-continuous t)
 '(rcirc-authinfo nil)
 '(rcirc-server-alist '(("chat.freenode.net" :channels ("#openbsd"))))
 '(rcirc-track-minor-mode t)
 '(revert-without-query '("resume\\.pdf"))
 '(safe-local-variable-values '((eval set-fill-column 80)))
 '(save-place-mode t)
 '(scroll-bar-mode nil)
 '(semantic-complete-inline-analyzer-displayer-class 'semantic-displayer-ghost)
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
