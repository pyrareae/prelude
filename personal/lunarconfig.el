(load "server")
(setq warning-minimum-level :emergency)
(unless (server-running-p) (server-start))
;; (require 'prelude-helm-everywhere)
;; (require 'smex)
;; (smex-initialize)
(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))
(use-package selectrum)
(selectrum-mode +1)
(setq completion-styles '(orderless))
(savehist-mode)
(setq orderless-skip-highlighting (lambda () selectrum-is-active))
(setq selectrum-highlight-candidates-function #'orderless-highlight-matches)
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))
(use-package consult)
(use-package embark)

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; (package-initialize)
;; (require 'ergoemacs-mode)
;; (setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme
;; (setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
;; (ergoemacs-mode 1)
;; (require 'boon-qwerty)
;; (boon-mode)


;; (require 'god-mode)
;; (god-mode)
;; (global-set-key (kbd "<escape>") #'god-mode-all)
;; (which-key-enable-god-mode-support)
;; (setq god-exempt-major-modes '(magit-mode))
;; (setq god-exempt-predicates nil)
;; (defun my-god-mode-update-cursor-type ()
;;   (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))

;; (add-hook 'post-command-hook #'my-god-mode-update-cursor-type)

(require 'tree-sitter)
(require 'tree-sitter-langs)
;; (require 'icicles)

;;  General CONF
(set-face-attribute 'default nil :height 120)


;; Vars

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq js-indent-level 2)
(setq indent-line-function 'insert-tab)
(setq split-height-threshold nil)
(setq create-lockfiles nil)
(setq prelude-whitespace nil)
;; (guru-global-mode nil)

;; Global modes
(global-display-line-numbers-mode t)
(smartparens-global-mode t)
(pixel-scroll-precision-mode t)

;; Mode hooks
;; File associations

;(add-to-list 'auto-mode-alist '("\\.vue\\'" .  vue-mode ))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(add-hook 'treemacs-mode-hook (lambda() (display-line-numbers-mode -1)))

;(add-hook 'vue-mode-hook #'lsp)
;; (add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'enh-ruby-mode-hook #'lsp)
(add-hook 'ruby-mode-hook #'lsp)

(add-hook 'text-mode-hook #'adaptive-wrap-prefix-mode)
(add-hook 'prog-mode-hook #'adaptive-wrap-prefix-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
(add-hook 'common-lisp-mode (lambda () (lispy-mode 1)))
;; (add-hook 'text-mode-hook #')
;(add-hook 'vue-mode-hook (lambda () (setq syntax-ppss-table nil)))

;; other hooks
(add-hook 'mmm-major-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face nil)))


;; Bindings
(global-set-key (kbd "C-?") 'undo-tree-redo)
(global-set-key (kbd "C-s-<up>") 'move-text-up)
(global-set-key (kbd "C-s-<down>") 'move-text-down)
(global-set-key (kbd "C-x M-t") 'treemacs)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "s-SPC") 'projectile-find-file)
(global-set-key (kbd "C-<tab>") 'consult-project-buffer)
;; (global-set-key (kbd "RET") 'newline-and-indent)
;; (global-set-key (kbd "M-x") 'helm-M-x)
;; (global-set-key (kbd "C-\\") 'helm-M-x)
;; (global-set-key (kbd "M-\\")  (lambda () (interactive)
                                ;; (if (bound-and-true-p projectile-mode)
                                  ;; 'projectile-find-file
                                  ;; 'find-file)))
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'helm-M-x)
;; (define-key 'magit-file-section-map (kbd "RET") 'magit-diff-visit-file-other-window)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-x C-b") 'consult-buffer)


;; MISC

;; transparent terminal bg
(defun on-frame-open (&optional frame)
  "If the FRAME created in terminal don't load background color."
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))

(add-hook 'after-make-frame-functions 'on-frame-open)

(require 'robe)

(windmove-default-keybindings)

;(load (expand-file-name "~/.quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")

;; VUE setup
;; source https://gist.github.com/SjB/07cdce0f1fba171704d93c2989077f4d

(use-package polymode
        :ensure t
        :defer t
        :hook (vue-mode . lsp-deferred)
        :mode ("\\.vue\\'" . vue-mode)
        :config
        (define-innermode poly-vue-template-innermode
          :mode 'html-mode
          :head-matcher "^<[[:space:]]*\\(?:template\\)[[:space:]]*>"
          :tail-matcher "^</[[:space:]]*\\(?:template\\)[[:space:]]*>"
          :head-mode 'host
          :tail-mode 'host)

        (define-innermode poly-vue-script-innermode
          :mode 'js-mode
          :head-matcher "<[[:space:]]*\\(?:script\\)[[:space:]]*>"
          :tail-matcher "</[[:space:]]*\\(?:script\\)[[:space:]]*>"
          :head-mode 'host
          :tail-mode 'host)

        (define-auto-innermode poly-vue-template-tag-lang-innermode
          :head-matcher "^<[[:space:]]*\\(?:template\\)[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*[[:alpha:]]+[[:space:]]*[\"'][[:space:]]*>"
          :tail-matcher "^</[[:space:]]*\\(?:template\\)[[:space:]]*>"
          :mode-matcher (cons  "^<[[:space:]]*\\(?:template\\)[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*\\([[:alpha:]]+\\)[[:space:]]*[\"'][[:space:]]*>" 1)
          :head-mode 'host
          :tail-mode 'host)

        (define-auto-innermode poly-vue-script-tag-lang-innermode
          :head-matcher "<[[:space:]]*\\(?:script\\)[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*[[:alpha:]]+[[:space:]]*[\"'][[:space:]]*>"
          :tail-matcher "</[[:space:]]*\\(?:script\\)[[:space:]]*>"
          :mode-matcher (cons  "<[[:space:]]*\\(?:script\\)[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*\\([[:alpha:]]+\\)[[:space:]]*[\"'][[:space:]]*>" 1)
          :head-mode 'host
          :tail-mode 'host)

        (define-auto-innermode poly-vue-style-tag-lang-innermode
          :head-matcher "<[[:space:]]*\\(?:style\\)\\(?:scoped\\|[[:space:]]\\)*lang=[[:space:]]*[\"'][[:space:]]*[[:alpha:]]+[[:space:]]*[\"']*\\(?:scoped\\|[[:space:]]\\)*>"
          :tail-matcher "</[[:space:]]*\\(?:style\\)[[:space:]]*>"
          :mode-matcher (cons  "<[[:space:]]*\\(?:style\\)\\(?:scoped\\|[[:space:]]\\)*lang=[[:space:]]*[\"'][[:space:]]*\\([[:alpha:]]+\\)[[:space:]]*[\"']\\(?:scoped\\|[[:space:]]\\)*>" 1)
          :head-mode 'host
          :tail-mode 'host)

        (define-innermode poly-vue-style-innermode
          :mode 'css-mode
          :head-matcher "<[[:space:]]*\\(?:style\\)[[:space:]]*\\(?:scoped\\|[[:space:]]\\)*>"
          :tail-matcher "</[[:space:]]*\\(?:style\\)[[:space:]]*>"
          :head-mode 'host
          :tail-mode 'host)

        (define-polymode vue-mode
          :hostmode 'poly-sgml-hostmode
          :innermodes '(
                        poly-vue-template-tag-lang-innermode
                        poly-vue-script-tag-lang-innermode
                        poly-vue-style-tag-lang-innermode
                        poly-vue-template-innermode
                        poly-vue-script-innermode
                        poly-vue-style-innermode
                        )))
