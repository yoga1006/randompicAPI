//
//  PicViewController.swift
//  randompicAPI
//
//  Created by Yoga on 2022/9/30.
//

import UIKit

class PicViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(systemName: "photo.artframe")
        // Do any additional setup after loading the view.
    }
    
    //抓取圖片API
    func fetchPic(){
        
        //讀取欲抓的資料url
        let urlString = "https://picsum.photos/200/300"
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    //主執行緒執行Main thread
                    DispatchQueue.main.sync {
                        self.imageView.image=UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    //編輯controller Title的function
    func edittitle(){
    
        let controller = UIAlertController(title: "TYPE TITLE", message: "", preferredStyle: .alert)
        //新增可以輸入文字的欄位
        controller.addTextField{ field in
            
        }
        
        let okAction = UIAlertAction(title: "EDIT", style: UIAlertAction.Style.default) { _ in
           
            if let field = controller.textFields?.first{
                if let text = field.text,!text.isEmpty{
                    self.titleLabel.text=text
                }
            }
            
        }
        controller.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        
        present(controller, animated: true, completion: nil)
        
    }
    
    //隨機照片
    @IBAction func changePic(_ sender: UIButton) {
        fetchPic()
        titleLabel.text = ""
    }
    
    //編輯文字
    @IBAction func addTitle(_ sender: UIButton) {
        edittitle()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
