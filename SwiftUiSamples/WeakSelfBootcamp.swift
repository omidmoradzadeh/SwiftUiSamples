//
//  WeakSelfBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 3.06.2023.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count : Int?
    
    init(){
        count = 0
    }
    
    var body: some View {
        NavigationView{
            NavigationLink("Navigation") {
                WeakSelfSecondScreen()
                    .navigationTitle("Screen 1")
            }
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(.green)
                .cornerRadius(10)
            , alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen : View{
    
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View{
        Text("SecondView")
            .font(.largeTitle)
            .foregroundColor(.red)
        
        if let data = vm.data{
            Text(data)
        }
    }
}

class WeakSelfSecondScreenViewModel : ObservableObject{
    @Published var data : String? = nil
    
    init(){
        print("Initilize now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit{
        print("Deinitilize now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData(){

        DispatchQueue.main.asyncAfter(deadline: .now() + 500, execute: { [weak self] in
            self?.data = "New Data!!!"
        })
        
    }
}
struct WeakSelfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfBootcamp()
    }
}
