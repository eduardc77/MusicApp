//
//  RadioView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct RadioView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                Divider()
                HighlightsView(items: selectedStations, imageSize: .large)

                Text("Radio")
                    .font(.title2).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                VerticalMediaGridView(mediaItems: [Media()], imageSize: .small)
                Spacer(minLength: Metric.playerHeight)
            }
            .navigationTitle("Radio")
        }
    }
}

struct RadioView_Previews: PreviewProvider {
    static var previews: some View {
        RadioView()
    }
}
