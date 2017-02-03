(defun rabbit/chinese ()
  ""
  
  (require 'chinese-pyim)

  ;;(require 'chinese-pyim-basedict)
  ;;(chinese-pyim-basedict-enable)
  (setq-default default-input-method "chinese-pyim")

  ;; chinese space
  (require 'pangu-spacing)
  (global-pangu-spacing-mode 1)
  )


(provide 'rabbit-chinese)
