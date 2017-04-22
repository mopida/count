//
//  ViewController.swift
//  PhotoMaster2
//
//  Created by nanako on 2017/04/21.
//  Copyright © 2017年 nanako. All rights reserved.
//

import UIKit
import Accounts //snsアップロードに使う

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //写真表示用 ImageView
    @IBOutlet var photoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //「カメラ」ボタンを押した時に呼ばれるメゾット
    @IBAction func onTappedCameraButton(){
        presentPickerController(sourceType: .camera)
    }
    
    //「アルバム」ボタンを押した時に呼ばれるメゾット
    @IBAction func onTappedAlbumButton(){
        presentPickerController(sourceType: .photoLibrary)
    }
    
    //カメラ、アルバムの呼び出しメゾット（カメラorアルバムのソースタイプが引数）
    func presentPickerController(sourceType: UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    //写真が選択された時に呼び出されるメゾッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {self.dismiss(animated: true, completion: nil)
        
        //画像を出力
        photoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        
    }
    
 
        //　元の画像にイラストを合成するメソッド
        func drawMaskImage(image: UIImage) ->UIImage {
            
        //マスク画像（保存場所：PhotoMaster > Assets.xcassets)の設定
        let maskImage = UIImage(named: "sakura")!
        
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(x: 0,y: 0, width: image.size.width,height: image.size.height))
        
        let margin: CGFloat = 50.0
        let maskRect = CGRect(x: image.size.width - maskImage.size.width - margin,
                              y: image.size.width - maskImage.size.width - margin,
                              width: maskImage.size.width,height: maskImage.size.height)
        
        maskImage.draw(in: maskRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    

        //テキストの内容の設定
        let text = "LifeisTech!\niPhoneアプリ開発コース"
    
        // textFontAttributes: 文字の特性[フォントとサイズ、カラー、スタイル]　の設定
        let textFontAttributes = [
            NSFontAttributeName: UIFont(name: "Arial", size: 120)!,
            NSForegroundColorAttributeName: UIColor.red]
    
    //　元の画像にテキストを合成するメソッド
    func drawTaxt(image: UIImage) ->UIImage {
        
        
                //グラフィックコンテキスト生成、編集を開始
    UIGraphicsBeginImageContext(image.size)
        
        //読み込んだ写真を書き出す
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        //定　CGRect([左からのx座標]px,[上からのy座標]px,[縦の長さ]px,[横の長さ]px)
        let margin: CGFloat = 5.0 //余白
        let textRect = CGRect(x: margin, y: margin, width: image.size.width - margin, height: image.size.height - margin)
        
        //textRectで指定した範囲にtextFontAttributesにしたがってtextを書き出す
                text.draw(in: textRect, withAttributes: textFontAttributes)
        
        //グラフィックコンテキストの画像を取得　
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //グラフィックコンテキストの編集の終了
        UIGraphicsEndImageContext()
        
        return newImage!
        
}
    //「テキスト合成」ボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedTextButton(){
        if photoImageView.image != nil{
            photoImageView.image = drawTaxt(image: photoImageView.image!)
        }else{
            print("画像がありません")
        }
        }
    
    //「イラスト合成」ボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedIllustButton(){
        if photoImageView.image != nil{
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        }else{
            print("画像がありません")
        }
        }
   //アップロードボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedUploadButton(){
        if photoImageView.image != nil{
            //共有するアイテムを設定
            let activityVC = UIActivityViewController(activityItems: [photoImageView.image!,"#PhotoMaster"], applicationActivities: nil)
            self.present(activityVC,animated: true,completion: nil)
        }else{
            print("画像がありません")
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
