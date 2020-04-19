# Use the keyboard shortcut shift-command-L (⇧⌘L) to open the library. This opens the snippet browser in the source editor or the object browser in Interface Builder.

#  <#-#>  <,#,type something,#>


# MARK: - Network WebSocket
private var webSocketTask: URLSessionWebSocketTask!
func websocket() {
    let urlSession = URLSession(configuration: .default)
    let webSocketTask = urlSession.webSocketTask(with: URL(string: "ws://194.5.207.132/echo-test")!)
    webSocketTask.resume()
    let message = URLSessionWebSocketTask.Message.string("hello/dear")
    webSocketTask.send(message) { error in
      if let error = error {
        print("WebSocket couldn’t send message because: \(error)")
      }
    }
    func readMessage() {
        webSocketTask.receive { result in
          switch result {
          case .failure(let error):
            print("Error in receiving message: \(error)")
          case .success(let message):
            switch message {
            case .string(let text):
              print("Received string: \(text)")
            case .data(let data):
              print("Received data: \(data)")
            default:
                break
            }
            readMessage()
          }
        }
    }
}

func nerkhSocket() {
    let urlSession = URLSession(configuration: .default)
    let webSocketTask = urlSession.webSocketTask(with: URL(string: "ws://194.5.207.132/listen/currency")!)
    webSocketTask.resume()
    func readMessage() {
        webSocketTask.receive { result in
          switch result {
          case .failure(let error):
                print("Error in receiving message: \(error)")
          case .success(let message):
            switch message {
            case .string(let text):
                print("Received string: \(text)")
            case .data(let data):
                let str = String(data: data, encoding: .utf8)!
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "SocketConnection", message: str, preferredStyle: .alert)
                    self.present(alertVC, animated: true, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+6.8) {
                        alertVC.dismiss(animated: true, completion: nil)
                    }
                }
                print("Received data: \(data)")
            default:
                break
            }
            readMessage()
          }
        }
    }
    readMessage()
}

// Send Ping
func sendPing() {
let urlSession = URLSession(configuration: .default)
self.webSocketTask = urlSession.webSocketTask(with: URL(string: "ws://194.5.207.132/echo-test")!)
  webSocketTask.sendPing { (error) in
    if let error = error {
      print("Sending PING failed: \(error)")
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
      self.sendPing()
    }
  }
}

// Close Connection
func close() {
    webSocketTask.cancel(with: .goingAway, reason: nil)
}

extension ChartsViewController: URLSessionWebSocketDelegate {
    /// connection disconnected
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("#1")
    }
    // connection established
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("#2")
    }
}

