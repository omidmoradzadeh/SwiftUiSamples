//
//  BackgroundThreadBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 2.06.2023.
//

import SwiftUI

class BackgroundThreadViewModel : ObservableObject {
    
    @Published var dataArray : [String] = []
    
    func fetchData(){
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            //show that is the current therad is main thread?!
            //Thread.isMainThread
            
            //get actualt thread we are on!
            //Thread.current
            
            
            print("Check 1 \(Thread.isMainThread)")
            print("Check 1 \(Thread.current)")
            
            
            //the proccess change the ui must use MAIN thread!
            DispatchQueue.main.async{
                self.dataArray = newData
                print("Check 2 \(Thread.isMainThread)")
                print("Check 2 \(Thread.current)")
            }
        }
       
    }
    
    private func downloadData() -> [String]{
        var data : [String] = []
        for x in 0..<10000{
            data.append("\(x)")
            print("\(x)")
        }
        return data
    }
    
}


struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 10){
                Text("Load Data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp()
    }
}
