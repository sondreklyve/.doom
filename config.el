;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Sondre Klyve"
      user-mail-address "sondre.klyve@hotmail.no")

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
(setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'semi-light))
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

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

(setq mac-option-modifier nil)
(setq mac-command-modifier 'meta)
(setq mac-control-modifier 'control)

(define-key evil-normal-state-map (kbd "-") 'dired-jump)
(setq ranger-show-hidden t)
(setq lsp-pyright-python-executable-cmd "python3")

;; Background transparency
(set-frame-parameter nil 'alpha-background 70) ; For current frame
(add-to-list 'default-frame-alist '(alpha-background . 70)) ; For all new frames henceforth
(setq indicate-empty-lines 'nil)


;; Shamelessly copied from https://codingstruggles.com/emacs/resizing-windows-doom-emacs.html
(defhydra doom-window-resize-hydra (:hint nil)
  "
             _k_ increase height
_h_ decrease width    _l_ increase width
             _j_ decrease height
"
  ("h" evil-window-decrease-width)
  ("j" evil-window-increase-height)
  ("k" evil-window-decrease-height)
  ("l" evil-window-increase-width)

  ("q" nil))

(defhydra doom-hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))


(map!
    (:prefix "SPC w"
      :desc "Hydra resize" :n "SPC" #'doom-window-resize-hydra/body)
    (:prefix "SPC w"
      :desc "Hydra scale text" :n ";" #'doom-hydra-text-scale/body))


(map! :after evil
      :m "j" #'evil-next-visual-line
      :m "k" #'evil-previous-visual-line)


(setq +lookup-provider-url-alist
      '(("SearX"             "http://searxng.nicfab.eu/searxng/search?q=%s")
        ("Doom Emacs issues" "https://github.com/hlissner/doom-emacs/issues?q=is%%3Aissue+%s")
        ("DuckDuckGo"        +lookup--online-backend-duckduckgo "https://duckduckgo.com/?q=%s")
        ("StackOverflow"     "https://stackoverflow.com/search?q=%s")
        ("Github"            "https://github.com/search?ref=simplesearch&q=%s")
        ("Youtube"           "https://youtube.com/results?aq=f&oq=&search_query=%s")
        ("Arch Wiki"         "https://wiki.archlinux.org/index.php?search=%s&title=Special%3ASearch&wprov=acrw1")
        ("AUR"               "https://aur.archlinux.org/packages?O=0&K=%s")))


(after! vterm
  (set-popup-rule! "*doom:vterm-popup:*" :size 0.40 :vslot -4 :select t :quit nil :ttl 0 :side 'right)
  )

(global-set-key (kbd "C-c [") #'window-toggle-side-windows)
