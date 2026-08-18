;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;;

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(after! python
  (set-formatter! 'ruff :modes '(python-mode python-ts-mode)))

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
;; - `doom-symbol-font' -- for symbols
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
(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :weight 'normal :size 24))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-tomorrow-night)
;; (setq doom-theme 'gruber-darker)
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-homage-black)
;; (setq doom-theme 'gruber-darker)
;;(setq doom-theme 'doom-tokyo-night)
(setq doom-theme 'doom-sourcerer)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Personal settings
;;(setq scroll-margin 5)
;; To enable, run display-fill-column-indicator-mode
(setopt display-fill-column-indicator-column 80)

(setq-default evil-escape-key-sequence "jk")

(add-to-list 'display-buffer-alist
             '((derived-mode . flycheck-error-list-mode)
               (display-buffer-reuse-window display-buffer-below-selected)
               (window-height . 0.3)
               (dedicated . t)
               (preserve-size . (t . t))))

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(use-package! ultra-scroll
  :init
  (setq scroll-conservatively 3 ; or whatever value you prefer, since v0.4
        scroll-margin 0)        ; important: scroll-margin>0 not yet supported
  :config
  (ultra-scroll-mode 1))

(use-package eglot
  :ensure t
  :config
    (add-to-list 'eglot-server-programs '(
      (python-mode python-ts-mode)
         "basedpyright-langserver" "--stdio"
    ))
    (setq-default
       eglot-workspace-configuration
       '(:basedpyright (
           :typeCheckingMode "basic"
         )
         :basedpyright.analysis (
           :diagnosticSeverityOverrides (
             :reportUnusedCallResult "none"
           )
           :inlayHints (
             :callArgumentNames :json-false
           )
         )))
)

(after! consult
  (setq consult-preview-key 'any))

; Fix paths for c libraries
(setenv "LIBRARY_PATH" (concat (getenv "LIBRARY_PATH") ":/opt/homebrew/lib"))
(setenv "CPATH" (concat (getenv "CPATH") ":/opt/homebrew/include"))

;; Enable rgbds-mode for rgbasm files
(require 'rgbds-mode)
(add-to-list 'auto-mode-alist '("\\.rgbasm\\'" . rgbds-mode))

;; accept completion from copilot and fallback to company
;; (use-package! copilot
;;   :hook (prog-mode . copilot-mode)
;;   :bind (:map copilot-completion-map
;;               ("<tab>" . 'copilot-accept-completion)
;;               ("TAB" . 'copilot-accept-completion)
;;               ("C-TAB" . 'copilot-accept-completion-by-word)
;;               ("C-<tab>" . 'copilot-accept-completion-by-word)))
;; End of personal settings

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


