(require 'cask "~/.cask/cask.el")

(defvar rabbit/store '() "global store")

(let ((__dir__ (file-name-directory load-file-name)))
  (cask-initialize __dir__)
  (add-to-list 'load-path (concat __dir__ "src"))

  ;; register config
  (require 'rabbit-util)
  (rabbit/store-register :__dir__ __dir__)
  )

(require 'rabbit-core)
