;;; rabbit-core.el --- core.rabbitmacs  -*- lexical-binding:t -*-

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

(require 'rabbit-util)

(import rabbit-default)
(import 'rabbit-face)
(import 'rabbit-edit)

(defvar rabbit/store '() "rabbitmacs store.")


(defun rabbit/store-creator (update)
  ""

  (let* ((curr-listener '())
	 (curr-modal '())
	 (curr-update update)
	 (next-listener curr-listener)
	 (is-dispatching nil)

	 (make-imuttable-listener (lambda (fn)
				    (when (eq next-listener curr-listener)
				      (setq next-listener (-slice curr-listener 0)))
				    (funcall fn)
				    ))
	 (get-modal (lambda () curr-modal))

	 (subscribe (lambda (listener)
		      (let ((is-subscribe t))

			(make-imuttable-listener
			 (lambda ()
			   (push listener curr-listener)))

			(lambda ()
			  "Unsubscribe."
			  (when is-subscribe
			    (setq is-subscribe nil)
			    (make-imuttable-listener
			     (lambda ()
			       (let (idx (-elem-index listener curr-listener))
				 (-remove-at idx curr-listener)))))))))

	 (dispatch (lambda (msg)
		     "Dispatch msg"

		     (print curr-update)

		     (unless is-dispatching
		       (setq is-dispatching (not is-dispatching))
		       (setq curr-modal (curr-update curr-modal msg))
		       (setq is-dispatching (not is-dispatching))

		       ;; fire listeners
		       (-each curr-listener
			 (lambda (listener)
			   (funcall listener))))))
	 )

    
    (setq rabbit/store (list :type :store
			     :dispatch 'dispatch
			     :subscribe 'subscribe
			     :get-modal 'get-modal
			     ))))

(rabbit/store-creator (lambda (state action)
			(print action)
			state))

(funcall (plist-get rabbit/store :dispatch) 123)

(defun rabbit/listener-creator (fn)
  "Create listener."
  (list :type :listener
	:call fn))


(defun defmodal (body)
  ""
  (let* ((model rabbit/modal)
	 (key (intern (buffer-name))))
    (plist-put rabbit/modal key body)))

(defmodal '((a . 1) (b . 2)))

(defun rabbit/dispatch (store)
  "dispatch a action."
  (lambda (action)
    
    )
  )

(rabbit/listener-creator
 (lambda (x) (print x) ))


(defun rabbit/subscription ()
  ""
  
  )





(provide 'rabbit-core)

;; Local Variables:
;; coding: utf-8
;; End:
;;; rabbit-core.el ends here
