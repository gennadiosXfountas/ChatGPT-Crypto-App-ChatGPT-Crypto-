//
//  ContentView.swift
//
//  Created by Ingo Boehme on 28.02.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CoinListViewModel()
    
    var body: some View {
        CoinListView(viewModel: viewModel)
            .onAppear {
                viewModel.fetchCoins()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
