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
                            
                            // MKPointAnnotationインスタンスを取得しピンを生成
                            let pin = MKPointAnnotation()
                            
                            // ピンの置く場所に緯度経度を設定
                            pin.coordinate = targetCoordinate
                            
                            // ピンのタイトルを設定
                            pin.title = searchKey
                            
                            // ピンを地図に置く
                            self.dispMap.addAnnotation(pin)
                            
                            // 緯度経度を中心にして半径500mの範囲を表示
                            self.dispMap.region = MKCoordinateRegionMakeWithDistance(targetCoordinate, 500.0, 500.0)
                        }
                    }
                }
            })
        }
        
        return true
    }
    
    @IBAction func changeMapButtonAction(_ sender: Any) {
        // mapTypeプロパティー値をトグル
        // 標準(.standard)→航空写真(.satellite)→航空写真+標準(.hybrid)
        // →3D Flyover(.satelliteFlyover)→3D Flyover+標準(.hybridFlyover)
        if dispMap.mapType == .standard {
            dispMap.mapType = .satellite
        } else if dispMap.mapType == .satellite {
            dispMap.mapType = .hybrid
        } else if dispMap.mapType == .hybrid {
            dispMap.mapType = .satelliteFlyover
        } else if dispMap.mapType == .satelliteFlyover {
            dispMap.mapType = .hybridFlyover
        } else {
            dispMap.mapType = .standard
        }
    }
    
    
}

