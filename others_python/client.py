import requests

user_info = {'sender':'a', 'recipient':'b', 'amount':'abcd'}
r = requests.post("http://localhost:53264/transactions/new", json=user_info)

print (r.text)