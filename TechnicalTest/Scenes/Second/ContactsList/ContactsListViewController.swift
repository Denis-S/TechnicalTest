//
//  ContactsViewController.swift
//  TechnicalTest
//
//  Created by Denis Shalagin on 14.11.2022.
//

import UIKit

protocol ContactsListView: AnyObject {
    func reloadViewData()
    func showError(_ error: String)
}

final class ContactsListViewController: UIViewController, ContactsListView {
    private enum Constants {
        static let contactsCellIdentifier = "ContactCell"
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: ContactsListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ContactsListPresenterImpl(service: MockContactsServiceImpl(), view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.reloadData()
    }
    
    func reloadViewData() {
        tableView.reloadData()
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Error".localized, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: .default))
        present(alert, animated: true)
    }
}

extension ContactsListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.data[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.data[section].contacts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.contactsCellIdentifier,
                                                       for: indexPath) as? ContactTableViewCell,
              let item = presenter?.data[indexPath.section].contacts[indexPath.row]
        else {
            return UITableViewCell()
        }
        
        cell.configure(with: ContactCellViewModel(contact: item))
        
        return cell
    }
}

extension ContactsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.filterData(withString: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
