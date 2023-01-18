import Foundation

struct JsonData {
    
    private enum FileName: String {
        case userFile = "userInfo.json"
    }
    
    @discardableResult
    public func readUser() -> Bool {
        do {
            let jsonUrl = try getUrl(fileName: FileName.userFile.rawValue)
            
            let userData = try Data(contentsOf: jsonUrl)
            
            let jsonDecoder = JSONDecoder()
            
            let user = try jsonDecoder.decode(User.self, from: userData)
            
            User.current.setUser(email: user.email, password: user.password)
            
            return true
            
        } catch {
            print("Error to read JSON:\n\(error.localizedDescription)")
            return false
        }
    }
    
    @discardableResult
    public func writeUser() -> Bool {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            
            let userData = try jsonEncoder.encode(User.current)
            
            let jsonUrl = try getUrl(fileName: FileName.userFile.rawValue)
            
            try userData.write(to: jsonUrl)
            
            return true
            
        } catch {
            print("Error to write to JSON:\n\(error.localizedDescription)")
            return false
        }
    }
    
    private func getUrl(fileName: String) throws -> URL {
        var url = try FileManager.default.url(for: .applicationSupportDirectory,
                                              in: .allDomainsMask,
                                              appropriateFor: nil,
                                              create: true)
        url.append(path: fileName)
        return url
    }
    
}
