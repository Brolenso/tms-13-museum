import Foundation

// name of JSON-file in any type for universal generic-based JSON service
protocol JsonFileStorableProtocol {
    static var jsonFileName: String { get }
}

extension User: JsonFileStorableProtocol {
    static var jsonFileName: String = "userInfo.json"
}

protocol JsonServiceProtocol {
    func read<T: Codable & JsonFileStorableProtocol>(type: T.Type) -> T?
    func write<T: Codable & JsonFileStorableProtocol>(dataObject: T)
}

class JsonService: JsonServiceProtocol {
    // read from JSON any Codable & JsonFileStorable object
    public func read<T: Codable & JsonFileStorableProtocol>(type: T.Type) -> T? {
        do {
            let jsonUrl = try getUrl(fileName: T.jsonFileName)
            let data = try Data(contentsOf: jsonUrl)
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(type, from: data)
        } catch {
            debugPrint("Error to read JSON:\n\(error.localizedDescription)")
            return nil
        }
    }
    
    // write any Codable & JsonFileStorable object to JSON
    public func write<T: Codable & JsonFileStorableProtocol>(dataObject: T) {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let data = try jsonEncoder.encode(dataObject)
            let jsonUrl = try getUrl(fileName: T.jsonFileName)
            try data.write(to: jsonUrl)
        } catch {
            debugPrint("Error to write to JSON:\n\(error.localizedDescription)")
            return
        }
    }
    
    private func getUrl(fileName: String) throws -> URL {
        var url = try FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .allDomainsMask,
            appropriateFor: nil,
            create: true
        )
        url.append(path: fileName)
        return url
    }
}
