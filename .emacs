;; -*- Mode: Emacs-Lisp -*-

;;; This is a sample .emacs file.
;;;
;;; The .emacs file, which should reside in your home directory, allows you to
;;; customize the behavior of Emacs.  In general, changes to your .emacs file
;;; will not take effect until the next time you start up Emacs.  You can load
;;; it explicitly with `M-x load-file RET ~/.emacs RET'.
;;;
;;; There is a great deal of documentation on customization in the Emacs
;;; manual.  You can read this manual with the online Info browser: type
;;; `C-h i' or select "Emacs Info" from the "Help" menu.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      Basic Customization                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start up screen
(setq inhibit-startup-message t)
(set-language-environment "Latin-1") ; Support for most western languages
(global-set-key [(shift insert)] 'clipboard-yank) ; clipboard copying
(setq x-select-enable-clipboard t) ; clipboard interaction
(defvar my-auto-save-folder "~/.emacs.d/auto-save/"); folder for auto-saves

;; font size
(set-face-attribute 'default nil :height 80)

;my load paths
 (add-to-list 'load-path "~/symlink/emacs/")
 (add-to-list 'load-path "~/.emacs.d/lisp/")

; Color theme
(require 'color-theme)
(require 'color-theme-tango)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-tango)))
; line numbers
(require 'line-num)
	(add-hook 'text-mode-hook 'display-line-numbers)
	(add-hook 'ess-mode-hook 'display-line-numbers)

(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
; Can't use these as they are set to buffer switching
;(global-set-key (kbd "C-x <right>") 'windmove-right)
;(global-set-key (kbd "C-x <left>") 'windmove-left)

; requires windowswitch-el switch with C-o 
(require 'switch-window)
;requires highlight-indentation
(require 'highlight-indentation)
; 80 line width hook
(require 'column-marker)
(add-hook 'text-mode-hook (lambda () (interactive) (column-marker-1 80)))
(add-hook 'ess-mode-hook (lambda () (interactive) (column-marker-1 80)))

; Parenthesis highlighting
(show-paren-mode t) ;for Emacs

(defun dired-window () (window-at (frame-width) 1))

(eval-after-load 'dired
  '(define-key dired-mode-map (kbd "o")
     (lambda ()
       (interactive)
       (let ((dired-window (dired-window)))
         (set-window-buffer dired-window
                            (find-file-noselect 
                             (dired-get-file-for-visit)))
         (select-window dired-window)))))

;;Package.el repositories
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(setq package-check-signature nil)
;; Enable toggling of uninteresting files.
(setq dired-omit-mode t)

;; CamelCaseProgramming sensitivity
(subword-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Awesome custom functions

;; Copy the current file path
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name))
  (kill-new (file-truename buffer-file-name))
)
(global-set-key [C-f1] 'show-file-name)

;; increment numbers function
(defun increment-number-at-point ()
      (interactive)
      (skip-chars-backward "0123456789")
      (or (looking-at "[0123456789]+")
          (error "No number at point"))
      (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

    (global-set-key (kbd "C-c +") 'increment-number-at-point)

;; insert date
  (defun insert-date (prefix)
    "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
    (interactive "P")
    (let ((format (cond
                   ((not prefix) "%d.%m.%Y")
                   ((equal prefix '(4)) "%Y-%m-%d")
                   ((equal prefix '(16)) "%A, %d. %B %Y")))
          (system-time-locale "de_DE"))
      (insert (format-time-string format))))
  (global-set-key (kbd "C-c d") 'insert-date)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      Emacs Speaks Statistics                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(load 'ess-site')
;; automatically get the correct mode 
(add-to-list 'auto-mode-alist '("\\.r$'" . R-mode))
(add-to-list 'auto-mode-alist '("\\.R$'" . R-mode))


;;auto-mode-alist (append (list '("\\.c$" . c-mode)
;;			      '("\\.tex$" . latex-mode)
;;			      '("\\.S$" . S-mode)
;;			      '("\\.s$" . S-mode)
;;			      '("\\.R$" . R-mode)
;;			      '("\\.r$" . R-mode)
;;			      '("\\.html$" . html-mode)
;;                            '("\\.emacs" . emacs-lisp-mode)
;;	                )
;;		      auto-mode-alist)


;;(require 'r-autoyas)
(add-hook 'ess-mode-hook 'r-autoyas-ess-activate)
(add-hook 'ess-mode 'yas/minor-mode-on) 

;; Add support for knit and purl
;;(add-to-list 'load-path "~/.emacs.d/ess-knitr/")
(require 'ess-knitr)

;; ESS mode
;;(require 'ess-tracebug)
;;(add-hook 'ess-post-run-hook 'ess-tracebug)
;;(setq ess-use-auto-complete 'script-only)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ess-R-font-lock-keywords (quote ((ess-R-fl-keyword:modifiers . t) (ess-R-fl-keyword:fun-defs . t) (ess-R-fl-keyword:keywords . t) (ess-R-fl-keyword:assign-ops . t) (ess-R-fl-keyword:constants . t) (ess-fl-keyword:fun-calls . t) (ess-fl-keyword:numbers . t) (ess-fl-keyword:operators . t) (ess-fl-keyword:delimiters) (ess-fl-keyword:=) (ess-R-fl-keyword:F&T)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Stop enter based indention of everything in ESS mode
(add-hook 'ess-mode-hook 
          (lambda () 
            (local-set-key (kbd "RET") 'newline)))

(setq ess-eval-visibly nil) ; ESS will not print the evaluated commands, also speeds up the evaluation 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     Set Windows		  			                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;; STOP BEEPING!!!
(setq visible-bell 1)


;; Numbers always on
(global-linum-mode t) 
;; Read to do list
(find-file "/mnt/disk/Work/todo.org")

;;Window splitter
       (other-window 1)
        (split-window-horizontally)
        (other-window 2)
        (dired "~/symlinks")
        (split-window-vertically)
        (other-window 3)
        (list-buffers)

;; Auto predictive completion? (must start after autoyas)
(setq global-pabbrev-mode t)
