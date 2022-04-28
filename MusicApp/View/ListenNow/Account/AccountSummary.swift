//
//  AccountSummary.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 28.04.2022.
//

import SwiftUI

struct AccountSummary: View {
//    @EnvironmentObject var modelData: ModelData
    var account: Account

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(account.username)
                    .bold()
                    .font(.title)

                Text("Notifications: \(account.prefersNotifications ? "On": "Off" )")
                Text("Seasonal Photos: \(account.seasonalPhoto.rawValue)")
                Text("Goal Date: ") + Text(account.goalDate, style: .date)

                Divider()

                VStack(alignment: .leading) {
                    Text("Completed Badges")
                        .font(.headline)

                    ScrollView(.horizontal) {
                        HStack {
                            Text("First Hike")
                            Text("Earth Day")
                                .hueRotation(Angle(degrees: 90))
                            Text("Tenth Hike")
                                .grayscale(0.5)
                                .hueRotation(Angle(degrees: 45))
                        }
                        .padding(.bottom)
                    }
                }

                Divider()

                VStack(alignment: .leading) {
                    Text("Recent Hikes")
                        .font(.headline)

                    
                }
            }
            .padding()
        }
    }
}

struct AccountSummary_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummary(account: Account())
    }
}
