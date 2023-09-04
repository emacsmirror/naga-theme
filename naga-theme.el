;;; naga-theme.el --- Dark color theme with green foreground color

;; Copyright (C) 2021-2022 Johannes Maier

;; Author: Johannes Maier <johannes.maier@mailbox.org>
;; Version: 0.1
;; Homepage: https://github.com/kenranunderscore/emacs-naga-theme
;; Keywords: faces themes
;; Package-Requires: ((emacs "24.1"))

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see
;; <http://www.gnu.org/licenses/>.

;;; Commentary:

;; The main feature of this dark color theme is its usage of a green
;; foreground color, achieving a retro look while still being easy on
;; the eyes.

;; Note that while I've been using this as my main theme for nearly a
;; year now, it still is very much a work in progress, as I've only
;; styled and checked the packages I actually use so far.  Some main
;; colors might still be subject to change.

;;; Code:

(deftheme naga
  "Created 2021-09-26.")

(require 'color)

(defgroup naga-theme nil
  "Configuration options for the `naga' theme."
  :group 'faces)

(defcustom naga-theme-modeline-style 'green-box
  "The modeline style to use.
The default style is green text in a green box."
  :group 'naga-theme
  :type '(choice
          (const :tag "Green box" green-box)
          (const :tag "Golden box" golden-box)
          (const :tag "Filled green" filled-green)))

(defcustom naga-theme-use-lighter-org-block-background t
  "Whether to set a background for the `org-block' face.
The default is to use a slightly lighter color than the usual
background.  Setting this to `nil' means blocks have no special
background color."
  :group 'naga-theme
  :type 'boolean)

(defcustom naga-theme-use-red-cursor nil
  "Whether to use a more visible, bright red color for the cursor.
By default, the cursor uses the foreground color."
  :group 'naga-theme
  :type 'boolean)

(defcustom naga-theme-surround-org-blocks t
  "Whether to surround org blocks by underlining (overlining) the
beginning (or ending) line."
  :group 'naga-theme
  :type 'boolean)

(defmacro create-theme-colors ()
  "Expects the color variables to be bound."
  '(mapcar
    (lambda (entry)
      (list (car entry)
            `((t ,@(cdr entry)))))
    `((default (:foreground ,fg :background ,bg))
      (minibuffer-prompt (:foreground ,string))
      (highlight (:foreground ,fg :background ,dark-blue))
      (region (:background ,dark-blue))
      (secondary-selection
       (:foreground "black" :background ,(color-darken-name "dark green" 7)))
      (vertical-border (:foreground "gray30"))
      (help-key-binding (:foreground ,fg :background ,bg-green :box ,fg))
      (link (:foreground ,cyan :underline t))
      (font-lock-builtin-face (:foreground ,orange))
      (font-lock-comment-face (:foreground ,comment))
      (font-lock-constant-face (:foreground ,purple))
      (font-lock-doc-face (:slant oblique :foreground ,docstring))
      (font-lock-function-name-face (:foreground ,cyan))
      (font-lock-keyword-face (:foreground ,yellow))
      (font-lock-preprocessor-face (:inherit (font-lock-constant-face)))
      (font-lock-string-face (:foreground ,string))
      (font-lock-type-face (:foreground ,sea-green))
      (font-lock-variable-name-face (:foreground ,sea-green))
      (font-lock-warning-face (:slant italic :foreground ,orange-red))
      (fringe (:background ,bg))
      (warning (:foreground ,orange-red :weight regular))
      (header-line (:foreground ,grey :background ,block-light))
      (mode-line ,(cond
                   ((eq naga-theme-modeline-style 'golden-box)
                    `(:background ,bg :foreground ,gold :box ,gold))
                   ((eq naga-theme-modeline-style 'filled-green)
                    `(:background ,fg-dark :foreground ,bg :box ,bg))
                   ((eq naga-theme-modeline-style 'green-box)
                    `(:background ,bg-green :foreground ,fg :box ,fg))))
      (mode-line-buffer-id (:weight bold))
      (mode-line-emphasis (:weight bold))
      (mode-line-inactive (:box "#555555" :background ,bg :foreground ,comment))
      (isearch (:foreground ,bg :weight semi-bold :background ,gold :underline t))
      (lazy-highlight (:foreground ,fg :background "blue3" :underline t))
      (show-paren-match
       (:foreground ,bg :background ,(if naga-theme-use-red-cursor
                                         fg
                                       red)))
      (show-paren-mismatch (:foreground "red" :background ,dark-blue))
      (completions-common-part (:foreground ,purple))
      (error (:foreground ,red))
      (compilation-mode-line-run (:foreground ,yellow))
      (cursor (:background ,(if naga-theme-use-red-cursor
                                red
                              fg)))
      (shadow (:foreground ,comment-light))
      (match (:foreground ,yellow :background ,bg-green :slant oblique))

      ;; orderless
      (orderless-match-face-0 (:inherit 'completions-common-part))
      (orderless-match-face-1 (:foreground ,orange))
      (orderless-match-face-2 (:foreground ,string))
      (orderless-match-face-3 (:foreground ,comment-light))

      ;; outline-*, and by extension org-level-*
      (outline-1 (:weight bold :foreground ,fg))
      (outline-2 (:foreground ,gold))
      (outline-3 (:foreground ,cyan))
      (outline-4 (:foreground ,orange))
      (outline-5 (:foreground ,purple))
      (outline-6 (:foreground ,string))
      (outline-7 (:foreground ,sea-green))
      (outline-8 (:foreground "dark khaki"))

      ;; company
      (company-tooltip (:background "gray10"))
      (company-tooltip-common (:foreground ,orange))
      (company-tooltip-selection (:background ,dark-blue :weight bold))

      ;; corfu
      (corfu-current (:inherit 'highlight))
      (corfu-default (:background "#090909"))
      (corfu-border (:background ,fg-dark))
      (corfu-bar (:background ,comment-light))

      ;; which-key
      (which-key-key-face (:foreground ,yellow))
      (which-key-group-description-face (:foreground ,sea-green))
      (which-key-command-description-face (:foreground ,fg))

      ;; marginalia
      (marginalia-file-priv-dir (:inherit 'font-lock-keyword-face))
      (marginalia-file-priv-no (:inherit 'font-lock-comment-face))
      (marginalia-file-priv-exec (:inherit 'font-lock-function-name-face))
      (marginalia-file-priv-link (:inherit 'font-lock-keyword-face))
      (marginalia-file-priv-rare (:inherit 'font-lock-variable-name-face))
      (marginalia-file-priv-read (:inherit 'font-lock-type-face))
      (marginalia-file-priv-write (:inherit 'font-lock-builtin-face))
      (marginalia-file-priv-other (:inherit 'font-lock-constant-face))
      (marginalia-date (:foreground ,gold))
      (marginalia-number (:inherit 'font-lock-constant-face))

      ;; dired and related
      (diredfl-dir-name (:foreground ,string))
      (diredfl-dir-heading (:slant oblique :weight bold :foreground ,sea-green))
      (diredfl-file-name (:foreground ,fg))
      (diredfl-file-suffix (:foreground ,fg))
      (diredfl-ignored-file-name (:inherit (font-lock-comment-face)))
      (diredfl-dir-priv (:inherit 'marginalia-file-priv-dir))
      (diredfl-no-priv (:inherit 'marginalia-file-priv-no))
      (diredfl-exec-priv (:inherit 'marginalia-file-priv-exec))
      (diredfl-link-priv (:inherit 'marginalia-file-priv-link))
      (diredfl-rare-priv (:inherit 'marginalia-file-priv-rare))
      (diredfl-read-priv (:inherit 'marginalia-file-priv-read))
      (diredfl-other-priv (:inherit 'marginalia-file-priv-other))
      (diredfl-write-priv (:inherit 'marginalia-file-priv-write))
      (diredfl-compressed-file-suffix (:foreground ,fg-dark :slant italic))
      (diredfl-compressed-file-name (:foreground ,fg-dark :slant italic))
      (diredfl-symlink (:foreground ,cyan))
      (diredfl-deletion (:foreground ,orange-red))
      (diredfl-deletion-file-name (:foreground ,orange-red))
      (diredfl-flag-mark-line (:background "#033903"))
      (diredfl-flag-mark (:weight bold :foreground ,cyan))
      (diredfl-date-time (:inherit 'marginalia-date))
      (diredfl-number (:inherit 'marginalia-number))

      ;; line numbers
      (line-number (:foreground "gray15"))
      (line-number-current-line (:foreground "dark green"))

      ;; org
      (org-todo (:foreground ,orange-red :weight bold))
      (org-done (:foreground ,fg :weight bold))
      (org-headline-todo (:foreground ,orange-red))
      (org-headline-done (:foreground ,comment :strike-through t))
      (org-document-title (:foreground ,cyan :weight bold))
      (org-document-info (:foreground ,cyan))
      (org-verbatim (:foreground ,purple))
      (org-code (:foreground ,string))
      (org-block (:background ,(if naga-theme-use-lighter-org-block-background
                                   block
                                 bg)))
      (org-block-begin-line (:slant oblique :foreground ,comment-dark :underline ,naga-theme-surround-org-blocks :extend t))
      (org-block-end-line (:slant oblique :foreground ,comment-dark :overline ,naga-theme-surround-org-blocks :extend t))
      (org-special-keyword (:foreground ,comment))

      ;; magit
      (magit-section-heading (:foreground ,orange :weight semi-bold))
      (magit-section-highlight (:background ,dark-blue))
      (magit-branch-local (:foreground ,yellow))
      (magit-branch-remote (:foreground ,cyan))
      (magit-tag (:foreground ,string))
      (magit-diff-file-heading-highlight (:background ,dark-blue))
      (magit-diff-context-highlight (:background ,block-light :foreground ,grey))
      (magit-diff-context (:foreground ,comment))
      (magit-diff-hunk-heading (:background "#181818" :foreground ,comment-light :slant oblique))
      (magit-diff-hunk-heading-highlight (:slant oblique :weight bold :background "#3f3f3f" :foreground "#b5c5b5"))

      ;; manpages
      (Man-overstrike (:foreground ,cyan))

      ;; mu4e
      (mu4e-highlight-face (:weight semi-bold :foreground ,orange))

      ;; notmuch
      (notmuch-tag-unread (:weight semi-bold :foreground ,gold))

      ;; whitespace-mode
      (whitespace-space (:foreground ,whitespace-fg :background ,bg))
      (whitespace-tab (:foreground ,whitespace-fg :background ,bg))
      (whitespace-line (:foreground ,orange-red :background ,bg))
      (whitespace-newline (:foreground ,whitespace-fg :background ,bg))
      (whitespace-empty (:foreground ,red :background ,yellow))
      (whitespace-indentation (:foreground ,red :background ,yellow))
      (whitespace-space-before-tab (:foreground ,red :background ,orange))
      (whitespace-space-after-tab (:foreground ,red :background ,yellow))
      (whitespace-missing-newline-at-eof (:background ,string))
      (whitespace-trailing (:background ,red))
      (whitespace-big-indent (:background ,red))

      ;; shortdoc
      (shortdoc-section (:inherit 'default))
      (shortdoc-heading (:inherit 'default :weight bold :height 1.3))

      ;; gnus and message-mode
      (gnus-header (:inherit default))

      ;; helm
      (helm-match (:inherit 'orderless-match-face-0))
      (helm-source-header (:foreground ,bg :background ,fg))
      (helm-header (:foreground ,sea-green))
      (helm-selection (:foreground ,fg :background ,dark-blue))
      (helm-M-x-key (:foreground ,gold :background ,bg :box ,gold))
      (helm-ff-directory (:foreground ,string :background ,bg))
      (helm-buffer-directory (:inherit helm-ff-directory))
      (helm-ff-dotted-directory (:foreground ,fg :background ,bg))
      (helm-ff-dotted-symlink-directory (:foreground ,dark-blue :background ,bg))

      ;; ivy
      (ivy-current-match (:inherit 'highlight))
      (ivy-minibuffer-match-face-1 (:foreground ,fg))
      (ivy-minibuffer-match-face-2 (:inherit 'orderless-match-face-0))
      (ivy-minibuffer-match-face-3 (:inherit 'orderless-match-face-1))
      (ivy-minibuffer-match-face-4 (:inherit 'orderless-match-face-2))

      ;; envrc
      (envrc-mode-line-none-face (:foreground ,fg))
      (envrc-mode-line-on-face (:foreground ,string))
      (envrc-mode-line-error-face (:inherit 'error))

      ;; vterm NOTE: vterm doesn't use the whole face description (or
      ;; these would not make sense at all), but rather seems to pick
      ;; either foreground or background color as actual foreground,
      ;; hence the duplicated color values.
      (vterm-color-red (:foreground ,red :background ,red))
      (vterm-color-blue (:foreground ,cyan :background ,cyan))
      (vterm-color-black (:foreground ,comment :background ,comment))
      (vterm-color-yellow (:foreground ,gold :background ,gold))
      (vterm-color-green (:foreground ,string :background ,string))
      (vterm-color-cyan (:foreground ,cyan :background ,cyan))
      (vterm-color-white (:foreground ,fg :background ,bg))
      (vterm-color-magenta (:foreground ,purple :background ,purple))

      ;; eglot
      (eglot-highlight-symbol-face (:foreground ,fg :background ,bg-green :weight bold)))))

;; Set all the colors to their actual values.
(let ((bg "#040404")
      (bg-green "#041a04")
      (fg "#0ac30a")
      (fg-dark "#078807")
      (yellow "#eec900")
      (gold "#eead0e")
      (cyan "#00cdcd")
      (string "#b3ee3a")
      (purple "#cc59d2")
      (orange "#ff9000")
      (comment "#707370")
      (comment-light "#909590")
      (comment-dark "#353535")
      (docstring "olivedrab4")
      (grey "#aabaaa")
      (dark-blue "#01018a")
      (sea-green "#3cb371")
      (orange-red "#ff4500")
      (red "#ff1500")
      (whitespace-fg "#555f55")
      (block "#060606")
      (block-light "#252525"))
  (apply #'custom-theme-set-faces
         (cons 'naga (create-theme-colors))))

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'naga)

;;; naga-theme.el ends here

;; Local Variables:
;; fill-column: 70
;; End:
