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

(import 'rabbit-default)
(import 'rabbit-face)
(import 'rabbit-edit)

(defvar rabbit/store '() "rabbitmacs store.")


(defun rabbit/store-creator (update)
  "Create store."
  (let* ((curr-listener '())
	 (curr-modal '())
	 (curr-update update)
	 (next-listener curr-listener)
	 (is-dispatching nil))

    (defun make-imuttable-listener (fn)
      (when (eq next-listener curr-listener)
	(setq next-listener (-slice curr-listener 0)))
      (funcall fn))

    
    (defun get-modal ()
      ""
      curr-modal)


    (defun subscribe (listener)
      "Subscribe."
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
		 (-remove-at idx curr-listener))))))))
    

    (defun dispatch (msg)
      "Dispatch msg."

      (let ((type (plist-get msg :type))
	    (msg-type (plist-get msg :msg-type)))
	
	(unless (eq :msg type)
	  (error "TypeError: %s not a Msg." msg))

	(unless msg-type
	  (error "Error: Msg must have an type property." msg-type))

	(unless is-dispatching
	  (setq is-dispatching (not is-dispatching))
	  (setq curr-modal (funcall curr-update curr-modal msg))
	  (setq is-dispatching (not is-dispatching))

	  (-each curr-listener 'funcall)
	  ;; (lambda (listener)
	  ;;     "Call listeners."
	  ;;     (funcall listener))

	  msg)))

    
    (setq rabbit/store (list :type :store
			     :dispatch  'dispatch
			     :subscribe 'subscribe
			     :get-modal 'get-modal))))



(defmacro defmsg (msg-type payload)
  "Define Msg."
  (list 'list :type :msg
	:msg-type msg-type
	:payload payload))

(defmacro defupdate (name &rest body)
  "Define Update."
  `(defun ,name (state msg)
     (let ((msg-type (plist-get msg :msg-type))
	   (payload (plist-get msg :payload)))
       (pcase msg-type ,@body
	      (_ state)))))

;; (defupdate app
;;   (:print-42 (print payload)))

;; (app 123 (defmsg :print-42 "asd"))

;;(rabbit/store-creator 'app)

;;(funcall (plist-get rabbit/store :dispatch) (defmsg :print-42 "asd"))


(provide 'rabbit-core)

;; Local Variables:
;; coding: utf-8
;; End:
;;; rabbit-core.el ends here
