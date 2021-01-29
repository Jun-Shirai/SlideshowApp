//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 白井淳 on 2021/01/28.
//

import UIKit

class ViewController: UIViewController {
    //接続
    @IBOutlet weak var imageView: UIImageView!//画像
    @IBOutlet weak var startButton: UIButton!//再生・停止
    @IBOutlet weak var advanceButton: UIButton!//進む
    @IBOutlet weak var returnButton: UIButton!//戻る
    
    var nowIndex = 0
    var timer: Timer!
    //画像の配列宣言
    var imageArry: [UIImage] = [
         UIImage(named: "neko1.jpg")!,
         UIImage(named: "neko2.jpg")!,
         UIImage(named: "neko3.jpg")!
    ]
    
    //再生・停止
    @IBAction func showButton(_ sender: Any) {
        if (timer == nil) {
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
            
            startButton.setTitle("停止", for: .normal)
            advanceButton.isEnabled = false
            returnButton.isEnabled = false
        }else {
            timer.invalidate()
            timer = nil
            
            startButton.setTitle("再生", for: .normal)
            advanceButton.isEnabled = true
            returnButton.isEnabled = true
        }
    }
    
    //再生時に呼ばれる関数
    @objc func changeImage() {
        nowIndex += 1
        
        if (nowIndex == imageArry.count) {
            nowIndex = 0
        }
        imageView.image = imageArry[nowIndex]
    }
    
    //進む
    @IBAction func advanceImage(_ sender: Any) {
        if (nowIndex == 0) {
            nowIndex = 1
        }else if (nowIndex == 1) {
            nowIndex = 2
        }else if (nowIndex == 2) {
            nowIndex = 0
        }
        imageView.image = imageArry[nowIndex]
    }
    
    //戻る
    @IBAction func returnImage(_ sender: Any) {
        if (nowIndex == 0) {
            nowIndex = 2
        }else if (nowIndex == 2) {
            nowIndex = 1
        }else if (nowIndex == 1) {
            nowIndex = 0
        }
        imageView.image = imageArry[nowIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.image = imageArry[0]
    }
    //セグエ実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //遷移するとき、再生中の場合は停止する
        if (timer != nil) {
            timer.invalidate()
            timer = nil
            startButton.setTitle("再生", for: .normal)
            advanceButton.isEnabled = true
            returnButton.isEnabled = true
        }else {
            //停止中のときはそのまま遷移
        }
        
        //遷移先のコントローラーを取得
        let expansionViewController:ExpansionViewController = segue.destination as! ExpansionViewController
        //遷移先に渡す値を設定
        expansionViewController.image = imageArry[nowIndex]
    }
    
    @IBAction func tapImage(_ sender: UIStoryboardSegue) {
    }
    
    

}

