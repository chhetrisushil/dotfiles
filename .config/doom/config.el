;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; org export config
(setq org-publish-project-alist
      '(("roam-html"
         :base-directory "~/org-roam-dir/"
         :base-extension "org"
         :recursive t
         :publishing-directory "~/org-roam-html/"
         :publishing-function org-html-publish-to-html
       )))

;; doom theme
(setq doom-theme 'doom-palenight)

;; Function to enable minor modes in org-mode-hook
(defun my/multi-minor-mode ()
  (flyspell-mode)
  (olivetti-mode))

;; Hook to auto-pulbish when a org file in org-roam-dir is saved
(defun auto-publish-blog-hook ()
  "Auto publish notes on save"
  ;; check if saved file is part of org-roam-dir
  (if (org-publish-get-project-from-filename
       (buffer-file-name (buffer-base-buffer)) 'up)
      (save-excursion (org-publish-current-file)
             (message "auto published blog") nil)))

;; pretty bullets in org mode.
(require 'org-bullets)
(add-hook 'org-mode-hook
          (lambda ()
            (my/multi-minor-mode)
            (org-bullets-mode 1)
            (add-hook 'after-save-hook 'auto-publish-blog-hook nil nil)))
(add-hook 'text-mode-hook #'my/multi-minor-mode)

;; close todo with time.
(setq org-log-done 'time)

;; load olivetti
(require 'olivetti)

;; load org-reveal
(require 'ox-reveal)

;; load emojify
(require 'emojify)
(add-hook 'after-init-hook #'global-emojify-mode)

;; org-roam folder
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/org-roam-dir")
  :bind (("C-c r f" . org-roam-node-find)
         ("C-c r i" . org-roam-node-insert))
  :config
  (org-roam-db-autosync-enable)
)

;; org-roam keybindings
(map! :leader
      (:prefix ("r" . "roam mappings")
       :desc "Find node."
       "f" #'org-roam-node-find
       :desc "Insert node."
       "i" #'org-roam-node-insert))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; presentation mode config: start ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Install org-present if needed
(unless (package-installed-p 'org-present)
  (package-install 'org-present))

;; Install visual-fill-column
(unless (package-installed-p 'visual-fill-column)
  (package-install 'visual-fill-column))

;; Configure fill width
(setq visual-fill-column-width 110
      visual-fill-column-center-text t)

;; load org-present
(require 'org-present)

;; load visual-fill-column
(require 'visual-fill-column)

;; load org-modern
(require 'org-modern)

;; Set reusable font name variables
(defvar my/fixed-width-font "JetBrains Mono"
  "The font to use for monospaced (fixed width) text.")

(defvar my/variable-width-font "Iosevka Aile"
  "The font to use for variable-pitch (document) text.")

;; NOTE: These settings might not be ideal for your machine, tweak them as needed!
(set-face-attribute 'default nil :font my/fixed-width-font :weight 'light :height 120)
(set-face-attribute 'fixed-pitch nil :font my/fixed-width-font :weight 'light :height 190)
(set-face-attribute 'variable-pitch nil :font my/variable-width-font :weight 'light :height 1.3)

;; load Org-faces
(require 'org-faces)

;; Hide emphasis markers on formatted text
(setq org-hide-emphasis-markers t)

;; Resize Org headings
(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
(set-face-attribute (car face) nil :font my/variable-width-font :weight 'medium :height (cdr face)))

;; Make the document title a bit bigger
(set-face-attribute 'org-document-title nil :font my/variable-width-font :weight 'bold :height 1.3)

;; Make sure certain org faces use the fixed-pitch face when variable-pitch-mode is on
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-table nil :inherit 'fixed-pitch)
(set-face-attribute 'org-formula nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

(defun my/org-present-prepare-slide (buffer-name heading)
  ;; Show only top-level headlines
  (org-overview)

  ;; Unfold the current entry
  (org-fold-show-entry)

  ;; Show only direct subheadings of the slide but don't expand them
  (org-fold-show-children))

(defun my/org-present-start ()
  ;; enable variable-pitch mode
  (variable-pitch-mode 1)

  ;; Tweak font sizes
  (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
                                     (header-line (:height 4.0) variable-pitch)
                                     (org-document-title (:height 1.75) org-document-title)
                                     (org-code (:height 1.55) org-code)
                                     (org-verbatim (:height 1.55) org-verbatim)
                                     (org-block (:height 1.25) org-block)
                                     (org-block-begin-line (:height 0.7) org-block)))
  ;; Set a blank header line string to create blank space at the top
  (setq header-line-format " ")

  ;; Display inline images automatically
  (org-display-inline-images)

  (olivetti-mode 0)
  (org-modern-mode 1)

  ;; Center the presentation and wrap lines
  (visual-fill-column-mode 1)
  (visual-line-mode 1)

  (display-line-numbers-mode 0))

(defun my/org-present-end ()
  ;; enable variable-pitch mode
  (variable-pitch-mode 0)

  ;; Reset font customizations
  (setq-local face-remapping-alist '((default variable-pitch 0)))

  ;; Clear the header line string so that it isn't displayed
  (setq header-line-format nil)

  ;; Stop centering the document
  (visual-fill-column-mode 0)
  (visual-line-mode 0)

  (org-modern-mode 0)
  (olivetti-mode 1)

  (display-line-numbers-mode 1))

;; Register hooks with org-present
(add-hook 'org-present-mode-hook 'my/org-present-start)
(add-hook 'org-present-mode-quit-hook 'my/org-present-end)
;; (add-hook 'org-present-after-navigate-functions 'my/org-present-prepare-slide)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; presentation mode config: end ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; emoji font on macos
(set-fontset-font t 'emoji (font-spec :family "Apple Color Emoji") nil 'prepend)
