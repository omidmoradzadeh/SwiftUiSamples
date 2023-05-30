//
//  LocalNotificationBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 30.05.2023.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    //Singlton
    static let instance = NotificationManager()
    
    func requestAuthorization(){
        
        let option : UNAuthorizationOptions  = [.alert, .sound , .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: option) { success, error in
            if let error = error {
                print("error \(error)")
            }
            else{
                print("success")
            }
        }
    }
    
    func scheduleNotification(){
        
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle = "This is so easy"
        content.sound = .default
        content.badge = 1
        
        
        //Trigger types :
        // 1- time
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // 2- calender
        // var  dateComponent = DateComponents()
        // dateComponent.hour = 23
        // dateComponent.minute = 27
        // dateComponent.weekday = 6 // friday
        // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        // 3- location
        let coordinate = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00
        )
        let region = CLCircularRegion(
            center: coordinate,
            radius: 100,
            identifier: UUID().uuidString
        )
        region.notifyOnEntry = true
        region.notifyOnExit = false
        var trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancleNotification(){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") {
                
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Schedule Notification") {
                
                NotificationManager.instance.scheduleNotification()
            }
            
            Button("Cancle Notification") {
                
                NotificationManager.instance.cancleNotification()
            }
        }
        .onAppear(){
            //for clear badge when user open app
            UIApplication.shared.applicationIconBadgeNumber = .zero
        }
    }
}

struct LocalNotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBootcamp()
    }
}
