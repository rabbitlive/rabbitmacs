

(defun set-default-face ()
  ""
  
  ;; Disable tool bar
  (tool-bar-mode 0)


  ;; Disable menu bar
  (menu-bar-mode 0)


  ;; Disable scroll bar
  (scroll-bar-mode 0)
  
  )

;;; autoload
(defun init-face ()
  (interactive)
  (set-default-face)
  )

(provide 'face)
