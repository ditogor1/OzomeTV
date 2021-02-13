//
//  ShowDetailsRouter.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit

protocol ShowDetailsDataPassing {
    //TODO: FIXED WITH SET ???
    var dataSource: ShowDetailsDataSource? { get set }
}

class ShowDetailsRouter: ShowDetailsDataPassing {
    weak var viewController: ShowDetailsViewController?
    var dataSource: ShowDetailsDataSource?
}


