# Import necessary libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.preprocessing import MinMaxScaler
from sklearn.model_selection import train_test_split
import tensorflow as tf
from keras.models import Sequential
from keras.layers import Dense, LSTM, Dropout
from keras.callbacks import EarlyStopping
from keras.metrics import MeanAbsoluteError
from keras.initializers import Orthogonal



# Load and preprocess the dataset
df = pd.read_csv('/content/variable_app_hourly_usage.csv')
df['DateTime'] = pd.to_datetime(df['DateTime'])
df.sort_values('DateTime', inplace=True)

scaler = MinMaxScaler(feature_range=(0, 1))
df['Usage (Hours)'] = scaler.fit_transform(df[['Usage (Hours)']])

def create_dataset(dataset, look_back=24):
    X, Y = [], []
    for i in range(len(dataset) - look_back):
        a = dataset[i:(i + look_back), 0]
        X.append(a)
        Y.append(dataset[i + look_back, 0])
    return np.array(X), np.array(Y)

data = df['Usage (Hours)'].values.reshape(-1, 1)
X, Y = create_dataset(data, 24)
X = np.reshape(X, (X.shape[0], 24, 1))
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.2, random_state=42)

# Define and compile the LSTM model
model = Sequential([
    LSTM(100, return_sequences=True, input_shape=(24, 1)),
    Dropout(0.2),
    LSTM(100, return_sequences=True),
    Dropout(0.2),
    LSTM(50),
    Dense(1)
])
model.compile(optimizer='adam', loss='mean_squared_error', metrics=[MeanAbsoluteError()])

# Train the model
history = model.fit(X_train, Y_train, epochs=100, batch_size=32, verbose=2, validation_data=(X_test, Y_test), callbacks=[EarlyStopping(monitor='val_loss', patience=10)])

# Plot training and validation loss and MAE
fig, axs = plt.subplots(2, 1, figsize=(10, 10))
axs[0].plot(history.history['loss'], label='Training Loss')
axs[0].plot(history.history['val_loss'], label='Validation Loss')
axs[0].set_title('Model Loss')
axs[0].set_ylabel('Loss')
axs[0].set_xlabel('Epoch')
axs[0].legend()
axs[1].plot(history.history['mean_absolute_error'], label='Training MAE')
axs[1].plot(history.history['val_mean_absolute_error'], label='Validation MAE')
axs[1].set_title('Model MAE')
axs[1].set_ylabel('MAE')
axs[1].set_xlabel('Epoch')
axs[1].legend()
plt.tight_layout()
plt.show()

# Predict the next day's usage for each hour
predictions = []
input_seq = data[-24:].reshape(1, 24, 1)  # Starting with the last day available in the dataset

for _ in range(24):  # Predict the next 24 hours
    predicted_hour = model.predict(input_seq)
    predictions.append(predicted_hour.flatten()[0])
    
    # Update the input sequence to include the new prediction and drop the first hour
    input_seq = np.append(input_seq.flatten()[1:], predicted_hour).reshape(1, 24, 1)

# Inverse transform the predictions to get actual values
predictions = np.array(predictions).reshape(-1, 1)
predictions = scaler.inverse_transform(predictions)

# Append the predicted usage to the last day's data for visualization
last_day_actual = scaler.inverse_transform(data[-24:])
combined_data = np.concatenate((last_day_actual, predictions))

# Plotting the actual last day and the predicted next day usage
plt.figure(figsize=(15, 6))
hours = range(1, 49)  # 24 hours for last day + 24 hours for predicted day
plt.plot(hours[:24], last_day_actual, label='Actual Usage on Last Day', marker='o')
plt.plot(hours[24:], predictions, label='Predicted Usage for Next Day', marker='x', linestyle='--', color='red')
plt.title('Actual and Predicted Usage: Last Day and Next Day')
plt.xlabel('Hour of the Day')
plt.ylabel('Usage (Hours)')
plt.xticks(ticks=hours, labels=[f"{hr%24}:00" for hr in hours], rotation=45)
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()



