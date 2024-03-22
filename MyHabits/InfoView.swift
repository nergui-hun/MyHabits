//
//  InfoView.swift
//  MyHabits
//
//  Created by M M on 3/13/24.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ScrollView(.vertical) {
            HStack {
                Text(StringsRU.infoHeaderRU.rawValue)
                    .font(.custom("SFProText-Semibold", size: 17))
                    .padding(.vertical)
                Spacer()
            }
            Text(StringsRU.infoTextRU.rawValue)
        }
        .scenePadding(.horizontal)
        .scrollIndicators(.hidden)
    }
}


#Preview {
    InfoView()
}
