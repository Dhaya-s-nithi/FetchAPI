//
//  ContentView.swift
//  Newbie
//
//  Created by Dhayanithi on 28/12/22.
//

import SwiftUI


struct Info: Codable{
    var id:Int
    var name:String
    var genus:String
    var family:String
    var order:String
    let nutritions: Nutritions
    }

    // MARK: - Nutritions
    struct Nutritions: Codable {
        let carbohydrates, protein, fat: Double
        let calories: Int
        let sugar: Double
    
    
}
struct ContentView: View {
    
    @State private var results = [Info]()
    var body: some View {
        NavigationView {
            List(results, id: \.id) { info in
                VStack(alignment: .leading){
                    HStack{
                        Text("Name: \(info.name)")
                            .foregroundColor(.mint)
                        Spacer()
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Nutritions:")
                            Text("Sugar: \(info.nutritions.sugar)")
                            Text("Calories: \(info.nutritions.calories)")
                            Text("Protien: \(info.nutritions.protein)")
                        }
                    }
                    Text(info.family)
                    Text(info.order)
                    
                }
            
                
            }
            
            .listStyle(GroupedListStyle())
            
            .task {
                await getResponse()
            }
        
            .navigationTitle("Fruits")

        }
            }
    
    
    func getResponse() async{
        guard let url = URL(string: "https://www.fruityvice.com/api/fruit/all")
        else{
            print("URL does not exists...")
            return
            
        }
        
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decoding Data
            
            if let decode = try? JSONDecoder().decode([Info].self, from: data){
                results = decode
            }
        }catch{
            print("Invalid Data...")
        }
    }
}

struct DetailView: View{
    var body: some View{
        Text("Hello")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
