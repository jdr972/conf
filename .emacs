(setq emacs-lisp-dir "~/.emacs.d/lisp"
      my-elmode-dir (concat emacs-lisp-dir "elmodes/"))
(setq load-path
      (append load-path (list my-elmode-dir)))

(load "std.el")
(load "std_comment.el")
(if (file-exists-p "~/.myemacs")
    (load-file "~/.myemacs"))

(global-linum-mode 1)
(setq make-backup-files nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; append-tuareg.el - Tuareg quick installation: Append this file to .emacs.

(setq emacs-lisp-dir "~/.emacs.d/"
      my-elmode-dir (concat emacs-lisp-dir "elmodes/"))
(setq load-path
      (append load-path (list my-elmode-dir)))


(load "std.el")
(load "std_comment.el")
(if (file-exists-p "~/.myemacs")
    (load-file "~/.myemacs"))

(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(dolist (ext '(".cmo" ".cmx" ".cma" ".cmxa" ".cmi"))
  (add-to-list 'completion-ignored-extensions ext))

;; Nice Linum
(dolist (hook '(python-mode-hook
		c-mode-common-hook
		php-mode-hook
		sh-mode-hook
		emacs-list-mode-hook))
  (add-hook hook (lambda () (linum-mode t) (setq linum-format "%3d |"))))
(setq linum-format "%3d |")
					;\u2502

;; Ask y/n instead yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; Featured switch-to-buffer
(iswitchb-mode t)

;;Pour changer facilement de buffer
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)

;; Bold line
(global-hl-line-mode t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight ((t (:weight bold))))
 '(my-loong-line-face ((((class color)) (:background "yellow"))) t)
 '(my-tab-face ((((class color)) (:foreground "black" :weight bold :underline t))) t))

;;parentheses
(show-paren-mode)

;; molette souris
(mouse-wheel-mode t)

;;colonnes
(setq column-number-mode t)

;;surbrillance de la region
(setq transient-mark-mode t)

;;affiche les espaces inutile
(setq-default show-trailing-whitespace t)

;; Disable blinking cursor
					;(blink-cursor-mode 0)

					; battery state
(display-battery-mode)
(setq display-time-next-load-average)

;; Clear whitespaces
					;(define-key text-mode-map (kbd "<f8>") 'delete-trailing-whitespace)
(global-set-key (kbd "<f8>") 'delete-trailing-whitespace)

;; Replace
(global-set-key (kbd "<f7>") 'query-replace-regexp)

;; Linum-mode
(global-set-key (kbd "<f6>") 'linum-mode)

;; Disable unusual bars
					;(scroll-bar-mode -1)
					;(menu-bar-mode -1)
					;(tool-bar-mode -1)

;;couleur en mode shell
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(defun to-bottom () (interactive) "Recenter screen so that current
line is on the bottom of the screen"
       (recenter -1)
       )
(defun set-key-to-bottom () (interactive)
       (local-set-key "\C-l" 'to-bottom)
       )
(add-hook 'shell-mode-hook 'set-key-to-bottom)

;; Whitespaces
(require 'whitespace)
					;(setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-style '(face empty lines-tail trailing))
(global-whitespace-mode t)



;; Show tabs and too long lines


(defun cc-mode-add-keywords (mode)
  (font-lock-add-keywords
   mode
   '(
     ("\t+" (0 'my-tab-face append))
     ("^.\\{81\\}\\(.+\\)$" (1 'my-loong-line-face append)))))

(cc-mode-add-keywords 'c-mode)
(cc-mode-add-keywords 'php-mode)
(cc-mode-add-keywords 'sh-mode)
(cc-mode-add-keywords 'python-mode)
(cc-mode-add-keywords 'perl-mode)
(cc-mode-add-keywords 'c++-mode)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#eaeaea" "#d54e53" "DarkOliveGreen3" "#e7c547" "DeepSkyBlue1" "#c397d8" "#70c0b1" "#181a26"))
 '(custom-safe-themes
   (quote
    ("b51c2dda65e8e7e66ab1b06bc10b59e61c153b0cf928f296efab5a7574779fb6" "4e753673a37c71b07e3026be75dc6af3efbac5ce335f3707b7d6a110ecb636a3" "c335adbb7d7cb79bc34de77a16e12d28e6b927115b992bccc109fb752a365c72" default)))
 '(delete-selection-mode nil)
 '(fci-rule-color "#14151E")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "goldenrod")
     (60 . "#e7c547")
     (80 . "DarkOliveGreen3")
     (100 . "#70c0b1")
     (120 . "DeepSkyBlue1")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "goldenrod")
     (200 . "#e7c547")
     (220 . "DarkOliveGreen3")
     (240 . "#70c0b1")
     (260 . "DeepSkyBlue1")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "goldenrod")
     (340 . "#e7c547")
     (360 . "DarkOliveGreen3"))))
 '(vc-annotate-very-old-color nil))


;;melpa
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line





;;theme
(load-theme 'zenburn t)

;;Helm
(global-set-key (kbd "M-x") 'helm-M-x)
