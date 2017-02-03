
(defun rabbit/ido ()
  ""
  (require 'smex)
  (ido-mode 1)
  (ido-everywhere 1)
  (setq-default ido-enable-flex-matching t)
  (ido-vertical-mode 1)  
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
  )


(provide 'rabbit-ido)
