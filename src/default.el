;; Auto revert
(global-auto-revert-mode 1)

;; Disable foo~ file
(setq make-backup-files nil)

;; Disable auto save
;;(setq auto-save-default nil)

(fset 'yes-or-no-p 'y-or-n-p)


(provide 'default)
