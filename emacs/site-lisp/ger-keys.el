;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; name ` ger-keys.el '
;;; Author: Werner Fink (1993)
;;;         Werner Fink (1997)  <werner@suse.de>
;;; 
;;; F"ur eine deutsche Tastatur
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar ger-g2iso-table
  '(("\"A" "\304")
    ("\"O" "\326")
    ("\"U" "\334")
    ("\"a" "\344")
    ("\"o" "\366")
    ("\"s" "\337")
    ("\"u" "\374"))
  "\334bersetzungstabelle von German-Style-LaTeX nach ISO-8859-1.")
;;
(defvar ger-iso2g-table
  '(("\304" "\"A")
    ("\326" "\"O")
    ("\334" "\"U")
    ("\344" "\"a")
    ("\366" "\"o")
    ("\337" "\"s")
    ("\374" "\"u"))
  "\334bersetzungstabelle von ISO-8859-1 nach German-Style-LaTeX.")
;;
(defun ger-translate (trans-table)
  "Konvertiert \334bersetzungstabellen."
  (save-excursion
    (goto-char (point-min))
    (let ((work-table trans-table)
          (buffer-read-only nil)
        (case-fold-search nil))
      (while work-table
        (save-excursion
          (let ((trans-this (car work-table)))
            (while (re-search-forward (car trans-this) nil t)
              (replace-match (car (cdr trans-this)) t nil)))
          (setq work-table (cdr work-table)))))))
;;
;; Controll us keyboard with german overlay
;;
(defvar ger-keyboard-mode nil)
 (make-variable-buffer-local 'ger-keyboard-mode)
 (put  'ger-keyboard-mode 'permanent-local
  (get 'ger-keyboard-mode 'permanent-local))
;;
;; ispell-Features
;;
(defvar ispell-process nil)
(defvar ispell-local-dictionary nil)
 (make-variable-buffer-local 'ispell-local-dictionary)
 (put  'ispell-local-dictionary 'permanent-local
  (get 'ispell-local-dictionary 'permanent-local))
;;
;; Globale TeX-Makros f"ur die deutschen 8-bit Chararkter
;;
(defun ger-active ()
  (global-set-key [?\304] "\"A")
  (global-set-key [?\326] "\"O")
  (global-set-key [?\334] "\"U")
  (global-set-key [?\344] "\"a")
  (global-set-key [?\366] "\"o")
  (global-set-key [?\337] "\"s")
  (global-set-key [?\374] "\"u"))
(ger-active)
;;
(defun ger-inactive ()
  (global-set-key [?\304] 'self-insert-command)
  (global-set-key [?\326] 'self-insert-command)
  (global-set-key [?\334] 'self-insert-command)
  (global-set-key [?\344] 'self-insert-command)
  (global-set-key [?\366] 'self-insert-command)
  (global-set-key [?\337] 'self-insert-command)
  (global-set-key [?\374] 'self-insert-command))
(modify-syntax-entry ?\" "w")
(setq  minibuffer-setup-hook
   (function (lambda ()
      (local-set-key [?\304] 'self-insert-command)
      (local-set-key [?\326] 'self-insert-command)
      (local-set-key [?\334] 'self-insert-command)
      (local-set-key [?\344] 'self-insert-command)
      (local-set-key [?\366] 'self-insert-command)
      (local-set-key [?\337] 'self-insert-command)
      (local-set-key [?\374] 'self-insert-command))))
;;
;; Lokale Hook's vor und nach dem Sichern des Buffers
;;
(defvar local-write-file-hooks nil)
 (make-variable-buffer-local 'local-write-file-hooks)
 (put  'local-write-file-hooks 'permanent-local
  (get 'local-write-file-hooks 'permanent-local))

(defvar after-save-hooks nil)
 (make-variable-buffer-local 'after-save-hooks)
 (put  'after-save-hooks 'permanent-local nil)

(defvar after-save-hook  nil)
 (make-variable-buffer-local 'after-save-hook )
 (put  'after-save-hook  'permanent-local nil)
;;
;; Die Hook's sind lokale Variablen -- sie m"ussen also initialisiert werden
;;
(defvar german-mode nil
"Diese Variable ben\366tigt die Funktion german-mode
der Wert  nil  hei\337t: `ISO 8859 Latin 1'-Standard nicht geladen
der Wert   1   hei\337t: Latin-Standard geladen und benutzt
der Wert  -1   hei\337t: Latin-Standard geladen aber nicht benutzt")
 (make-variable-buffer-local 'german-mode)
 (put  'german-mode  'permanent-local nil)
;;
;; Ispell-Kontrolle
;;
(defvar ispell-german-mode ""
"Diese Variable kontrolliert beim german-dictionary den Modus:
  \"\"          -> Kein german-dictionary
  \"~latin1\\n\" -> german-dictionary mit Latin-Zeichensatz
  \"~tex\\n\"    -> german-dictionary mit TeX-Kryptogrammen")
 (make-variable-buffer-local 'ispell-german-mode)
 (put 'ispell-german-mode  'permanent-local "")
;;
;; Funktionen
;;
(defun german-mode ()
  "Initialisiert den `ISO 8859 Latin 1'-Standard
und sichert die entsprechende Abspeicherung der Umlaute als TeX-Makros.
Europ\344ischer Tastatur-Standard
------------------------------
Man dr\374cke *nacheinander* <ComposeCharacter>, <\">, <a> und staune!
Die deutsche Belegung einer amerikanischen Tastatur bitte mit der
Funktion `german-keyboard' einschalten."
  (interactive)
  (ger-active)
  (cond
     ((not german-mode)
	(setq german-mode 1)
	(german-mode-Init)
	(german-mode-Latin))
     ((= german-mode  1)
	(setq german-mode -1)
	(german-mode-TeX))
     ((= german-mode -1)
	(setq german-mode 1)
	(german-mode-Latin))
     (t (setq german-mode -1))))
;;
(defun german-mode-off ()
  "Schaltet s\344mtliche Features und Belegungen aus dem german-mode ab.
Dazu werden erst die Umlaute in `ISO 8859 Latin 1' dargestellt, um
danach alle Belegungen zu entfernen."
  (interactive)
  (ger-inactive)
  (local-unset-key [?\304])
  (local-unset-key [?\326])
  (local-unset-key [?\334])
  (local-unset-key [?\344])
  (local-unset-key [?\366])
  (local-unset-key [?\337])
  (local-unset-key [?\374])
  (remove-hook 'after-save-hooks        'TeX-german-original)
  (remove-hook 'after-save-hook         'TeX-german-original)
  (remove-hook 'local-write-file-hooks  'TeX-german-style)
  (setq german-mode nil))
;;
(defun german-mode-Init ()
"Zusammenfassung der Initialisierung des german-mode"
    (require 'iso-syntax)
    (modify-syntax-entry ?\304 "w")
    (modify-syntax-entry ?\326 "w")
    (modify-syntax-entry ?\334 "w")
    (modify-syntax-entry ?\344 "w")
    (modify-syntax-entry ?\366 "w")
    (modify-syntax-entry ?\337 "w")
    (modify-syntax-entry ?\374 "w")
    (modify-syntax-entry ?\"   "w")
    (setq ispell-local-dictionary "deutsch")
    (setq ispell-german-mode "~latin1\n"))
;;
(defun german-mode-Latin ()
"Zusammenfassung der Setzung des german-mode TeX-Standards"
    (add-hook 'after-save-hooks        'TeX-german-original)
    (add-hook 'after-save-hook         'TeX-german-original)
    (add-hook 'local-write-file-hooks  'TeX-german-style)
    (local-set-key [?\304] 'self-insert-command)
    (local-set-key [?\326] 'self-insert-command)
    (local-set-key [?\334] 'self-insert-command)
    (local-set-key [?\344] 'self-insert-command)
    (local-set-key [?\366] 'self-insert-command)
    (local-set-key [?\337] 'self-insert-command)
    (local-set-key [?\374] 'self-insert-command)
    (if (or (string= ispell-local-dictionary "deutsch")
	    (string= ispell-local-dictionary "deutsch8"))
	(setq ispell-german-mode "~latin1\n")
      (setq ispell-local-dictionary "deutsch"))
   (TeX-german-original)
    (message (concat
	"Amerikanische Tastatur mit deutscher Belegung:"
	" `M-x german-keyboard'")))
;;
(defun german-mode-TeX ()
"Zusammenfassung der Setzung des german-mode Latin-Standards"
    (remove-hook 'after-save-hooks        'TeX-german-original)
    (remove-hook 'after-save-hook         'TeX-german-original)
    (remove-hook 'local-write-file-hooks  'TeX-german-style)
    (local-unset-key [?\304])
    (local-unset-key [?\326])
    (local-unset-key [?\334])
    (local-unset-key [?\344])
    (local-unset-key [?\366])
    (local-unset-key [?\337])
    (local-unset-key [?\374])
    (if (or (string= ispell-local-dictionary "deutsch")
	    (string= ispell-local-dictionary "deutsch8"))
	(setq ispell-german-mode "~tex\n")
      (setq ispell-local-dictionary "deutsch"))
    (TeX-german-style))
;;
(defun ispell-german-mode ()
"Sendet dem Ispell-Proze\337 bei german-dictionary den Modus aus
 der german-mode Funktion."
 (if (or (string= ispell-local-dictionary "deutsch")
	 (string= ispell-local-dictionary "deutsch8"))
     (process-send-string ispell-process ispell-german-mode)
   (setq ispell-german-mode "")))
;;
;; Internes
;;
(defun TeX-german-original ()
  "Wechsel der Umlaute von der German-Style- in die Originalschreibweise"
  (let ((TeX-modified (buffer-modified-p)))
       (ger-translate ger-g2iso-table)
    (set-buffer-modified-p TeX-modified))
  )
;;
(defun TeX-german-style ()
  "Wechsel der Umlaute von der Original- in die German-Style-Schreibweise"
       (ger-translate ger-iso2g-table)
  )
;;
;; Eine deutsche Tastatur auf einem amerikanischen Keyboard
;;
(defun __ger-set-uskey-Auml () (interactive "*") (insert ?\304))
(defun __ger-set-uskey-Ouml () (interactive "*") (insert ?\326))
(defun __ger-set-uskey-Uuml () (interactive "*") (insert ?\334))
(defun __ger-set-uskey-auml () (interactive "*") (insert ?\344))
(defun __ger-set-uskey-ouml () (interactive "*") (insert ?\366))
(defun __ger-set-uskey-suml () (interactive "*") (insert ?\337))
(defun __ger-set-uskey-uuml () (interactive "*") (insert ?\374))
(defun __ger-set-uskey-ZY   () (interactive "*") (insert ?Y))
(defun __ger-set-uskey-YZ   () (interactive "*") (insert ?Z))
(defun __ger-set-uskey-zy   () (interactive "*") (insert ?y))
(defun __ger-set-uskey-yz   () (interactive "*") (insert ?z))
;;
(defun german-keyboard ()
  "Schalter zwischen der deutschen bzw. der originalen Belegung
einer *amerikanischen* Tastatur zum Blindschreiben.
\304nderung der Tastatur beim Aufruf von \"german-keyboard\":
     \"    <-->  \304    bzw.    '    <-->  \344
     :    <-->  \326    bzw.    ;    <-->  \366
     {    <-->  \334    bzw.    [    <-->  \374
     -    <-->  \337
     z    <-->  y    bzw.    y    <-->  z
     Z    <-->  Y    bzw.    Y    <-->  Z
Die urspr\374nglichen Zeichen erh\344lt man durch die Tastenkombination
<Crtl> + <q> und der Eingabe des gew\374nschten Zeichens."
  (interactive)
  (cond ((not german-mode) (german-mode))
        ((= german-mode -1) (german-mode)))
  (if ger-keyboard-mode
      (progn
	(setq ger-keyboard-mode nil)
	(local-unset-key [?"])
	(local-unset-key [?:])
	(local-unset-key [?{])
	(local-unset-key [?'])
	(local-unset-key [?;])
	(local-unset-key [?-])
	(local-unset-key [?[])
	(local-unset-key [?Z])
	(local-unset-key [?Y])
	(local-unset-key [?z])
	(local-unset-key [?y])
	(message "Amerikanische Tastatur in Originalbelegung"))
    (setq ger-keyboard-mode t)
    (local-set-key [?"] '__ger-set-uskey-Auml)
    (local-set-key [?:] '__ger-set-uskey-Ouml)
    (local-set-key [?{] '__ger-set-uskey-Uuml)
    (local-set-key [?'] '__ger-set-uskey-auml)
    (local-set-key [?;] '__ger-set-uskey-ouml)
    (local-set-key [?-] '__ger-set-uskey-suml)
    (local-set-key [?[] '__ger-set-uskey-uuml)
    (local-set-key [?Z] '__ger-set-uskey-ZY)
    (local-set-key [?Y] '__ger-set-uskey-YZ)
    (local-set-key [?z] '__ger-set-uskey-zy)
    (local-set-key [?y] '__ger-set-uskey-yz)
    (message
     (concat
      "Amerikanische Tastatur mit deutscher Belegung:"
      " Hilfe -> `C-h f german-keyboard'"))))
;;
;; Gewohntes f"ur eve-Benutzer
(defun tex-write ()
  "Die \304nderung des Buffers erfolgt \374ber die Hooks
\"local-write-contents-hooks\" und \"after-save-hook\[s\]\""
  (interactive)
  (save-buffer))
;;
;;
(provide 'ger-keys)
;;
;; Ende ger-keys.el
