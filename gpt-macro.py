import os
import sys
import openai

openai.api_key = sys.argv[1]
gpt_macro_input = sys.argv[2]
data = sys.argv[3]

def complete(input_, data_, model="davinci"):
    prompt = "{}:\n\n{}".format(input_, data_)
    if model == "davinci":
        response = openai.Completion.create(
            model="text-davinci-003",
            prompt=prompt,
            temperature=0.7,
            max_tokens=256,
            top_p=1,
            frequency_penalty=0,
            presence_penalty=0
        )
        return response['choices'][0]['text']
    elif model == "chat":
        completion = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "user", "content": prompt}
            ],
            temperature=1.0, # default
            max_tokens=256,
            top_p=1,
        )
        return completion.choices[0]["message"]["content"]


payload = complete(gpt_macro_input, data, model="davinci").strip()
print(payload)
