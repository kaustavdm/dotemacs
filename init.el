 ;;; Emacs configuration file

;; -------------------------------------------------
;; Base editor configurations
;; -------------------------------------------------

;; Scrollbars, menubars, toolbars. Hide'em
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Base text mode and other configuration
(setq inhibit-startup-message t)
(setq default-major-mode 'text-mode)

;; Line and column numbers
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; Set paren-mode and transient-mark-mode
(show-paren-mode t)
(transient-mark-mode t)

;; Let noobs use this editor
(mouse-wheel-mode t)

;; Change behaviour of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; Indentation
(setq tab-width 4)
(setq-default indent-tabs-mode nil)

;; Delete selection
(delete-selection-mode 1)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("emacs - " (:eval (if (buffer-file-name)
                              (abbreviate-file-name (buffer-file-name))
                            "%b"))))

;; Electric indent mode enable
(electric-indent-mode t)

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Stop creating backups
(setq make-backup-files nil)

;; -------------------------------
;; Setup packages
;; -------------------------------

;; Configure package sources
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Install packages
(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

 Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Install packages
(ensure-package-installed
 'magit
 'auto-complete
 'js2-mode
 'skewer-mode
 'ac-js2
 'json-mode
 'web-mode
 'markdown-mode
 'scss-mode
 'less-css-mode
 'sass-mode
 'projectile
 'helm
 'helm-projectile
 'php-mode
 'rust-mode
 'flycheck
 'diff-hl
 'undo-tree
 'monokai-theme)

;; -------------------------------------------------
;; Package configurations
;; -------------------------------------------------

;; Theme
(load-theme 'monokai t)

;;; auto complete
(require 'auto-complete-config)
(global-auto-complete-mode t)
(set-default 'ac-sources
             '(ac-source-imenu
               ac-source-dictionary
               ac-source-words-in-buffer
               ac-source-words-in-same-mode-buffers
               ac-source-words-in-all-buffer))
(setq ac-set-trigger-key "TAB")
(setq ac-set-trigger-key "<tab>")
(setq ac-auto-start 2)

;; JS2 mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)
(setq js2-highlight-level 3)

;; PHP mode
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode)) ;; - For Drupal
(add-to-list 'auto-mode-alist '("\\.\\(module\\|test\\|install\\|theme\\)$" . php-mode)) ;; - For Drupal

;; Web mode
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("/\\(views\\|html\\|theme\\|templates\\)/.*\\.php\\'" . web-mode))
(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 4)
(setq web-mode-enable-comment-keywords t)
(setq web-mode-enable-current-element-highlight t)

;; CSS mode
(setq css-indent-offset 2)

;; JSON mode
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(add-to-list 'auto-mode-alist '("\\manifest.webapp\\'" . json-mode))

;; Undo-tree mode
(global-undo-tree-mode 1)

;; Helm
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode 1)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;; Projectile
(projectile-global-mode)
(helm-projectile-on)

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Whitespace
(require 'whitespace)
(setq whitespace-line-column 120) ;; limit line length
(setq whitespace-style '(face tabs empty trailing lines-tail tab-mark))
(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;; Electric pair mode
(add-hook 'prog-mode-hook 'electric-pair-mode)

;; Didd--hl
(setq diff-hl-fringe-bmp-function 'diff-hl-fringe-bmp-from-type)
(global-diff-hl-mode 1)

;; --------------------------------------------------
;; Custom functions
;; --------------------------------------------------

(defun cleanup-buffer-or-region ()
  "Cleanup a region if selected, otherwise the whole buffer."
  (interactive)
  (call-interactively 'untabify)
  (call-interactively 'indent-region)
  (whitespace-cleanup))

(defun set-web-mode-indent-level (depth)
  (interactive "nIndent level: ")

  (setq web-mode-markup-indent-offset depth)
  (setq web-mode-css-indent-offset depth)
  (setq web-mode-code-indent-offset depth))

(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

;; --------------------------------------------------
;; Keybindings
;; --------------------------------------------------

;; Replace switch-buffer with helm-for-files
(global-set-key (kbd "C-x b") 'helm-for-files)

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Magit rules!
(global-set-key (kbd "C-x g") 'magit-status)

;; rename buffer & visited file
(global-set-key (kbd "C-c r") 'rename-file-and-buffer)

;; Recent files
(global-set-key (kbd "C-c f") 'helm-recentf)

;; Font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Perform general cleanup.
(global-set-key (kbd "C-c n") 'cleanup-buffer-or-region)

;; Newline and indent on pressing Return
(local-set-key (kbd "RET") 'newline-and-indent)
(put 'dired-find-alternate-file 'disabled nil)