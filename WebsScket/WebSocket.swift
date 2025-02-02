//
//  Websocket.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/16/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import Foundation
import SwiftWebSocket
import Network

// Class WebSocket: Responsible for handling specific functionality in the app.class WebSocket {
    
    static let `default` = WebSocket()

    // MARK: - Network WebSocket
    private var webSocketTask: URLSessionWebSocketTask!
    
    public func websocketEcho() {
// Variable urlSession: Stores data relevant to this class.        let urlSession = URLSession(configuration: .default)
// Variable webSocketTask: Stores data relevant to this class.        let webSocketTask = urlSession.webSocketTask(with: URL(string: "ws://194.5.207.132/echo-test")!)
        webSocketTask.resume()
// Variable message: Stores data relevant to this class.        let message = URLSessionWebSocketTask.Message.string("hello/nerkh")
        webSocketTask.send(message) { error in
          if let error = error {
            print("WebSocket couldn’t send message because: \(error)")
          }
        }
    }
    
    public func nerkhsocket(completion: @escaping (_ data: Data) -> Void) {
// Variable urlSession: Stores data relevant to this class.        let urlSession = URLSession(configuration: .default)
        self.webSocketTask = urlSession.webSocketTask(with: URL(string: "ws://194.5.207.132/listen/currency")!)
        webSocketTask.resume()
        income(webSocketTask: webSocketTask, completion: completion)
    }
    
    public func close() {
        webSocketTask.cancel(with: .goingAway, reason: nil)
    }
}

extension WebSocket {
    private func income(webSocketTask: URLSessionWebSocketTask, completion: ((_ data: Data) -> Void)?) {
        webSocketTask.receive { [unowned self = self] result in
          switch result {
          case .failure(let error):
                print("Error in receiving message: \(error)")
          case .success(let message):
            switch message {
            case .string(let text):
                print("Received string: \(text)")
            case .data(let data):
                print("#data: \(data)")
                completion?(data)
            default:
                break
            }
            self.income(webSocketTask: webSocketTask, completion: completion)
          }
        }
    }

    private func sendPing(webSocketTask: URLSessionWebSocketTask) {
// Variable urlSession: Stores data relevant to this class.        let urlSession = URLSession(configuration: .default)
// Variable webSocketTask: Stores data relevant to this class.        let webSocketTask = urlSession.webSocketTask(with: URL(string: "ws://194.5.207.132/echo-test")!)
          webSocketTask.sendPing { (error) in
            if let error = error {
              print("Sending PING failed: \(error)")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.sendPing(webSocketTask: webSocketTask)
            }
          }
    }
}
