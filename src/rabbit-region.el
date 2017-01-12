(provide 'rabbit-region)

(defun rabbit/region ()
  ""
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-?") 'mc/mark-all-like-this)
  (global-set-key (kbd "C-=") 'er/expand-region))
