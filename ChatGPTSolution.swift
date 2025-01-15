//
//  ChatGPTSolution.swift
//  test
//
//  Created by Ingo Boehme on 28.02.23.
//

import SwiftUI


struct Coin: Codable, Identifiable {
    let id: String
    let name: String
    let symbol: String
    let image: String
    let currentPrice: Double
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, image
        case currentPrice = "current_price"
    }
}

struct CoinListView: View {
    @ObservedObject var viewModel: CoinListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.coins) { coin in
                NavigationLink(destination: CoinDetailView(coin: coin)) {
                    CoinRow(coin: coin)
                }
            }
            .navigationTitle("Coins")
        }
    }
}

struct CoinRow: View {
    let coin: Coin
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: coin.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            } placeholder: {
                Color.gray
                    .frame(width: 50, height: 50)
            }
            VStack(alignment: .leading) {
                Text(coin.name)
                    .font(.headline)
                Text(coin.id)
                    .font(.subheadline)
            }
            Spacer()
            FormattedPrice(amount: coin.currentPrice)
        }
    }
}

struct FormattedPrice: View {
    let amount: Double
    
    var body: some View {
        Text(NumberFormatter.localizedString(from: NSNumber(value: amount), number: .currency))
            .font(.headline)
    }
}


class CoinListViewModel: ObservableObject {
    @Published var coins: [Coin] = []
    
    func fetchCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=1h%2C24h") else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                fatalError("Invalid Data")
            }
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                DispatchQueue.main.async {
                    self.coins = coins
                }
            } catch {
                fatalError("Failed to decode JSON")
            }
        }.resume()
    }
}

extension Double {
    func currencyFormatted() -> String {
        "\(NumberFormatter.localizedString(from: NSNumber(value: self), number: .currency))"
    }
}

struct CoinDetailView: View {
    let coin: Coin
    
    var body: some View {
        VStack {
            Text(coin.name)
                .font(.title)
            AsyncImage(url: URL(string: coin.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } placeholder: {
                Color.gray
                    .frame(width: 1100, height: 100)
            }

            FormattedPrice(amount: coin.currentPrice)
        }
    }
}
