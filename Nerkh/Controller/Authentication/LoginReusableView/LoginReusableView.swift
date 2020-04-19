//
//  ReusableView.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/25/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

protocol LoginReusableViewDelegate: class {
    func gAuthButtonTapped(_ sender: UIButton)
    func phoneAuthButtonTapped(_ sender: UIButton)
}

class LoginReusableView: UIView {

    @IBOutlet weak var loginView: LoginView!
    
    let nibname = "LoginReusableView"
    
    public weak var delegate: LoginReusableViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibname, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    // MARK: - @IBAction
    @IBAction func gAuthButtonTapped(_ sender: UIButton) {
        delegate?.gAuthButtonTapped(sender)
    }
    
    // MARK: - @IBAction
    @IBAction func phoneAuthButtonTapped(_ sender: UIButton) {
        delegate?.phoneAuthButtonTapped(sender)
    }
}
