//
// ApiResponse.swift
// Created by waseem on 10/1/19
//

import UIKit

class ApiResponse {
    var success: Bool!   // whether the API call passed or failed
    var message: String? // message returned from the API
    var data: AnyObject? // actual data returned from the API

    init(success: Bool, message: String? = nil, data: AnyObject? = nil) {
        self.success = success
        self.message = message
        self.data = data
    }
}
