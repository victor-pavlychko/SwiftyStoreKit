//
//  InAppReceiptRefreshRequest.swift
//  SwiftyStoreKit
//
//  Created by phimage on 23/12/15.
// Copyright (c) 2015 Andrea Bizzotto (bizz84@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import StoreKit
import Foundation

#if os(iOS)
    class InAppReceiptRefreshRequest: NSObject, SKRequestDelegate {

        enum ResultType {
            case Success
            case Error(e: NSError)
        }

        typealias RequestCallback = (result: ResultType) -> ()

        class func refresh(receiptProperties: [String : AnyObject]? = nil, callback: RequestCallback) -> InAppReceiptRefreshRequest {
            let request = InAppReceiptRefreshRequest(receiptProperties: receiptProperties, callback: callback)
            request.start()
            return request
        }

        let refreshReceiptRequest: SKReceiptRefreshRequest
        let callback: RequestCallback

        init(receiptProperties: [String : AnyObject]? = nil, callback: RequestCallback) {
            self.callback = callback
            self.refreshReceiptRequest = SKReceiptRefreshRequest(receiptProperties: receiptProperties)
            super.init()
            self.refreshReceiptRequest.delegate = self
        }

        func start() {
            self.refreshReceiptRequest.start()
        }

        func requestDidFinish(request: SKRequest) {
            /*if let resoreRequest = request as? SKReceiptRefreshRequest {
                let receiptProperties = resoreRequest.receiptProperties ?? [:]
                for (k, v) in receiptProperties {
                    print("\(k): \(v)")
                }
            }*/
            callback(result: .Success)
        }
        func request(request: SKRequest, didFailWithError error: NSError) {
            // XXX could here check domain and error code to return typed exception
            callback(result: .Error(e: error))
        }
        
    }
#endif