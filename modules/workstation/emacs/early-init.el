;;; -*- lexical-binding: t -*-

;; Avoid gc at startup
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 1.0)
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold (* 8 1024 1024)
                                            gc-cons-percentage 0.1)))
;; Unnecessary UI elements
(setq inhibit-splash-screen t
      inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Do this here to make sure nothing gets initialized before these are set
(setq no-littering-var-directory (expand-file-name "~/.local/share/emacs/")) ; Required when loading
(require 'no-littering)

(startup-redirect-eln-cache (no-littering-expand-var-file-name "eln-cache/"))
(no-littering-theme-backups) ; This may leak secret information on the disk for longer than intended
(setq make-backup-files nil
      lock-file-name-transforms `((".*" ,temporary-file-directory t)))
