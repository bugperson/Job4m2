import Foundation

protocol KeyValueStorage {
    func value<T: Codable>(forKey key: String) -> T?
    func setValue<T: Codable>(_ value: T?, forKey key: String)
}

class KeyValueContainer<T: Codable> {
    private let storage: KeyValueStorage = UserDefaults.standard
    private let key: String
    private let defaultValue: T?

    var value: T? {
        get {
            storage.value(forKey: key) ?? defaultValue
        }

        set {
            storage.setValue(newValue, forKey: key)
        }
    }

    init(key: String, defaultValue: T? = nil) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

extension UserDefaults: KeyValueStorage {
    func value<T: Codable>(forKey key: String) -> T? {
        guard
            let data = self.data(forKey: key),
            let value = try? JSONDecoder().decode(T.self, from: data)
        else { return nil }
        
        return value
    }

    func setValue<T: Codable>(_ value: T?, forKey key: String) {
        let data: Data? = value.flatMap { try? JSONEncoder().encode($0) }
        self.set(data, forKey: key)
    }

    func make<T: Codable>(key: String = #function) -> KeyValueContainer<T> {
        return KeyValueContainer<T>(key: key)
    }
}
