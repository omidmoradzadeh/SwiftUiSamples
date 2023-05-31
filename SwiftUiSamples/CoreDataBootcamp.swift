//
//  CoreDataBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 31.05.2023.
//

import SwiftUI
import CoreData

/*
 - View -> UI
 - Model -> data point
 - ViewModel -> manage the data for a view
 */


class CoreDataViewModel : ObservableObject {
    
    let container : NSPersistentContainer
    @Published var savedEntities : [FruitEntity] = []
    
    init(){
        container = NSPersistentContainer(name: "FruitsContrainer")
        container.loadPersistentStores { description, error in
            if let error  = error{
                print("Error loading Core Data!\(error)")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits(){
        let requset = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do{
            savedEntities = try container.viewContext.fetch(requset)
        }
        catch let error {
            print("Error in fetching \(error )")
        }
    }
    
    func addFruit( name : String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = name
        
        saveData()
    }
    
    func upadteFruit(fruit : FruitEntity){
        let currentName = fruit.name ??  ""
        let newName = currentName + "!"
        fruit.name = newName
        saveData()
    }
    
    func deleteFruit(indexSet : IndexSet){
        
        guard let index = indexSet.first else {return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData(){
        do {
            try container.viewContext.save()
            fetchFruits()
            
        }
        catch let error {
            print("Error saving \(error)")
        }
        
    }
}

struct CoreDataBootcamp: View {
    
    
    
    @State var textFieldText : String = ""
    @StateObject var vm = CoreDataViewModel()
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add Fruit Hear ...", text: $textFieldText)
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .background(.gray)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    guard !textFieldText.isEmpty else {return}
                    vm.addFruit(name: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Button")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.pink)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                List{
                    ForEach(vm.savedEntities){ index in
                        Text(index.name ?? "No Name")
                            .onTapGesture {
                                vm.upadteFruit(fruit: index)
                            }
                    }
                    .onDelete( perform:  vm.deleteFruit)
                }
                .listStyle(.plain)
                Spacer()
            }
        }
        .navigationTitle("Fruits")
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
