;; Init default settings
(load-theme 'modus-vivendi)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
(set-default 'truncate-lines t)
(set-face-attribute 'default nil :font "Consolas" :height 128)
(windmove-default-keybindings)
(global-hl-line-mode 1)
(set-face-foreground 'highlight nil)

;; (customize-option global-superword-mode)
;; (customize-option global-subword-mode)

;; Customize key bindings
;; (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-S-d") 'c-electric-delete)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-M-d") 'c-electric-backspace)
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

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 15))

(use-package company
  :config
  (setq company-minimum-prefix-length 1
	company-idle-delay 0.0
	global-company-mode 1)) ; default is 2.0
(require 'company)

(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-mode 0)

(use-package which-key)
(require 'which-key)
(which-key-mode)

;; (use-package lsp-mode
  ;; :commands (lsp-mode-deferred)
  ;; :init
  ;; (setq lsp-keymap-prefix "C-c l")
  ;; :config
  ;; (lsp-enable-which-key-integration t))

(use-package eglot)
(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; Custom vars
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company which-key evil doom-modeline counsel ivy command-log-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "burlywood2" :background "gray10"))))
 '(cursor ((t (:background "dark violet"))))
 '(font-lock-builtin-face ((t (:foreground "orange"))))
 '(font-lock-constant-face ((t (:foreground "orange"))))
 '(font-lock-function-name-face ((t (:foreground "orange"))))
 '(font-lock-keyword-face ((t (:foreground "orange" :weight normal))))
 '(font-lock-preprocessor-face ((t (:inherit normal :foreground "burlywood1"))))
 '(font-lock-string-face ((t (:foreground "DarkOrange1"))))
 '(font-lock-type-face ((t (:foreground "orange" :weight normal))))
 '(font-lock-variable-name-face ((t (:foreground "burlywood1")))))
