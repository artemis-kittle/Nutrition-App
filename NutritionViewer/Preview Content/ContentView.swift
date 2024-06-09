//
//  ContentView.swift
//  NutritionViewer
//
//  Created by Aryan Sinha on 08/10/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: FavoriteFood.entity(), sortDescriptors: []) var favoriteFoods: FetchedResults<FavoriteFood>
    @State private var foods = [Food]()
    @State private var query: String = ""
    @State private var showingFavorites = false
    @State private var isRed = false


    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }

    func saveFavoriteFood(_ food: Food) {
        let favorite = FavoriteFood(context: managedObjectContext)
        favorite.name = food.name
        favorite.calories = food.calories
        favorite.carbohydrates_total_g = food.carbohydrates_total_g
        favorite.cholesterol_mg = food.cholesterol_mg
        favorite.fiber_g = food.fiber_g
        favorite.potassium_mg = food.potassium_mg
        favorite.protein_g = food.protein_g
        favorite.fat_saturated_g = food.fat_saturated_g
        favorite.serving_size_g = food.serving_size_g
        favorite.sodium_mg = food.sodium_mg
        favorite.sugar_g = food.sugar_g
        favorite.fat_total_g = food.fat_total_g

        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving favorite food: \(error)")
        }
    }

    func getNutrition() {
        if !query.isEmpty {
            Api().loadData(query: query) { foods in
                self.foods = foods
            }
        }
    }


    var body: some View {
        NavigationView {
        LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                VStack(alignment: .leading) {
                    VStack {
                        TextField(
                            "Enter some food text",
                            text: $query
                        )
                        .multilineTextAlignment(.center)
                        .font(Font.title.weight(.light))
                        .foregroundColor(Color.white)
                        .padding()
                        HStack {
                            Spacer()
                            Button(action: getNutrition) {
                                Text("Get Nutrition")
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 50).stroke(Color.white, lineWidth: 2))
                            }
                            .font(.title2)
                            .foregroundColor(Color.white)
                            Spacer()
                        }
                    }
                    .padding(30.0)
                    List {
                        ForEach(foods) { food in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(food.name)
                                        .font(.title)
                                        .padding(.bottom)
                                        .foregroundColor(.red)
                                        .textCase(.uppercase)

                                    Text("\(food.calories, specifier: "%.0f") calories")
                                        .font(.title2)
                                        .foregroundColor(Color.black)

                                    Button(action: {
                                                saveFavoriteFood(food)
                                            }) {Image(systemName: favoriteFoods.contains(where: { $0.name == food.name }) ? "heart.fill" : "heart")
                                                    .imageScale(.large)
                                                    .foregroundColor(favoriteFoods.contains(where: { $0.name == food.name }) ? .red : .black)
                                                    .foregroundColor(isRed ? .red : .black)
                                                    .frame(width: 32, height: 32)
                                            }
                                }
//                                .minimumScaleFactor(0.01)
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("Serving Size: \(food.serving_size_g, specifier: "%.1f")g")
                                        .foregroundColor(Color.black)
                                    Text("Total Fat: \(food.fat_total_g, specifier: "%.1f")g").foregroundColor(Color.black)
                                    Text("Saturated Fat: \(food.fat_saturated_g, specifier: "%.1f")g").foregroundColor(Color.black)
                                    Text("Protein: \(food.protein_g, specifier: "%.1f")g").foregroundColor(Color.black)
                                    Text("Sodium: \(food.sodium_mg, specifier: "%.1f")mg").foregroundColor(Color.black)
                                    Text("Potassium: \(food.potassium_mg, specifier: "%.1f")mg").foregroundColor(Color.black)
                                    Text("Cholesterol: \(food.cholesterol_mg, specifier: "%.1f")mg").foregroundColor(Color.black)
                                    Text("Carbohydrates: \(food.carbohydrates_total_g, specifier: "%.1f")g").foregroundColor(Color.black)
                                    Text("Fiber: \(food.fiber_g, specifier: "%.1f")g").foregroundColor(Color.black)
                                    Text("Sugar: \(food.sugar_g, specifier: "%.1f")g").foregroundColor(Color.black)
                                }
                                .minimumScaleFactor(0.01)
                                .font(.system(size: 18.0))
                            }
                            .listRowBackground(Color.clear)
                            .foregroundColor(.white)
                        }
                    }
//                    .navigationBarTitle("Nutrition Viewer")
                    .navigationBarItems(
                        trailing: Button(action: {
                            self.showingFavorites.toggle()
                        }) {
                            Image(systemName: "heart.fill")
                                .imageScale(.large)
                                .foregroundColor(.white)
                                .frame(width: 32, height: 32)
                        }
                    )
                }
            )
    }
        .sheet(isPresented: $showingFavorites) {
            FavoriteFoodView()
        }
    }
}

                

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
