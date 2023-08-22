//
//  JsonService.swift
//  Museum
//
//  Created by Vyacheslav on 08.07.2023.
//

import Foundation

protocol JsonFileStorable {
    // name of any type JSON-file for universal generic-based JSON service
    static var jsonFileName: String { get }
}

protocol JsonServiceProtocol {
    func read<T: Codable & JsonFileStorable>(type: T.Type) -> T?
    func write<T: Codable & JsonFileStorable>(dataObject: T)
    func delete<T: Codable & JsonFileStorable>(type: T.Type)
}

final class JsonService: JsonServiceProtocol {

    // MARK: Public Methods

    // read from JSON any Codable & JsonFileStorable object
    func read<T: Codable & JsonFileStorable>(type: T.Type) -> T? {
        do {
            let jsonURL = try getURL(fileName: T.jsonFileName)
            let data = try Data(contentsOf: jsonURL)
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(type, from: data)
        } catch {
            ErrorHandler.shared.logError(error)
            return nil
        }
    }

    // write any Codable & JsonFileStorable object to JSON
    func write<T: Codable & JsonFileStorable>(dataObject: T) {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let data = try jsonEncoder.encode(dataObject)
            let jsonURL = try getURL(fileName: T.jsonFileName)
            try data.write(to: jsonURL)
        } catch {
            ErrorHandler.shared.logError(error)
            return
        }
    }

    // delete from JSON
    func delete<T: Codable & JsonFileStorable>(type: T.Type) {
        do {
            let jsonURL = try getURL(fileName: T.jsonFileName)
            try FileManager.default.removeItem(at: jsonURL)
        } catch {
            ErrorHandler.shared.logError(error)
        }
    }

   // MARK: Private Methods

    private func getURL(fileName: String) throws -> URL {
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
