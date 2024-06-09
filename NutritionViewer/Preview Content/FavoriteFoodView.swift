//
//  FavoriteFoodView.swift
//  NutritionViewer
//
//  Created by Aryan Sinha on 08/10/23.
//
import SwiftUI
import CoreData

struct FavoriteFoodView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: FavoriteFood.entity(), sortDescriptors: []) var favoriteFoods: FetchedResults<FavoriteFood>

    var body: some View {
        NavigationView {
            List {
                ForEach(favoriteFoods, id: \.id) { favoriteFood in
                    HStack {
                        VStack(alignment: .leading) {
                            if let name = favoriteFood.name {
                                Text(name)
                                    .font(.title)
                                    .padding(.bottom)
                                    .foregroundColor(.red)
                                    .textCase(.uppercase)
                            } else {
                                Text("Unknown Food")
                                    .font(.title)
                                    .padding(.bottom)
                                    .foregroundColor(.red)
                                    .textCase(.uppercase)
                            }

                            Text("\(favoriteFood.calories, specifier: "%.0f") calories")
                                .font(.title2)
                                .foregroundColor(.black)

                            // Include other details in a similar manner...
                            Text("Serving Size: \(favoriteFood.serving_size_g, specifier: "%.1f")g")
                                .foregroundColor(Color.black)
                            Text("Total Fat: \(favoriteFood.fat_total_g, specifier: "%.1f")g")
                                .foregroundColor(Color.black)
                            Text("Saturated Fat: \(favoriteFood.fat_saturated_g, specifier: "%.1f")g")
                                .foregroundColor(Color.black)
                            Text("Protein: \(favoriteFood.protein_g, specifier: "%.1f")g")
                                .foregroundColor(Color.black)
                            Text("Sodium: \(favoriteFood.sodium_mg, specifier: "%.1f")mg")
                                .foregroundColor(Color.black)
                            Text("Potassium: \(favoriteFood.potassium_mg, specifier: "%.1f")mg")
                                .foregroundColor(Color.black)
                            Text("Cholesterol: \(favoriteFood.cholesterol_mg, specifier: "%.1f")mg")
                                .foregroundColor(Color.black)
                            Text("Carbohydrates: \(favoriteFood.carbohydrates_total_g, specifier: "%.1f")g")
                                .foregroundColor(Color.black)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Favorite Foods")
        }
    }
}
