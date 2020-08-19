(require 'subr-x)

(defun sourcegraph-open ()
  (interactive)
  (start-process-shell-command "sourcegraph-open" "sourcegraph-open"
                               (format "sg open -pos 'L%d:%d' %s" (line-number-at-pos) (current-column) (buffer-file-name)))
  )

(defun sourcegraph-copy ()
  (interactive)
  (start-process-shell-command "sourcegraph-copy" "sourcegraph-copy"
                               (format "sg open -pos 'L%d:%d' -copy %s" (line-number-at-pos) (current-column) (buffer-file-name)))
  (message "Link copied!")
  )

(defun sourcegraph-search (query)
  (interactive "sSearch on Sourcegraph: ")
  (message (buffer-file-name))
  (start-process-shell-command "sourcegraph-search" "sourcegraph-search"
                               (format "sg search %s" query))
  )

(defun -sourcegraph-url-to-path (url)
  (string-trim (shell-command-to-string (format "sg local %s" url))))

(defun -sourcegraph-url-to-pos (url)
  (string-trim (shell-command-to-string (format "sg local -pos %s" url))))

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

;; TODO: factor this out into proper minor mode
(define-key (current-global-map) (kbd "C-c g") 'sourcegraph-open)
(define-key (current-global-map) (kbd "C-c j") 'sourcegraph-search)
(define-key (current-global-map) (kbd "C-c e") 'sourcegraph-edit)
(define-key (current-global-map) (kbd "C-c c") 'sourcegraph-copy)


;; (defvar sourcegraph-mode-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "C-h h") 'sourcegraph-open)
;;     map))
;; (add-to-list 'minor-mode-map-alist `(sourcegraph-mode-map) t)
