//
//  HashableBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 31.05.2023.
//

import SwiftUI


// 1- Identifiable
// 2- Hashable


//Approch 1 : Identifiable
//struct MyCustomModel : Identifiable {
//    let id : String = UUID().uuidString
//    let title : String
//}

//Approch 2 : Hashable
struct MyCustomModel : Hashable {
    
    let title : String
    
    func hash(into hasher: inout Hasher) {
        //hasher.combine(title + subTitle) // if title
        hasher.combine(title)
    }
}

struct HashableBootcamp: View {
    
    let data : [MyCustomModel] = [
        MyCustomModel(title: "One"),
        MyCustomModel(title: "Two"),
        MyCustomModel(title: "Three"),
        MyCustomModel(title: "Fore"),
        MyCustomModel(title: "Five"),
    ]
    
    var body: some View {
        ScrollView{
            VStack(spacing: 40){
                
                //Example : notmal mode
                //                ForEach(data , id: \.self) { item in
                //                    Text(item.hashValue.description)
                //                        .font(.headline)
                //                }
                
                
                //Approch 1 : Identifiable
                //                ForEach(data) { item in
                //                    Text(item.title)
                //                        .font(.headline)
                //
                //                    Text(item.id)
                //                        .font(.headline)
                //                    Divider()
                //                }
                
                
                //Approch 2 : Hashable
                ForEach( data , id: \.self) { item in
                    Text(item.title)
                        .font(.headline)
                    
                    Text(item.hashValue.description)
                        .font(.headline)
                    Divider()
                    
                }
            }
        }
    }
}

struct HashableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootcamp()
    }
}
