//
//  ListOfShowsViewController.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit
import AlamofireImage

protocol ListOfShowsDisplayLogic: class {
    func displayFetchedShows(viewModel: ListOfShows.FetchShows.ViewModel)
    func displayEmptyShows(_ emptyShows: Bool)
    func displaySpinnerLoader(_ display: Bool)
}

protocol DisplayLogicError {
    func displayErrorAlert(_ error: Error)
}

class ListOfShowsViewController: OzomeTVViewController {
    var interactor: ListOfShowsBusinessLogic?
    var router: ListOfShowsRoutingLogic?
    var displayedShows: [VMDisplayedShow] = []
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var tableFooterLabel: UILabel!
    var refreshControl: UIRefreshControl?
    var extraHour = 0
    var timer: Timer?
        
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
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataSource = interactor
    }
    
    // MARK: Routing
    
    func selectedIndexPath(_ indexPath: IndexPath) {
        router?.routeToDisplayShowDetails(indexPath: indexPath, navigationController: self.navigationController)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
        setupRefreshControl()
        setupBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchShows()
    }
    
    // MARK: Private Methods
    
    private func setupRefreshControl() {
        let tempRefreshControl = UIRefreshControl()
        tempRefreshControl.tintColor = UIColor.black
        tempRefreshControl.addTarget(self, action: #selector(refreshShows), for: .valueChanged)
        refreshControl = tempRefreshControl
        table.addSubview(refreshControl!)
    }
    
    private func setupBarButtons() {
        let nextButton = UIBarButtonItem(title: "Next Hour", style: .plain, target: self, action: #selector(addHour))
        navigationItem.rightBarButtonItem = nextButton
    }
    
    // MARK: Follow Rules
    
    @objc func addHour() {
        if extraHour < 6 {
            extraHour += 1
            
            fireTimer()
            updateDisplayableHour(extraHour)
        }
    }
    
    private func fireTimer() {
        if let validTimer = timer {
            validTimer.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fetchShows), userInfo: nil, repeats: false)
    }
    
    @objc func fetchShows() {
        
        let request = ListOfShows.FetchShows.Request(date: Date().add(minutes: 2 * (60 * 24)), atHour: extraHour)
        interactor?.fetchShowsRule(request: request)
    }
    
    @objc func refreshShows() {
        extraHour = 0
        self.navigationItem.title = "Ongoing Shows"
        fetchShows()
    }
    
    func updateDisplayableHour(_ hour: Int) {
        DispatchQueue.main.async {
            let newHour = Date().add(minutes: (60 * hour)).hour
            self.navigationItem.title = "Schedule at: \(newHour)"
        }
    }
}

extension ListOfShowsViewController: ListOfShowsDisplayLogic {

    func displayFetchedShows(viewModel: ListOfShows.FetchShows.ViewModel) {
        displayedShows = viewModel.displayedShows
        refreshControl?.endRefreshing()
        table.reloadData()
    }
    
    func displayEmptyShows(_ emptyShows: Bool) {
        tableFooterLabel.isHidden = emptyShows
    }
    
    func displaySpinnerLoader(_ display: Bool) {
        if display {
            showLoading("Loading TV shows")
        } else {
            hideLoading()
        }
    }
}

extension ListOfShowsViewController: DisplayLogicError {
    func displayErrorAlert(_ error: Error) {
        refreshControl?.endRefreshing()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath(indexPath)
    }
}
