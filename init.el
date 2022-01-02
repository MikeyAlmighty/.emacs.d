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
  :config (projectile-mode)
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

(mikey/leader-keys
  "g"  '(:ignore g :which-key "Magit")
  "gg" '(magit-status-here :which-key "Status")
  "gl" '(magit-log-all :which-key "Log")
  "p"  '(:ignore p :which-key "Projects")
  "pa" '(projectile-add-known-project :which-key "Add Project")
  "ps" '(projectile-switch-project :which-key "Switch Project")
  "pf" '(projectile-find-file :which-key "Find File")
  "w"  '(:ignore w :which-key "Window")
  "wh" '(evil-window-left :which-key "Left")
  "wl" '(evil-window-right :which-key "Right")
  "wk" '(evil-window-up :which-key "Up")
  "wj" '(evil-window-down :which-key "Down"))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

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
   '(evil-magit general evil-leader all-the-icons doom-themes marginalia helpful magit which-key linum-relative badwolf-theme projectile tron-legacy-theme evil-collection evil undo-fu counsel ivy use-package shrink-path)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
