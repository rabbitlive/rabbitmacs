

(provide 'rabbit-face)


(defun rabbit/clear-face ()
  "Clear default emacs face."

  (require 'rabbit-modeline)
  
  ;; No tool bar
  (tool-bar-mode 0)
  ;; No menu bar
  (menu-bar-mode 0)
  ;; No scroll bar
  (scroll-bar-mode 0)
  )



(defun rabbit/face ()
  (rabbit/clear-face)
  ;;(rabbit/modeline)
  (import 'rabbit-ido)
  (import 'rabbit-headerline)
  )
