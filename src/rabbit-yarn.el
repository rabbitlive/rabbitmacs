(provide 'rabbit-yarn)

(defun rabbit/yarn ()
  "Main call."

  (require 'rabbit-shell)

  ;; define esh alias
  (rabbit/esh-alias "yi" "yarn install")
  (rabbit/esh-alias "ys" "yarn start")
  (rabbit/esh-alias "yt" "yarn test")
  )
