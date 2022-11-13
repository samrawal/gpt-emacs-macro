import os
import sys
import openai

openai.api_key = sys.argv[1]
gpt_macro_input = sys.argv[2]
data = sys.argv[3]

response = openai.Completion.create(
  model="text-davinci-002",
  prompt="{}:\n\n{}".format(gpt_macro_input, data),
  temperature=0.7,
  max_tokens=256,
  top_p=1,
  frequency_penalty=0,
  presence_penalty=0
)

payload = response['choices'][0]['text'].strip()
print(payload)
