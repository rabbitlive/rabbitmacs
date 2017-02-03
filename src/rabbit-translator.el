;;; rabbit-translator.el --- EN|ZH translator  -*- lexical-binding:t -*-

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

(provide 'rabbit-translator)

(require 'cl)
(require 'dash)
(require 'request)
(require 'rabbit-util)

(defun rabbit/translator-map-translated-to-result (translated)
  "Map translated result"
  (let* ((result (assoc-default 'trans_result translated))
	 (resultdata (assoc-default 'data result)))
    (-map (lambda (x)
	    (assoc-default 'dst x))
	  resultdata)))

(defun rabbit/translator-receive (query from to translated)
  "Make response props."
  (when translated
    (rabbit/translator-render (list :query query
				    :from  from
				    :to    to
				    :data (rabbit/translator-map-translated-to-result translated)))))

(defun rabbit/translator-request (query &optional mode)
  "Request from server."
  (let* ((checkmode (if mode mode 1))
	 (from (if (eq 1 checkmode) "zh" "en"))
	 (to (if (eq 1 checkmode) "en" "zh")))

    (request
     "http://fanyi.baidu.com/v2transapi"
     :type "POST"
     :data `(("from" . ,from)
	     ("query" . ,query)
	     ("to" . ,to)
	     ("simple_means_flag" . "3"))
     :parser 'json-read
     :success (function*
	       (lambda (&key data &allow-other-keys)
		 (rabbit/translator-receive query from to data)
		 ))
     )))




(defconst rabbit/translator-buffer-max-size 80)

(defun rabbit/translator-render (option)
  "Render data to *Rabbit Translator* Buffer"
  (let ((translator-buffer-name "*Translator*"))
    (rabbit/render-to-buffer translator-buffer-name
			     (s-join "\n" (list (rabbit/translator-render-header)
						(rabbit/translator-render-body option)
						)))))


(defun rabbit/translator-render-header ()
  "Render header"
  (let ((bmax rabbit/translator-buffer-max-size))
    (s-join "\n" (list (s-center bmax "")
		       (s-center bmax "Rabbit Translator")
		       (s-center bmax "")))))

(defun rabbit/translator-render-body (option)
  "Render body"
  (let ((bmax rabbit/translator-buffer-max-size)
	(from (plist-get option :from))
	(to (plist-get option :to))
	(query (plist-get option :query))
	(data (car (plist-get option :data))))
    (s-join "\n" (list (s-center bmax "")
		       (s-concat (s-pad-right 6 " " "From: ") (propertize from 'face '((:foreground "lightcyan"))))
		       (s-concat (s-pad-right 6 " " "To: ") (propertize to 'face '((:foreground "lightgreen"))))
		       (s-center bmax "")
		       (s-center bmax "")
		       (s-concat (propertize query 'face '((:foreground "darkgray"))))
		       (s-center bmax "")
		       (s-center bmax "")
		       (s-concat data)
		       (s-center bmax "")))))


(defun rabbit/translator ()
  "Main call."
  
  (rabbit/translator-request "测式")
  )

(rabbit/translator)

;; Local Variables:
;; coding: utf-8
;; End:
;;; rabbit-translator.el ends here
