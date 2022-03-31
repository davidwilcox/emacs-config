(global-set-key [?\C-\M-j] 'backward-sexp)
(global-set-key [?\C-\M-k] 'forward-sexp)
(global-set-key [f6] 'org-d20-roll)
(global-set-key [f7] 'org-d20-initiative)
(global-set-key [f5] 'goto-line)
(global-set-key [?\C-x ?\C-f] 'ffap)
;(add-hook 'c-mode-common-hook
;(lambda()
;(local-set-key [f2] 'rtags-find-symbol-at-point)
;(local-set-key [f3] 'rtags-find-references-at-point)))
(set-face-attribute 'default nil :height 105)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;(add-to-list 'load-path "/home/dawilcox/rtags/src")
;(require 'rtags)
;(require 'clang-format)

; (rtags-enable-standard-keybindings c-mode-base-map)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(clang-format-executable "clang-format-3.6")
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(global-font-lock-mode t nil (font-lock))
 '(package-selected-packages
   '(zoom zoom-frm org-d20 improv-rez axle yaml-mode writegood-mode wgrep-ack php-mode lua-mode clang-format bison-mode ack-and-a-half))
 '(safe-local-variable-values
   '((org-d20-party
      ("Vieren" . 1)
      ("Thurrig" . 2)
      ("Deneith" . 0)
      ("Doragin" . 0)
      ("Luth" . 1)
      ("Collin" . 4))
     (org-d20-party
      ("Vieren" . 0)
      ("Thurrig" . 1))))
 '(show-paren-mode t nil (paren))
 '(show-trailing-whitespace t)
 '(transient-mark-mode t))

(global-set-key (kbd "C-x i") (lambda ()
                                (interactive)
                                (other-window -1)))

(defun dnd-size ()
  "Change font size to be bigger for dnd."
  (interactive)
  (set-face-attribute 'default nil :height 200))

(set-face-attribute 'default nil :height 105)
(defun kill-word (arg)
  "Kill characters forward until encountering the end of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(require 'elide-head)
(add-to-list 'elide-head-headers-to-hide
             '("ADOBE CONFIDENTIAL" .
               "from Adobe Systems Incorporated\\."))
(add-hook 'c++-mode-hook 'elide-head)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(defun delete-trailing-whitespace (&optional start end)
  "Delete trailing whitespace between START and END.
If called interactively, START and END are the start/end of the
region if the mark is active, or of the buffer's accessible
portion if the mark is inactive.

This command deletes whitespace characters after the last
non-whitespace character in each line between START and END.  It
does not consider formfeed characters to be whitespace.

If this command acts on the entire buffer (i.e. if called
interactively with the mark inactive, or called from Lisp with
END nil), it also deletes all trailing lines at the end of the
buffer if the variable `delete-trailing-lines' is non-nil."
  (interactive (progn
                 (barf-if-buffer-read-only)
                 (if (use-region-p)
                     (list (region-beginning) (region-end))
                   (list nil nil))))
  (save-match-data
    (save-excursion
      (let ((end-marker (copy-marker (or end (point-max))))
            (start (or start (point-min))))
        (goto-char start)
        (while (re-search-forward "\\s-$" end-marker t)
          (skip-syntax-backward "-" (line-beginning-position))
          ;; Don't delete formfeeds, even if they are considered whitespace.
          (if (looking-at-p ".*\f")
              (goto-char (match-end 0)))

          (if (bolp)
              (forward-line 1)
            (delete-region (point) (match-end 0))))
        ;; Delete trailing empty lines.
        (goto-char end-marker)
        (when (and (not end)
                   ;; Really the end of buffer.
                   (= (point-max) (1+ (buffer-size)))
                   (<= (skip-chars-backward "\n") -2))
          (delete-region (1+ (point)) end-marker))
        (set-marker end-marker nil))))
  ;; Return nil for the benefit of `write-file-functions'.
  nil)
(defun dawilcox-maybe-close-window ()
  "Will `bury-buffer' if displayed in another window, `kill-buffer' otherwise."
  (interactive)
  (let* ((buf (current-buffer))
         (win (selected-window))
         (in-another-window (dolist (w (window-list) nil)
                              (when (and (not (eq w win))
                                         (eq buf (window-buffer w)))
                                (return t)))))
    (if in-another-window
        (bury-buffer)
      (kill-buffer))))
(global-set-key "\C-xk" 'dawilcox-maybe-close-window)


;; make emacs use the clipboard
(setq x-select-enable-clipboard t)
;;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
(setq inhibit-startup-message t)

;; Always/never end a file with a newline
(setq require-final-newline t)


 (setq indent-tabs-mode nil)

 (setq-default indent-tabs-mode nil)


 (defun my-c-mode-common-hook ()
  ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
  (c-set-offset 'substatement-open 0)
  ;; other customizations can go here

  (setq c++-tab-always-indent t)
  (setq c-basic-offset 4)                  ;; Default is 2
  (setq c-indent-level 4)                  ;; Default is 2

  (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
  (setq tab-width 8)
  (setq indent-tabs-mode nil)

  (setq-default indent-tabs-mode nil)


  (defconst my-c-lineup-maximum-indent 30)
   (defun my-c-lineup-arglist (langelem)
     (let ((ret (c-lineup-arglist langelem)))
       (if (< (elt ret 0) my-c-lineup-maximum-indent)
           ret
         (save-excursion
           (goto-char (cdr langelem))
           (vector (+ (current-column) 8))))))
   (defun my-indent-setup ()
     (setcdr (assoc 'arglist-cont-nonempty c-offsets-alist)
      '(c-lineup-gcc-asm-reg my-c-lineup-arglist)))
   ;(c-set-offset 'arglist-intro '+)
   (c-set-offset 'arglist-cont-nonempty '+)
  )

(defun gvol-indent-declarations-and-calls-differently (langelem)
    "Indent a method by + if it's all on one line, by 0 otherwise."
    (condition-case err
        (let ((bob (save-excursion
                     (beginning-of-line)
                     (backward-up-list)
                     (line-beginning-position)))
              (joe (save-excursion
                     (beginning-of-line)
                     (beginning-of-defun)
                     (point))))
          (if (> bob joe)
              '++
            '++))
      (error '+)))

 (defconst dawilcox-c-lineup-maximum-indent 30)
 (defun dawilcox-c-lineup-arglist (langelem)
   (let ((ret (c-lineup-arglist langelem)))
     (if (and (sequencep ret) (> (elt ret 0) dawilcox-c-lineup-maximum-indent))
         '++
       ret)))

 (setq-default c-electric-flag nil)

 (defconst dawilcox-c++-style

   ;; Actually he didn't have nearly this much stuff, so this is
   ;; basically Vipers+dawilcox-c-lineup-arglist
   ;; (c-add-style "Dave Wilcox's" dawilcox-c++-style t)
     '((c-echo-syntactic-information-p . t)
       (c-doc-comment-style . ((java-mode . javadoc)
                               (c++-mode  autodoc javadoc)))
       (c-basic-offset                 . 4)
       ;;(c-toggle-auto-newline          . t)
       (c-block-comment-prefix         . "*")
       ;; (c-hanging-comment-starter-p    . nil)
       ;; (c-hanging-comment-ender-p      . nil)
       (c-indent-comments-syntactically-p . t)
       (c-tab-always-indent        . t)
       (c-comment-only-line-offset . (0 . 0))
       ;; (c-comment-only-line-offset . (0 . -1000))
       (c-hanging-braces-alist     . ((substatement-open after)
                                      (brace-list-open)
                                      (block-close . c-snug-do-while)))


       (c-hanging-colons-alist     . ((member-init-intro before)
                                      (inher-intro       before)
                                      (case-label        after)
                                      (label             after)
                                      (access-label      after)))

       (c-cleanup-list             . (scope-operator
                                      empty-defun-braces
                                      defun-close-semi
                                      brace-else-brace
                                      brace-elseif-brace
                                      list-close-comma))
       (c-offsets-alist .
                        ((string                . +)
;;                         ;;(c                     . 1) ; For doxygen-style comments
                         (c                     . c-lineup-C-comments)
                         (defun-open            . 0)
                         (defun-close           . 0)
                         (defun-block-intro     . +)
                         (class-open            . 0)
                         (class-close           . 0)
                         (inline-open           . 0)
                         (inline-close          . 0)
                         (func-decl-cont        . +)
                         (knr-argdecl-intro     . +)
                         (knr-argdecl           . +)
                         (topmost-intro         . 0)
                         (topmost-intro-cont    . 0)
                         (member-init-intro     . +)
                         ;(member-init-intro     . 0)
                         (member-init-cont      . c-lineup-multi-inher)
                         (inher-intro           . +)
                         (inher-intro           . 0)
                         (inher-cont            . +)
                         (block-open            . 0)
                         (block-close           . 0)
                         (brace-list-open       . 0)
                         (brace-list-close      . 0)
                         (brace-list-intro      . +)
                         (brace-list-entry      . 0)
                         (statement             . 0)
                         (statement-cont        . +)
                         ;; (statement-cont        . c-lineup-math)
                         (statement-block-intro . +)
                         (statement-case-intro  . +)
                         (statement-case-open   . 0)
                         (substatement          . +)
                         (substatement-open     . 0)
                         (case-label            . 0)
                         ;(case-label            . +)
                         (access-label          . -)
                         (label                 . 0)
                         (do-while-closure      . 0)
                         (else-clause           . 0)
                         (comment-intro         . c-lineup-comment)
                                     
                         ;; I don't like this, but it's consistent
                         ; (arglist-intro         . c-lineup-arglist-intro-after-paren)
                         ; (arglist-intro         . +)
                         (arglist-intro         . gvol-indent-declarations-and-calls-differently)
                         (arglist-cont          . c-lineup-arglist)
                         (arglist-cont          . c-lineup-argcont)
                         ;; (arglist-cont-nonempty . +)
                         ;; (arglist-cont-nonempty . my-c-lineup-arglist-intro-after-paren)
                         ;; (arglist-cont-nonempty . c-lineup-arglist-intro-after-paren)

                         ;; (arglist-cont-nonempty . c-lineup-arglist)

                         ;; (arglist-cont-nonempty . (c-lineup-gcc-asm-reg dawilcox-c-lineup-arglist))
                         (arglist-cont-nonempty . dawilcox-c-lineup-arglist)
                         (arglist-cont          . c-lineup-argcont)
                         ;; (arglist-close         . c-lineup-arglist)
                         ;; (arglist-close         . 0)
                         (arglist-close         . c-lineup-argcont)
                         ;; (stream-op             . +)
                         (stream-op             . c-lineup-streamop)
                         (inclass               . +)
                         (cpp-macro             . 0)
                         (cpp-macro-cont        . 0)
                         (friend                . 0)
                         (objc-method-intro     . +)
                         (objc-method-args-cont . c-lineup-ObjC-method-args)
                         (objc-method-call-cont . c-lineup-ObjC-method-call)
                         (objc-method-call-cont . c-lineup-ObjC-method-call-colons)
                         (extern-lang-open      . 0)
                         (extern-lang-close     . 0)
                         (inextern-lang         . +)
                         (namespace-open        . 0)
                         (namespace-close       . 0)
                         ;;(innamespace           . ++) ;; I really don't like it this way
                         ;; From http://stackoverflow.com/questions/3156812/indenting-nested-namespaces-on-the-same-line-to-just-one-level
                         ;; (innamespace . (lambda (x) (if (followed-by '(innamespace namespace-close)) 0 '+)))
                         (innamespace           . 0)
                         (inlambda              . c-lineup-inexpr-block)
                         (template-args-cont    . dawilcox-c-lineup-arglist)
 ;;;;;;;; What is wrong here?
                         (catch-clause          . 0)
                         )))

 )


 (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)


 (c-add-style "My Style" dawilcox-c++-style nil)
 (add-hook 'c-mode-common-hook (lambda () (c-set-style "My Style")))


 (if window-system
       (set-frame-size (selected-frame) 170 240))


(setq c-basic-indent 2)
(setq tab-width 4)

(require 'whitespace)
(setq whitespace-style '(tabs tab-mark)) ;turns on white space mode only for tabs
(global-whitespace-mode 1)
(set-background-color "black")
(set-cursor-color "white")
(set-foreground-color "white")

(global-set-key [f6] 'balance-windows)
(remove-hook 'find-file-hooks 'vc-find-file-hook)
(setq make-backup-files nil)
(auto-save-mode 0)
(defun other-window-backwards ()
  (interactive)
  (other-window -1))
(global-set-key [?\C-x ?p] 'other-window-backwards)
(require 'org)


 (define-derived-mode slice-mode idl-mode "Slice"
    "This is a mode for editing slice (Ice definition) files.  It
is based on idl-mode because of the comment at
http://www.zeroc.com/forums/help-center/818-any-editor-slice-syntax-highlight.html
I haven't been able to determine the differences between slice
and idl, so I don't know how good it is."

    (font-lock-add-keywords
     'slice-mode
     `(
       (,(concat "\\<\\("
                 (regexp-opt
                  (list
                   "Object" "LocalObject" "exception" "interface" "idempotent"
                   ))
                 "\\)\\> ")

        1 font-lock-keyword-face t)
       ;; Ice.*

       ("^! .*"   0 font-lock-preprocessor-face t)
       ("^! .*"   0 font-lock-warning-face t)


       ;; Reserved names
       ("\\(Ice\\w*\\)" 1 font-lock-builtin-face)
       ,(concat "\\<\\(\\w*"
                (regexp-opt
                 (list
                  "Helper" "Holder" "Prx" "Ptr"
                  ))
                "\\)\\> ")

       ;; Built-in types
       ,(concat "\\<\\(\\w*"
                (regexp-opt
                 (list

                  "bool" "byte" "short" "int" "long" "float" "double" "string"

                  "sequence<Fruit>"
                  "dictionary<long, Employee>"
                  ))
                "\\)\\> ")
       ))
    )
(add-to-list 'auto-mode-alist '("\\.\\(?:ice\\)\\'" . slice-mode))

(setq package-archives '(
                         ("melpa"     . "http://melpa.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("ADOBE"     . "https://axle.corp.adobe.com/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")))

(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG\\'" . log-edit-mode))

;; Better log messages through engineering
;; (setq log-edit-font-lock-gnu-style t)
(require 'log-edit)

(add-hook 'log-edit-mode-hook #'flyspell-mode) ;; Spell checking
(add-to-list 'log-edit-font-lock-keywords
             '("\\<[[:alpha:]]+\\(ed\\)\\>"
               (1
                '(face font-lock-warning-face help-echo "Use present tense.")
                t)))

;(featurep 'writegood-mode)
(package-initialize)
;; Even highlight (some?) irregular past tense verbs
(when  (require 'writegood-mode nil t)
  (add-to-list 'log-edit-font-lock-keywords
               `(,(regexp-opt
                   (append (mapcar
                            (lambda (x) (capitalize x))
                            writegood-passive-voice-irregulars)
                           writegood-passive-voice-irregulars)
                   'words)
                 (1 '(face font-lock-warning-face help-echo "Use present tense.") t))))

(defun axle-include-guard ()
  "Return an include guard conforming for the Axle coding standard."
  (let* ((fn (upcase (file-name-nondirectory (buffer-file-name))))
         (fn (replace-regexp-in-string "[^A-Z0-9_]" "_" fn ))
         (fn (replace-regexp-in-string "__+" "_" fn )))
    (format "%s_%X" fn (random))))


(defun update-axle-include-guard ()
  "Update the include guard in a file to conform with the Axle coding standard.
This does not check whether the previous include guard already
matched, it unconditionally updates.  If the file does not
already have an include guard, the behavior is unspecified."
  (interactive)
  (let ((ig (axle-include-guard)))
    (save-restriction
      (save-excursion
        (goto-char (point-min))
        (re-search-forward "^#ifndef ")
        (insert ig)
        (delete-region (point) (line-end-position))
        (re-search-forward "^#define ")
        (insert ig)
        (delete-region (point) (line-end-position))))))

(global-set-key [f9] 'update-axle-include-guard)


(setq ns-option-modifier 'meta
          ;; The following allows accented input etc.
          ns-right-option-modifier nil)
