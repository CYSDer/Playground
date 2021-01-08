import Foundation

public func example(_ description: String, action: () -> Void) {
    printExampleHeader(description)
    action()
}

public func printExampleHeader(_ description: String) {
    print("\n--- \(description) example ---")
}
