# gpt-macro
Connect GPT-3 to Emacs and run "semantic" kbd macros

# About
![Demo](./assets/emacs-gpt-macro-2.gif)

[![About](https://raw.githubusercontent.com/samrawal/gpt-macro/main/assets/tweet.png)](https://twitter.com/samarthrawal/status/1591527892386734081)

![Blog post with more details](https://samrawal.substack.com/p/semantic-macros-with-emacs-gpt)

# Usage
This was a super quick implementation and currently uses the OpenAI Python package and interfaces with a Python script.
To use, add your OpenAI API key and set the Python script path in `gpt-macro.el` 

# *TODO:*
- Rewrite to elisp-only via curl to interface with API. (Was experiencing a bug with passing in single quotes via curl)
