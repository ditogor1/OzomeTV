//
//  AppDelegate.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit
import AlamofireImage

protocol ListOfShowsDisplayLogic: class {
    func displayFetchedShows(viewModel: ListOfShows.FetchShows.ViewModel)
}

protocol DisplayLogicError {
    func displayErrorAlert(_ error: Error)
}

class ListOfShowsViewController: OzomeTVViewController {
    var interactor: ListOfShowsBusinessLogic?
//    var router: (NSObjectProtocol & ListOfShowsRoutingLogic & ListOfShowsDataPassing)?
    var displayedShows: [ListOfShows.FetchShows.ViewModel.DisplayedShow] = []
    
    
    @IBOutlet weak var table: UITableView!
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ListOfShowsInteractor()
        let presenter = ListOfShowsPresenter()
        let router = ListOfShowsRouter()
        viewController.interactor = interactor
//        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
//            if let router = router, router.responds(to: selector) {
//                router.perform(selector, with: segue)
//            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchShows()
    }
    
    
    // MARK: Follow Rules
    
    func fetchShows() {
        let request = ListOfShows.FetchShows.Request()
        interactor?.fetchShowsRule(request: request)
    }
}

extension ListOfShowsViewController: ListOfShowsDisplayLogic {
    func displayFetchedShows(viewModel: ListOfShows.FetchShows.ViewModel) {
        displayedShows = viewModel.displayedShows
        table.separatorStyle = displayedShows.count == 0 ? .none : .singleLine
        table.reloadData()
    }
}

extension ListOfShowsViewController: DisplayLogicError {
    func displayErrorAlert(_ error: Error) {
        showError(error)
    }
}

extension ListOfShowsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowCellTableViewCell.reuseIdentifier, for: indexPath) as! ShowCellTableViewCell
        let displayedShow = displayedShows[indexPath.row]
        cell.filloutCell(with: displayedShow)
        
        return cell
    }
    
    
}

extension ListOfShowsViewController: UITableViewDelegate {
    
    
    
}
