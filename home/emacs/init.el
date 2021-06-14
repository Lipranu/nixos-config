(require 'package)

;; optional. makes unpure packages archives unavailable
(setq package-archives nil)

(setq package-enable-at-startup nil)
(package-initialize)

(setq inhibit-startup-screen t)

;; Disable auto-save and backup
(setq make-backup-files nil)
(setq auto-save-list-file-name nil)
(setq auto-save-default nil)

(use-package which-key
  :config
  (which-key-mode))

(use-package all-the-icons)

(set-face-attribute
  'default
  nil
  :height 120
  :family "Iosevka")

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(global-hl-line-mode +1)
(delete-selection-mode 1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(show-paren-mode 1)
;;(global-whitespace-mode 1)
(ido-mode 1)
(line-number-mode)
(column-number-mode)

(use-package treemacs
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn (setq treemacs-width 25
               treemacs-no-png-images t)
  (pcase (cons (not (null (executable-find "git")))
               (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package evil
  :config
  (evil-mode 1))

(use-package kaolin-themes
  :config
  (load-theme 'kaolin-dark t))

(use-package doom-modeline
  :hook
  (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-bar-width 3
        doom-modeline-icon t
        doom-modeline-buffer-file-name-style 'truncate-with-project
        doom-modeline-minor-modes nil
        doom-modeline-modal-icon t))

(use-package company
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (global-company-mode 1))

(use-package company-nixos-options
  :config
  (add-to-list 'company-backends 'company-nixos-options))

(use-package helm-nixos-options
  :config
  (global-set-key (kbd "C-c C-S-n") 'helm-nixos-options))

;; 2 space instead of tab
(setq-default indent-tabs-mode nil
              tab-width 4
              c-basic-offset 4)

;; Show trailing white space
(setq-default show-trailing-whitespace t)

(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package treemacs-evil
  :after treemacs evil)

(use-package treemacs-projectile
  :after treemacs projectile)

(use-package treemacs-magit
  :after treemacs magit)

(use-package pdf-tools
  :init
  (pdf-tools-install))
