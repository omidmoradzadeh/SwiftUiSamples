//
//  EscapingBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 3.06.2023.
//

import SwiftUI

class EscapingViewModel : ObservableObject{
    @Published var text: String = "Hello"
    
    func getData(){
        
        // sync
        //        let newData = downloadData()
        //        text = newData
        
        
        //        //async
        //        downloadData2 { data in
        //            text = data
        //        }
        
        //        //async
        //        downloadData3 { [weak self] data in
        //            self?.text = data
        //        }
        
        
        //        //async
        //        downloadData4 { [weak self] result in
        //            self?.text = result.data
        //        }
        
        downloadData5 { [weak self] result in
            self?.text = result.data
        }
        
        
    }
    
    func downloadData() -> String{
        return "New Data"
    }
    
    
    //    func downloadData2() -> String {
    //        // cant do this
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
    //            return "New Data"
    //        })
    //    }
    
    func downloadData2(compeletionHandler : (_ data : String) -> Void) {
        compeletionHandler("New Data")
        
    }
    
    
    // when we call async we must use @escaping
    func downloadData3(compeletionHandler : @escaping (_ data : String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute: {
            compeletionHandler("New Data")
        })
    }
    
    
    //More readble than previos
    func downloadData4(compeletionHandler : @escaping (DownloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute: {
            let result = DownloadResult(data: "New Data")
            compeletionHandler(result)
        })
    }
    
    //With TypeAlias **** 1
    func downloadData5(compeletionHandler : @escaping DownloadCompeletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute: {
            let result = DownloadResult(data: "New Data")
            compeletionHandler(result)
        })
    }
    
}

struct DownloadResult {
    let data : String
}

//**** 1
typealias DownloadCompeletion = (DownloadResult) -> ()

struct EscapingBootcamp: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text("\(vm.text)")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}
