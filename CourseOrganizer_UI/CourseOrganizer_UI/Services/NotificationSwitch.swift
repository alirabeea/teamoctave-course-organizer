//
//  NotificationSwitch.swift
//  CourseOrganizer_UI
//
//  Created by Kai on 12/1/22.
//

import Foundation
import UserNotifications
import UIKit


class NotificationSwitch: ObservableObject {
    let notificationCenter = UNUserNotificationCenter.current()
    var isenabled = false
    var isauthorized = false
    
    func enableNotification() {
        notificationCenter.requestAuthorization(options:[.alert,.badge,.sound]) { result, error in
                if let error = error {
                    print(error)
                }
        }
        isenabled = true
    }
    
    func getnotificationsettings() async {
        let settings = await notificationCenter.notificationSettings()
        isauthorized = settings.authorizationStatus == .authorized && isenabled
    }
    
    func scheduleNotification(course: Course) {
        let content = UNMutableNotificationContent()
        content.title = "Scheduled course update for " + course.course__verbose + " !"
        content.body = "Your daily reminder to check your course info to see if there is an update for your interested courses!"
        content.sound = UNNotificationSound.default
        
        var schedule = DateComponents()
        schedule.calendar = Calendar.current
        schedule.weekday = 7 // everyday
        schedule.hour = 8 // at 8:00
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: schedule, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: course.id.uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print(error)
            } else {
                print("Schedule success!")
            }
        }
    }
    
    func abortscheduleNotification(course: Course) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [course.id.uuidString])
    }
    
    func directsetting() {
        if let url = URL(string:UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                Task {
                    await UIApplication.shared.open(url)
                }
            }
        }
    }
}

