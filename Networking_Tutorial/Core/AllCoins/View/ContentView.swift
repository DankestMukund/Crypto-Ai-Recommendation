import SwiftUI

struct ContentView: View {
    @State var animateBorder = false
    
    var viewModel =  CoinsViewModel()
    @State private var showingAIRecommendationSheet: Bool = false
    
    var body: some View {
        ZStack {
            MainView(coins: viewModel.coins)
                
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Button(action: {
                        Task{
                            await viewModel.getAICryptoRecommendation()
                            if !viewModel.aiRecommendation.isEmpty && viewModel.aiError == nil {
                                showingAIRecommendationSheet = true
                            }
                        }
                    }) {
                        ButtonView(animateBorder: $animateBorder)
                    }.disabled(viewModel.isGeneratingAIRecommendation)
                }
            }
            .padding()
        }.sheet(isPresented: $showingAIRecommendationSheet) {
            AIRecommendationSheet(
                recommendation: viewModel.aiRecommendation,
                isLoading: viewModel.isGeneratingAIRecommendation,
                error: viewModel.aiError
            )
        }
    }
}

// --- NEW: AI Recommendation Sheet View ---
// This struct defines the view that will appear as a sheet.
struct AIRecommendationSheet: View {
    var recommendation: String
    var isLoading: Bool
    var error: String?
    @Environment(\.dismiss) var dismiss // Allows you to dismiss the sheet

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("AI Crypto Recommendation:")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 5)

                if isLoading {
                    ProgressView("Generating recommendation...")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else if let errorMessage = error {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(10)
                } else if !recommendation.isEmpty {
                    ScrollView {
                        Text(recommendation)
                            .font(.body)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: .leading) // Ensure text aligns left
                    }
                } else {
                    Text("No recommendation available yet. Tap the button on the main screen to generate one.")
                        .foregroundColor(.secondary)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                }

                Spacer()

                Button("Dismiss") {
                    dismiss() // Close the sheet
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            }
            .padding()
            .navigationTitle("AI Insight")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}

