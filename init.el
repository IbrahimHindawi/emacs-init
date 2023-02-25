;; Init default settings
(load-theme 'x19 t)
;;(load-theme 'firebelly-theme t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
(set-default 'truncate-lines t)
(set-face-attribute 'default nil :font "Consolas" :height 92)
(windmove-default-keybindings)
(global-hl-line-mode 1)
(set-face-foreground 'highlight nil)
;; (customize-option global-superword-mode)
;; (customize-option global-subword-mode)

(setq-default indent-tabs-mode nil)
(setq-default tabs-width 4)
(setq indent-line-function 'insert-tab)

;; Customize key bindings
(global-set-key (kbd "<f5>") 'recompile)
(defun my-project-runner ()
  (interactive)
  (let ((default-directory (project-root (project-current t))))
    (shell-command "brun.bat")))
(global-set-key (kbd "<f6>") #'my-project-runner2)
;; (GLOBAL-set-key (kbd "<f6>") 'shell brun.bat)
;; (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; (global-set-key (kbd "C-S-d") 'c-electric-delete)
;; (global-set-key (kbd "M-o") 'other-window)
;; (global-set-key (kbd "C-M-d") 'c-electric-backspace)
;; (global-set-key (kbd "C-l") 'forward-char)
;; (global-set-key (kbd "C-j") 'backward-char)
;; (global-set-key (kbd "M-l") 'forward-to-word)
;; (global-set-key (kbd "M-j") 'backward-to-word)

;; (global-set-key (kbd "C-k") 'next-line)
;; (global-set-key (kbd "C-i") 'previous-line)
;; (global-set-key (kbd "M-k") 'next-line)
;; (global-set-key (kbd "M-i") 'previous-line)

;; (Global-Set-Key (Kbd "C-M-L") 'Move-End-Of-Line)
;; (Global-Set-Key (Kbd "C-M-J") 'move-beginning-of-line)
;; (global-set-key (kbd "C-M-S-l") 'move-end-of-line)
;; (global-set-key (kbd "C-M-S-j") 'move-beginning-of-line)

(defun set-bidi-env ()
  "interactive"
  (setq bidi-paragraph-direction 'nil))
(add-hook 'org-mode-hook 'set-bidi-env)

;; Init package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Init use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
(use-package command-log-mode)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))

(use-package company
  :config
  (setq company-minimum-prefix-length 1
	company-idle-delay 0.0
	global-company-mode 1))
(require 'company)
(company-mode 0)

;;;; Code Completion
(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                 ; Allows cycling through candidates
  (corfu-auto t)                  ; Enable auto completion
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  (corfu-popupinfo-delay '(0.5 . 0.2))
  (corfu-preview-current 'insert) ; Do not preview current candidate
  (corfu-preselect-first nil)
  (corfu-on-exact-match nil)      ; Don't auto expand tempel snippets

  ;; Optionally use TAB for cycling, default is `corfu-complete'.
  ;;:bind (:map corfu-map
              ;;("M-SPC"      . corfu-insert-separator)
              ;;("TAB"        . corfu-next)
              ;;([tab]        . corfu-next)
              ;;("S-TAB"      . corfu-previous)
              ;;([backtab]    . corfu-previous)
              ;;("S-<return>" . corfu-insert)
              ;;("RET"        . nil))

  :init
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode) ; Popup completion info
  :config
  (add-hook 'eshell-mode-hook
            (lambda () (setq-local corfu-quit-at-boundary t
                              corfu-quit-no-match t
                              corfu-auto nil)
              (corfu-mode))))

(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-mode 1)

(modify-syntax-entry ?_ "w" (standard-syntax-table))
(modify-syntax-entry ?_ "w" (c-mode))

;;(require 'masm-mode)

(use-package which-key)
(require 'which-key)
(which-key-mode)

(use-package eglot)
(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(use-package org-bullets)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(use-package cff)
(require 'cff)
;; defines shortcut for find source/header file for the current
;; file
(add-hook 'c++-mode-hook
           '(lambda ()
              (define-key c-mode-base-map (kbd "M-o") 'cff-find-other-file)))
(add-hook 'c-mode-hook
           '(lambda ()
              (define-key c-mode-base-map (kbd "M-o") 'cff-find-other-file)))

;; Custom vars
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("45830f6a1aacf065bee5853f619522773ba635a3f0d52938dbcd967d65496605" "e694a96f516b37b6876581eec2a13cc542d3bf70639acd72161fb45583a66494" default))
 '(package-selected-packages
   '(inkpot-theme cff corfu masm-mode simple-httpd org-bullets firebally-theme company which-key command-log-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

