//
//  ViewController.swift
//  MyMap
//
//  Created by Kakeru Nakabachi on 2018/03/14.
//  Copyright © 2018年 kakeru nakabachi. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        inputText.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var dispMap: MKMapView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        // 入力された文字取り出す
        if let searchKey = textField.text {
            print(searchKey)
            
            // CLGeocoderインスタンスを取得
            let geocoder = CLGeocoder()
            
            // 入力された文字から位置情報を取得
            geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks, error) in
                
                // 位置情報が存在する場合はunwrapPlacemarksに取り出す
                if let unwrapPlacemarks = placemarks {
                    
                    // 1件目の情報を取り出す
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
                        // 位置情報を取り出す
                        if let location = firstPlacemark.location {
                            
                            // 位置情報から緯度経度をtargetCoordinateに取り出す
                            let targetCoordinate = location.coordinate
                            
                            print(targetCoordinate)
                        }
                    }
                }
            })
        }
        
        return true
    }
}

