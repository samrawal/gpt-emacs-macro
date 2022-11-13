(setq openai-api-key "sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")

(defun gpt-macro-call (api-key prompt data)
  (setq cmd (concat "python3.9 /path-to-project/gpt-emacs-macro/gpt-macro.py \"" api-key "\" \"" prompt "\" \"" data "\""))
  (shell-command-to-string cmd)
)

(defun gpt-macro()
  (interactive)
  (setq selection  (buffer-substring (region-beginning) (region-end)))
  (setq gpt-macro-input (read-string "Command: "))
  (delete-region (region-beginning) (region-end))
  (insert (gpt-macro-call openai-api-key gpt-macro-input selection))
)

(defun gpt-macro-noreplace()
  (interactive)
  (setq selection  (buffer-substring (region-beginning) (region-end)))
  (setq gpt-macro-input (read-string "Command: "))
  (insert (gpt-macro-call openai-api-key gpt-macro-input selection))
)

(global-set-key (kbd "C-c g") 'gpt-macro)
