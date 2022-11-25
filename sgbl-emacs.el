(define-minor-mode sourcegraph-mode
  "This is the doc"
  nil
  " Sourcegraph"
  :keymap nil

  (defun sourcegraph-open ()
    (interactive)
    (start-process-shell-command "sourcegraph-open" "sourcegraph-open"
                                 (format "sgbl open -rev -pos 'L%d:%d' %s" (line-number-at-pos) (current-column) (buffer-file-name)))
    )

  (defun sourcegraph-copy ()
    (interactive)
    (start-process-shell-command "sourcegraph-copy" "sourcegraph-copy"
                                 (format "sgbl open -rev -pos 'L%d:%d' -copy %s" (line-number-at-pos) (current-column) (buffer-file-name)))
    (message "Link copied!")
    )

  (defun sourcegraph-search (query)
    (interactive "sSearch on Sourcegraph: ")
    (message (buffer-file-name))
    (start-process-shell-command "sourcegraph-search" "sourcegraph-search"
                                 (format "sgbl search %s" query))
    )

  (defun -sourcegraph-url-to-path (url)
    (string-trim (shell-command-to-string (format "sgbl local %s" url))))

  (defun -sourcegraph-url-to-pos (url)
    (string-trim (shell-command-to-string (format "sgbl local -pos %s" url))))

  (defun sourcegraph-edit (url)
    (interactive "sSourcegraph URL: ")
    (let ((file (-sourcegraph-url-to-path url)))
      (find-file file))
    (let ((pos (-sourcegraph-url-to-pos url)))
      (let ((line (string-to-number (nth 0 (split-string pos ":"))))
            (col (string-to-number (nth 1 (split-string pos ":")))))
        (goto-line line)
        (move-to-column col)
        )
      )
    )

  (global-set-key (kbd "C-c g") 'sourcegraph-open)
  (global-set-key (kbd "C-c j") 'sourcegraph-search)
  (global-set-key (kbd "C-c e") 'sourcegraph-edit)
  (global-set-key (kbd "C-c c") 'sourcegraph-copy))
