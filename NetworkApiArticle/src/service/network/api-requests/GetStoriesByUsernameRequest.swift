//
// GetStoriesByUsernameRequest.swift
// Created by waseem on 10/1/19
//

import Foundation

class GetStoriesByUsernameRequest: ApiRequest<[Story]> {

    var username: String!
    var limit: Int?
    var pageNumber: Int?

    override func apiResource() -> String {
        return "stories/"
    }

    override func endPoint() -> String {
        return username
    }

    override func bodyParams() -> NSDictionary? {
        return ["limit": limit!,
                "pageNumber": pageNumber!]
    }

    override func requestType() -> HTTPMethod {
        return .get
    }

}


