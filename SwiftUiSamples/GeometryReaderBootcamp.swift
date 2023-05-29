//
//  GeometryReaderBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 29.05.2023.
//

import SwiftUI


//Use when defenatly need it . cost of many callculation and cuse slow down applicaion
struct GeometryReaderBootcamp: View {
    var body: some View {
        
        //Example 1
        //            GeometryReader{ geometry in
        //
        //                HStack(spacing: 0){
        //                Rectangle()
        //                    .fill(.red)
        //                    //.frame(width: UIScreen.main.bounds.width * 0.666)
        //                    // above action not adaptive when you are rotate device
        //                    .frame(width: geometry.size.width * 0.666)
        //
        //                Rectangle()
        //                    .fill(.blue)
        //
        //            }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(0..<20) { index in
                    
                    GeometryReader{ geometry in
                        RoundedRectangle(cornerRadius: 10)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 30 ),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 250)
                    .padding()
              
                }
            }
        }
        
        
        
        //}
        .ignoresSafeArea()
    }
    
    func getPercentage( geo : GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
}

struct GeometryReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBootcamp()
    }
}
