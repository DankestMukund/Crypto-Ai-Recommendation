//
//  CoinDataService.swift
//  Networking_Tutorial
//
//  Created by Mukund Madhav on 03/08/25.
//

import Foundation


struct CoinList: Codable , Identifiable {
    let name: String
    let symbol: String
    let id: String
    let image: String
    let current_price: Double?

    static let mockData: [CoinList] = [
        CoinList(
            name: "Aave Polygon AAVE",
            symbol: "amaave",
            id: "aave-polygon-aave",
            image: "https://coin-images.coingecko.com/coins/images/17239/large/amAAVE_2x.png?1696516796",
            current_price: 22239.04
        ) , CoinList(
            name: "ALTAVA",
            symbol: "tava",
            id: "altava",
            image: "https://coin-images.coingecko.com/coins/images/26299/large/altava.jpeg?1696525382",
            current_price: 0.85
        ) , CoinList(
            name: "Advanced United Continent",
            symbol: "auc",
            id: "advanced-united-continent",
            image: "https://coin-images.coingecko.com/coins/images/24369/large/200x200.png?1696523553",
            current_price: 0.03
        )
    ]
}


class CoinDataService {
    
    
//    func fetchCoins(completion: @escaping (Result<[CoinList], Error>) -> Void) {
//        
//        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=250&page=1&precision=2"
//
//        guard let url = URL(string: urlString) else {
//            print("❌ Invalid URL")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            
//            if let error = error {
//                print("❌ Network error: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let data = data else {
//                print("❌ No data returned")
//                return
//            }
//            
//            do {
//                let coins = try JSONDecoder().decode([CoinList].self, from: data)
//                
//                DispatchQueue.main.async {
//                    completion(.success(coins))
//                }
//            } catch {
//                print("❌ Decoding error: \(error)")
//            }
//        }.resume()
//    }
    
    func fetchCoins() async throws -> [CoinList]
    {
        
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=250&page=1&precision=2"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        let coins = try JSONDecoder().decode([CoinList].self, from: data)
        return coins
       
    }
    
    struct PriceResponse: Codable {
        let inr: Double
    }
   
    
//    func fetchPrice(coin: String, completion: @escaping (Result<PriceResponse, Error>) -> Void) {
//        
//        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=inr"
//        
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//           
//            if let error = error {
//                print("DEBUG: Failed with error \(error.localizedDescription) ")
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                print("No HTTP response")
//                return
//            }
//            
//            
//            guard let data = data else {
//                print("No data")
//                return
//            }
//            
//            do {
//                
//                let fullResponse = try JSONDecoder().decode([String: PriceResponse].self, from: data)
//                
//                if let coinData = fullResponse[coin] {
//                    DispatchQueue.main.async {
//                      
//                        
//                        //self.coin = coin.capitalized
//                        //self.price = "₹\(coinData.inr)"
//                        
////                        print("Price in service: \(coinData)")
//                        completion(.success(coinData))
//                    }
//                } else {
//                    print("Coin not found in response")
//                }
//            } catch {
//                print("Failed to decode: \(error)")
//            }
//        }.resume()
//    }
}


    
   
