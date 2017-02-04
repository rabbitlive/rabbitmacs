;;; rabbit-doc.el --- for devdocs  -*- lexical-binding:t -*-

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

(provide 'rabbit-doc)

(require 'rabbit-util)
(rabbit/store-selector :docs)

(defun rabbit/define-doc (name url entry &optional ext)
  "Put doc list."
  (let ((doc-list (rabbit/store-selector :docs))
	(mklist (list :name  name
		      :url   url
		      :entry entry
		      :ext   (if ext ext "md"))))
    (rabbit/store-register :docs
			   (plist-put doc-list (intern name) mklist))))

(defun rabbit/get-doc (name &optional prop)
  "Get doc list by name."
  (let* ((doc-list (rabbit/store-selector :docs))
	 (matched (plist-get doc-list (intern name))))
    (if (not prop) matched
      (plist-get matched prop))))


(defun rabbit/doc-match-doc-file (entry ext)
  "Match file from entries."
  (lambda (file)
    (and
     (string= ext (f-ext file))
     (not (string= "_" (substring (f-relative file entry) 0 1))))))

(defun rabbit/doc-map-matched-file-readable (entry)
  "Map match file to minibuffer."
  (lambda (x)
    (f-no-ext (f-relative x entry))))


(defun rabbit/get-doc-index (name)
  ""
  (let* ((projdir (rabbit/store-selector :__dir__))
	 (docdir (rabbit/store-selector :doc-local-dir))
	 (docext (rabbit/get-doc name :ext))
	 (entry (concat projdir docdir name "/" (rabbit/get-doc name :entry) "/")))
     (-map (rabbit/doc-map-matched-file-readable entry)
	  (f-files entry (rabbit/doc-match-doc-file entry docext) t))))


;;(rabbit/get-doc-index "yarn")
;;(completing-read "find docs: " (rabbit/get-doc-index "yarn") nil t "yarn")
;;(find-file (completing-read "find Docs: " (rabbit/get-doc-index "yarn") nil t ""))


(defun rabbit/docs ()
  "render docs list"
  (interactive)

  )

;;(print (completing-read "find docs: " '("yarn" "yarn1") nil t "yarn"))
;;(print completing-read-function)

(defun rabbit/doc ()
  "Main call."
  (rabbit/store-register :docs '())
  (rabbit/store-register :doc-local-dir "docs/")
  )

;; Local Variables:
;; coding: utf-8
;; End:
;;; rabbit-doc.el ends here
