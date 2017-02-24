;; init.el

;;===========================================
;; common
;;===========================================
(prefer-coding-system 'utf-8)

(package-initialize)

(require 'cask)
(cask-initialize)

(setq make-backup-files nil)

(fset 'yes-or-no-p 'y-or-n-p)

(menu-bar-mode 0)

(global-auto-revert-mode 1)

(show-paren-mode t)

(setq dired-dwim-target t)
(setq dired-recursive-copies 'always)

(setq initial-scratch-message "")
(setq initial-major-mode 'markdown-mode)


;;===========================================
;; global keybind
;;===========================================
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\M-h" 'backward-kill-word)
(global-set-key (kbd "C-o") 'other-window)


;;===========================================
;; customize
;;===========================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-search-threshold 1000)
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 2)
 '(global-anzu-mode t)
 '(global-company-mode t)
 '(helm-mode t)
 '(popwin-mode t)
 '(recentf-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-group-tag ((t (:inherit variable-pitch :foreground "blue" :weight bold :height 1.2))))
 '(custom-variable-tag ((t (:foreground "color-31" :weight bold))))
 '(font-lock-function-name-face ((t (:foreground "color-30")))))


;;===========================================
;; anzu
;;===========================================
(require 'anzu)


;;===========================================
;; company
;;===========================================
(require 'company)
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-h") nil)
(define-key company-active-map (kbd "<tab>") 'company-complete)
(define-key company-active-map (kbd "C-i") 'company-complete-selection)



;;===========================================
;; recentf
;;===========================================
(require 'recentf)
  

;;===========================================
;; helm
;;===========================================
(require 'helm)
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)


;;===========================================
;; popwin
;;===========================================
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)


;;===========================================
;; docker
;;===========================================
(require 'dockerfile-mode)
(autoload 'dockerfile-mode "dockerfile-mode" nil t)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;;===========================================
;; ruby-mode
;;===========================================
(require 'dockerfile-mode)
(setq ruby-insert-encoding-magic-comment nil)
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))
(setq ruby-deep-indent-paren-style nil)

;;===========================================
;; magit
;;===========================================
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)
(custom-set-faces  
 '(diff-added ((t (:foreground "#149914" :background nil :inherit nil))))
 '(diff-removed ((t (:foreground "#991414" :background nil :inherit nil)))))
;; (magit-file-header ((t (:foreground "violet"))))
;; (magit-hunk-header ((t (:foreground "blue"))))
;; (magit-header ((t (:foreground "cyan"))))
;; (magit-tag-label ((t (:background "blue" :foreground "orange"))))
;; (magit-diff-add ((t (:foreground "MediumSlateBlue"))))
;; (magit-diff-del ((t (:foreground "maroon"))))
;; (magit-item-highlight ((t (:background "#000012"))))


;;===========================================
;; undo-tree
;;===========================================
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)


;;===========================================
;; tomorrow-night
;;===========================================
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'tomorrow-night-bright t)

;;===========================================
;; ruby-mode
;;===========================================
(setq ruby-insert-encoding-magic-comment nil)


;;===========================================
;; template
;;===========================================
;(require 'template)



