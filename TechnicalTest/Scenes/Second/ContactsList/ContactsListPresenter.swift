//
//  ContactsListPresenter.swift
//  TechnicalTest
//
//  Created by Denis Shalagin on 14.11.2022.
//

import UIKit

protocol ContactsListPresenter {
    var data: [ContactsGroup] { get }
    
    func reloadData()
    func filterData(withString filterString: String)
}

final class ContactsListPresenterImpl: ContactsListPresenter {
    var data = [ContactsGroup]()
    
    private let service: ContactsService
    private weak var view: ContactsListView?
    
    private var unfilteredData = [ContactsGroup]()
    private var filterString = ""
    
    init(service: ContactsService, view: ContactsListView) {
        self.service = service
        self.view = view
    }
    
    func reloadData() {
        service.getContacts { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.unfilteredData = data
                self.filterData(withString: self.filterString)
            case .failure(let error):
                self.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func filterData(withString filterString: String) {
        self.filterString = filterString
        
        if filterString.isEmpty {
            data = unfilteredData
        } else {
            var filteredData = [ContactsGroup]()
            
            unfilteredData.forEach {
                let filteredContacts = $0.contacts.filter {
                    $0.firstName.lowercased().contains(filterString.lowercased()) ||
                    $0.lastName.lowercased().contains(filterString.lowercased())
                }
                
                if !filteredContacts.isEmpty {
                    filteredData.append(ContactsGroup(title: $0.title, contacts: filteredContacts))
                }
            }
            
            data = filteredData
        }
        
        view?.reloadViewData()
    }
}
