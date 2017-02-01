//
//  ViewController.swift
//  NoteTaking
//
//  Created by Varun Rathi on 31/01/17.
//  Copyright © 2017 vrat28. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView:UITableView!
    
    var selectedRow: Int = -1
    var data:[String] = []
    var file:String!
    var selectedRowText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //navigationItem.title =  "Notes"
        self.title = "Notes"
        
        let addBtn = UIBarButtonItem(barButtonSystemItem:.add, target: self, action: #selector(addNote))
        navigationItem.rightBarButtonItem = addBtn
        
       
        self.navigationItem.leftBarButtonItem = editButtonItem
        getDocumentDirectory()
        loadFile()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(selectedRow == -1)
        {
            return;
        }
        
        data[selectedRow] = selectedRowText
        if selectedRowText == " "
        {
            data.remove(at: selectedRow)
            
        }
        
        tableView.reloadData()
        saveFile()
    }
    
    func getDocumentDirectory()
    {
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        file = docDir[0].appending("/data.txt")
        
        
    }
    
    func addNote()
    {
        
        if(tableView.isEditing) {return}

        
        let item:String  = " "
        data.insert(item, at: 0)
        let indexpath:IndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexpath], with: .automatic)
        tableView.selectRow(at: indexpath, animated: true, scrollPosition: .bottom)
        self.performSegue(withIdentifier: "show", sender: nil)
       // saveFile()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "cell"
       let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!
       
        
       cell.textLabel?.text = data[indexPath.row]
       return cell
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        saveFile()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
      //  selectedRow = indexPath.row
        self.performSegue(withIdentifier: "show", sender: nil)
    }
    
    func save()
    {
        UserDefaults.standard.set(data, forKey: "notes")
        UserDefaults.standard.synchronize()
        
        
    }
    
    func load()
    {
        if let loadedData = UserDefaults.standard.value(forKey: "notes") as? [String]
        {
            data = loadedData
            tableView.reloadData()
        }
    }
    
    func saveFile()
    {
        let dataToStore:NSArray = NSArray(array: data)
        let status:Bool = dataToStore.write(toFile: file, atomically: true)
        print(status)
        
    }
    func loadFile()
    {
        if let loadedData = NSArray(contentsOfFile: file) as? [String]
        {
            data = loadedData
            tableView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "show"
        {
            let noteDetailVC = segue.destination as! NoteDetailViewController
            selectedRow = tableView.indexPathForSelectedRow!.row
            noteDetailVC.masterView = self
            noteDetailVC.setText(newText: data[selectedRow])
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

