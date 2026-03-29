//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Louis Vincelli on 3/29/26.
//

import SwiftUI

struct SearchBarView: View {
    
    //could call enviornment object and pull viewmodel but then it would only be available in environment obj available features. so make it binding
    
    //@State var searchText: String = ""
    @Binding var searchText: String
    // now we can add to any view that has a string that we can bind to.
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                    // padding so tapping area is bigger and users easier to tap, tapable area bigger
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 10, x:0, y:0
                       )
        )
        .padding()
    }
}

#Preview {
    Group {
        SearchBarView(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
        
        SearchBarView(searchText: .constant(""))
            .preferredColorScheme(.dark)
    }
    //SearchBarView()
}
