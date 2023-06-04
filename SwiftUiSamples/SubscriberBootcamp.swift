//
//  SubscriberBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 4.06.2023.
//

import SwiftUI
import Combine


// TIMER Part 2
class SubscriberViewModel : ObservableObject {
    
    @Published var count : Int = 0
    
    // Approch 1
    //var timer : AnyCancellable?
    // Approch 2
    var cancellable = Set<AnyCancellable>()
    
    init(){
        setUpTimer()
    }
    
    func setUpTimer(){
        // Approch 1
        //timer = Timer
        
        // Approch 2
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] (_) in
                
                guard let self = self else {return}
                self.count += 1
                
                if count >= 10 {
                    // Approch 1
                    //self.timer?.cancel()
                    
                    // Approch 2
                    for item in self.cancellable{
                        item.cancel()
                    }
                }
            }
        // Approch 2
            .store(in: &cancellable)
    }
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack{
            Text("\(vm.count)")
                .font(.largeTitle)
        }
    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}
