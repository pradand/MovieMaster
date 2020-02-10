//
//  ErrorView.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 08/02/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

class ErrorView: UIView {

    @IBOutlet weak var errorLabel: UILabel!
    weak var errorViewDelegate: ErrorViewDelegate?
    private var notificationCenter: NotificationCenter = NotificationCenter.default
    public var errorViewModel: ErrorViewModel? {
        didSet {
            errorLabel.text = self.errorViewModel?.getText()
        }
    }

    @IBAction func retry(_ sender: Any) {
        notificationCenter.post(name: .errorViewRetry, object: nil)
        errorViewDelegate?.retryOnError()
    }

    override init(frame: CGRect) {
         super.init(frame: frame)
         commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         commonInit()
    }

    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: String(describing: ErrorView.self), bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
