//
//  ViewController.swift
//  EYSlider
//
//  Created by Etjen Ymeraj on 3/25/18.
//  Copyright © 2018 Etjen Ymeraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: CustomSlider!
    
    let cSlider = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        slider.frame = CGRect(x: 20.0, y: 20.0, width: 100.0, height: 100.0)
        slider.addTarget(self, action: #selector(ViewController.sliderValueChanged(_:)), for: UIControlEvents.valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func sliderValueChanged(_ sender: Any){
        print("\(slider.value)")
    }
    

}

