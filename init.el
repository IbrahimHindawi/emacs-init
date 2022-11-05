;; Init default settings
(load-theme 'wombat)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
(set-default 'truncate-lines t)
(set-face-attribute 'default nil :font "Consolas" :height 128)
(windmove-default-keybindings)
(global-hl-line-mode t)

;; (customize-option global-superword-mode)
;; (customize-option global-subword-mode)

;; Customize key bindings
;; (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-S-d") 'c-electric-delete)
(global-set-key (kbd "M-o") 'other-window)

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

;; Download Ivy
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

;; Download Counsel
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))

;; Doom Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 15))

;; Doom themes
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; Evil Mode
(unless (package-installed-p 'evil)
  (package-install 'evil))
;; Enable Evil
(require 'evil)
(evil-mode 0)

;; which key
(use-package which-key)
(require 'which-key)
(which-key-mode)

;; Custom vars
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(which-key evil doom-modeline counsel ivy command-log-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "burlywood2" :background "gray10"))))
 '(cursor ((t (:background "dark violet"))))
 '(font-lock-builtin-face ((t (:foreground "orange"))))
 '(font-lock-constant-face ((t (:foreground "orange"))))
 '(font-lock-function-name-face ((t (:foreground "burlywood1"))))
 '(font-lock-keyword-face ((t (:foreground "orange" :weight normal))))
 '(font-lock-preprocessor-face ((t (:inherit normal :foreground "burlywood1"))))
 '(font-lock-string-face ((t (:foreground "DarkOrange1"))))
 '(font-lock-type-face ((t (:foreground "orange" :weight normal))))
 '(font-lock-variable-name-face ((t (:foreground "burlywood1")))))
