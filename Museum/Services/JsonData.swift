import Foundation

protocol JsonDataProtocol {
    func read<T>(type: T.Type) -> T? where T: Codable
    func write<T>(_ objectToWrite: T) -> Bool where T: Codable
}

struct JsonData: JsonDataProtocol {
    
    private enum FileName: String {
        case userFile = "userInfo.json"
    }
    
//    private func getFileName<T>(byType type: T.Type) -> String? {
//        if type is User {
//            return "userInfo.json"
//        } else {
//            print("Type is not found in func getFileName(byType:)")
//            return nil
//        }
//
////        switch (type as Any.Type) {
////        case User.self:
////            return "userInfo.json"
////        default:
////            print("Type is not found in func getFileName(byType:)")
////            return nil
////        }
//    }
    
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
    
    @discardableResult
    public func write<T>(_ objectToWrite: T) -> Bool where T: Codable {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let data = try jsonEncoder.encode(objectToWrite)
            let jsonUrl = try getUrl(fileName: FileName.userFile.rawValue)
            try data.write(to: jsonUrl)
            return true
        } catch {
            print("Error to write to JSON:\n\(error.localizedDescription)")
            return false
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
