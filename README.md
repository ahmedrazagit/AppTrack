# AppTrack 📱 - Track Your Apps to Keep You on Track

## 📌 Index
1. [Introduction](#introduction)
2. [Features](#features)
3. [Technologies Used](#technologies-used)
4. [Screenshots](#screenshots)
5. [How to Run the Project](#how-to-run-the-project)

---

### Introduction
**AppTrack** is a screen time and productivity management tool built for Android. It helps users monitor and control their app usage, promoting healthier digital habits and increased productivity through screen time tracking, app restrictions, and AI-driven insights.

---

### Features
- **Screen Time Tracking & Analysis**: Real-time usage tracking and visual analysis to give users insights into their app habits.
- **App Lock**: Enables app restrictions with customizable time limits and app lockouts.
- **AI-Powered Chatbot**: Provides personalized recommendations and emotional support for better mental well-being.
- **Customizable Overlays**: Displays overlays with suggestions to help users stay productive when app limits are reached.
- **Predictive Analytics**: AI model to predict usage patterns and send proactive alerts.

---

### Technologies Used
- **Flutter Framework (Dart)**: For building the Android app interface and managing backend services.
- **Hive NoSQL Database**: Local storage for fast data access, holding screen time data and app restrictions.
- **Firebase Firestore**: Used for secure user authentication.
- **Flask API (Python)**: Hosts a machine learning LSTM model for predicting usage trends.
- **TensorFlow & GANs**: TensorFlow powers the predictive model, while GANs generate synthetic datasets for model training.

---

### Screenshots

#### ## Login Screen  
<p float="left">
   <img src="https://github.com/user-attachments/assets/0675943c-0700-4f7d-bd08-7b52c7a48e65" width="200" />
   <img src="https://github.com/user-attachments/assets/d0390351-59a3-4905-93ba-771e11b4fbbc" width="200" />
</p>
User login screens with varying styles.

#### ## App Dashboard and Analysis
<p float="left">
   <img src="https://github.com/user-attachments/assets/f7e135a0-3e60-4739-85ac-be84e04ffbaf" width="200" />
   <img src="https://github.com/user-attachments/assets/529e69c2-73e3-4ffe-b2b8-1c7f9859786c" width="200" />
   <img src="https://github.com/user-attachments/assets/d7125187-c60f-4889-a0ab-4fd485bd36e8" width="200" />
</p>
Screens showing dashboard overview and detailed app usage analytics.

#### ## App Menu and Permissions
<p float="left">
   <img src="https://github.com/user-attachments/assets/cc445377-a0c9-46c9-9ee0-e9ced4fbb8fc" width="200" />
   <img src="https://github.com/user-attachments/assets/0d2e7d52-7663-4d78-8171-64c8b12ba9be" width="200" />
   <img src="https://github.com/user-attachments/assets/57eaf7e6-1265-49c9-9d1f-50ec175dcb57" width="200" />
</p>
App menu for navigating features and permissions setup screens.

#### ## App Lock Settings and Time Limit Exceeded
<p float="left">
   <img src="https://github.com/user-attachments/assets/82bc2262-7efa-42ee-8b55-288d65f4d8f8" width="200" />
   <img src="https://github.com/user-attachments/assets/bf8e801b-9e9b-4362-bda6-691a015f7836" width="200" />
</p>
Settings to set app usage limits and notification when time limit is exceeded.

#### ## App Overlay and Overlay Settings
<p float="left">
   <img src="https://github.com/user-attachments/assets/e0d36830-1876-438a-9bf3-41776309cc1c" width="200" />
   <img src="https://github.com/user-attachments/assets/ec67d708-f54c-4cc9-9aa1-3a10e4ff886c" width="200" />
</p>
Customizable overlays that provide reminders and overlay settings screen.

#### ## Chatbot
<p float="left">
   <img src="https://github.com/user-attachments/assets/1c47d4b0-cb23-4371-8ff0-277d2d73ca0f" width="200" />
</p>
AI-powered chatbot offering personalized support and recommendations.

---

### How to Run the Project
1. **Clone the Repository**  
   ```bash
   git clone https://git.cs.bham.ac.uk/projects-2023-24/axa1874.git

2.  cd into axa1874 if not already there

               cd axa1874

3. Open up a terminal and run the virtual environment
            
            python -m venv venv

            venv\Scripts\activate

3. Install Requirements

            pip install -r requirements.txt

4. Run Flask API

            python app.py

5. Open up a new terminal and download dependencies for Flutter

            flutter pub get

6. Run Flutter on an Android Emulator or device
       

       flutter run

       A full tutorial for setting up an emulator can be found at https://developer.android.com/studio/run/emulator.


7: Login email:ahmedraza1233@gmail.com
   Password:123456
