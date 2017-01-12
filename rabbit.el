(require 'cask "~/.cask/cask.el")

(let ((__dir__ (file-name-directory load-file-name)))
  (cask-initialize __dir__)
  (add-to-list 'load-path (concat __dir__ "src")))

(require 'rabbit-core)
