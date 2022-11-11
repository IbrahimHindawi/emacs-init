(deftheme x19
  "x19's Theme") ;; this is a theme

(custom-theme-set-variables
 'x19
 '(package-selected-packages '(company which-key command-log-mode use-package)))

(custom-theme-set-faces
 'x19
 '(default ((t (:background "gray10" :foreground "burlywood2"))))
 '(cursor ((t (:background "dark violet"))))
 '(font-lock-builtin-face ((t (:foreground "orange"))))
 '(font-lock-constant-face ((t (:foreground "orange"))))
 '(font-lock-function-name-face ((t (:foreground "orange"))))
 '(font-lock-keyword-face ((t (:foreground "orange" :weight normal))))
 '(font-lock-preprocessor-face ((t (:inherit normal :foreground "burlywood1"))))
 '(font-lock-string-face ((t (:foreground "DarkOrange1"))))
 '(font-lock-type-face ((t (:foreground "orange" :weight normal))))
 '(font-lock-variable-name-face ((t (:foreground "burlywood1"))))
 '(font-lock-comment-face ((t (:foreground "gray60"))))
 '(highlight ((t (:background "#000033"))))
 '(link ((t (:foreground "hot pink" :underline t))))
 '(mode-line ((t (:background "gray30" :foreground "gray80" :box (:line-width (1 . 1) :color "#a8a8a8") :overline nil :underline nil)))))
(provide-theme 'x19)
