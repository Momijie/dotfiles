(add-to-list 'load-path "~/.config/emacs/scripts/")
(require 'elpaca-setup)
(require 'buffer-move)

(setq initial-scratch-message "")

(let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
	       (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
	       (36 . ".\\(?:>\\)")
	       (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
	       (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
	       (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
	       (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
	       (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
	       (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
	       (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
	       (48 . ".\\(?:x[a-zA-Z]\\)")
	       (58 . ".\\(?:::\\|[:=]\\)")
	       (59 . ".\\(?:;;\\|;\\)")
	       (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
	       (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
	       (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
	       (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
	       (91 . ".\\(?:]\\)")
	       (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
	       (94 . ".\\(?:=\\)")
	       (119 . ".\\(?:ww\\)")
	       (123 . ".\\(?:-\\)")
	       (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
	       (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
	       )
	     ))
  (dolist (char-regexp alist)
    (set-char-table-range composition-function-table (car char-regexp)
			  `([,(cdr char-regexp) 0 font-shape-gstring]))))

(set-face-attribute 'default nil
		    :font "Fira Code"
		    :height 120
		    :weight 'medium)

(use-package catppuccin-theme :after org :config
  (load-theme 'catppuccin :no-confirm))

(use-package rainbow-mode
  :hook org-mode prog-mode)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(setq visible-bell t)

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 10      ;; sets modeline height
        doom-modeline-bar-width 0    ;; sets right bar width
        doom-modeline-persp-name t   ;; adds perspective name to modeline
        doom-modeline-persp-icon 'nil)) ;; adds folder icon next to persp name

(setq org-agenda-files
      '("~/Documents/notes/"))
(setq org-agenda-block-separator 8411)
(require 'org)
(setq org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%a %b %e %Y>" . "<%a %e %b %Y %I:%M %p"))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(electric-indent-mode -1)
(setq org-edit-src-content-indentation 0)

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(require 'org-tempo)

(use-package org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config (setq org-auto-tangle-default t))

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))
(use-package evil-tutor)

(global-set-key [escape] 'keyboard-escape-quit)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(use-package general
  :config
  (general-evil-setup)
  ;; set up 'SPC' as the global leader key
  (general-create-definer satori/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

  (satori/leader-keys
    "SPC" '(counsel-M-x :wk "Counsel M-x")
    "ff" '(find-file :wk "Find file")
    "fc" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit emacs config")
    "fr" '(counsel-recentf :wk "Find recent files")
    "TAB TAB" '(comment-line :wk "Comment lines")
    "s" '(save-buffer :wk "Save file"))

  (satori/leader-keys
    "g" '(:ignore t :wk "Git")
    "g/" '(magit-displatch :wk "Magit dispatch")
    "g." '(magit-file-displatch :wk "Magit file dispatch")
    "gb" '(magit-branch-checkout :wk "Switch branch")
    "gc" '(:ignore t :wk "Create")
    "gcb" '(magit-branch-and-checkout :wk "Create branch and checkout")
    "gcc" '(magit-commit-create :wk "Create commit")
    "gcf" '(magit-commit-fixup :wk "Create fixup commit")
    "gC" '(magit-clone :wk "Clone repo")
    "gf" '(:ignore t :wk "Find")
    "gfc" '(magit-show-commit :wk "Show commit")
    "gff" '(magit-find-file :wk "Magit find file")
    "gfg" '(magit-find-git-config-file :wk "Find gitconfig file")
    "gF" '(magit-fetch :wk "Git fetch")
    "gg" '(magit-status :wk "Magit status")
    "gi" '(magit-init :wk "Initialize git repo")
    "gl" '(magit-log-buffer-file :wk "Magit buffer log")
    "gr" '(vc-revert :wk "Git revert file")
    "gs" '(magit-stage-file :wk "Git stage file")
    "gt" '(git-timemachine :wk "Git time machine")
    "gu" '(magit-stage-file :wk "Git unstage file"))

  (satori/leader-keys
    "b" '(:ignore t :wk "buffer")
    "bb" '(switch-to-buffer :wk "Switch buffer")
    "bi" '(ibuffer :wk "Ibuffer")
    "bk" '(kill-this-buffer :wk "Kill this buffer")
    "bn" '(next-buffer :wk "Next buffer")
    "bp" '(previous-buffer :wk "Previous buffer")
    "br" '(revert-buffer :wk "Reload buffer"))

  (satori/leader-keys
    "e" '(:ignore t :wk "Eshell/Evaluate")
    "eb" '(eval-buffer :wk "Evaluate elisp in buffer")
    "ed" '(eval-defun :wk "Evaluate defun containing or after point")
    "ee" '(eval-expression :wk "Evaluate and elisp expression")
    "eh" '(counsel-esh-history :which-key "Eshell History")
    "el" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "er" '(eval-region :wk "Evaluate elisp in region")
    "es" '(eshell :which-key "Eshell"))

  (satori/leader-keys
    "h" '(:ignore t :wk "Help")
    "hd" '(:ignore t :wk "Describe")
    "hdf" '(describe-function :wk "Describe function")
    "hdv" '(describe-variable :wk "Describe variable")
    "hdk" '(describe-key :wk "Describe key")
    "hdb" '(describe-key-briefly :wk "Describe key briefly")
    "hi" '(:ignore t :wk "Info")
    "hii" '(info :wk "Info documentation browser")
    "hid" '(Info-directory :wk "Info Directory")
    "hia" '(info-apropos :wk "Find indice")
    "hr" '(+reload-init :wk "Reload emacs config")
    "ht" '(evil-tutor-start :wk "Evil tutor"))

  (satori/leader-keys
    "o" '(:ignore t :wk "Org")
    "oa" '(org-agenda :wk "Org agenda")
    "os" '((lambda () (interactive) (find-file "~/Documents/notes/brain.org")) :wk "Satori's Brain")
    "oe" '(org-export-dispatch :wk "Org export dispatch")
    "oi" '(org-toggle-item :wk "Org toggle item")
    "ot" '(org-todo :wk "Org todo")
    "oB" '(org-babel-tangle :wk "Org babel tangle")
    "oT" '(org-todo-list :wk "Org todo list")
    "ol" '(org-insert-link :wk "Org insert link")
    "oo" '(org-open-at-point :wk "Org open")
    "or" '(:ignore t :wk "Org roam")
    "oro" '(org-roam-node-open :wk "Org roam open")
    "orv" '(org-roam-node-visit :wk "Org roam visit")
    "orf" '(org-roam-node-find :wk "Org roam find")
    "ori" '(org-roam-node-insert :wk "Org roam insert"))

  (satori/leader-keys
    "ob" '(:ignore t :wk "Tables")
    "ob -" '(org-table-insert-hline :wk "Insert hline in table"))

  (satori/leader-keys
    "od" '(:ignore t :wk "Date/deadline")
    "odt" '(org-time-stamp :wk "Org time stamp"))

  (satori/leader-keys
    "t" '(:ignore t :wk "Toggle")
    "tl" '(display-line-numbers-mode :wk "Toggle line numbers")
    "tt" '(visual-line-mode :wk "Toggle truncated lines")
    "t/" '(vterm-toggle :wk "Toggle vterm"))

  (satori/leader-keys
    "w" '(:ignore t :wk "Windows")
    ;; Window splits
    "wc" '(evil-window-delete :wk "Close window")
    "wn" '(evil-window-new :wk "New window")
    "wv" '(evil-window-vsplit :wk "Vertical split window")
    "ws" '(evil-window-split :wk "Horizontal split window")
    ;; Window motions
    "wh" '(evil-window-left :wk "Window left")
    "wj" '(evil-window-down :wk "Window down")
    "wk" '(evil-window-up :wk "Window up")
    "wl" '(evil-window-right :wk "Window right")
    "ww" '(evil-window-next :wk "Goto next window")
    ;; Move Windows
    "wH" '(buf-move-left :wk "Buffer move left")
    "wJ" '(buf-move-down :wk "Buffer move down")
    "wK" '(buf-move-up :wk "Buffer move up")
    "wL" '(buf-move-right :wk "Buffer move right")))

(use-package git-timemachine
  :after git-timemachine
  :hook (evil-normalize-keymaps . git-timemachine-hook)
  :config
  (evil-define-key 'normal git-timemachine-mode-map (kbd "C-j") 'git-timemachine-show-previous-revision)
  (evil-define-key 'normal git-timemachine-mode-map (kbd "C-k") 'git-timemachine-show-next-revision))

(use-package magit)

(setq eshell-prompt-regexp "^[^#$\n]*[#$] "
      eshell-prompt-function
      (lambda nil
	(concat
	 "[" (user-login-name) "@" (system-name) " "
	 (if (string= (eshell/pwd) (getenv "HOME"))
	     "~" (eshell/basename (eshell/pwd)))
	 "]"
	 (if (= (user-uid) 0) "# " "$ "))))


(use-package eshell-syntax-highlighting
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
;; eshell-rc-script -- your profile for eshell; like a bashrc for eshell.
;; eshell-aliases-file -- sets an aliases file for the eshell.

(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))

(use-package vterm
  :config
  (setq shell-file-name "/bin/zsh"
	vterm-max-scrollback 5000))

(use-package vterm-toggle
  :after vterm
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
	       '((lambda (buffer-or-name _)
		   (let ((buffer (get-buffer buffer-or-name)))
		     (with-current-buffer buffer
		       (or (equal major-mode 'vterm-mode)
			   (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
		 (display-buffer-reuse-window display-buffer-at-bottom)
		 (reusable-frames . visible)
		 (window-height . 0.3))))

(use-package dashboard
  :ensure t
  :init
  (setq initial-buffer-choice `dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Satori's Emacs")
  (setq dashboard-center-content t)
  (setq dashboard-startup-banner "/home/satori/.config/emacs/images/satori-scaled.png")
  (setq dashboard-items ' ((recents . 5)
			   (projects . 3)
			   (bookmarks . 3)
			   (agenda . 3)
			   (registers . 3)
			   ))
  :config
  (dashboard-setup-startup-hook))

(use-package which-key
  :init
  (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
	which-key-sort-order #'which-key-key-order-alpha
	which-key-sort-uppercase-first nil
	which-key-add-column-padding 1
	which-key-max-display-columns nil
	which-key-min-display-lines 6
	which-key-side-window-slot -10
	which-key-side-window-max-height 0.25
	which-key-idle-delay 10
	which-key-max-description-length 25
	which-key-allow-imprecise-window-fit t
	which-key-separator " → " ))

(use-package diminish)

(use-package flycheck
  :ensure t
  :defer t
  :diminish
  :init (global-flycheck-mode))

(use-package company
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package ivy
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :after ivy
  :ensure t
  :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
  :custom
  (ivy-virtual-abbreviate 'full
			  ivy-rich-switch-buffer-align-virtual-buffer t
			  ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
			       'ivy-rich-switch-buffer-transformer))

(setq backup-directory-alist '(("" . "~/.backup/emacs/")))
