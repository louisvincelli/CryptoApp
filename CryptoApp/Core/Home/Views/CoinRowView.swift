//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Louis Vincelli on 2/19/26.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingsColumn {
                centerColumn
            }
            Spacer()
            rightColumn
        }
        .font(.subheadline)
    }
}

#Preview {
    Group {
        CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)
            //.previewLayout(.sizeThatFits)
            //.preferredColorScheme(.light)
            //.colorScheme(.light)
        
        CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)
            //.previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .colorScheme(.dark)
    }
    
}
// make one for light and dark
//#Preview("Dark") {
//    CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)
//        .preferredColorScheme(.dark)
//}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            //Circle()
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith6Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundStyle(Color.theme.accent)

    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            //Text("\(coin.currentPrice)")
            Text(coin.currentPrice.asCurrencyWith2Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            //Text("\(coin.priceChangePercentage24H ?? 0.0, specifier: "%.2f")")
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                )
        }
        // since portrait only. but do 3.5 slightly smaller than 1/3
        //.frame(width: UIScreen.main.bounds.width / 3)
        //.frame(maxWidth: .infinity)
        //.layoutPriority(1)
        //.frame(width: .containerRelative(.width, 0.3333))
    }
    
}
