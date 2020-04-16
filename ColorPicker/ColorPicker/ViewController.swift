//
//  ViewController.swift
//  ColorPicker
//
//  Created by Stephanie Ballard on 4/16/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func changeColor(_ sender: ColorPicker) {
        view.backgroundColor = sender.color
    }
}

