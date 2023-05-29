//
//  ScrollViewReader.swift
//  SwiftUiSamples
//
//  Created by Omid on 29.05.2023.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    
    @State var textFeiledText : String = ""
    @State var scrollToIndex : Int = 0
    var body: some View {
        
        
        //Example 1
//                ScrollView{
//
//                    ScrollViewReader{ proxy in
//
//                        Button("Click Hear to go to #49") {
//                            withAnimation(.spring()){
//                                proxy.scrollTo(49, anchor: .center)
//                            }
//                        }
//
//                        ForEach(0..<50){ index in
//                            Text("This is item number #\(index)")
//                                .font(.headline)
//                                .frame(height: 200)
//                                .frame(maxWidth: .infinity)
//                                .background(.white)
//                                .cornerRadius(10)
//                                .shadow(radius: 10)
//                                .padding(10)
//                                .id(index)
//                        }
//                    }
//                }
//
        
        
        
        //Example 2 . control from out of scroll view
        ScrollView{

            TextField("Enter a number hear", text: $textFeiledText)
                .frame(height: 55)
                .border(.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)

            Button("Scroll Now") {
                withAnimation(.spring()){
                    if let index  =  Int( textFeiledText){
                        scrollToIndex = index
                    }
                }
            }

            VStack {
                ScrollViewReader{ proxy in

                    ForEach(0..<50){ index in
                        Text("This is item number #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(10)
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { value in
                        withAnimation(.spring()){
                            proxy.scrollTo(value, anchor: .top)
                        }

                    }
                }
            }
        }
    }
}


struct ScrollViewReader_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBootcamp()
    }
}
