//
//  ContactsService.swift
//  TechnicalTest
//
//  Created by Denis Shalagin on 14.11.2022.
//

import Foundation

protocol ContactsService {
    func getContacts(completion: @escaping (Result<[ContactsGroup], ContactsServiceError>) -> Void)
}

public enum ContactsServiceError: Error, LocalizedError {
    case decodeError
    case generic
    
    public var errorDescription: String? {
        switch self {
        case .decodeError:
            return "Can't parse data.".localized
        case .generic:
            return "Can't load data.".localized
        }
    }
}

final class MockContactsServiceImpl: ContactsService {
    private enum Constants {
        static let contactsFileName = "contacts"
        static let contactsFileType = "json"
    }
    
    func getContacts(completion: @escaping (Result<[ContactsGroup], ContactsServiceError>) -> Void) {
        guard let contactsFilePath = Bundle.main.path(forResource: Constants.contactsFileName,
                                                      ofType: Constants.contactsFileType)
        else {
            completion(.failure(.generic))
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                if let jsonData = try String(contentsOfFile: contactsFilePath).data(using: .utf8) {
                    let decodedData = try JSONDecoder().decode(ContactsGroupsResponse.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(.success(decodedData.groups))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.generic))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodeError))
                }
            }
        }
    }
}

private struct ContactsGroupsResponse {
    let groups: [ContactsGroup]
}

extension ContactsGroupsResponse: Decodable { }
