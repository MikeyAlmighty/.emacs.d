;; COCKPIT
(setq inhibit-startup-message t)

(setq evil-want-C-u-scroll t)

;; Declutter Frame/Window space
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 8)       ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
; (setq visible-bell t)

(load-theme 'wombat)

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

(use-package magit
  :bind ((""))
  )

;;; Vim Bindings
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))

(define-key evil-motion-state-map " " nil)

(define-key evil-motion-state-map (kbd "SPC w h") 'evil-window-left)
(define-key evil-motion-state-map (kbd "SPC w j") 'evil-window-down)
(define-key evil-motion-state-map (kbd "SPC w k") 'evil-window-up)
(define-key evil-motion-state-map (kbd "SPC w l") 'evil-window-right)

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
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
  (setq which-key-idle-delay 0))

;; THEME
(use-package badwolf-theme
  :config
  (load-theme 'badwolf t))

(use-package projectile
  :config
  (projectile-mode +1))

;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("16ab866312f1bd47d1304b303145f339eac46bbc8d655c9bfa423b957aa23cc9" "cf9414f229f6df728eb2a5a9420d760673cca404fee9910551caf9c91cff3bfa" default))
 '(package-selected-packages
   '(doom-themes marginalia helpful magit which-key linum-relative badwolf-theme projectile tron-legacy-theme evil-collection evil undo-fu counsel ivy use-package shrink-path)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
