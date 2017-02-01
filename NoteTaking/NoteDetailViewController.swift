//
//  NoteDetailViewController.swift
//  NoteTaking
//
//  Created by Varun Rathi on 01/02/17.
//  Copyright © 2017 vrat28. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var textView:UITextView!
    var text:String = ""
    
    var masterView:ViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = text
        textView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        masterView.selectedRowText  = textView.text
    }
    
    func setText(newText:String)
    {
        text = newText
        if isViewLoaded
        {
            textView.text = newText
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
