import Foundation

//@propertyWrapper
//struct Located<T> {
//    
//    var wrappedValue: T {
//        let x: T = ServiceLocator.shared.get()
//        return x
//    }
//}
final class ServiceLocator {

    let shared = ServiceLocator()

    private let services: [Any] = [
        APIService()
    ]

    func get<T>() -> T {
        return services.first(where: { $0 is T })! as! T
    }
}
