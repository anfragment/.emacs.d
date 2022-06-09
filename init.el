(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("melpa" . "http://melpa.org/packages/")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fc48cc3bb3c90f7761adf65858921ba3aedba1b223755b5924398c666e78af8b" default))
 '(package-selected-packages
   '(use-package lsp-ui lsp-mode nyan-mode darcula-theme ample-theme multiple-cursors pdf-view-restore ivy rainbow-delimiters neotree projectile resize-window ace-window vterm eyebrowse move-text helm typescript-mode))
 '(typescript-indent-level 2)
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (require 'lsp)

(set-frame-font "SF Mono 10")
(fset 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-screen t)

;; move between windows
(windmove-default-keybindings)
(global-set-key (kbd "M-o") 'other-window)

(fringe-mode 0)
(tool-bar-mode 0)
(tab-bar-mode 0)
(tab-line-mode 0)
(tooltip-mode 0)
(scroll-bar-mode 0)
(winner-mode 1)
(eyebrowse-mode 1)
(electric-pair-mode 1)
(ivy-mode 1)
(recentf-mode 1)

;; global-rainbow-delimiters-mode
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; show paren mode
(show-paren-mode)

;; projectile mode
(projectile-mode 1)
(setq projectile-project-search-path '("~/dev/"))

;; theme
(load-theme 'darcula t)
(enable-theme 'darcula)

;; mulitple-cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C->") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; ace-window
(global-set-key (kbd "M-o") 'ace-window)
(setq aw-dispatch-always 1)

;; nyan-mode
(when (display-graphic-p)
  (setq nyan-animate-nyancat t)
  (nyan-mode 1))
 
;; pdf-tools
(pdf-tools-install)
(define-globalized-minor-mode my-global-linum-mode linum-mode
  (lambda ()
    (unless (or (minibufferp)
		(derived-mode-p 'pdf-view-mode 'vterm-mode))
      (linum-mode 1))))
(my-global-linum-mode 1)
(add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode)

;; temporary files
(setq backup-directory-alist `(("." . "~/.emacs-saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; display help in current buffer
(add-to-list 'display-buffer-alist
             '("*Help*" display-buffer-same-window))

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "<f5>") 'recentf-open-files)
(global-set-key (kbd "C-`") 'vterm)
(global-set-key (kbd "C-c ;") 'resize-window)
(global-set-key (kbd "C-c p") 'projectile-command-map)
(global-set-key [f8] 'neotree-projectile-action)
(global-set-key (kbd "M-n") 'scroll-up-line)
(global-set-key (kbd "M-p") 'scroll-down-line)
(global-set-key (kbd "M-f") 'forward-to-word)
(global-set-key (kbd "M-b") 'backward-to-word)
(move-text-default-bindings)
(setq-default frame-title-format '("%f"))

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(defun ide-layout ()
  (interactive)
  (setq starting-window (selected-window))
  (neotree-projectile-action)
  (select-window starting-window)
  (setq starting-window-new-height
	(floor (* (window-total-height) 0.8)))
  (select-window (split-window-below starting-window-new-height))
  (projectile-run-vterm)
  (select-window starting-window))

(global-set-key [f6] 'ide-layout)

;; disable Ctrl+Z suspend in graphical environment
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z C-z") 'my-suspend-frame)
(defun my-suspend-frame ()
  (interactive)
  (if (display-graphic-p)
      (message "suspend-frame disabled for graphical environments")
    (suspend-frame)))


