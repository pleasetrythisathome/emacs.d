;;; latest-clojure-libraries-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "latest-clojure-libraries" "latest-clojure-libraries.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from latest-clojure-libraries.el

(autoload 'latest-clojure-libraries-insert-dependency "latest-clojure-libraries" "\
Insert dependency for PACKAGE and optionally INJECT it into nrepl classpath.

\(fn PACKAGE INJECT)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "latest-clojure-libraries" '("lcl/")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; latest-clojure-libraries-autoloads.el ends here
