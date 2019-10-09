;;; Emacs --- init with init install script
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;;+++ package-list +++
;; insert packages for init installation
(setq package-list
      '(;; Visual Packages:
	smart-mode-line  ;; 08.07.19
	all-the-icons
	;; IDE
	neotree
	magit
	;; Editor
	evil-mc-extras   ;; 08.07.19
	evil-mc          ;; 08.07.19
	multiple-cursors
	irony
	flyspell
	helm
	helm-company
	company
	evil
	flycheck
	markdown-mode
	yasnippet
	;; org-mode
	org
	org-kanban
	;; org-capture-templates
	;; Other stuff
	use-package
	
	)
      )

;;+++ Description for all installed packages +++
;; use-package: declaration for simplyfying your .emacs
;; all-the-icons: gives some beautiful icons for neotree or dired
;; company: is a code completion frontend
;; evil: vim in emacs!
;; flycheck: brings on-the-fly syntax checking
;; magit: git in emacs
;; markdown-mode: Markdown with emacs
;; neotree: a tree explorer for emacs
;; yasnippet: is a template system for emacs
;; irony:
;; flyspell
;; helm


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;+++ use-package +++ 15.06.19
(eval-when-compile
  (require 'use-package))
;;(require 'use-package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(doc-view-continuous t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (multiple-cursors function-args evil-mc-extras evil-mc smart-mode-line helm-ag company-rtags rtags helm-flyspell company-c-headers use-package plantuml-mode helm-bibtex company-auctex auctex org-caldav pomodoro org all-the-icons neotree markdown-mode latex-preview-pane magit evil yasnippet)))
 '(plantuml-default-exec-mode (quote jar))
 '(plantuml-jar-path "~/.emacs.d/plantuml/plantuml.jar"))





(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;
;; open Emacs with fullscreen
(neotree)
(toggle-frame-fullscreen)

;; Recent Files
;; recentf-open-files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)



;;##################
;; packages
;;##################

;;+++ evil-mode +++
(require 'evil)
(evil-mode 1)
(show-paren-mode 1)

;;+++ neotree +++ 15.06.19
;; with help from https://github.com/syl20bnr/spacemacs/issues/4042
(require 'neotree)
(global-set-key (kbd "<f9>") 'neotree-toggle)

;; open neotree with start up
(setq neo-smart-open t)

;; disable the evil vim keys
(with-eval-after-load 'neotree
    (add-hook 'neotree-mode-hook
              (lambda()
                (define-key evil-motion-state-local-map (kbd "o") 'neotree-enter)
                (define-key evil-motion-state-local-map (kbd "i") (neotree-make-executor
                                                                   :file-fn 'neo-open-file-horizontal-split))
                (define-key evil-motion-state-local-map (kbd "s") (neotree-make-executor
                                                                    :file-fn 'neo-open-file-vertical-split))
                (define-key evil-motion-state-local-map (kbd "S") 'neotree-hidden-file-toggle)
        (define-key evil-motion-state-local-map (kbd "TAB")  'neotree-stretch-toggle)
	(define-key evil-motion-state-local-map (kbd "RET")  'neotree-enter)
	(define-key evil-motion-state-local-map (kbd "|")    'neotree-enter-vertical-split)
	(define-key evil-motion-state-local-map (kbd "-")    'neotree-enter-horizontal-split)
	(define-key evil-motion-state-local-map (kbd "?")    'evil-search-backward)
	(define-key evil-motion-state-local-map (kbd "c")    'neotree-create-node)
	(define-key evil-motion-state-local-map (kbd "d")    'neotree-delete-node)
	(define-key evil-motion-state-local-map (kbd "gr")   'neotree-refresh)
	;; (define-key evil-motion-state-local-map (kbd "h")    'spacemacs/neotree-collapse-or-up)
	(define-key evil-motion-state-local-map (kbd "H")    'neotree-select-previous-sibling-node)
	(define-key evil-motion-state-local-map (kbd "J")    'neotree-select-down-node)
	(define-key evil-motion-state-local-map (kbd "K")    'neotree-select-up-node)
	;; (define-key evil-motion-state-local-map (kbd "l")    'spacemacs/neotree-expand-or-open)
	(define-key evil-motion-state-local-map (kbd "L")    'neotree-select-next-sibling-node)
	(define-key evil-motion-state-local-map (kbd "q")    'neotree-hide)
	(define-key evil-motion-state-local-map (kbd "r")    'neotree-rename-node)
	(define-key evil-motion-state-local-map (kbd "R")    'neotree-change-root)
;;      	(define-key evil-motion-state-local-map (kbd "s")    'neotree-hidden-file-toggle)
              'append)))


;;+++ pomodoro +++
'(pomodoro-desktop-notification t)
'(pomodoro-show-number t)
'(word-wrap t)


;;+++ irony-mode +++ 15.06.19
;; http://martinsosic.com/development/emacs/2017/12/09/emacs-cpp-ide.html
 (use-package irony
   :config
   ;; if irony server was never installed install it.
   (progn
     (unless (irony--find-server-executable) (call-interactively #'irony-install-server))))

;;+++ flyspell +++
;; https://www.emacswiki.org/emacs/FlySpell
;; change dictionary
(defun fd-switch-dictionary()
      (interactive)
      (let* ((dic ispell-current-dictionary)
    	 (change (if (string= dic "deutsch8") "english" "deutsch8")))
        (ispell-change-dictionary change)
        (message "Dictionary switched from %s to %s" dic change)
        ))

      (global-set-key (kbd "<f8>")   'fd-switch-dictionary)


;;+++ company mode +++ 15.06.19
(use-package company
 	     :config
 	     (progn
 	       (add-hook 'after-init-hook 'global-company-mode)
 	       (global-set-key (kbd "M-/") 'company-complete-common-or-cycle)
(setq company-idle-delay 0)))

;;
;; Add yasnippet support for all company backends
;;
;; http://emacs.stackexchange.com/questions/10431/get-company-to-show-suggestions-for-yasnippet-names
;; Add yasnippet support for all company backends
;; https://github.com/syl20bnr/spacemacs/pull/179
;;
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))


;;+++ Flycheck +++
;; TODO Flycheck only for some modes

(use-package flycheck
     :config
     (progn
       (global-flycheck-mode)))


;;+++ Latex-mode +++
;;(defun my-latex-mode-setup ()
;;   (setq-local company-backends
;;       (append '(company-math-symbols-latex company-latex-commands)
;;           company-backends))
;;   (local-set-key (kbd "C-z TAB") 'company-math-symbols-latex))
;; (add-hook 'org-mode-hook 'my-latex-mode-setup)
;;
;;(setq company-math-allow-latex-symbols-in-faces t)


;;+++ git / magit +++
(global-set-key (kbd "C-x g") 'magit-status)


;;+++ org-mode +++
(add-hook 'org-mode-hook #'(lambda ()
  ;; make the lines in the buffer wrap around the edges of the screen.
  ;; to press C-c q  or fill-paragraph ever again!
    (visual-line-mode)
    (org-indent-mode)))

;; The following lines are always needed. Choose your own keys.
;; actually, I used it never...?
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

(add-hook 'org-finalize-agenda-hook
  (lambda ()
    (setq appt-message-warning-time 10        ;; warn 10 min in advance
          appt-display-diary nil              ;; do not display diary when (appt-activate) is called
          appt-display-mode-line t            ;; show in the modeline
          appt-display-format 'window         ;; display notification in window
          calendar-mark-diary-entries-flag t) ;; mark diary entries in calendar
          org-agenda-include-diary t          ;; indlude agenda in diary
    (org-agenda-to-appt)                      ;; copy all agenda schedule to appointments
    (appt-activate 1)))                       ;; active appt (appointment notification)

(use-package org
  ;; :ensure org-plus-contrib 
  :config
    ; really long config section omitted
    ; not sure if I need this:
    (setq org-default-notes-file "~/.emacs.d/org/inbox.org")
    (setq org-capture-templates
          '(("t" "Todo [inbox]" entry
          (file+headline "~/.emacs.d/org/inbox.org" "Tasks")
          "* TODO %i%?\n%a")
            ("n" "Todo [inbox, no link]" entry
            (file+headline "~/.emacs.d/org/inbox.org" "Tasks")
            "* TODO %i%?\n")
            ("b" "Backlog" entry
            (file+headline "~/.emacs.d/org/backlog.org" "Backlog")
            "* %i%?\n%a")))
  :bind (; other bindings removed
         ("C-c c" . org-capture)))

;; org-Agenda
;; Maybe I should have a look on super-agenda:
;; https://github.com/alphapapa/org-super-agenda

(setq org-agenda-files '("~/.emacs.d/org/"))

;;(setq org-agenda-files (list "~/org/uni.org" 
;;                             "~/org/home.org"
;;			     "~/org/birthday.org"))

(setq org-todo-keyword-faces
  '(("WORKING" . "orange")
    ("CANCELLED" . "grey")
    ("IDEA" . "yellow")))

;; http://www.johnborwick.com/2019/02/23/org-todo-setup.html
;; WAITING(w@/!) means w is the keyboard shortcut,
;; @ means "note with timestamp"
;; /! means "add a timestamp even if I bailed on writing a note." 


(setq org-todo-keywords
  '((sequence "TODO(t)" "WORKING(n)" "WAITING(w@)"
              "POSTPONED(p)" "DONE(d@/!)" "CANCELLED(c)" "IDEA(@)")))

(setq org-plantuml-jar-path
      (expand-file-name "~/.emacs.d/plantuml/plantuml.jar"))

(setq org-hide-emphasis-markers t)

;;+++ org-mode calendar ++;;+++ org-mode calendar ++++
 (add-hook 'fancy-diary-display-mode-hook
	   '(lambda ()
              (alt-clean-equal-signs)))
  
 (defun alt-clean-equal-signs ()
   "This function makes lines of = signs invisible."
   (goto-char (point-min))
   (let ((state buffer-read-only))
     (when state (setq buffer-read-only nil))
     (while (not (eobp))
       (search-forward-regexp "^=+$" nil 'move)
       (add-text-properties (match-beginning 0) 
	                    (match-end 0) 
			    '(invisible t)))
     (when state (setq buffer-read-only t))))


;; org-kanban
;; (require 'org)
;; (define-key "C-al" 'org-kanban/switch)

;; org-calendar
(setq calendar-week-start-day 1)

(setq solar-n-hemi-seasons
      '("Frühlingsanfang" "Sommeranfang" "Herbstanfang" "Winteranfang"))

(setq holiday-general-holidays
      '((holiday-fixed 1 1 "Neujahr")
        (holiday-fixed 5 1 "1. Mai")
        (holiday-fixed 10 3 "Tag der Deutschen Einheit")))

;; Feiertage für Bayern, weitere auskommentiert
(setq holiday-christian-holidays
      '((holiday-float 12 0 -4 "1. Advent" 24)
        (holiday-float 12 0 -3 "2. Advent" 24)
        (holiday-float 12 0 -2 "3. Advent" 24)
        (holiday-float 12 0 -1 "4. Advent" 24)
        (holiday-fixed 12 25 "1. Weihnachtstag")
        (holiday-fixed 12 26 "2. Weihnachtstag")
        (holiday-fixed 1 6 "Heilige Drei Könige")
        (holiday-easter-etc -48 "Rosenmontag")
        ;; (holiday-easter-etc -3 "Gründonnerstag")
        (holiday-easter-etc  -2 "Karfreitag")
        (holiday-easter-etc   0 "Ostersonntag")
        (holiday-easter-etc  +1 "Ostermontag")
        (holiday-easter-etc +39 "Christi Himmelfahrt")
        (holiday-easter-etc +49 "Pfingstsonntag")
        (holiday-easter-etc +50 "Pfingstmontag")
        (holiday-easter-etc +60 "Fronleichnam")
        (holiday-fixed 8 15 "Mariae Himmelfahrt")
        (holiday-fixed 11 1 "Allerheiligen")
        ;; (holiday-float 11 3 1 "Buss- und Bettag" 16)
        (holiday-float 11 0 1 "Totensonntag" 20)))

    (add-hook 'calendar-load-hook
              (lambda ()
                (calendar-set-date-style 'european)))

(defun diary-schedule (m1 d1 y1 m2 d2 y2 dayname)
    "Entry applies if date is between dates on DAYNAME. 
    Order of the parameters is M1, D1, Y1, M2, D2, Y2 if 
    `european-calendar-style' is nil, and D1, M1, Y1, D2, M2, Y2 if 
    `european-calendar-style' is t. Entry does not apply on a history."
    (let ((date1 (calendar-absolute-from-gregorian
                    (if european-calendar-style
                        (list d1 m1 y1)
                      (list m1 d1 y1))))
            (date2 (calendar-absolute-from-gregorian
                    (if european-calendar-style
                        (list d2 m2 y2)
                      (list m2 d2 y2))))
            (d (calendar-absolute-from-gregorian date)))
        (if (and 
             (<= date1 d) 
             (<= d date2)
             (= (calendar-day-of-week date) dayname)
             (not (check-calendar-holidays date))
             )
             entry)))


;;+++ markdown +++
;; needs pandoc, using markdown in Emacs
(setq markdown-command "/usr/bin/pandoc")

;;+++ helm +++
;;
(helm-mode 1)

;;+++ Example function +++ 15.06.19
;; (defun hello-world()
;;   (interactive)
;;   (message "Hello World!"))
;;
;;   (global-set-key (kbd "<f7>") 'hello-world)

;;+++ toggle-terminal +++ 08.07.19
;; (defun new-buffer-terminal ()
;;   "Create a new frame with a new empty buffer."
;;   (interactive)
;;   (let ((buffer (generate-new-buffer "terminal")))
;;     (set-buffer-major-mode shell)
;;     (display-buffer buffer '(display-buffer-pop-up-frame . nil))))


;; Diese Funktion soll eine Shell öffnen. Ist diese schon geöffnet, soll sie wieder geschlossen werden.
;;
;; (defun open-shell()
;;       (interactive)
;;       (let* ((dic ispell-current-dictionary)
;;     	 (change (if (string= dic "deutsch8") "english" "deutsch8")))
;;         (ispell-change-dictionary change)
;;         (message "Dictionary switched from %s to %s" dic change)
;;         ))
;; 
;; (defcustom shell-window-width 25
;;   "*Specifies the width of the NeoTree window."
;;   :type 'integer
;;   :group 'neotree)
;; 
;; (defun shell-window--minimize-p ()
;;   "Return non-nil when the shell window is minimize."
;; (<= (window-width) shell-window-width))
;; 

(global-set-key (kbd "<f10>") 'shell)

;;############################################################
;;## Here I wait to add some specials hooks for specials modes

;;--- c++-hook ---
;; (defun save-and-compile-c++ ()
;;   (interactive)
;;   (save-buffer)
;;   (compile))

(defun my-compiler ()
  (interactive)
  (save-buffer)
  (make-frame-command)
  (compile))

(defun my-c++-compile-key ()
    (interactive)
    (local-set-key (kbd "<f6>") 'my-compiler))


(add-hook 'c++-mode-hook 'my-c++-compile-key)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;##### added for literate programming ####
;(require 'org-tempo)  

;(add-to-list 'org-structure-template-alist
;              '("sc" . "src"))


;; Wofür sind die folgenden 3 Zeilen? Ich vermute, dass es den Source Block im org-mode ermöglicht.
;;(add-to-list 'org-structure-template-alist '("y" . "src c++"))

(org-babel-do-load-languages
 'org-babel-load-languages '((C . t)
			     (plantuml . t))

;; add plantuml in org-mode
;; http://eschulte.github.io/babel-dev/DONE-integrate-plantuml-support.html
;(org-babel-do-load-languages
; 'org-babel-load-languages
; '((plantuml . t))) ; this line activates dot

;(with-eval-after-load 'org-babel-do-load-languages
;  'org-babel-load-languages '(plantuml . t))


; (add-to-list 'load-path "~/.emacs.d/lisp/")
; (load "ob-C.el")
(require 'ob-C)


;; (provide '.emacs)\n ;;; .emacs ends hier
