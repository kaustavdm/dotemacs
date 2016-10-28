;;; env-custom --- Custom environment variables for this Emacs configuration

;;; Commentary:
; Put custom environment variables here.

;;; Code:

;; ----- Edit below ------


(setq user-mail-address "youremail@address.com")  ;; default: user@host

(setenv "GOPATH" "/Users/kaustavd/src/go-workspace")
(setenv "GOROOT" "/usr/local/go")

;; ---- Do not edit below ----

(provide 'env-custom)

;;; env-custom.el ends here
