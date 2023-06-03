//
//  typeAlisaBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 3.06.2023.
//

import SwiftUI

struct MovieModel{
    let title : String
    let director : String
    let count : Int
}


//Inseted Of copy old structure we use type alias to create name to name that already exist and rename that 
//struct TvModel{
//    let title : String
//    let director : String
//    let count : Int
//}
typealias TvModel = MovieModel

struct TypeAlisaBootcamp: View {
    
    //@State var item: MovieModel = MovieModel(title: "Walking Death", director: "Omid", count: 236)
    @State var item : TvModel = TvModel(title: "Tv Title", director: "Omid", count: 265)
    var body: some View {
        VStack{
            Text(item.title)
            Text(item.director )
            Text("\(item.count)")
        }
    }
}

struct TypeAlisaBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TypeAlisaBootcamp()
    }
}
