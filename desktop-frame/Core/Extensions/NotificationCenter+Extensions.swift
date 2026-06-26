import Foundation

public extension NotificationCenter {

    // MARK: - Async Stream

    /// Returns an `AsyncStream` of notifications for the given `name`.
    ///
    /// The stream cancels automatically when the caller's `Task` is cancelled,
    /// so no manual `removeObserver` call is required.
    ///
    /// ```swift
    /// for await _ in NotificationCenter.default.stream(for: AppConstants.Notifications.themeDidChange) {
    ///     await reloadTheme()
    /// }
    /// ```
    func stream(
        for name: Notification.Name,
        object: AnyObject? = nil
    ) -> AsyncStream<Notification> {
        AsyncStream { continuation in
            let observer = addObserver(forName: name, object: object, queue: nil) { note in
                continuation.yield(note)
            }
            continuation.onTermination = { _ in
                self.removeObserver(observer)
            }
        }
    }

    // MARK: - Typed Post

    /// Posts a notification on the main run loop.
    @MainActor
    func postOnMain(_ name: Notification.Name, userInfo: [AnyHashable: Any]? = nil) {
        post(name: name, object: nil, userInfo: userInfo)
    }
}
