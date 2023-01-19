//
//  NotificationExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2023/1/3.
//

import Foundation

final public class FastNotificationToken {
    let notificationCenter: NotificationCenter
    let token: Any

    init(notificationCenter: NotificationCenter = .default, token: Any) {
        self.notificationCenter = notificationCenter
        self.token = token
    }

    deinit {
        notificationCenter.removeObserver(token)
    }
}

public extension FastExtensionWrapper where Base: NotificationCenter {
    func addObserve(name: NSNotification.Name?,
                    object obj: Any? = nil,
                    queue: OperationQueue? = nil,
                    using block: @escaping (Notification) -> ()) -> FastNotificationToken
    {
        let token = base.addObserver(forName: name, object: obj, queue: queue, using: block)
        return FastNotificationToken(notificationCenter: base, token: token)
    }
}

