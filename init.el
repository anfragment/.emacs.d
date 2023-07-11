;; Use 'y or n' instead of full 'yes or no' for confirmation messages
(fset 'yes-or-no-p 'y-or-n-p)

;; Save and restore sessions
(desktop-save-mode 1)

;; Display line, column numbers, and size of the file in the modeline
(line-number-mode 1)
(column-number-mode 1)
(size-indication-mode 1)

;; Highlight current line
(global-hl-line-mode 1)

;; Display line numbers in all modes
(global-display-line-numbers-mode t)

;; Show matching parentheses
(show-paren-mode 1)

;; Enable clipboard
(setq x-select-enable-clipboard t)

;; Auto revert files when they change on disk
(global-auto-revert-mode 1)

;; Highlight the selected region
(setq transient-mark-mode t)

;; Set tab width to 4
(setq-default tab-width 4)

;; Use spaces instead of tabs for indentation
(setq-default indent-tabs-mode nil)

;; Set fill column to 80 characters
(setq-default fill-column 80)

;; Automatically break lines at the fill column in text mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Do not make backup files
(setq make-backup-files nil)

;; Do not create auto-save files
(setq auto-save-default nil)

;; Enable delete-selection-mode
(delete-selection-mode 1)

;; Disable startup screen
(setq inhibit-startup-screen t)

;; Always end a file with a newline
(setq require-final-newline t)

;; Reduce the frequency of garbage collection by making it happen on 
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; Warn on opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; Use ibuffer for buffer list
(defalias 'list-buffers 'ibuffer)

;; Keep track of loading time
(defconst emacs-start-time (current-time))

(defun emacs-uptime ()
  (interactive)
  (message (format "Emacs has been up for %s"
                   (format-seconds "%d days %d hours %d minutes %d seconds"
                                   (float-time (time-subtract (current-time)
                                                              emacs-start-time))))))

;; Enable recent files mode.
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;; Saveplace remembers your location in a file when saving files
(require 'saveplace)
(setq save-place-file (expand-file-name "saveplace" user-emacs-directory))
;; activate it for all buffers
(setq-default save-place t)

;; Savehist keeps track of some history
(require 'savehist)
(setq savehist-additional-variables
      ;; search entries
      '(search-ring regexp-search-ring)
      ;; save every minute
      savehist-autosave-interval 60
      ;; keep the home clean
      savehist-file (expand-file-name "savehist" user-emacs-directory))
(savehist-mode +1)

;; Ido mode for better file navigation
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Move to trash instead of delete
(setq delete-by-moving-to-trash t)
