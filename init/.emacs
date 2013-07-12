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

;my load path
 (add-to-list 'load-path "~/symlink/emacs")
 (add-to-list 'load-path "~/.emacs.d")
; Requires the emacs-goodies-el package
(add-to-list 'load-path "/usr/share/emacs23/site-lisp/emacs-goodies-el/")

; Color theme
(require 'color-theme)
(require 'color-theme-tango)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-tango)))
; line numbers
(require 'line-num)
	(display-line-numbers)

;; Read to do list
(find-file "/mnt/disk/Work/TODO.txt")
;; Load directory paths
(cd "~/symlinks/")

;; From Bryan Oakley at SO
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 80))
           (add-to-list 'default-frame-alist (cons 'width 100)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
         (cons 'height (/ (- (x-display-pixel-height) 190)
                             (frame-char-height)))))))

;(set-frame-size-according-to-resolution)

;Window splitter
;       (other-window 1)
        (split-window-vertically)
        (other-window 1)
        (dired "~/symlinks")
        (split-window-horizontally)
        (other-window 1)
        (R)
;; Fullscreen 
;
;  (add-hook 'emacs-startup-hook (lambda ()
 ;                                 (set-frame-parameter nil 'fullscreen 'fullboth)))

(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
; Can't use these as they are set to buffer switching
;(global-set-key (kbd "C-x <right>") 'windmove-right)
;(global-set-key (kbd "C-x <left>") 'windmove-left)

; requires windowswitch-el
(require 'switch-window)
;requires highlight-indentation
(require 'highlight-indentation)
; 80 line width hook
(require 'column-marker)
(add-hook 'text-mode-hook (lambda () (interactive) (column-marker-1 80)))
; Parenthesis highlighting
(show-paren-mode t) ;for Emacs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      Emacs Speaks Statistics                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; automatically get the correct mode 
auto-mode-alist (append (list '("\\.c$" . c-mode)
			      '("\\.tex$" . latex-mode)
			      '("\\.S$" . S-mode)
			      '("\\.s$" . S-mode)
			      '("\\.R$" . R-mode)
			      '("\\.r$" . R-mode)
			      '("\\.html$" . html-mode)
                              '("\\.emacs" . emacs-lisp-mode)
	                )
		      auto-mode-alist)

;; ESS mode
(require 'ess-tracebug)
(add-hook 'ess-post-run-hook 'ess-tracebug)
;(setq ess-use-auto-complete 'script-only)
;(define-key ac-completing-map (kbd "M-h") 'ac-quick-help)
;; Set to open help in a webbrowser
;;(setq inferior-ess-r-help-command "help(\"%s\", help_type=\"html\")\n")
;;(setq ess-help-own-frame t)
;; ESS-R_object-tooltip
;;(require 'ess-R-object-tooltip)
;; Auto completion for R
;;(require 'ac-R)
;;(make-local-variable ac-ignore-case)





