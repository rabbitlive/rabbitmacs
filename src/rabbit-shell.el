(provide 'rabbit-shell)

(defun rabbit/esh-alias (&rest args)
  "Define eshell alias."
  (let ((name (car args)))
    (unless (eshell-command-aliased-p name)
      (apply 'eshell/alias args))))

(defun rabbit/esh-alias-clean ()
  "Clear eshell alias file."
  (interactive)
  (let ((file eshell-aliases-file))
    (f-delete file)
    (f-touch file)))


(defun rabbit/shell ()
  "Configure eshell."

  ;; Global keybinding.
  (global-set-key (kbd "C-M-'") 'eshell)

  
  ;; Define alias
  (require 'em-alias)
  ;; better default.
  (rabbit/esh-alias "ll" "ls -Alh $*")
  (rabbit/esh-alias "lr" "ls -R1 $*")
  (rabbit/esh-alias "cls" "clear")
  (rabbit/esh-alias "e." "explorer .")

  
  ;; git
  ;; github

  
  )


