(setq openai-api-key "sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")

(defun escape-quotes (start end)
  "Escape all single and double quotes in the selected region."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (while (re-search-forward "[\"']" nil t)
        (replace-match (format "\\%s" (match-string 0)) nil t)))))

(defun gpt-macro-call (api-key prompt data)
  (setq cmd (concat "python3.9 /path-to-project/gpt-emacs-macro/gpt-macro.py \"" api-key "\" \"" prompt "\" \"" data "\""))
  (shell-command-to-string cmd)
)

(defun gpt-macro()
  (interactive)
  (escape-quotes (region-beginning) (region-end))
  (setq selection  (buffer-substring (region-beginning) (region-end)))
  (setq gpt-macro-input (read-string "Command: "))
  (delete-region (region-beginning) (region-end))
  (insert (gpt-macro-call openai-api-key gpt-macro-input selection))
)

(defun gpt-macro-noreplace()
  (interactive)
  (escape-quotes (region-beginning) (region-end))
  (setq selection  (buffer-substring (region-beginning) (region-end)))
  (setq gpt-macro-input (read-string "Command: "))
  (insert (gpt-macro-call openai-api-key gpt-macro-input selection))
)

(global-set-key (kbd "C-c g") 'gpt-macro)
