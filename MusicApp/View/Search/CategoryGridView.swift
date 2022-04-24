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
            ScrollView {
                Divider().padding(.horizontal)
                
                Text("Browse Categories")
                    .font(.title2).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                LazyVGrid(columns: columns) {
                    ForEach(categories, id: \.self) { category in
                        NavigationLink(destination: SearchDetailView(category: category))
                        {
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                                MediaImageView(image: Image(category.image), size: Size(width: geometry.size.width / 2.29, height: nil))
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
                Spacer(minLength: Metric.playerHeight) 
            }
        }
    }
}

struct CategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGridView()
    }
}
