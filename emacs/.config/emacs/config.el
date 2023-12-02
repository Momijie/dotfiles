(add-to-list 'load-path "~/.config/emacs/scripts/")
(require 'elpaca-setup)
(require 'buffer-move)

(defun disable-line-numbers ()
  (display-line-numbers-mode -1))

(defun disable-mode-line ()
  (setq mode-line-format nil))

(defun display-line-numbers-equalize ()
  "Equalize the width"
  (setq display-line-numbers-width (length (number-to-string (line-number-at-pos (point-max))))))

(setq initial-scratch-message "")

(recentf-mode 1)

(defun satori/visual/minimal-ui()
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))
;(satori/visual/minimal-ui)

(defun satori/org/init-org-modern()
  ; putting this setq here for now.
  (org-indent-mode -1)

  (use-package org-modern
    :hook
    (org-mode . org-modern-mode)
    (org-agenda-finalize . org-modern-agenda)))
(satori/org/init-org-modern)

(defun satori/org/init-org-modern-indent()
  (use-package org-modern-indent 
    :elpaca (:host github :repo "jdtsmith/org-modern-indent")
    :config 
    (add-hook 'org-mode-hook #'org-modern-indent-mode 90)))
;(satori/org/init-org-modern-indent)
