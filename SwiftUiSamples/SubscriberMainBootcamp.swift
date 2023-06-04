//
//  SubscriberMainBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 4.06.2023.
//

import SwiftUI
import Combine


class SubscriberViewModel2 : ObservableObject {
    
    @Published var count : Int = 0
    @Published var textFieldText : String = ""
    @Published var textIsValid : Bool = false
    @Published var showButton : Bool = false
    
    var cancellable = Set<AnyCancellable>()
    
    init(){
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscribert()
    }
    
    func addTextFieldSubscriber(){
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count >= 3 {
                    return true
                }
                return false
            }
        //.assign(to: \.textIsValid , on : self) dont use assign . because it cant be define as self weak
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellable)
    }
    
    func setUpTimer(){
        
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] (_) in
                
                guard let self = self else {return}
                self.count += 1
            }
            .store(in: &cancellable)
    }
    
    func addButtonSubscribert(){
        // add second publisher on one item ( $textIsValid , $count )
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid , count) in
                guard let self = self else {return}
                if isValid && count >= 10{
                    self.showButton = true
                }
                else{
                    self.showButton = false
                }
            }
        // must written
            .store(in: &cancellable)
        
    }
}


struct SubscriberMainBootcamp: View {
    @StateObject var vm = SubscriberViewModel2()
    
    var body: some View {
        VStack{
            Text("\(vm.count)")
                .font(.largeTitle)
            
            
            
            
            TextField("type some thing here ..", text: $vm.textFieldText )
                .padding(.leading )
                .frame(height: 55)
                .font(.headline)
                .background( .gray)
                .cornerRadius(10)
                .overlay(ZStack{
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .opacity(
                            vm.textFieldText.count < 1 ? 0 :
                                vm.textIsValid ? 0 : 1)
                    
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                        .opacity( vm.textIsValid ? 1 : 0)
                    
                }
                    .font(.title)
                    .padding(.trailing)
                         , alignment:  .trailing
                )
            
            Button {
                
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            }
            .disabled(!vm.showButton)
            
        }
        .padding()
    }
}

struct SubscriberMainBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberMainBootcamp()
    }
}
