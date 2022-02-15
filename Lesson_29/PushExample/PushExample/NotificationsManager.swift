//
//  NotificationsManager.swift
//  PushExample
//
//  Created by Nickolai Nikishin on 15.02.22.
//

import UserNotifications

class NotificationsManager {
    static let shared = NotificationsManager()
    
    private let defaults = UserDefaults.standard
    public var title: String? {
        set {
            defaults.set(newValue, forKey: Keys.title.rawValue)
        }
        get {
            defaults.object(forKey: Keys.title.rawValue) as? String
        }
    }
    
    public var subTitle: String? {
        set {
            defaults.set(newValue, forKey: Keys.subTitle.rawValue)
        }
        get {
            defaults.object(forKey: Keys.subTitle.rawValue) as? String
        }
    }
    
    public var time: Date? {
        set {
            defaults.set(newValue, forKey: Keys.time.rawValue)
        }
        get {
            defaults.object(forKey: Keys.time.rawValue) as? Date
        }
    }
    
    public var isEnabled: Bool {
        set {
            defaults.set(newValue, forKey: Keys.isEnabled.rawValue)
        }
        get {
            defaults.bool(forKey: Keys.isEnabled.rawValue)
        }
    }
    
    
    private enum Keys: String {
        case title
        case subTitle
        case time
        case isEnabled
    }
    // delete pending notifications
    
    func deletePendingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    
    func scheduleNotifications() {
        guard let title = title, let subTitle = subTitle, let time = time else {
            return
        }

        
        if isEnabled {
            let content = UNMutableNotificationContent()
            content.title = title
            content.subtitle = subTitle
          
            content.categoryIdentifier = "myActionCategoryIdentifier"
            content.userInfo = ["customDataKey": "cusom_data_value"]

            // 2. Create Trigger and Configure the desired behaviour - Calendar
            // TODO: adjust timing function
            
            var date = DateComponents()
            date.year = 2022
            date.month = 1
            date.day = 30
            date.hour = 15
            date.minute = 08
            date.second = 0
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)

            // Choose a random identifier, this is important if you want to be able to cancle the Notification
            let notificationIdentifier = UUID().uuidString + "_" + "some_uniq_identifier" // E.g. 123-abc_clock-alarm
            let request = UNNotificationRequest(identifier: notificationIdentifier,
                                                content: content,
                                                trigger: trigger)

            // 3. Create the Request
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    func saveNotificationSettings(title: String?, subtitle: String?, time: Date?, isEnabled: Bool) {
        self.title = title
        self.subTitle = subtitle
        self.time = time
        self.isEnabled = isEnabled
    }
    
    func readNotificationSettings() -> (String?, String?, Date?, Bool) {
        return (title, subTitle, time, isEnabled)
    }
    
    func recreateNotifications() {
        deletePendingNotifications()
        scheduleNotifications()
    }
}
