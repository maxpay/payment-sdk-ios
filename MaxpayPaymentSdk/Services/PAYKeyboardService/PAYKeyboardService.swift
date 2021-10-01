import UIKit

internal final class PAYKeyboardNotificationService {
    
    // MARK: - Properties
    
    private var keyboardEventHandler: ((CGRect) -> ())?
    
    private var isKeyboardHidden = true
    
    // MARK: - Init and Deinit
    
    deinit {
        self.unregisterNotifications()
    }
    
    init(_ keyboardEventHandler: ((CGRect) -> ())? = nil) {
        self.keyboardEventHandler = keyboardEventHandler
        self.registerNotifications()
    }
    
    // MARK: - Private
    
    private func registerNotifications() {
        [UIWindow.keyboardDidShowNotification, UIWindow.keyboardWillHideNotification]
            .forEach {
            NotificationCenter.default.addObserver(self,
                                           selector: #selector(process(notification:)),
                                           name: $0,
                                           object: nil)
        }
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func process(notification: Notification) {
        let isShow = UIWindow.keyboardDidShowNotification == notification.name

        if isShow == self.isKeyboardHidden {  //  sync notification and current state
            let endFrame = notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? CGRect ?? CGRect.zero

            self.isKeyboardHidden = !isShow
            
            self.keyboardEventHandler?(isShow ? endFrame : .zero)
        }
    }
}

