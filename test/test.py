import py_test
import requests



def sanity_test():
    try:
        res = requests.get('localhost:80/countries')
    except Exception:
        print('something went wrong')
    assert res.status_code == 200

