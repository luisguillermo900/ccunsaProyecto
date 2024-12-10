//
//  ArtView.swift
//  ccunsaProyecto
//
//  Created by galaxy on 5/12/24.
//

import SwiftUI

struct ArtView: View {
    @State private var selectedTab: Tab = .picture
    enum Tab: String, CaseIterable {
        case picture = "Pinturas"
        case gallery = "Galerias"
        case author = "Autores"
        case category = "Categorias"
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        Button(action: {
                            self.selectedTab = tab
                        }) {
                            Text(tab.rawValue) 
                                .padding()
                                .background(selectedTab == tab ? Color.customBlue : Color.clear)
                                .foregroundColor(selectedTab == tab ? Color.white : Color.black) .cornerRadius(20)
                        }
                    }
                } 
                .padding()
            }
            
            Spacer()
            
            switch selectedTab {
                case .picture: ReceivedView()
                case .gallery: SentView()
                case .author: AccountView()
                case .category: AccountView()
            }
        }
    }
}

struct ReceivedView: View {
    var body: some View {
        PaintingListView()
        //Text("Sent View")
    }
}
struct SentView: View {
    var body: some View {
        DetallePintura(id: "1")
        //Text("Sent View")
    }
}
struct AccountView: View {
    var body: some View {
        Text("Account View")
    }
}
