(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("melpa" . "http://melpa.org/packages/")))


(setq apropos-sort-by-scores t)
(global-set-key (kbd "M-o") 'other-window)
(windmove-default-keybindings)
(fset 'yes-or-no-p 'y-or-n-p)
(setq create-lockfiles nil)

(set-frame-font "SF Mono 10")

(tool-bar-mode 0)
(tab-bar-mode 0)
(tab-line-mode 0)
(tooltip-mode 0)
(scroll-bar-mode 0)
(winner-mode 1)
(eyebrowse-mode 1)
(rainbow-delimiters-mode 1)
(electric-pair-mode 1)
(rainbow-delimiters-mode 1)
(ivy-mode 1)
(recentf-mode 1)
(rainbow-delimiters-mode 1)

;; show paren mode
(show-paren-mode)

;; projectile mode
(projectile-mode 1)
(setq projectile-project-search-path '("~/dev/" "~/dev/ps/"))

;; theme
(load-theme 'zenburn t)

;; mulitple-cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C->") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; ace-window
(global-set-key (kbd "M-o") 'ace-window)
(setq aw-dispatch-always 1)

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
(setq backup-directory-alist '((".+" . "~/.emacs.d/.backup-files")))

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "<f5>") 'recentf-open-files)
(global-set-key (kbd "C-`") 'vterm)
(global-set-key (kbd "C-c ;") 'resize-window)
(global-set-key (kbd "C-c p") 'projectile-command-map)
(global-set-key [f8] 'neotree-projectile-action)
(global-set-key (kbd "M-n") 'scroll-up-line)
(global-set-key (kbd "M-p") 'scroll-down-line)
(move-text-default-bindings)
(setq-default frame-title-format '("%f"))
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))
(setq inhibit-startup-screen t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fc48cc3bb3c90f7761adf65858921ba3aedba1b223755b5924398c666e78af8b" default))
 '(package-selected-packages
   '(pdf-view-restore pdf-tools ivy rainbow-delimiters zenburn-theme neotree projectile resize-window ace-window vterm eyebrowse move-text helm typescript-mode))
 '(typescript-indent-level 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
