(provide 'rabbit-face)

(require 'rabbit-modeline)
(require 'rabbit-ido)

(defun rabbit/clear-face ()
  "Clear default emacs face."
  
  ;; No tool bar
  (tool-bar-mode 0)
  ;; No menu bar
  (menu-bar-mode 0)
  ;; No scroll bar
  (scroll-bar-mode 0)
  )



(defun main ()
  (rabbit/clear-face)
  ;;(rabbit/modeline)
  (rabbit/ido)
  )


(main)
