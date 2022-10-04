(setq inhibit-startup-message t)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)
(menu-bar-mode 0)
(electric-pair-mode 1)
(set-fringe-mode 0)
(winner-mode 1)
(setq use-dialog-box nil) ;; don't pop up UI dialogs when prompting
(fset 'yes-or-no-p 'y-or-n-p)
(setq visible-bell t)
(cond
 ((find-font (font-spec :name "Cascadia Code"))
  (set-frame-font "Cascadia Code-12"))
 ((find-font (font-spec :name "Menlo"))
  (set-frame-font "Menlo-12"))
 ((find-font (font-spec :name "DejaVu Sans Mono"))
  (set-frame-font "DejaVu Sans Mono-14"))
 ((find-font (font-spec :name "Inconsolata"))
  (set-frame-font "Inconsolata-12")))
(setq gc-cons-threshold (* 100 1000 1000))
(setq tab-width 4)

(desktop-save-mode 1)
(setq desktop-path '("~/.emacs.d/desktop-mode"))
(setq desktop-dirname "~/.emacs.d/desktop-mode")

(recentf-mode 1)
(global-set-key (kbd "<f5>") 'recentf-open-files)

(save-place-mode 1)

(global-auto-revert-mode 1) ;; revert buffers when the underlying file has changed
(setq global-auto-revert-non-file-buffers t) ;; revert dired and other non-file buffers

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up-line 3)))
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down-line 3)))
(windmove-default-keybindings)

(global-display-line-numbers-mode t)
(dolist (mode '(eshell-mode-hook
		term-mode-hook
		treemacs-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; disable Ctrl+Z in a graphical environment
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z C-z") 'my-suspend-frame)
(defun my-suspend-frame ()
  (interactive)
  (if (display-graphic-p)
      (message "suspend-frame disabled for graphical environments")
    (suspend-frame)))

;; temporary files
(setq backup-directory-alist `(("." . "~/.emacs-saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
(setq create-lockfiles nil)

(require 'package)
(setq custom-file (concat user-emacs-directory "/custom.el"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-always-ensure t)

;; custom M-s search using ivy
(use-package swiper)

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config (setq ivy-initial-inputs-alist nil)) ;; dont start searches with ^

(use-package ivy
  :diminish
  :init (ivy-mode 1)
  :bind (("C-s" . swiper)))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package all-the-icons
  :if (display-graphic-p)
  :commands all-the-icons-install-fonts
  :init (unless (find-font (font-spec :name "all-the-icons"))
	  (all-the-icons-install-fonts t)))

(use-package all-the-icons-dired
  :if (display-graphic-p)
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :init (setq lsp-keymap-prefix "C-c l")
  :hook
  ((c-mode . lsp-deferred))
  :config
  (setq read-process-output-max (* 1024 1024))
  (setq lsp-log-io nil))

(use-package flycheck
  :hook (lsp-mode . flycheck-mode))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))

(use-package treemacs
  :bind
  (:map global-map
	("M-0" . treemacs-select-window)
	("C-x t t" . treemacs))
  :config
  (dolist (face '(treemacs-root-face
                  treemacs-git-unmodified-face
                  treemacs-git-modified-face
                  treemacs-git-renamed-face
                  treemacs-git-ignored-face
                  treemacs-git-untracked-face
                  treemacs-git-added-face
                  treemacs-git-conflict-face
                  treemacs-directory-face
                  treemacs-directory-collapsed-face
                  treemacs-file-face
                  treemacs-tags-face))
      (set-face-attribute face nil :family "SF Mono")))

(use-package lsp-treemacs
  :after lsp)

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind
  (:map company-active-map
	("<tab>" . company-complete-selection)
	("C-n" . company-select-next)
	("C-p" . company-select-previous))
  (:map lsp-mode-map
	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.5))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package typescript-mode
  :ensure t
  :mode
  "\\.ts\\'"
  "\\.tsx\\'"
  :hook (typescript-mode . lsp-deferred)
  :config (setq typescript-indent-level 2))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package ace-window
  :ensure t
  :bind (("M-o" . ace-window)))

(use-package resize-window
  :bind
  (:map global-map
	("C-c ;" . resize-window)))

(use-package multiple-cursors
  :bind
  (("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-c C->" . mc/mark-all-like-this)
   ("C-S-c C-S-c" . mc/edit-lines)))

(use-package move-text
  :init (move-text-default-bindings))

(use-package nasm-mode
  :config
  (add-hook 'asm-mode-hook 'nasm-mode)
  (setq nasm-basic-offset 4)
  (electric-indent-local-mode -1))

(use-package move-text
  :config
  (move-text-default-bindings))


(defun dired-open-file ()
  "In dired, open the file named on this line."
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (call-process "xdg-open" nil 0 nil file)))

(define-key dired-mode-map (kbd "C-c o") 'dired-open-file)

