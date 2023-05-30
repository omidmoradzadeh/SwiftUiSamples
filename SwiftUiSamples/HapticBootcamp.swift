//
//  HapticBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 30.05.2023.
//

import SwiftUI


class HapticManager {
    
    static let instance = HapticManager()
    
    func notification( type : UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact( style :UIImpactFeedbackGenerator.FeedbackStyle  ){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticBootcamp: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Success") {
                HapticManager.instance.notification(type: .success)
            }
            
            Button("Warning") {
                HapticManager.instance.notification(type: .warning)
            }
            
            Button("Error") {
                HapticManager.instance.notification(type: .error)
            }
            
            Divider()
            
            Button("Heavy") {
                HapticManager.instance.impact(style: .heavy)
            }
            
            Button("light") {
                HapticManager.instance.impact(style: .light)
            }
            
            Button("medium") {
                HapticManager.instance.impact(style: .medium)
            }
            
            Button("rigid") {
                HapticManager.instance.impact(style: .rigid)
            }
            
            Button("soft") {
                HapticManager.instance.impact(style: .soft)
            }
        }
    }
}

struct HapticBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HapticBootcamp()
    }
}
