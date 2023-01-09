//
//  NavigationLinkList.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 05.05.2022.
//

import SwiftUI

protocol Nameable { var title: String { get } }

struct NavigationLinkList<Content: View, Enum: RawRepresentable & CaseIterable & Hashable & Nameable> : View where Enum.AllCases: RandomAccessCollection, Enum.RawValue == Int {
  var rowItems: Enum.Type
  var content: [Content]
  var title: String = ""
  
  var body: some View {
      VStack(spacing: 0) {
        Divider()
          .padding(.leading)
        
        List {
          ForEach(rowItems.allCases, id: \.self) { enumCase in
            NavigationLink {
              content[enumCase.rawValue]
            } label: {
              Text(String(describing: enumCase.title))
                .font(.title3)
                .foregroundColor(.accentColor)
            }
          }
        }
        .listStyle(.plain)
        .scrollingDisabled(true)
      }

    .frame(idealHeight: CGFloat(50 * rowItems.allCases.count), maxHeight: .infinity)
	 .labeledViewModifier(header: !title.isEmpty ? title : nil)
	 .padding(.top)
  }
}


// MARK: - Previews

struct NavigationLinkList_Previews: PreviewProvider {
	struct NavigationLinkListExample: View {

		var detailViews: [CategoryDetailView] {
			var detailsViews = [CategoryDetailView]()

			for browseSection in BrowseMoreToExplore.allCases {
				detailsViews.append(CategoryDetailView(category: SearchCategoryModel(image: "category\(browseSection.rawValue)", title: browseSection.title, tag: browseSection.rawValue)))
			}

			return detailsViews
		}

		var body: some View {
			NavigationLinkList(rowItems: BrowseMoreToExplore.self, content: detailViews, title: "More to Explore")
				.padding()
		}
	}

	static var previews: some View {
		NavigationLinkListExample()
	}
}
