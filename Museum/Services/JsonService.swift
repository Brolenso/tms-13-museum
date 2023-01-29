import Foundation

protocol JsonServiceProtocol {
    func read<T>(type: T.Type) -> T? where T: Codable
    func write<T>(dataObject objectToWrite: T) where T: Codable
}

struct JsonService: JsonServiceProtocol {
    
    private enum FileName: String {
        case userFile = "userInfo.json"
    }
    
    // TODO: make universal function that return file-name by T.Type
    
//    private func getFileName<T>(byType type: T.Type) -> String? {
//        if type is User {
//            return "userInfo.json"
//        } else {
//            print("Type is not found in func getFileName(byType:)")
//            return nil
//        }
//
//        switch (type as Any.Type) {
//        case User.self:
//            return "userInfo.json"
//        default:
//            print("Type is not found in func getFileName(byType:)")
//            return nil
//        }
//    }
    
    // read from JSON any codable object
    public func read<T>(type: T.Type) -> T? where T: Codable {
        do {
            let jsonUrl = try getUrl(fileName: FileName.userFile.rawValue)
            let data = try Data(contentsOf: jsonUrl)
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(type, from: data)
        } catch {
            print("Error to read JSON:\n\(error.localizedDescription)")
            return nil
        }
    }
    
    // write any codable object to JSON
    public func write<T>(dataObject: T) where T: Codable {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let data = try jsonEncoder.encode(dataObject)
            let jsonUrl = try getUrl(fileName: FileName.userFile.rawValue)
            try data.write(to: jsonUrl)
        } catch {
            print("Error to write to JSON:\n\(error.localizedDescription)")
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
