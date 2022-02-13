(load "server")
(unless (server-running-p) (server-start))
(require 'prelude-helm-everywhere)
(require 'use-package)

;; Vars

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq js-indent-level 2)
(setq indent-line-function 'insert-tab)
(setq split-height-threshold nil)
(setq create-lockfiles nil)
(setq prelude-whitespace nil)

;; Global modes
(global-display-line-numbers-mode t)
(smartparens-global-mode t)

;; Mode hooks
;; File associations

;(add-to-list 'auto-mode-alist '("\\.vue\\'" .  vue-mode ))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(add-hook 'treemacs-mode-hook (lambda() (display-line-numbers-mode -1)))

;(add-hook 'vue-mode-hook #'lsp)
(add-hook 'ruby-mode-hook 'robe-mode)

(add-hook 'text-mode-hook #'adaptive-wrap-prefix-mode)
(add-hook 'prog-mode-hook #'adaptive-wrap-prefix-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)  
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
;; (global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-x") 'helm-M-x)
;; (define-key 'magit-file-section-map (kbd "RET") 'magit-diff-visit-file-other-window)


;; MISC

;; transparent terminal bg
(defun on-frame-open (&optional frame)
  "If the FRAME created in terminal don't load background color."
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))

(add-hook 'after-make-frame-functions 'on-frame-open)

(require 'robe)

(windmove-default-keybindings)

;; buffer tab conf
;; key to begin cycling buffers.  Global key.
(global-set-key (kbd "C-<tab>") 'buffer-flip)

;; transient keymap used once cycling starts
(setq buffer-flip-map
      (let ((map (make-sparse-keymap)))
        (define-key map (kbd "C-<tab>")   'buffer-flip-forward)
        (define-key map (kbd "C-S-<tab>") 'buffer-flip-backward)
        (define-key map (kbd "C-ESC")     'buffer-flip-abort)
        map))

;; buffers matching these patterns will be skipped
(setq buffer-flip-skip-patterns
      '("^\\*helm\\b"
        "^\\*swiper\\*$"))


(load (expand-file-name "~/.quicklisp/slime-helper.el"))
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
