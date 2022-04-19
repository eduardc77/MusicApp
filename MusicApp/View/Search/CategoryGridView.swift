//
//  CategoryGridView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 19.04.2022.
//

import SwiftUI

struct CategoryGridView: View {
    @State var categories = searchCategories
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView() {
                Divider().padding(.horizontal)
                
                    Text("Browse Categories")
                        .font(.title2).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    LazyVGrid(columns: columns) {
                        ForEach(categories, id: \.self) { category in
                            NavigationLink(destination:
                                            SearchDetailView(category: category)
                                .navigationBarTitleDisplayMode(.inline)
                            )
                            {
                                ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                                Image(category.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width / 2.29)
                                    .cornerRadius(6)
//
//                                        Text(category.title)
//                                            .padding()
//                                            .foregroundColor(.white)
//                                            .font(.body.bold())
                                }
                            }
                        }
                    }
                .padding(.horizontal)
            }
    }
    }
}

struct CategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGridView()
    }
}
