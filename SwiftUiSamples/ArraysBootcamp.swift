//
//  ArraysBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 31.05.2023.
//

import SwiftUI

struct UserModel : Identifiable {
    let id: String = UUID().uuidString
    let name : String?
    let point : Int
    let veified : Bool
}

class ArrayModificationViewModel : ObservableObject {
    
    @Published var dataArray : [UserModel] = []
    @Published var filteredArray : [UserModel] = []
    @Published var mappedArray : [String] = []
    
    init(){
        getUsers()
        updateFilteredArray()
    }
    
    func getUsers(){
        let user1 = UserModel(name: "Omid", point: 5, veified: true)
        let user2 = UserModel(name: nil, point: 3, veified: false)
        let user3 = UserModel(name: "Joe", point: 4, veified: true)
        let user4 = UserModel(name: "Pepe", point: 2, veified: false)
        let user5 = UserModel(name: "Adam", point: 1, veified: false)
        let user6 = UserModel(name: "Aive", point: 4, veified: true)
        let user7 = UserModel(name: "Pery", point: 4, veified: true)
        let user8 = UserModel(name: nil, point: 5, veified: false)
        let user9 = UserModel(name: "Mary", point: 5, veified: false)
        
        self.dataArray.append(contentsOf: [user1,user2 , user3, user4, user5 , user6 , user7 , user8 , user9] )
        
        
    }
    
    func updateFilteredArray(){
        
        //sort
        //1 - sort approch 1
        //        filteredArray = dataArray.sorted { user1, user2 in
        //            // sort condition
        //            return user1.point > user2 .point
        //        }
        
        //2 - sort approch 2
        //filteredArray = dataArray.sorted(by: {$0.point > $1.point})
        
        //filter:
        //1 - filter approch 1
        //        filteredArray = dataArray.filter({ user in
        //            //filter condition
        //            //return user.point > 3
        //            //return user.name.contains("a")
        //            return user.veified
        //        })
        //2 - filter approch 2
        // filteredArray = dataArray.filter({$0.veified})
        
        
        //Map:
        //1 - filter approch 1
        //        mappedArray = dataArray.map({ user in
        //            return user.name
        //        })
        
        //2 - filter approch 2
        //mappedArray = dataArray.map({$0.name})
        
        //3 - filter approch 3 (when name can be nil)
        //        mappedArray = dataArray.compactMap({ user in
        //            return user.name
        //        })
        
        //4 - filter approch 4 (when name can be nil)
        //mappedArray = dataArray.compactMap({$0.name})
        
        
        
        mappedArray = dataArray
            .sorted( by: { $0.point > $1.point})
            .filter({$0.veified})
            .compactMap({$0.name})
    }
}

struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    var body: some View {
        VStack(spacing: 10) {
            //            ForEach(vm.filteredArray) { user in
            //                VStack(alignment: .leading){
            //                    Text(user.name)
            //                        .font(.headline)
            //
            //                    HStack{
            //                        Text("Points : \(user.point)")
            //                        Spacer()
            //                        if user.veified{
            //                            Image(systemName: "flame.fill")
            //                        }
            //                    }
            //                }
            //                .foregroundColor(.white)
            //                .padding()
            //                .background(.blue)
            //                .cornerRadius(10)
            //                .padding(.horizontal)
            //            }
            
            ForEach(vm.mappedArray , id:  \.self) { item in
                Text(item)
                    .font(.title)
            }
            
            Spacer()
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}
