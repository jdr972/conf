;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; File name: ` /usr/share/emacs/site-lisp/site-start.el '
;;; ---------------------
;;; System wide start file for emacs.
;;;
;;; If you need your own personal ~/.emacs
;;; please have a look on /etc/skel/.emacs
;;; an placein your changes and/or extension.
;;;
;;; For emacs commands have a look onto the
;;; `emacs-revcard' in the directory /usr/doc/packages/emacs/
;;;
;;; Copyright 1993-2001 Werner Fink
;;; Copyright 1996-2001 (c) SuSE Gmbh Nuernberg, Germany. All rights reserved.
;;;
;;; Author: Werner Fink <werner@suse.de>, 1993-2001
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Path to users own emacs libaries
;; -----------------------------
;;  Do not forget:
;;       This directory should exist!
;;       that means: mkdir ~/lib/site-lisp
(if (file-accessible-directory-p "~/lib/site-lisp/")
    (setq load-path (append (list "~/lib/site-lisp/") load-path)))
;;
;; RMAIL: repair a bug in rmail of emacs 19.29
;; -------------------------------------------
(if (and (eq emacs-major-version 19) (eq emacs-minor-version 29))
    (progn
      (put 'rmail-disable-menu 'menu-enable ''t)
      (add-hook 'rmail-summary-mode-hook
	'(lambda () (rmail-summary-construct-io-menu)))))
;;
;; GNUS
;; ----
;; You may set your domain and organization system wide to overwrite
;; the environment variables HOSTNAME or FROM_HEADER and ORGANIZATION.
;; (Note: gnus-local-organization is obsolete.)
;;
;(setq gnus-local-domain "our.domain.is.not.set")
;(setq message-user-organization "Linux Private Site")
;;
;; This should be set by gnus via (system-name) call (does not work)
;;
(if (or (not (boundp 'gnus-local-domain)) (null gnus-local-domain))
  (let ((tmph (getenv "HOSTNAME"))
	(tmpf (getenv "FROM_HEADER")))
     (if (or (null tmph) (not (string-match "\\." tmph)))
	 (setq tmph (system-name)))
     (if (not (string-match "\\." tmph))
	 (setq gnus-local-domain "our.domain.is.not.set")
	(string-match "\\." tmph)
	(setq gnus-local-domain (substring tmph (match-end 0))))
     (if (stringp tmpf)
	 (setq gnus-local-domain tmpf))))
;;
(eval-when-compile (defvar message-user-organization))
(if (or (not (boundp 'message-user-organization)) (null message-user-organization))
  (let ((tmp (getenv "ORGANIZATION")))
     (if (null tmp)
	     (setq message-user-organization "Linux Private Site")
       (setq message-user-organization tmp))))
;;
;; Preload dynamic (i)Spell menu
;; -----------------------------
(if (not (load "/usr/lib/ispell/ispell-emacs-menu.el" t t))
  (let ((aspells (file-expand-wildcards "/usr/lib/aspell*")))
    (dolist (aspell aspells)
      (if (and (stringp aspell)
	       (file-exists-p aspell))
	(load "ispell" nil t)))))
;;
;; Load some package startups
;; --------------------------
(let ((dir (directory-files "/usr/share/emacs/site-lisp/" t "^suse-start-.*\\.el$")))
  (while dir (load (car dir) nil t t) (setq dir (cdr dir))))
(if (file-accessible-directory-p "/usr/share/emacs/site-lisp/site-start.d")
    (let ((dir (directory-files "/usr/share/emacs/site-lisp/site-start.d/" t "^[^/]*\\.el$")))
      (while dir (load (car dir) nil t t) (setq dir (cdr dir)))))
(if (file-accessible-directory-p "/etc/emacs/site-lisp/site-start.d")
    (let ((dir (directory-files "/etc/emacs/site-lisp/site-start.d/" t "^[^/]*\\.el$")))
      (while dir (load (car dir) nil t t) (setq dir (cdr dir)))))
;;
;; One step scrolling
;; ------------------
(eval-when-compile (defvar hscroll-step))
(setq  scroll-step 1)
(setq hscroll-step 1)
;;
;; Repair a vt200 suffer: the <ESC> key
;; -------------------------------------------
;(require 'vt200-esc-fix)
;(auto-escape-key-fix)
;(setq terminal-needs-escape-key '("vt200" "vt201" "vt220" "vt240"))
;;
;; Specials for X Window System
;; -------------------------
(if (not window-system)
    (progn
     ;;
     ;; XON XOFF Handshake
     ;; ------------------
;    (set-input-mode nil nil t)
     ;;
     ;; Search highlight
     ;; ----------------
     (setq search-highlight nil)
     ;;
     ;; Paren-mode
     ;; ----------
     (setq blink-matching-paren t)
    )
  ;;
  (set-input-mode t nil t)
  ;;
  ;; Search highlight
  ;; ----------------
  (setq search-highlight t)
  ;;
  ;; Highlighting of marked regions
  ;; ------------------------------
  (setq mark-even-if-inactive t)
  ;;
  ;; Enable region highlight
  ;; -----------------------
  (transient-mark-mode 1)
  ;;
  ;; But only in the selected window
  ;; -------------------------------
  (setq highlight-nonselected-windows nil)
  ;;
  ;; Enable pending-delete
  ;; ---------------------
; (delete-selection-mode 1)
  ;;
  ;; Show corresponding braces
  ;; -------------------------
  (show-paren-mode 1)
  ;;
)
;;
;; XX-mode commands loads "XX-mode" or "XX"
;; ----------------------------------------
;;(autoload 'bibtex-mode "bibtex" "Modus f\"ur BibTeX" t)
(autoload 'maple-mode "maple" "Modus f\"ur Maple" t)
;;(autoload 'web-mode "web-mode" "Major mode for editing WEB-based documents" t)
;;(autoload 'cweb-mode "cweb" "Major mode for editing CWEB-based documents" t)
;;(autoload 'c++-mode   "cc-mode" "C++ Editing Mode" t)
;;(autoload 'perl-mode "perl-mode" "Perl Editing Mode" t)
;;(autoload 'pascal-mode "pascal-mode" "Pascal Editing Mode" t)
;;
;; Some rechanges on the auto-mode-alist
;; -------------------------------------
;;(setq auto-mode-alist (cons '("\\.web\\'" . web-mode) auto-mode-alist))
;;(setq web-default-directory "/usr/share/texmf/")
;;
;; Some extensions of autoload modes
;; ---------------------------------------------------
(setq auto-mode-alist (append auto-mode-alist
			      '(("\\.\\(aux\\|bbl\\|toc\\|lo[ft]\\|idx\\|ind\\|glo\\)\\'" . plain-tex-mode)
				("\\.maple\\'" . maple-mode)
				("\\.mpl\\'" . maple-mode)
				("\\^maple-" . maple-mode)
				("\\^mpl-" . maple-mode)
;;				("\\.w\\'" . cweb-mode)		;; Sorry, no cweb mode for emacs 22
;;				("\\.ch\\'" . cweb-mode)
;;				("\\.web\\'" . web-mode)	;; Sorry, no web mode for emacs 22
				("\\.perl\\'" .  perl-mode)
				("\\.p\\'" .  pascal-mode)
		              )
))

;; -----------------------------------------------------
;; locale related settings like encodings:

(load "term/locale" t t)

;;;;;;;;;;
;; the end
