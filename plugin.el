(defun sourcegraph-open ()
  (interactive)
  (message (buffer-file-name))
  (start-process-shell-command "sourcegraph-open" "sourcegraph-open"
                               (format "sg open %s" (buffer-file-name)))
  )

(defun sourcegraph-search (query)
  (interactive "squery: ")
  (message (buffer-file-name))
  (start-process-shell-command "sourcegraph-search" "sourcegraph-search"
                               (format "sg search %s" query))
  )

;; TODO: factor this out into proper minor mode
(define-key (current-global-map) (kbd "C-c g") 'sourcegraph-open)
(define-key (current-global-map) (kbd "C-c j") 'sourcegraph-search)


;; (defvar sourcegraph-mode-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "C-h h") 'sourcegraph-open)
;;     map))
;; (add-to-list 'minor-mode-map-alist `(sourcegraph-mode-map) t)
