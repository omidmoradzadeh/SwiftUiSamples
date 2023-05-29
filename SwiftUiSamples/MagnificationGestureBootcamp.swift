//
//  MagnificationGestureBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 29.05.2023.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    @State var currentAmount : CGFloat = 0
    @State var lastAmount : CGFloat = 0
      
      var body: some View {
          
          //Example 1 Zoomable Rectangle
//          Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//              .font(.title)
//              .padding(40)
//              .background(.red)
//              .cornerRadius(10)
//              .scaleEffect( 1 + currentAmount + lastAmount)
//              .gesture(
//                  MagnificationGesture()
//                    .onChanged({ value in
//                        currentAmount = value - 1
//                    })
//                    .onEnded({ value in
//                        lastAmount += currentAmount
//                        currentAmount = 0
//                    })
//
//              )
//
          
          
          VStack(spacing: 10){
              HStack{
                  Circle()
                      .frame(width: 35, height: 35)
                  Text("Omid Moradzadeh")
                  Spacer()
                  Image(systemName: "ellipsis")
              }
              .padding(.horizontal)
              
              Rectangle()
                  .frame( height: 300)
                  .scaleEffect( 1 + currentAmount)
                  .gesture(
                  MagnificationGesture()
                    .onChanged({ value in
                        currentAmount = value - 1
                    })
                    .onEnded({ value in
                        withAnimation(.spring()){
                            currentAmount = 0
                        }
                    })
                  )
              
              
              
              HStack{
                  Image(systemName: "heart.fill")
                  Image(systemName: "text.bubble.fill")
                  Spacer()
              }
              .padding(.horizontal)
              .font(.headline)
              
              Text("This is the caption to my photo")
                  .frame(maxWidth: .infinity , alignment: .leading)
                  .padding(.horizontal)
          }
      }

}

struct MagnificationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureBootcamp()
    }
}
