from flask import Flask, request, jsonify

app = Flask(__name__)

# In-memory storage for countries
countries = [
        {"name": "United States", "capital": "Washington, D.C.", "population": 331002651},
        {"name": "Canada", "capital": "Ottawa", "population": 37742154},
        {"name": "United Kingdom", "capital": "London", "population": 67886011},
        {"name": "Australia", "capital": "Canberra", "population": 25499884},
        {"name": "India", "capital": "New Delhi", "population": 1380004385}
    ]

@app.route('/countries', methods=['GET'])
def get_countries():
    return jsonify(countries)

@app.route('/countries', methods=['POST'])
def add_country():
    data = request.get_json()
    countries.append(data)
    return jsonify({"message": "Country added successfully"})

@app.route('/countries/<int:index>', methods=['PUT'])
def update_country(index):
    if index >= 0 and index < len(countries):
        data = request.get_json()
        countries[index] = data
        return jsonify({"message": "Country updated successfully"})
    else:
        return jsonify({"message": "Invalid index"})

@app.route('/countries/<int:index>', methods=['DELETE'])
def delete_country(index):
    if index >= 0 and index < len(countries):
        del countries[index]
        return jsonify({"message": "Country deleted successfully"})
    else:
        return jsonify({"message": "Invalid index"})

if __name__ == '__main__':
    app.run(host='0.0.0.0',debug=True)
