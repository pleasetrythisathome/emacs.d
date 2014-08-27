;; User pack init file
;;
;; Use this file to initiate the pack configuration.
;; See README for more information.

(add-to-list 'custom-theme-load-path "~/.live-packs/pleasetrythisathome-pack/lib/themes/")
(live-load-config-file "packages.el")
(live-load-config-file "general.el")
(live-load-config-file "prodigy.el")
(live-load-config-file "clojure.el")
(live-load-config-file "web.el")
(live-load-config-file "bindings.el")
