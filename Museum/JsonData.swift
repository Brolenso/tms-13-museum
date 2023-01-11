import Foundation

struct JsonData {
    
    private enum FileName: String {
        case user = "userInfo.json"
    }
    
    var user: User? {
        get {
            do {
                let jsonUrl = try getUrl(fileName: FileName.user.rawValue)
                
                let userData = try Data(contentsOf: jsonUrl)
                
                let jsonDecoder = JSONDecoder()
                
                let user = try jsonDecoder.decode(User.self, from: userData)

                return user
                
            } catch {
                print("Error to read JSON:\n\(error.localizedDescription)")
                return nil
            }
        }
        nonmutating set {
            do {
                let jsonEncoder = JSONEncoder()
                jsonEncoder.outputFormatting = .prettyPrinted
                
                let userData = try jsonEncoder.encode(newValue)
                
                let jsonUrl = try getUrl(fileName: FileName.user.rawValue)
                
                try userData.write(to: jsonUrl)
                
            } catch {
                print("Error to write to JSON:\n\(error.localizedDescription)")
                return
            }
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
