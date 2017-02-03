(provide 'rabbit-default)

(defun rabbit/default ()
  ;; Auto revert
  (global-auto-revert-mode 1)

  ;; Disable foo~ file
  (setq make-backup-files nil)

  ;; Disable auto save
  ;;(setq auto-save-default nil)

  (fset 'yes-or-no-p 'y-or-n-p)


  ;; Editorconfig
  (require 'editorconfig)
  (editorconfig-mode 1)

  ;; Uniquify
  (require 'uniquify)
  (setq-default uniquify-buffer-name-style 'forward)

  (setq x-select-enable-clipboard t
        x-select-enable-primary t
        save-interprogram-paste-before-kill t
        apropos-do-all t
        mouse-yank-at-point t
        require-final-newline t
        visible-bell t
        load-prefer-newer t
        ediff-window-setup-function 'ediff-setup-windows-plain
        save-place-file (concat user-emacs-directory "places")
        backup-directory-alist `(("." . ,(concat user-emacs-directory
                                                 "backups"))))
  )


