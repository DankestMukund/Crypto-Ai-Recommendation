import Foundation
import GoogleGenerativeAI


@Observable class CoinsViewModel {
    
    var coin = ""
    var price = ""
    // AI shit
    var aiRecommendation: String = ""
    var isGeneratingAIRecommendation: Bool = false
    var aiError: String?
    
    private var service = CoinDataService()
    
    var MockData = CoinList.mockData
    
    var coins: [CoinList] = []
    
    // AI
    private let geminiModel = GenerativeModel(
        name: "gemini-1.5-flash",
        apiKey: APIKey.default
        )
    
    init() {
//        fetchPrice(coin: "litecoin")
        fetchCoins()
    }
    
    
    
    
    func fetchCoins()
    {
        Task{
            self.coins = try await service.fetchCoins()
        }
    }
    
    // --- NEW: Function to get AI-powered crypto recommendations ---
        func getAICryptoRecommendation() async {
            // Set loading state and clear previous recommendation/errors
            isGeneratingAIRecommendation = true
            aiError = nil
            aiRecommendation = "" // Clear previous recommendation

            do {
                // Ensure we have coin data to provide to the AI
                guard !coins.isEmpty else {
                    aiError = "No coin data available for recommendation. Please refresh the list or wait for it to load."
                    isGeneratingAIRecommendation = false
                    return
                }

                // Format a subset of your fetched coin data into a string for Gemini
                // Taking top 10 to keep the prompt concise and within free tier limits
                let relevantCoins = coins.prefix(190)
                var cryptoDataString = "Here's some recent cryptocurrency market data from CoinGecko:\n\n"
                for coin in relevantCoins {
                    cryptoDataString += "Coin: \(coin.name) (\(coin.symbol.uppercased()))\n"
                    cryptoDataString += "  Current Price: ₹\(String(format: "%.2f", coin.current_price ?? 0.0)) (if available)\n\n"
                }

                // Construct the detailed prompt for Gemini
                let recommendationPrompt = """
                **IMPORTANT DISCLAIMER:** I am an AI and cannot provide financial advice. Cryptocurrency markets are highly volatile and speculative. Any recommendation provided is for entertainment/informational purposes only and should not be taken as professional financial advice. Always do your own research (DYOR) before making any investment decisions.

                Based on the following recent cryptocurrency market data, which of these cryptocurrencies looks potentially interesting from a purely observational, high-level perspective? Focus on coins with good market capitalization, recent positive price movement, or general popularity. Please explain your reasoning briefly for 1-2 coins. If none are particularly interesting, mention that. Keep it concise.

                \(cryptoDataString)

                Please only provide a few sentences as a recommendation, followed by your reasoning. Do not suggest other coins not in this list.
                """

                // Send the prompt to Gemini
                let response = try await geminiModel.generateContent(recommendationPrompt)

                // Update the UI with Gemini's response on the main thread
                DispatchQueue.main.async {
                    if let geminiText = response.text {
                        self.aiRecommendation = geminiText
                    } else {
                        self.aiRecommendation = "Gemini couldn't generate a text recommendation at this time."
                    }
                }

            } catch {
                // Handle any errors during API calls (CoinGecko or Gemini)
                print("Error getting AI crypto recommendation: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.aiError = "Failed to get AI recommendation: \(error.localizedDescription)"
                    self.aiRecommendation = "Error generating recommendation." // Fallback text for UI
                }
            }
            // Always stop loading, regardless of success or failure
            DispatchQueue.main.async {
                self.isGeneratingAIRecommendation = false
            }
        }
    
    
}
