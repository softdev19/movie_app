//
//  Protocols.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 07.10.2022.
//

import Foundation

protocol CellDelegate: AnyObject{
    func CellDidTapped(_ cell: TableCell, with model: DetailedVideoModel)
}

protocol ResultCellDelegate: AnyObject{
    func cellTapped(with model: DetailedVideoModel)
}


