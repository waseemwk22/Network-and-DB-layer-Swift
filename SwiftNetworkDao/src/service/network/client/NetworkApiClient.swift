//
// NetworkApiClient.swift
// Created by waseem on 10/1/19
//

import UIKit
import Alamofire
import SwiftyJSON

typealias ResponseHandler = (ApiResponse) -> Void

class NetworkApiClient {

    func callApi<T>(request: ApiRequest<T>, responseHandler: @escaping ResponseHandler) {

        let urlRequest = urlRequestWith(apiRequest: request)
        AF.request(urlRequest).responseData { (response) in
            switch(response.result) {
            case .success:
                let apiResponse = self.successResponse(request: request, response: response)
                responseHandler(apiResponse)
            case .failure:
                self.failureResponse(response: response)
            }
        }
    }

    func urlRequestWith<T>(apiRequest: ApiRequest<T>) -> URLRequest {
        let  completeUrl = apiRequest.webserviceUrl() + apiRequest.apiPath() +
            apiRequest.apiVersion() + apiRequest.apiResource() + apiRequest.endPoint()

        var urlRequest = URLRequest(url: URL(string: completeUrl)!)
        urlRequest.httpMethod = apiRequest.requestType().rawValue
        urlRequest.setValue(apiRequest.contentType(), forHTTPHeaderField:  "Content-Type")
        urlRequest.httpBody = try?JSONSerialization.data(withJSONObject:  apiRequest.bodyParams()!, options: [])
        return urlRequest
    }

    // here we are going to parse the data
    func successResponse<T: Codable>(request: ApiRequest<T>,
                                     response: AFDataResponse<Data>) -> ApiResponse{
        do {
            // Step 1
            let responseJson = try JSON(data: response.data!)
            // Step 2
            let dataJson = responseJson["data"].object
            let data = try JSONSerialization.data(withJSONObject: dataJson,
                                                  options: [])
            // Step 3
            let decodedValue = try JSONDecoder().decode(T.self, from: data)

            return ApiResponse(success: true, data: decodedValue as AnyObject)
            
        } catch {
            return ApiResponse(success: false)
        }
    }

    func failureResponse(response: AFDataResponse<Data>) {
        // do something here
    }

}
