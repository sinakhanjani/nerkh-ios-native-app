//
//  NetworkViewController.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/9/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit
import NetworkAPI
import Network

// Class NetworkViewController: Responsible for handling specific functionality in the app.class NetworkViewController: UIViewController {
    
    open var shouldReloadDataWhenNecessary: Bool {
        return true
    }
    
    open var showLoadingWhenReloading: Bool {
        return true
    }
    
    open var showLoadingWhenFetching: Bool {
        return true
    }
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
// Variable indicatorView: Stores data relevant to this class.        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.center = view.center
        view.addSubview(indicatorView)
        return indicatorView
    }()
    
    private let disposeBag = DisposeBag()
    private var status: NWPath.Status = .unsatisfied
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(requestForReloading: false)
        if shouldReloadDataWhenNecessary {
            addFetchingObserver()
        }
// Variable monitor: Stores data relevant to this class.        let monitor = NWPathMonitor()
// Variable queue: Stores data relevant to this class.        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
// Variable _:Bool: Stores data relevant to this class.            let _:Bool = path.usesInterfaceType(.cellular)
            if path.status == .satisfied {
                self.status = path.status
            }
        }
    }
    
    private func addFetchingObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(tryForData), name: Notification.Name("tryForData"), object: nil)
    }
    
    @objc private func tryForData() {
        if shouldReloadDataWhenNecessary {
            if showLoadingWhenReloading && showLoadingWhenFetching { showLoading() }
            reloadData()
        }
    }
    
    private func handleRequestByUI<V,T>(_ network: Network<V,T>,success: @escaping (V) -> Void,error: ((Error)->Void)? = nil) {
        guard self.status != .unsatisfied else {
            self.handleConnectionErrors(error: NetworkErrors.network)
            return
        }
        network.attack { [unowned self] (result) in
            result.ifSuccess { response in
                if self.showLoadingWhenFetching == true || self.showLoadingWhenReloading == true {
                    self.dismissLoading()
                }
                success(response)
            }
            result.ifFailed { (resError) in
                if self.showLoadingWhenFetching == true  || self.showLoadingWhenReloading == true {
                    self.dismissLoading()
                }
                self.handleConnectionErrors(error: resError)
                error?(resError)
            }
        }
        .disposed(by: disposeBag)
    }
    
    @objc func fetchData (requestForReloading reloading : Bool) {
// Variable isMethodXOverridden: Stores data relevant to this class.        let isMethodXOverridden = self.method(for: #selector(fetchData)) != NetworkViewController.instanceMethod(for: #selector(fetchData))
        if !isMethodXOverridden {
            // called from appViewController Class (this method does not implemenet in subClass)
        }
        else {
            if showLoadingWhenFetching && (!reloading) { showLoading() }
        }
    }
    
    private func reloadData() {
        fetchData(requestForReloading: true)
    }
    
    internal func showLoading() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    internal func dismissLoading() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    internal func handleConnectionErrors(error: Error) {
        switch error {
        case NetworkErrors.NotFound:
            break;
        case NetworkErrors.Unathorized:
            break;
        case NetworkErrors.InternalError:
            break;
        case NetworkErrors.BadURL:
            break;
        case NetworkErrors.BadRequest:
            break;
        case NetworkErrors.TimeOuted:
            // you should call 'NotificationCenter.default.post(name: .tryForData, object: nil)' to refresh all view controllers
            break
        case NetworkErrors.json:
            break
        default:
            break
        }
    }
    
    deinit {
        print("deinit: \(String(describing: self))")
    }
}
