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
(defvar my-auto-save-folder "~/.emacs.d/auto-save/"); folder for auto-saves

;my load path
 (add-to-list 'load-path "~/symlink/emacs")

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
