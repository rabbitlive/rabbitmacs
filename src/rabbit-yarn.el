;;; rabbit-yarn.el --- yarn pkg manager  -*- lexical-binding:t -*-

;; Copyright (C) 2017 Rabbit

;; Maintainer: Rabbit <yfhj1990@hotmail.com>
;; Package: rabbitmacs

;; MIT License

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Code:

(provide 'rabbit-yarn)


(require 'rabbit-doc)

(defun rabbit/yarn ()
  "Main call."

  (require 'rabbit-shell)
  ;; define esh alias
  (rabbit/esh-alias "yi" "yarn install --verbose $*")
  (rabbit/esh-alias "ys" "yarn start $*")
  (rabbit/esh-alias "yt" "yarn test $*")
  (rabbit/esh-alias "ya" "yarn add --verbose $*")
  (rabbit/esh-alias "yad" "yarn add --dev --verbose $*")
  (rabbit/esh-alias "yga" "yarn global --verbose add $*")

  ;; register doc
  (rabbit/define-doc "yarn" "https://github.com/yarnpkg/website.git" "lang/en/docs")
  )



;; Local Variables:
;; coding: utf-8
;; End:
;;; rabbit-yarn.el ends here
