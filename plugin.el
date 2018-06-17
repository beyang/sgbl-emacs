(defun sourcegraph-search ()
  (interactive)
  (message (buffer-file-name))
  (start-process-shell-command "sgopen" "sgopen"
                               (format "sg %s" (buffer-file-name)))
  )
