(deftheme pyra
  "Created 2022-02-08.")

(custom-theme-set-variables
 'pyra
 '(ansi-color-faces-vector [default default default italic underline success warning error])
 '(ansi-color-names-vector ["dim gray" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(cua-mode t)
 '(custom-safe-themes '("69b30fcd01e0bce8accefc2fd2f241b84ecbec13ec49719cdda5df550073886e" "c275c98009c50e039a3fa1fcd31e557c8995c6069abef3191aa7bbf81bc889d8" default)))

(custom-theme-set-faces
 'pyra
 '(region ((t :background "#24252c")))
 '(highlight ((t (:background "#434456"))))
 '(cursor ((t (:background "#E95378" :foreground "#1C1E26"))))
 '(fringe ((t :foreground "#232530")))
 '(show-paren-match ((t (:foreground "#abacad" :background "#44465c"))))
 '(show-paren-mismatch ((t (:background "#27D797"))))
 '(match ((t :foreground "#abacad" :background "#5c5e70")))
 '(lazy-highlight ((t :foreground "#abacad" :background "#363749")))
 '(minibuffer-prompt ((t :foreground "#B877DB")))
 '(shadow ((t :foreground "#16161C")))
 '(vertical-border ((t :foreground "#1A1C23")))
 '(success ((t :foreground "#25B0BC")))
 '(warning ((t :foreground "#27D797")))
 '(error ((t :foreground "#E95678")))
 '(trailing-whitespace ((t :foreground "#25B0BC" :background "#25B0BC")))
 '(link ((t :foreground "#F09483" :underline t)))
 '(line-number ((t :foreground "#77797a" :background "#1C1E26")))
 '(line-number-current-line ((t :foreground "#abacad" :background "#1C1E26")))
 '(font-lock-builtin-face ((t :foreground "#B877DB")))
 '(font-lock-comment-face ((t :foreground "#6a6a6a")))
 '(font-lock-constant-face ((t :foreground "#F09483")))
 '(font-lock-doc-face ((t :foreground "#6a6a6a")))
 '(font-lock-function-name-face ((t :foreground "#25B0BC")))
 '(font-lock-keyword-face ((t :foreground "#B877DB")))
 '(font-lock-negation-char-face ((t :foreground "#B877DB")))
 '(font-lock-preprocessor-face ((t :foreground "#B877DB"))))

(provide-theme 'pyra)
