//
//  DragGestureBootcamp2.swift
//  SwiftUiSamples
//
//  Created by Omid on 29.05.2023.
//

import SwiftUI

struct DragGestureBootcamp2: View {
    
    @State var startingOffcetY: CGFloat = UIScreen.main.bounds.height * 0.83
    @State var currentDragOffsetY : CGFloat = 0
    @State var endingOffsetY : CGFloat = 0
    
    var body: some View {
        ZStack{
            Color.green
                .ignoresSafeArea()
            
            SignUpView()
                .offset(y : startingOffcetY)
                .offset(y : currentDragOffsetY)
                .offset(y : endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()){
                                currentDragOffsetY = value.translation.height
                            }
                        })
                        .onEnded({ value in
                            withAnimation(.spring()){
                                
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffcetY
                                }
                                else if endingOffsetY != 0 // on top
                                            && currentDragOffsetY > 150{
                                    endingOffsetY = 0
                                }
                                currentDragOffsetY = 0
                            }
                        })
                )
            
            Text("\(currentDragOffsetY)")
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGestureBootcamp2_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp2()
    }
}

struct SignUpView: View {
    var body: some View {
        VStack(spacing: 20){
            Image(systemName: "chevron.up")
                .padding(.top)
            
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100 , height: 100)
            
            
            Text("Long text hear , i want to recoment to swift ui designing. Long text hear , i want to recoment to swift ui designing.")
                .multilineTextAlignment(.center)
            
            Text("Create An Account")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(.black)
                .cornerRadius(10)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(30)
    }
}
