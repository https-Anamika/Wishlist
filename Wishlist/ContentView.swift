//
//  ContentView.swift
//  Wishlist
//
//  Created by anamika singh on 10/04/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wishes: [Wish]
    @State private var isAlertShowing: Bool = false
    @State private var title: String = " "
    var body: some View {
        NavigationStack{
            List{
                ForEach (wishes) {  wish in
                    Text(wish.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                        .swipeActions{
                            Button("Delete", role: .destructive){
                                modelContext.delete(wish)
                            }
                        }
                   
                }
            }//LIST
            .navigationTitle("Wishlist")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        isAlertShowing.toggle()
                    }label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            }
            .alert("Create a new wish",isPresented: $isAlertShowing){
                TextField("enter your wish", text: $title)
                Button{
                    modelContext.insert(Wish(title: title))
                    title = ""
                    
                }label:{
                    Text("Save")
                }
            }
            .overlay{
                if wishes.isEmpty{
                    ContentUnavailableView("MY Wishlist",systemImage: "heart.circle",description: Text("No wishes yet. Add one to get started"))
                }
            }
        }
    }
}
#Preview ("List With Sample Data"){
    let container = try! ModelContainer(for:Wish.self,configurations:ModelConfiguration(isStoredInMemoryOnly: true))
    container.mainContext.insert(Wish(title: "Master in SwiftUI"))
    container.mainContext.insert(Wish(title: "Buy a new iphone "))
    container.mainContext.insert(Wish(title: "Make a positive impact"))
    return ContentView()
        .modelContainer(container)
}
#Preview ("Empty list"){
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
