(require 'json)

(setq openai-api-key "sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxx") ;; YOUR API KEY GOES HERE

;;;;;;;;;;;

(defvar openai-request-command
  "curl -s -X POST -H \"Content-Type: application/json\" -d '{
  \"model\": \"text-davinci-002\",
  \"prompt\": \"%s:\\n\\n%s\",
  \"temperature\": 0.7,
  \"max_tokens\": 256,
  \"top_p\": 1,
  \"frequency_penalty\": 0,
  \"presence_penalty\": 0
}' \"https://api.openai.com/v1/completions\" -H \"Authorization: Bearer %s\" ")


(defun gpt-macro-call (api-key prompt data)
  (let* ((response (shell-command-to-string (format openai-request-command prompt data openai-api-key))))
	(string-trim (cdr (assoc 'text (elt (cdr (assoc 'choices (json-read-from-string response))) 0))))))

(defun gpt-macro (&optional arg)
  "Call GPT3 with selected text and a user-input command.
If called with prefix argument, don't replace original selection."

  (interactive "P")
  (let* ((selection (buffer-substring-no-properties (region-beginning) (region-end)))
		 (selection-stripped (replace-regexp-in-string "\n" "\\\\n" selection)) 
		 (gpt-macro-input (read-string "Command: "))
		 (gpt-return (gpt-macro-call openai-api-key gpt-macro-input selection-stripped)))
	(if (not (equal '(4) arg)) ;; unless called with prefix argument delete original text
		(delete-region (region-beginning) (region-end))
	  (insert "\n")) ;; if keeping original text, add a newline before GPT output
	(insert gpt-return)))

(global-set-key (kbd "C-c g") 'gpt-macro)
