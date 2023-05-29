//
//  LongPressGetureBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 29.05.2023.
//

import SwiftUI

struct LongPressGetureBootcamp: View {
    
    
    
    @State var isComplete : Bool = false
    @State var isSuccess : Bool = false
    
    var body: some View {
        //        Text(isComplete ? "Completed" : "Not Completed" )
        //            .padding()
        //            .padding(.horizontal)
        //            .background(isComplete ? .green : .gray)
        //            .cornerRadius(10)
        //        //            .onTapGesture {
        //        //                isComplete.toggle()
        //        //            }
        //            .onLongPressGesture( minimumDuration: 5.0 , maximumDistance: 1 , perform: {
        //                isComplete.toggle()
        //            })
        
        
        VStack{
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(maxWidth: isComplete ? .infinity : 0 , alignment: .leading)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)
            
            
            HStack {
                Text("Click Here")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) {
                        // at the min duration
                        withAnimation(.easeInOut(duration: 1)){
                            isSuccess = true
                        }
                    } onPressingChanged: { (isPressing) in
                        // start of press -> min dduration
                        if isPressing{
                            withAnimation(.easeInOut(duration: 1.0)){
                                isComplete = true
                            }
                        }
                        else{
                            DispatchQueue.main.asyncAfter(deadline:  .now() + 0.1, execute: {
                                if !isSuccess{
                                    withAnimation(.easeInOut(duration: 2.0)){
                                        isComplete = false
                                    }
                                }
                            })
                        }
                    }
                
                
                
                Text("Reset")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isSuccess = false
                        isComplete = false
                    }
            }
        }
    }
}


struct LongPressGetureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGetureBootcamp()
    }
}
