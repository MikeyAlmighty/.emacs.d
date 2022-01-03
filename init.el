;; COCKPIT
(setq inhibit-startup-message t)
  
;; Declutter Frame/Window space
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 8)       ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar

;;; Startup
;;; PACKAGE LIST
(setq package-archives 
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

;;; BOOTSTRAP USE-PACKAGE
(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;;; UNDO
;; Vim style undo not needed for emacs 28
(use-package undo-fu)

(use-package magit)

;;; Vim Bindings
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  (setq evil-want-C-u-scroll t)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package linum-relative
  :config
  (linum-relative-global-mode t))

(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode t)
  (setq which-key-idle-delay 1))

;; THEME
(use-package badwolf-theme
  :config
  (load-theme 'badwolf t))

(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode)
  :custom
  (projectile-completion-system 'ivy)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Dev")
    (setq projectile-project-search-path '("~/Dev")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
        ("C-x b" . counsel-ibuffer)
        ("C-x C-f" . counsel-find-file)
        :map minibuffer-local-map
        ("C-r" . counsel-minibuffer-history)))

;; Requires ag to be installed on the system (https://github.com/ggreer/the_silver_searcher)
(use-package ag)

(use-package counsel-projectile
  :config
  (counsel-projectile-mode))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-outrun-electric t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; Fresh install requires: M-x all-the-icons-install-fonts
(use-package all-the-icons)

(use-package general
  :config
  (general-evil-setup t)

  (general-create-definer mikey/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"))

(use-package org-roam
  :ensure t)

(use-package rjsx-mode)
(use-package json-mode)
(use-package typescript-mode)
(use-package tide)
(use-package prettier)

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (typescript-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
;; (use-package lsp-ui :commands lsp-ui-mode)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

(mikey/leader-keys
  "g"  '(:ignore g :which-key "Magit")
  "gg" '(magit-status-here :which-key "Magit Status")
  "gl" '(magit-log-all :which-key "Magit Log")
  "p"  '(:ignore p :which-key "Project")
  "pa" '(projectile-add-known-project :which-key "Add Project")
  "pd" '(projectile-remove-known-project :which-key "Remove Project")
  "pp" '(projectile-switch-project :which-key "Switch Project")
  "pq" '(counsel-projectile-ag :which-key "Search Project")
  "pf" '(projectile-find-file :which-key "Find File")
  "w"  '(:ignore w :which-key "Window")
  "wh" '(evil-window-left :which-key "Move Window Left")
  "wb" '(balance-windows :which-key "Balance Windows")
  "wl" '(evil-window-right :which-key "Move Window Right")
  "wk" '(evil-window-up :which-key "Move Window Up")
  "wj" '(evil-window-down :which-key "Move Window Down")
  "n"  '(:ignore w :which-key "Notes")
  "ni" '(org-roam-node-insert :which-key "Insert Node")
  "nf" '(org-roam-node-find :which-key "Find Nodes")
  "o"  '(:ignore d :which-key "Dired")
  "o-" '(dired-jump :which-key "Jump")
  "q"  '(:ignore q :which-key "Comment")
  "cl" '(comment-line :which-key "Line")
  "co" '(comment-region :which-key "Region"))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; TODO: split branch here
(setq org-roam-directory "~/Dev/Playground/cerebrum")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("da53441eb1a2a6c50217ee685a850c259e9974a8fa60e899d393040b4b8cc922" "16ab866312f1bd47d1304b303145f339eac46bbc8d655c9bfa423b957aa23cc9" "cf9414f229f6df728eb2a5a9420d760673cca404fee9910551caf9c91cff3bfa" default))
 '(notmuch-search-line-faces
   '(("unread" :foreground "#aeee00")
     ("flagged" :foreground "#0a9dff")
     ("deleted" :foreground "#ff2c4b" :bold t)))
 '(package-selected-packages
   '(lsp-ivy lsp-mode tide prettier typescript-mode json-mode rjsx-mode org-roam ag counsel-projectile evil-magit general evil-leader all-the-icons doom-themes marginalia helpful magit which-key linum-relative badwolf-theme projectile tron-legacy-theme evil-collection evil undo-fu counsel ivy use-package shrink-path)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
