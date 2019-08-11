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


(add-to-list 'org-structure-template-alist '("y" . "src c++"))

(org-babel-do-load-languages
 'org-babel-load-languages '((C . t)))

; (add-to-list 'load-path "~/.emacs.d/lisp/")
; (load "ob-C.el")
(require 'ob-C)


;; (provide '.emacs)\n ;;; .emacs ends hier