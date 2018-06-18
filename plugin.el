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
