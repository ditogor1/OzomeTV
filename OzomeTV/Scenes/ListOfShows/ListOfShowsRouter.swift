//
//  ListOfShowsRouter.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit

protocol ListOfShowsRoutingLogic {
    func routeToDisplayShowDetails(indexPath: IndexPath, navigationController: UINavigationController?)
}

protocol ListOfShowsDataPassing {
    var dataSource: ListOfShowsDataSource? { get }
}

class ListOfShowsRouter: ListOfShowsDataPassing {
    weak var viewController: ListOfShowsViewController?
    var dataSource: ListOfShowsDataSource?
  
  
    // MARK: Passing Data
    func passDataToShowDetails(indexPath: IndexPath, source: ListOfShowsDataSource, destination: inout ShowDetailsDataSource) {
        destination.showDataSource = source.showsDataSource![indexPath.row]
    }
    
    // MARK: Navigation
    func navigateToShowOrder(navigationController: UINavigationController, destination: ShowDetailsViewController) {
        navigationController.pushViewController(destination, animated: true)
    }
}

extension ListOfShowsRouter: ListOfShowsRoutingLogic {
    
    func routeToDisplayShowDetails(indexPath: IndexPath, navigationController: UINavigationController?) {
        let destinationVC: ShowDetailsViewController = R.storyboard.main.kShowDetailsViewController()!
        destinationVC.router!.dataSource!.showDataSource = dataSource!.showsDataSource![indexPath.row]
        navigateToShowOrder(navigationController: navigationController!, destination: destinationVC)
    }
    
    
}
