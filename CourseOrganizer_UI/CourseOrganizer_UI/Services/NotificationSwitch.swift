//
//  NotificationSwitch.swift
//  CourseOrganizer_UI
//
//  Created by Kai on 12/1/22.
//

import Foundation
import UserNotifications


class NotificationSwitch: ObservableObject {
    let notificationCenter = UNUserNotificationCenter.current()
    var isenabled = false
    
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
        isenabled = settings.authorizationStatus == .authorized && isenabled
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
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: schedule, repeats: true)
        let request = UNNotificationRequest(identifier: course.id.uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func abortscheduleNotification(course: Course) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [course.id.uuidString])
    }
}

