;;; -*- lexical-binding: t -*-

;; catppuccin
(setq catppuccin-flavor 'macchiato)
(load-theme 'catppuccin :no-confirm)


;; doom-modeline
(with-eval-after-load 'doom-modeline
  (setq doom-modeline-project-detection 'project
        doom-modeline-buffer-file-name-style 'relative-to-project))

(doom-modeline-mode 1)


;; Terminal
(defun wl-copy (text)
  (setq wl-copy-process (make-process :name "wl-copy"
                                      :command '("wl-copy" "--foreground")
                                      :connection-type 'pipe
                                      :noquery t))
  (process-send-string wl-copy-process text)
  (process-send-eof wl-copy-process))
(defun wl-paste ()
  (unless (process-live-p wl-copy-process)
    (with-temp-buffer
      (call-process "wl-paste" nil t nil "--no-newline")
      (let ((output (buffer-string)))
        (unless (string-empty-p output) output)))))

(unless window-system
  (defvar wl-copy-process nil
    "The `wl-copy' process serving the contents of the Emacs kill ring.

This may not be live.")

  (setq interprogram-cut-function #'wl-copy
        interprogram-paste-function #'wl-paste)

  (xterm-mouse-mode 1))


;; Configuration
(setq nerd-icons-font-family "JetBrains Mono Nerd Font Mono"
      compilation-scroll-output t
      compile-command "make run"
      compilation-always-kill t
      shell-file-name "/bin/sh"
      fill-column 80
      read-process-output-max (* 1024 1024)
      process-adaptive-read-buffering nil
      read-extended-command-predicate #'command-completion-default-include-p
      duplicate-line-final-position -1
      duplicate-region-final-position -1
      initial-scratch-message nil
      dictionary-server "dict.org"
      dictionary-default-dictionary "gcide")

(setq-default indent-tabs-mode nil
              tab-width 4
              truncate-lines t
              cursor-type 'bar
              cursor-in-non-selected-windows 'hollow
              display-line-numbers-type 'relative)

(blink-cursor-mode -1)
(which-key-mode 1)
(electric-pair-mode 1)
(delete-selection-mode 1)
(savehist-mode 1)
(global-display-line-numbers-mode 1)
(repeat-mode 1)
(global-auto-revert-mode 1)

;; Global keys
(defun append-semi-colon ()
  "Appends a semi-colon to the current line."
  (interactive)

  (save-excursion
    (end-of-line)
    (insert ?\;)))

(defun open-path-at-point ()
  "Open the path under the cursor.

- If the region is active, use it as the path.
- The path can be relative, absolute or a URL.
- If the path starts with 「https*://」, open the URL in the browser.
- The path may have a trailing 「:‹n›」 that indicates the line number, or 「:‹n›:‹m›」 for both the line and column number.

This command is similar to `find-file-at-point' but without prompting for confirmation."
  (interactive)

  (let ((xinput (if (region-active-p)
                    (buffer-substring-no-properties (region-beginning) (region-end))
                  (let ((xp0 (point)) xp1 xp2
                        (xpathStops "^  \t\n\"`'‘’“”|()[]{}「」<>〔〕〈〉《》【】〖〗«»‹›❮❯❬❭〘〙·。\\"))
                    (skip-chars-backward xpathStops)
                    (setq xp1 (point))
                    (goto-char xp0)
                    (skip-chars-forward xpathStops)
                    (setq xp2 (point))
                    (goto-char xp0)
                    (buffer-substring-no-properties xp1 xp2))))
        xpath)
    (setq xpath (cond
                 ((string-match "^file:///[A-Za-z]:/" xinput) (substring xinput 8))
                 ((string-match "^file://[A-Za-z]:/" xinput) (substring xinput 7))
                 (t xinput)))

    (if (string-match-p "\\`https?://" xpath)
        (browse-url xpath)
      (let ((xpathNoQ
             (let ((xHasQuery (string-match "\?[a-z]+=" xpath)))
               (if xHasQuery
                   (substring xpath 0 xHasQuery)
                 xpath))))
        (cond
         ((string-match "#" xpathNoQ)
          (let ((xfpath (substring xpathNoQ 0 (match-beginning 0)))
                (xfractPart (substring xpathNoQ (1+ (match-beginning 0)))))
            (if (file-exists-p xfpath)
                (progn
                  (find-file xfpath)
                  (goto-char (point-min))
                  (search-forward xfractPart))
              (progn
                (message "File does not exist. Created at\n%s" xfpath)
                (find-file xfpath)))))
         ((string-match "^\\`\\(.+?\\):\\([0-9]+\\)\\(:[0-9]+\\)?\\'" xpathNoQ)
          (let ((xfpath (match-string-no-properties 1 xpathNoQ))
                (xlineNum (string-to-number (match-string-no-properties 2 xpathNoQ))))
            (if (file-exists-p xfpath)
                (progn
                  (find-file xfpath)
                  (goto-char (point-min))
                  (forward-line (1- xlineNum)))
              (progn
                (message "File does not exist. Created at\n%s" xfpath)
                (find-file xfpath)))))
         ((file-exists-p xpathNoQ)
          (find-file xpathNoQ))
         (t (progn
              (message "File does not exist. Created at\n%s" xpathNoQ)
              (find-file xpathNoQ))))))))

(keymap-global-set "S-<return>" #'open-line)
(keymap-global-set "C-S-d" #'duplicate-dwim)
(keymap-global-set "C-c C-g" #'count-words)
(keymap-global-set "M-z" #'zap-up-to-char)
(keymap-global-set "M-Z" #'zap-to-char)
(keymap-global-set "C-;" #'append-semi-colon)
(keymap-global-set "C-c C-f" #'open-path-at-point)

(keymap-global-set "<mouse-8>" #'previous-buffer)
(keymap-global-set "<mouse-9>" #'next-buffer)

;; Minibuffer
(require 'orderless)
(setq enable-recursive-minibuffers t
      read-extended-command-predicate #'command-completion-default-include-p
      completions-detailed t
      completion-show-help nil
      completion-ignore-case t
      completion-styles '(orderless basic)
      completion-category-defaults nil
      completion-category-overrides '((file (styles basic partial-completion))))

;; (with-eval-after-load 'vertico
;;   (keymap-set vertico-map "<tab>" #'vertico-next)
;;   (keymap-set vertico-map "<backtab>" #'vertico-previous)
;;   (keymap-set vertico-map "M-<tab>" #'vertico-insert))

(vertico-mode 1)


;; Spelling
(with-eval-after-load 'ispell
  (setq ispell-program-name "hunspell"
        ispell-dictionary "hu_HU"))

(fset 'flyspell-map (define-keymap
                      "t" #'flyspell-mode
                      "b" #'flyspell-buffer))
(keymap-global-set "C-c s" 'flyspell-map)


;; Elisp auto-recompile
(defun recompile-elisp ()
  "Recompile the current buffer, if it has been compiled before."

  (when (file-exists-p (byte-compile-dest-file buffer-file-name))
    (byte-compile-file buffer-file-name)
    (message "Recompiled %s" buffer-file-name)))
(defun register-recompile-elisp-hook ()
  "Automatically recompile elisp files, if they'd been compiled before saving."

  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook #'recompile-elisp))
(add-hook 'emacs-lisp-mode-hook #'register-recompile-elisp-hook)


;; calc
(with-eval-after-load 'calc
  (setq-default calc-symbolic-mode t
                calc-prefer-frac t))


;; ediff
(with-eval-after-load 'ediff
  (setq ediff-window-setup-function #'ediff-setup-windows-plain))


;; jj
(defun jj-confirm ()
  "Saves the current buffer, and calls `kill-emacs'."
  (interactive)

  (save-buffer)
  (kill-emacs))

(defun jj-cancel ()
  "Reverts the current buffer, and calls `kill-emacs' with an exit code of 1."
  (interactive)

  (revert-buffer t t t)
  (kill-emacs 1))

(defun jj-description ()
  "Sets comment font-face for lines starting with \"JJ:\""

  (when (s-ends-with? ".jjdescription" buffer-file-name)
    (font-lock-add-keywords nil '(("^JJ:.*$" . font-lock-comment-face)))
    (keymap-local-set "C-c C-c" #'jj-confirm)
    (keymap-local-set "C-c C-k" #'jj-cancel)))

(add-hook 'diff-mode-hook #'jj-description)


;; tree-sitter
(with-eval-after-load 'odin-ts-mode
  (add-hook 'odin-ts-mode-hook #'indent-tabs-mode))

(with-eval-after-load 'go-ts-mode
  (setq go-ts-mode-indent-offset 4))

(setq auto-mode-alist (append '(("\\.nix$" . nix-ts-mode)
                                ("\\.rs$" . rust-ts-mode)
                                ("\\.go$" . go-ts-mode)
                                ("/go\\.mod$" . go-mod-ts-mode)
                                ("\\.odin$" . odin-ts-mode)

                                ("\\.jjdescription$" . diff-mode))
                              auto-mode-alist)
      major-mode-remap-alist '((c-mode . c-ts-mode)))


;; avy
(defun avy-action-kill-whole-line (pt)
  "Kill whole line at PT."
  (save-excursion
    (goto-char pt)
    (kill-whole-line))
  (select-window
   (cdr
    (ring-ref avy-ring 0)))
  t)

(defun avy-action-copy-whole-line (pt)
  "Copy whole line at PT."
  (save-excursion
    (goto-char pt)
    (cl-destructuring-bind (start . end)
        (bounds-of-thing-at-point 'line)
      (copy-region-as-kill start end)))
  (select-window
   (cdr
    (ring-ref avy-ring 0)))
  t)

(defun avy-action-yank-whole-line (pt)
  "Yank whole line from PT."
  (avy-action-copy-whole-line pt)
  (save-excursion (yank))
  t)

(defun avy-action-teleport-whole-line (pt)
  "Teleport whole line from PT."
  (avy-action-kill-whole-line pt)
  (save-excursion (yank))
  t)

(defun avy-action-mark-to-char (pt)
  "Activate mark and jump to PT."
  (activate-mark)
  (goto-char pt))

(defun avy-action-smart-xref (pt)
  "Go xref at PT, if it's in an xref buffer, otherwise find the definition at PT:"
  (save-excursion (goto-char pt)
                  (if (string= (buffer-name) "*xref*")
                      (xref-goto-xref t)
                    (call-interactively #'xref-find-definitions)))
  t)

(defun avy-action-goto-indentation (pt)
  "Go to PT, then go to the start of the indentation on that line."
  (goto-char pt)
  (back-to-indentation))

(defun avy-action-beginning-of-line (pt)
  "Go to the beginning of the line at PT."
  (goto-char pt)
  (move-beginning-of-line nil))

(defun avy-action-end-of-line (pt)
  "Go to the end of the line at PT."
  (goto-char pt)
  (move-end-of-line nil))

(with-eval-after-load 'avy
  (setq avy-keys '(?a ?s ?d ?f ?j ?l ?é)
        avy-dispatch-alist '((?k . avy-action-kill-stay)
                             (?K . avy-action-kill-whole-line)
                             (?y . avy-action-yank)
                             (?Y . avy-action-yank-whole-line)
                             (?w . avy-action-copy)
                             (?W . avy-action-copy-whole-line)
                             (?t . avy-action-teleport)
                             (?T . avy-action-teleport-whole-line)
                             (?z . avy-action-zap-to-char)
                             (?@ . avy-action-mark)
                             (?  . avy-action-mark-to-char)
                             (?x . avy-action-smart-xref)
                             (?m . avy-action-goto-indentation)
                             (?a . avy-action-beginning-of-line)
                             (?e . avy-action-end-of-line)
                             (?i . avy-action-ispell))))

(keymap-global-set "C-:" #'avy-goto-char-2)


;; dumb-jump
;; Using prefer would be more ideal, but force is needed to work around #428
(with-eval-after-load 'dumb-jump
  (setq dumb-jump-force-searcher 'rg))

(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)


;; expand-region
(require 'expand-region) ; The functions in mark-map are not autoloaded

(keymap-global-set "C-=" #'er/expand-region)
(keymap-global-set "M-=" #'mark-word)


;; multiple-cursors
(keymap-global-set "C-c SPC" #'set-rectangular-region-anchor)
(keymap-global-set "C->" #'mc/mark-next-like-this)
(keymap-global-set "C-<" #'mc/mark-previous-like-this)

(fset 'mark-map (define-keymap
                  "w" #'er/mark-word
                  "s" #'er/mark-symbol
                  "p" #'er/mark-symbol-with-prefix
                  "." #'er/mark-next-accessor
                  "m" #'er/mark-method-call
                  "c" #'er/mark-comment
                  "u" #'er/mark-url
                  "d" #'er/mark-defun
                  "a" #'mc/mark-all-dwim))
(keymap-global-set "C-c m" 'mark-map)


;; move-text
(keymap-global-set "M-<down>" #'move-text-down)
(keymap-global-set "M-<up>" #'move-text-up)


;; org
(defun org-embed-image (path)
  "Copy a file, or download a URL to an img subfolder in `default-directory', and embed it at point.

Interactively, the path is the latest clipboard/kill ring value returned by `current-kill'."
  (interactive (list (current-kill 0 t)))

  (let (extension hash directory new-name new-path)
    (if (file-exists-p path)
        (setq extension (concat "." (file-name-extension-path)))
      (progn
        (setq extension (url-file-extension path))
        (setq path (url-file-local-copy path))))

    (setq hash (with-temp-buffer
                 (insert-file-contents path)
                 (secure-hash 'md5 (buffer-string))))
    (setq directory (file-name-concat default-directory "img"))
    (setq new-name (concat hash extension))
    (setq new-path (file-name-concat directory new-name))

    (make-directory directory t)
    (unless (file-exists-p new-path)
      (copy-file path new-path 1))
    (insert (format "[[./img/%s]]" new-name))
    (message "Image embedded successfully")))

(with-eval-after-load 'org
  (setq org-agenda-files '("~/documents/org/")
        org-log-done 'time
        org-return-follows-link t
        org-format-latex-options (plist-put org-format-latex-options :scale 1.8)
        org-blank-before-new-entry '((heading . t) (plain-list-item . nil)))
  (add-to-list 'org-src-lang-modes '("odin" . odin-ts))

  (set-face-foreground 'org-block (catppuccin-color 'text))

  (add-hook 'org-mode-hook #'org-indent-mode)
  (add-hook 'org-mode-hook #'org-autolist-mode)
  (add-hook 'org-mode-hook #'visual-line-mode)

  (fset 'org-mode-custom-map (define-keymap
                               "i" #'org-embed-image))
  (add-hook 'org-mode-hook (lambda ()
                             (keymap-local-set "C-c o" 'org-mode-custom-map))))

(with-eval-after-load 'ox
  (add-to-list 'org-export-smart-quotes-alist '("hu"
                                                (primary-opening :utf-8 "„" :html "&bdquo;" :latex ",," :texinfo "``")
                                                (primary-closing :utf-8 "”" :html "&rdquo;" :latex "''" :texinfo "''")
                                                (secondary-opening :utf-8 "‚" :html "&sbquo;" :latex "," :texinfo "`")
                                                (secondary-opening :utf-8 "’" :html "&rsquo;" :latex "'" :texinfo "'"))))

;; org-roam
(with-eval-after-load 'org-roam
  (setq org-roam-directory "~/documents/org"
        org-roam-dailies-directory "daily/"
        org-roam-capture-templates '(("d" "default" plain "%?"
                                      :target (file+head "notes/${slug}.org"
                                                         "#+TITLE: ${title}")
                                      :empty-lines-before 1
                                      :immediate-finish t
                                      :unnarrow t))
        org-roam-dailies-capture-templates '(("d" "default" plain "* %?"
                                              :target (file+head "%<%Y-%m-%d>.org"
                                                                 "#+TITLE: %<%Y. %m. %d>")
                                              :empty-lines-before 1)))


  (org-roam-setup))

(with-eval-after-load 'org-roam-timestamps
  (setq org-roam-timestamps-remember-timestamps nil))

(fset 'org-roam-dailies-map (define-keymap
                              "j" #'org-roam-dailies-goto-today
                              "J" #'org-roam-dailies-capture-today
                              "f" #'org-roam-dailies-goto-tomorrow
                              "F" #'org-roam-dailies-capture-tomorrow
                              "b" #'org-roam-dailies-goto-yesterday
                              "B" #'org-roam-dailies-capture-yesterday
                              "c" #'org-roam-dailies-goto-date
                              "C" #'org-roam-dailies-capture-date
                              "n" #'org-roam-dailies-goto-next-note
                              "p" #'org-roam-dailies-goto-previous-note
                              "d" #'org-roam-dailies-find-directory))

(fset 'org-roam-map (define-keymap
                      "l" #'org-roam-buffer-toggle
                      "f" #'org-roam-node-find
                      "i" #'org-roam-node-insert
                      "c" #'org-roam-capture
                      "d" #'org-roam-dailies-map))

(keymap-global-set "C-c n" 'org-roam-map)


;; surround
(fset 'surround-custom-keymap (define-keymap
                                "s" #'surround-insert
                                "k" #'surround-kill
                                "K" #'surround-kill-outer
                                "m" #'surround-mark
                                "M" #'surround-mark-outer
                                "d" #'surround-delete
                                "c" #'surround-change))

(keymap-global-set "C-," 'surround-custom-keymap)


;; olivetti
(with-eval-after-load 'olivetti
  (setq olivetti-body-width 0.55))


;; leetcode
(with-eval-after-load 'leetcode
  (setq leetcode-prefer-tag-display nil
        leetcode-prefer-language "python3"
        leetcode-prefer-sql "postegresql"
        leetcode-save-solutions t
        leetcode-directory "~/documents/dev/leetcode"))


;; corfu
(with-eval-after-load 'corfu
  (setq completion-at-point-functions (append '(yasnippet-capf
                                                comint-filename-completion)
                                              completion-at-point-functions)
        global-corfu-modes '((not org-mode magit-status-mode) t)
        tab-always-indent 'complete
        text-mode-ispell-word-completion nil
        corfu-popupinfo-delay 0.3
        corfu-cycle t
        corfu-left-margin-width 0
        corfu-right-margin-width 0)
        ;; corfu-auto t)

  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)

  (add-hook 'corfu-mode-hook #'corfu-history-mode)
  (add-hook 'corfu-mode-hook #'corfu-popupinfo-mode)
  (add-hook 'corfu-mode-hook #'yas-minor-mode))

  ;; (keymap-set corfu-map "<tab>" #'corfu-next)
  ;; (keymap-set corfu-map "<backtab>" #'corfu-previous)

  ;; (keymap-unset corfu-map "<remap> <next-line>")
  ;; (keymap-unset corfu-map "<remap> <previous-line>")

(global-corfu-mode 1)


;; vc
(with-eval-after-load 'vc-hooks
  (add-to-list 'vc-directory-exclusion-list ".jj"))


;; project
(defun project-ensure-root ()
  "Returns the root of the current project, prompting for a project,
if the user isn't in one."

  (require 'project)
  (project-root (project-current t)))

(defun project-find-ripgrep ()
  "Prompt for, then search for the given regex pattern in the current project
using `ripgrep-regexp'."
  (interactive)

  (require 'project)
  (let ((directory (project-ensure-root))
        (regexp (read-from-minibuffer "Ripgrep regexp: " (thing-at-point 'symbol))))
    (ripgrep-regexp regexp directory)))

(defun project-save ()
  "Save the current project using `project-remember-project'"
  (interactive)

  (require 'project)
  (let ((project (project-current t)))
    (project-remember-project project)
    (message "Project %s has been saved" (project-root project))))

(defun project-magit-status ()
  "Run `magit-status' in the current project."
  (interactive)

  (require 'project)
  (magit-status (project-ensure-root)))

(keymap-set project-prefix-map "m" #'project-magit-status)
(keymap-set project-prefix-map "g" #'project-find-ripgrep)
(keymap-set project-prefix-map "C-s" #'project-save)

(with-eval-after-load 'project
  (setq project-vc-extra-root-markers '(".jj" ".envrc")))


;; eldoc
(with-eval-after-load 'eldoc
  (setq eldoc-echo-area-prefer-doc-buffer t
        eldoc-echo-area-use-multiline-p nil)

  (defun eldoc-visual-line-mode (interactive)
    "Enable `visual-line-mode' in the current eldoc buffer."

    (with-current-buffer eldoc--doc-buffer
      (visual-line-mode 1)))

  (advice-add 'eldoc-doc-buffer :after #'eldoc-visual-line-mode))


;; eglot
(defun eglot-map-hook ()
  "Sets and unsets `eglot-map' based on `eglot-managed-p'."

  (if (eglot-managed-p)
      (keymap-local-set "C-c l" 'eglot-map)
    (keymap-local-unset "C-c l")))

(with-eval-after-load 'eglot
  (setq eglot-extend-to-xref t)
  (add-to-list 'eglot-server-programs '(odin-ts-mode . ("ols")))

  (fset 'eglot-map (define-keymap
                     "a" #'eglot-code-actions
                     "f" #'eglot-format
                     "r" #'eglot-rename
                     "d" #'eglot-find-declration
                     "i" #'eglot-find-implementation
                     "t" #'eglot-find-typeDefinition))

  (add-hook 'eglot-managed-mode-hook #'eglot-map-hook))


;; editorconfig
(editorconfig-mode 1)


;; envrc - keep this at the bottom
(envrc-global-mode 1)
(keymap-set envrc-mode-map "C-c e" 'envrc-command-map)
