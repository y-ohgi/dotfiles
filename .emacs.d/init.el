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
;; terraform-mode
;;===========================================
;(add-to-list 'auto-mode-alist '("\\.tf$" . terraform-mode)


;;===========================================
;; react-mode
;;===========================================
;; .js, .jsx を web-mode で開く
(add-to-list 'auto-mode-alist '("\\.js[x]?$" . web-mode))

;; 拡張子 .js でもJSX編集モードに
(setq web-mode-content-types-alist
      '(("jsx" . "\\.js[x]?\\'")))

;; インデント
(add-hook 'web-mode-hook
          '(lambda ()
             (setq web-mode-attr-indent-offset nil)
             (setq web-mode-markup-indent-offset 2)
             (setq web-mode-css-indent-offset 2)
             (setq web-mode-code-indent-offset 2)
             (setq web-mode-sql-indent-offset 2)
             (setq indent-tabs-mode nil)
             (setq tab-width 2)
          ))

;; 色
(custom-set-faces
 '(web-mode-doctype-face           ((t (:foreground "#4A8ACA"))))
 '(web-mode-html-tag-face          ((t (:foreground "#4A8ACA"))))
 '(web-mode-html-attr-name-face    ((t (:foreground "#87CEEB"))))
 '(web-mode-html-attr-equal-face   ((t (:foreground "#FFFFFF"))))
 '(web-mode-html-attr-value-face   ((t (:foreground "#D78181"))))
 '(web-mode-comment-face           ((t (:foreground "#587F35"))))
 '(web-mode-server-comment-face    ((t (:foreground "#587F35"))))

 '(web-mode-css-at-rule-face       ((t (:foreground "#DFCF44"))))
 '(web-mode-comment-face           ((t (:foreground "#587F35"))))
 '(web-mode-css-selector-face      ((t (:foreground "#DFCF44"))))
 '(web-mode-css-pseudo-class       ((t (:foreground "#DFCF44"))))
 '(web-mode-css-property-name-face ((t (:foreground "#87CEEB"))))
 '(web-mode-css-string-face        ((t (:foreground "#D78181"))))
 )


;;===========================================
;; vue-mode
;;===========================================
(add-to-list 'auto-mode-alist '("\\.vue$" . vue-mode)) 


;;===========================================
;; template
;;===========================================
;(require 'template)



