//
//  ShowDetailsViewController.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit

protocol ShowDetailsDisplayLogic: class {
    func displayShowDetails(viewModel: ShowDetail.FetchShow.ViewModel)
}

class ShowDetailsViewController: OzomeTVViewController {
    
    var interactor: ShowDetailsBusinessLogic?
    var displayedShowDetail: ShowDetail.FetchShow.ViewModel.DisplayedShowDetail?
    var router: ShowDetailsDataPassing?
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    private lazy var paragraph: NSMutableParagraphStyle = {
        let justifiedParagraph = NSMutableParagraphStyle()
        justifiedParagraph.alignment = .justified
        return justifiedParagraph
    }()
    
    private lazy var detailsAttributes: Dictionary<NSAttributedString.Key, Any> = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
        .foregroundColor: UIColor.blue,
        .paragraphStyle: paragraph]
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ShowDetailsInteractor()
        let presenter = ShowDetailsPresenter()
        let router = ShowDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataSource = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchShowDetails()
    }
    
    // MARK: Follow Rules
    
    func fetchShowDetails() {
        interactor?.fetchShowDetails()
    }
    
    private func filloutViewController(_ displayedShowDetail: ShowDetail.FetchShow.ViewModel.DisplayedShowDetail) {
        navigationItem.title = displayedShowDetail.name
        
        if let validImageURL = displayedShowDetail.imageURL {
            showImage.af.setImage(withURL: validImageURL)
        }
        scheduleLabel.text = displayedShowDetail.network
        durationLabel.text = displayedShowDetail.schedule
        descriptionLabel.attributedText = displayedShowDetail.summary.htmlAttributedString(detailsAttributes)
    }

}


extension ShowDetailsViewController: ShowDetailsDisplayLogic {
    func displayShowDetails(viewModel: ShowDetail.FetchShow.ViewModel) {
        filloutViewController(viewModel.displayedShowDetail)
    }
}

extension ShowDetailsViewController: DisplayLogicError {
    func displayErrorAlert(_ error: Error) {
        showError(error)
    }
}
