//
//  ContentView.swift
//  DinosaurInfo
//
//  Created by Akshat Gandhi on 04/11/25.
//

import SwiftUI

struct ContentView: View {
    let predators = Predators()
    
    @State private var searchText: String = ""
    @State private var alphabetical: Bool = false
    @State private var filterType: DinosaurType = .all
    
    var filteredDino: [DinosaurModel] {
        predators.filter(by: filterType)
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDino) { predator in
                NavigationLink {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                } label: {
                    HStack {
                        //  Dinosaur image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        VStack(alignment: .leading) {
                            // Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            // Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.backgroundColor)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Dinosaur Info")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic))
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $filterType) {
                            ForEach(DinosaurType.allCases, id: \.self) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                        .menuStyle(.borderlessButton)
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }

                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
