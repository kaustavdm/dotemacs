 ;;; Emacs configuration file

;;; Code:

;; -------------------------------------------------
;; Base editor configurations
;; -------------------------------------------------

;; Scrollbars, menubars, toolbars. Hide'em
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)
      (mouse-wheel-mode t)))

;; Remove menu bar
(menu-bar-mode -1)

;; Base text mode and other configuration
(setq inhibit-startup-message t)
(setq default-major-mode 'text-mode)

;; Line and column numbers
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; Enable windmove
(require 'windmove)
(windmove-default-keybindings 'super)

;; Set paren-mode and transient-mark-mode
(show-paren-mode t)
(transient-mark-mode t)

;; Change behaviour of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; Indentation
(setq default-tab-width 4)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)

;; Delete selection
(delete-selection-mode 1)

;; Set font
(set-frame-font "Consolas 12")

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

;; Changelog configuration
(setq user-mail-address "kaustav.dasmodak@yahoo.co.in")  ;; default: user@host
(setq change-log-default-name "CHANGELOG")   ;; default: ChangeLog

;; Startup *scratch* buffer
(setq initial-major-mode 'text-mode)
(setq initial-scratch-message "// Use this buffer for notes\n// Find files   : C-x C-f\n// Recent files : C-p f\n\n")

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
     (if (package-installed-p package) nil
       (package-install package)))
   packages))

;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Install packages
(ensure-package-installed
 'exec-path-from-shell
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
 'monokai-theme
 'multiple-cursors
 'editorconfig
 'go-mode
 'go-autocomplete
 'go-complete
 'go-projectile
 'go-rename
 'go-stacktracer
 'go-errcheck
 'go-playground
 'golint)

;; -------------------------------------------------
;; Package configurations
;; -------------------------------------------------

;; Theme
(load-theme 'monokai t)

;; Shell path initalize
(exec-path-from-shell-initialize)
(add-to-list 'load-path "~/.emacs.d/custom/")

;; Make sure to copy "./custom/env-custom-sample.el" to "./custom/env-custom.el"
(require 'env-custom)

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
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))
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
(setq whitespace-style '(face tabs empty trailing space-before-tab space-after-tab))
(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;; Electric pair mode
(add-hook 'prog-mode-hook 'electric-pair-mode)

;; Diff--hl
(setq diff-hl-fringe-bmp-function 'diff-hl-fringe-bmp-from-type)
(global-diff-hl-mode 1)

;; Multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Line numbers
(add-hook 'prog-mode-hook 'linum-mode)
(setq linum-format "%4d ")

;; Go mode
(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; OSX specific settings. Source: Emacs Prelude (https://github.com/bbatsov/prelude)
(when (eq system-type 'darwin)
  (defun prelude-swap-meta-and-super ()
    "Swap the mapping of Meta and Super. Very useful for people using their Mac with a Windows external keyboard
 from time to time."
    (interactive)
    (if (eq mac-command-modifier 'super)
        (progn
          (setq mac-command-modifier 'meta)
          (setq mac-option-modifier 'super)
          (message "Command is now bound to META and Option is bound to SUPER."))
      (progn
        (setq mac-command-modifier 'super)
        (setq mac-option-modifier 'meta)
        (message "Command is now bound to SUPER and Option is bound to META."))))

  (global-set-key (kbd "C-c w") 'prelude-swap-meta-and-super))

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

;; Toggle JS2 indent: Source: http://www.ianoxley.com/blog/2013/11/22/toggling-javascript-indentation/
(defun js2-toggle-indent ()
  (interactive)
  (setq js-indent-level (if (= js2-basic-offset 2) 4 2))
  (setq js2-indent-level (if (= js2-basic-offset 2) 4 2))
  (setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))
  (message "js2-indent-level, and js2-basic-offset set to %d"
           js2-basic-offset))

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
