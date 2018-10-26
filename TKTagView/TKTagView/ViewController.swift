//
//  ViewController.swift
//  TKTagView
//
//  Created by Toseef Khilji on 12/10/18.
//  Copyright © 2018 ASApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tagView: TKTagView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tags1 = ["When you", "eliminate","the", "the impossible,","what", "whatever remains,", "however improbable,", "must be", "the truth."]
        tagView.items = tags1
        tagView.selectedIndexes = [1,2,50]
    }

}

