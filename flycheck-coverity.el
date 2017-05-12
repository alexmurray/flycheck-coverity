;;; flycheck-coverity.el --- Integrate Coverity with flycheck

;; Copyright (c) 2016 Alex Murray

;; Author: Alex Murray <murray.alex@gmail.com>
;; Maintainer: Alex Murray <murray.alex@gmail.com>
;; URL: https://github.com/alexmurray/flycheck-coverity
;; Version: 0.1
;; Package-Requires: ((flycheck "0.24") (emacs "24.4"))

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This packages integrates the Coverity `cov-run-desktop' Fast Desktop
;; Analysis tool with flycheck to automatically detect any new defects in your
;; code on the fly.

;;;; Setup

;; (eval-after-load 'flycheck
;;   '(progn
;;      (require 'flycheck-coverity)
;;      (flycheck-coverity-setup)
;;      ;; chain after cppcheck since this is the last checker in the upstream
;;      ;; configuration
;;      (flycheck-add-next-checker 'c/c++-cppcheck '(warning . coverity))))

;; If you do not use cppcheck then chain after clang / gcc / other C checker
;; that you use

;; (flycheck-add-next-checker 'c/c++-clang '(warning . coverity))

;;; Code:
(require 'flycheck)
(require 'dash)

(flycheck-def-args-var flycheck-coverity-args coverity)

(defun flycheck-coverity-locate-coverity-conf ()
  "Locate the coverity.conf file."
  (-when-let (file (buffer-file-name))
    (locate-dominating-file file "coverity.conf")))

(flycheck-define-checker coverity
  "A checker using coverity.

See `https://github.com/alexmurray/coverity/'."
  :command ("cov-run-desktop"
            "--text-output-style=oneline"
            (eval flycheck-coverity-args)
            source-original)
  :predicate (lambda () (and flycheck-buffer-saved-p
			(flycheck-coverity-locate-coverity-conf)))
  :error-patterns ((warning line-start (file-name) ":" line ": CID"
                            (message (one-or-more not-newline)
                                     (zero-or-more "\n"
                                                   (one-or-more not-newline)))
                            line-end))
  :modes (c-mode c++-mode))

;;;###autoload
(defun flycheck-coverity-setup ()
  "Setup flycheck-coverity.

Add `coverity' to `flycheck-checkers'."
  (interactive)
  ;; append to list and chain after existing checkers
  (add-to-list 'flycheck-checkers 'coverity t))

(provide 'flycheck-coverity)

;;; flycheck-coverity.el ends here
