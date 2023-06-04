//
//  TimerBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 4.06.2023.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 3.0, on: .main , in: .common).autoconnect()
    
    
    //current time 1*
    /*
     @State var currentDate = Date()
     var dateFormatter : DateFormatter{
     let formatter = DateFormatter()
     formatter.timeStyle = .medium
     //formatter.dateStyle = .medium
     return formatter
     }*/
    
    //count down 2*
    /*
     @State var count : Int = 10
     @State var finishedText : String? = nil
     */
    
    //countdown to data *3
    /*
     @State var timeRemaining : String = ""
     let featureDate : Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
     
     func updateTimeRemaining(){
     let remaining = Calendar.current.dateComponents([ .minute , .second ], from: Date(), to: featureDate )
     
     let minute = remaining.minute ?? 0
     let second = remaining.second ?? 0
     timeRemaining = "00:\(minute):\(second)"
     
     }*/
    
    // Animation Counter *4
    /*
     @State var count : Int = 0
     */
    
    // Animation Counter *5
    
    @State var count : Int = 1
    
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [.blue , .purple , .green],
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
            .ignoresSafeArea()
            
            //Text( dateFormatter.string(from: currentDate)) 1*
            //Text( finishedText ?? "\(count)") 2*
            //Text( timeRemaining) // 3*
            
            //                .font(.system(size: 100 , weight: .semibold, design: .rounded))
            //                .foregroundColor(.white)
            //                .lineLimit(1)
            //                .minimumScaleFactor(0.1)
            
            
            // 4*
            //            HStack(spacing: 15){
            //                Circle()
            //                    .offset(y : count == 1 ? -20 : 0 )
            //                Circle()
            //                    .offset(y : count == 2 ? -20 : 0 )
            //                Circle()
            //                    .offset(y : count == 3 ? -20 : 0 )
            //            }
            //            .frame(width: 150)
            //            .foregroundColor(.white)
            
            //5*
            TabView(selection: $count , content: {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
                
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            })
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
            
            
            // 1*
            //        .onReceive(timer) { value in
            //            currentDate = value
            //        }
            // 2*
            //        .onReceive(timer ) { _ in
            //            if count < 1 {
            //                finishedText = "Wow!"
            //            }
            //            else{
            //                count -= 1
            //            }
            //        }
            //3*
            //        .onReceive(timer) { _ in
            //            updateTimeRemaining()
            //        }
            
            //*4
            //        .onReceive(timer) { _ in
            //            withAnimation(.easeInOut(duration: 0.5)) {
            //                count = count == 3 ? 0 : count + 1
            //            }
            //        }
            
            
            //*5
                    .onReceive(timer) { _ in
                        withAnimation(.default) {
                            count = count == 5 ? 1 : count + 1
                        }
                    }
            
            
        }
    }
    
    struct TimerBootcamp_Previews: PreviewProvider {
        static var previews: some View {
            TimerBootcamp()
        }
    }
    
}
