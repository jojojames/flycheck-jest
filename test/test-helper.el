;;; test-helper.el --- Helpers for flycheck-jest-test.el

;; Copyright (C) 2017 James Nguyen

;; Author: James Nguyen <james@jojojames.com>
;; Maintainer: James Nguyen <james@jojojames.com>
;; Created: 20 November 2017

;;; Commentary:

;; Utilities for running flycheck-jest tests.

;;; Code:
(require 'ert)

;; FIXME: Adding `f' as a dependency just for this line.
(require 'f)
(let ((flycheck-jest-dir (f-parent (f-dirname (f-this-file)))))
  (add-to-list 'load-path flycheck-jest-dir))
(require 'flycheck-jest)

;;; test-helper.el ends here
