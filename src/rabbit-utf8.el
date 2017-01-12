
(provide 'rabbit-utf8)


(defun rabbit/utf8 ()
  ""
  (prefer-coding-system 'utf-8)
  ;;(set-buffer-file-coding-system 'utf-8)
  (setq-default file-name-coding-system 'utf-8))
