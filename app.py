from flask import Flask, request, jsonify
import numpy as np
from tensorflow.keras.models import load_model
app = Flask(__name__)

# Load your model (adjust path as needed)
model = load_model('my_model2.h5')

@app.route('/predict', methods=['POST'])
def predict():
    if not request.json or 'data' not in request.json:
        return jsonify({'error': 'Missing data'}), 400
    data = request.json['data']
    # Assuming 'data' is a list of values
    data = np.array(data).reshape(1, 24, 1)  # Adjust reshape to match your model's input
    prediction = model.predict(data)
    prediction = prediction.flatten().tolist()
    return jsonify(prediction)

if __name__ == '__main__':
    app.run(debug=True)