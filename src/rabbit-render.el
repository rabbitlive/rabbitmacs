(provide 'rabbit-render)


(defun rabbit/css-color (name)
  ""
  `(:foreground ,name)
  )


(defun rabbit/css-font-family (name)
  ""
  `(:family ,name)
  )

(defun rabbit/css-font-size (name)
  ""
  `(:height ,name)
  )


(defun rabbit/css-font-weight (name)
  ""
  `(:weight ,name)
  )

(defun rabbit/css-background-color (name)
  ""
  `(:background ,name)
  )

(defun rabbit/css-text-decoration (name)
  ""
  (pcase name
    ("underline"    `(:underline t))
    ("overline"     `(:overline t))
    ("line-through" `(:strike-through t))
    (_ (error "Unsupport text decoration prop: %s" name))
    )
  )

(defun rabbit/css-box (name)
  ""
  `(:border ,name)
  )
