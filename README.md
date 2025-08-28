# Crypto AI Recommendation 🪙🤖

<p align="center">
  <img src="https://img.shields.io/badge/Architecture-MVVM-purple.svg" alt="Architecture: MVVM">
  <img src="https://img.shields.io/badge/Swift-5.9-orange.svg" alt="Swift: 5.9">
  <img src="https://img.shields.io/badge/Concurrency-Async/Await-blue.svg" alt="Concurrency: Async/Await">
  <img src="https://img.shields.io/badge/License-GPLv3-green.svg" alt="License: GPLv3">
</p>

## Project Overview

**Crypto AI Recommendation** is a native iOS application designed to showcase a modern, full-stack approach to mobile development. The app fetches and displays real-time cryptocurrency data from the **CoinGecko API** and integrates with **Google's Gemini Pro LLM** to provide users with AI-generated observational insights. This project serves as a strong example of implementing a clean architecture, handling asynchronous operations, and integrating with multiple third-party services in a SwiftUI environment.

---

## 🌟 Core Features & Functionality

* **Real-time Data Display**: On launch, the app asynchronously fetches and displays a list of the top 250 cryptocurrencies, including their names, symbols, logos, and current prices in INR.
* **AI-Powered Analysis**: A prominent "Ask AI" button allows users to request an analysis of the current market data.
* **Dynamic Prompt Engineering**: The app dynamically constructs a detailed prompt for the Gemini LLM, feeding it the most recent crypto data to ensure relevant and timely insights.
* **Modal Presentation**: The AI's recommendation is presented cleanly in a modal sheet, ensuring a non-disruptive user experience.
* **Loading & Error States**: The UI provides clear feedback to the user, displaying loading indicators during network calls and handling potential errors gracefully.



---

## 🏗️ Technical Highlights & Architecture

This application was built with a focus on modern development practices and a scalable architecture.

### **Model-View-ViewModel (MVVM) Architecture**
The project strictly adheres to the MVVM design pattern to ensure a clean separation of concerns:
* **Model**: The `CoinList` struct serves as the data model, perfectly matching the JSON response from the CoinGecko API.
* **View**: The UI is composed of declarative SwiftUI views (`ContentView`, `MainView`, `AIRecommendationSheet`), which are responsible only for presenting data and capturing user input.
* **ViewModel**: The `CoinsViewModel` acts as the intermediary. It contains all business logic, manages the application's state via `@Observable`, and exposes data to the View, never allowing the View to directly modify the model.

### **Modern Concurrency with Async/Await**
All network operations are handled using Swift's modern `async/await` syntax.
* The `CoinDataService` fetches data from the API asynchronously, preventing the UI from freezing.
* The call to the Google Gemini AI in the `CoinsViewModel` is also an `async` function, ensuring the app remains responsive while waiting for the LLM to process the request.

### **Robust API Integration**
The app demonstrates proficiency in integrating with two distinct, high-volume, third-party REST APIs:
1.  **CoinGecko API**: For fetching a large dataset of financial information.
2.  **Google Gemini API**: For sending complex, dynamically generated prompts and parsing the natural language response.

---

## 🛠️ Technologies & Dependencies

* **UI Framework**: SwiftUI
* **Language**: Swift 5.9
* **State Management**: SwiftUI's Observation framework (`@Observable`)
* **Dependencies**:
    * **GoogleGenerativeAI**: Swift package for interfacing with the Gemini LLM.

---

## 🚀 Setup & Installation

1.  **Clone the repository:**
    ```sh
    git clone [https://github.com/DankestMukund/Crypto-Ai-Recommendation.git](https://github.com/DankestMukund/Crypto-Ai-Recommendation.git)
    ```
2.  **Add Swift Package Dependency:**
    * In Xcode, go to `File` > `Add Packages...` and add the `GoogleGenerativeAI` package using its repository URL.
3.  **Configure API Key:**
    * Create a new Swift file (`APIKey.swift`) and populate it with your Google AI Studio API key. The `CoinsViewModel` is pre-configured to access this key.
4.  **Build & Run** the project in Xcode.

---

## 📜 License

This project is licensed under the GPLv3. See the `LICENSE` file for details.
