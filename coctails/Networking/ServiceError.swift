//
//  ServiceError.swift
//  coctails
//
//  Created by Macbook Air on 11.09.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

enum ServiceError: Error {
    case decoding, buildingRequest, network, creatingUrl
}

extension ServiceError {
    var alert: UIAlertController {
        let message: String
        
        switch self {
        case .network:
            message = "Check your network connection, or try again later"
        default:
            message = "Something went wrong :("
        }
        
        let alert = UIAlertController(title: "Opps", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
}
