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

(setq ring-bell-function 'ignore)

(setq vc-follow-symlinks t)


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
 '(js-indent-level 2)
 '(package-selected-packages
   (quote
    (less-css-mode yaml-mode web-mode vue-mode use-package undo-tree terraform-mode sync-recentf smex smartparens slim-mode recentf-ext projectile prodigy popwin pallet nyan-mode multiple-cursors markdown-mode magit js2-mode idle-highlight-mode htmlize highlight-indentation helm flycheck-cask expand-region exec-path-from-shell emmet-mode drag-stuff dockerfile-mode company anzu ac-php)))
 '(popwin-mode t)
 '(recentf-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-group-tag ((t (:inherit variable-pitch :foreground "blue" :weight bold :height 1.2))))
 '(custom-variable-tag ((t (:foreground "color-31" :weight bold))))
 '(diff-added ((t (:foreground "#149914" :background nil :inherit nil))))
 '(diff-removed ((t (:foreground "#991414" :background nil :inherit nil))))
 '(font-lock-function-name-face ((t (:foreground "color-30"))))
 '(web-mode-comment-face ((t (:foreground "#587F35"))))
 '(web-mode-css-at-rule-face ((t (:foreground "#DFCF44"))))
 '(web-mode-css-property-name-face ((t (:foreground "#87CEEB"))))
 '(web-mode-css-pseudo-class ((t (:foreground "#DFCF44"))))
 '(web-mode-css-selector-face ((t (:foreground "#DFCF44"))))
 '(web-mode-css-string-face ((t (:foreground "#D78181"))))
 '(web-mode-doctype-face ((t (:foreground "#4A8ACA"))))
 '(web-mode-html-attr-equal-face ((t (:foreground "#FFFFFF"))))
 '(web-mode-html-attr-name-face ((t (:foreground "#87CEEB"))))
 '(web-mode-html-attr-value-face ((t (:foreground "#D78181"))))
 '(web-mode-html-tag-face ((t (:foreground "#4A8ACA"))))
 '(web-mode-server-comment-face ((t (:foreground "#587F35")))))


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
(define-key company-active-map (kbd "C-h") 'delete-backward-char)
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
;; php-mode
;;===========================================
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))



;;===========================================
;; web-mode
;;===========================================
(add-to-list 'auto-mode-alist '("\\.tpl$" . web-mode))


;;===========================================
;; emmet-mode
;;===========================================
(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)


;;===========================================
;; vue-mode
;;===========================================
;; (defun your-layer-name/init-vue-mode ()
;;   (use-package vue-mode
;;     :config
;;     ;; 0, 1, or 2, representing (respectively) none, low, and high coloring
;;     (setq mmm-submode-decoration-level 0)))
(add-to-list 'auto-mode-alist '("\\.vue$" . vue-mode))



;;===========================================
;; php-mode
;;===========================================
(require 'cl)
(add-hook 'php-mode-hook
            '(lambda ()
               (auto-complete-mode t)
               (require 'ac-php)
               (setq ac-sources  '(ac-source-php ) )
               (yas-global-mode 1)
               (define-key php-mode-map  (kbd "C-]") 'ac-php-find-symbol-at-point)   ;goto define
               (define-key php-mode-map  (kbd "C-t") 'ac-php-location-stack-back   ) ;go back
               ))


;;===========================================
;; js-mode
;;===========================================
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-disabled-checkers '(javascript-jshint javascript-jscs))))
(setq js2-strict-missing-semi-warning nil)
(setq-default indent-tabs-mode nil)
(add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))

;;===========================================
;; template
;;===========================================
;(require 'template)



