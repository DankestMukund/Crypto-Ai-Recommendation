//
//  MainView.swift
//  Networking_Tutorial
//
//  Created by Mukund Madhav on 04/08/25.
//
import SwiftUI

struct MainView: View {
  
     var coins: [CoinList]
    
   //
    var body: some View {
        NavigationView {
                        List(coins) { coin in
                            HStack(alignment: .center, spacing: 20) {
                                imageForCoin(imageURL: coin.image)
                                
                                VStack(alignment: .leading) {
                                    Text(coin.name)
                                        .font(.title3)
                                        .bold(true)
                                    
                                    HStack {
                                        Text("#\(coin.symbol)")
                                            .font(.caption)
                                            .tint(.secondary)
                                        
                                        if let price = coin.current_price {
                                            Text("₹ \(String(format: "%.2f", price))")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .background(.green)
                                        }
                                    }
                                }
                                
                            }
                            
                        }.padding()
                .navigationTitle("Coins")
//                .refreshable {
//                    Task {
//                        await viewMode
//                    }
//                }
                
                    }
                        .listStyle(PlainListStyle())
                        
                

    }
}


struct imageForCoin : View {
    
    //var viewModel = CoinsViewModel()
    @State var imageURL : String
    
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { Image in
            Image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
        } placeholder: {
            ProgressView()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
        }

    }
}

#Preview {
    MainView(coins: CoinList.mockData )
}
