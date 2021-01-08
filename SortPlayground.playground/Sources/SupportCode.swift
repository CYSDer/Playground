import Foundation

public func example(_ description: String, action: () -> Void) {
    printExampleHeader(description)
    action()
}

public func printExampleHeader(_ description: String) {
    print("\n--- \(description) ---")
}

public func swapArr(_ arr: inout Array<Int>, _ i: Int, _ j: Int) {
    if i == j { return }
    let temp = arr[i]
    arr[i] = arr[j]
    arr[j] = temp
}
