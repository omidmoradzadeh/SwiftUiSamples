//
//  MultipleSheetsBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 30.05.2023.
//

import SwiftUI

struct RandomModel : Identifiable{
    var id : String = UUID().uuidString
    var title : String
}



// 1- binding
// 2- multiple sheet
// 3- item approch



// 1- ->binding
//struct MultipleSheetsBootcamp: View {
//    
//    @State var randomModel : RandomModel = RandomModel( title: "Starting title")
//    @State var showSheet : Bool = false
//    @State var showSheet2 : Bool = false
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Button("Button 1") {
//                randomModel = RandomModel(title: "One")
//                showSheet.toggle()
//            }
//            
//            Button("Button 2") {
//                randomModel = RandomModel(title: "two")
//                showSheet.toggle()
//            }
//        }
//        .sheet(isPresented: $showSheet) {
//            nextScreen(selectedModel: randomModel)
//        }
//    }
//}
//
//struct nextScreen : View{
//    
//    
//    var selectedModel : RandomModel
//    // solution 1: use @Bining insted of normal variable
//    //@Binding var selectedModel : RandomModel
//    
//    var body: some View{
//        Text(selectedModel.title)
//            .font(.largeTitle)
//    }
//}



// 2- ->multiple sheet
//sheet cant be in hirichey - they must be seprate foram each other
//struct MultipleSheetsBootcamp: View {
//
//    @State var randomModel : RandomModel = RandomModel( title: "Starting title")
//    @State var showSheet : Bool = false
//    @State var showSheet2 : Bool = false
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Button("Button 1") {
//                showSheet.toggle()
//            }
//            .sheet(isPresented: $showSheet) {
//                nextScreen(selectedModel: RandomModel(title: "One"))
//            }
//
//            Button("Button 2") {
//                showSheet.toggle()
//            }
//            .sheet(isPresented: $showSheet2) {
//                nextScreen(selectedModel: RandomModel(title: "two"))
//            }
//        }
//
//    }
//}
//
//struct nextScreen : View{
//
//
//    var selectedModel : RandomModel
//
//    var body: some View{
//        Text(selectedModel.title)
//            .font(.largeTitle)
//    }
//}


// 3- ->multiple sheet
//sheet cant be in hirichey - they must be seprate foram each other
//the best way is this ( in next example show the power of dynamicity of this solution)
//struct MultipleSheetsBootcamp: View {
//
//    @State var randomModel : RandomModel? = nil
//    @State var showSheet : Bool = false
//    @State var showSheet2 : Bool = false
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Button("Button 1") {
//                randomModel = RandomModel(title: "One")
//            }
//
//            Button("Button 2") {
//                randomModel = RandomModel(title: "Two")
//            }
//
//        }
//        .sheet(item: $randomModel) { model in
//            nextScreen(selectedModel: model)
//        }
//
//    }
//}
//
//struct nextScreen : View{
//
//
//    var selectedModel : RandomModel
//
//    var body: some View{
//        Text(selectedModel.title)
//            .font(.largeTitle)
//    }
//}



// 3- ->multiple sheet (Dynamic example)
struct MultipleSheetsBootcamp: View {
    
    @State var randomModel : RandomModel? = nil
    @State var showSheet : Bool = false
    @State var showSheet2 : Bool = false
    
    var body: some View {
        
        ScrollView{
            VStack(spacing: 20) {
                ForEach(0..<50) { index in
                    
                    Button(("Button \(index)")) {
                        randomModel = RandomModel(title: "\(index)")
                    }
                    .frame(width: .infinity)
                    
                }
                
            }
            .sheet(item: $randomModel) { model in
                nextScreen(selectedModel: model)
            }
        }
        
    }
}

struct nextScreen : View{
    
    
    var selectedModel : RandomModel
    
    var body: some View{
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}









struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
