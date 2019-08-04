//
//  ViewController.swift
//  TODOBASE
//
//  Created by Adam Torok on 2019. 08. 03..
//  Copyright © 2019. Adam Torok. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications
var tasks:[Task] = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTask, ChangeButton {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        
        
        func savedata() {
            // saving date - not yet done 
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "Enabled")
            let enabled = defaults.bool(forKey: "Enabled")
            
        }
  
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert,.sound]) {
            (granted,error) in
        }
        let content = UNMutableNotificationContent()
        content.title = "Hey, works to do!"
        content.body = "Please, finish your task today!"
        
        
        
        let  trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 400.0,
            repeats: true)
        
  
      
        
        let uiIdString = UUID().uuidString
        
         let reguest = UNNotificationRequest(identifier: uiIdString, content: content, trigger: trigger)
        
        center.add(reguest) { (error) in
        }

        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        cell.taskNameLabel.text = tasks[indexPath.row].name
        
        if tasks[indexPath.row].checked{
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxFILLED.png"), for: UIControl.State.normal)
            let sound: SystemSoundID = 1016
            AudioServicesPlaySystemSound (sound)


        }
        else{
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxOUTLINE.png"), for: UIControl.State.normal)
        }
        
        cell.delegate = self
        cell.indexP = indexPath.row
        cell.tasks = tasks
        
        return cell
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddTaskController
        vc.delegate = self
    }
    func addTask(name: String) {
            tasks.append(Task(name: name))
        tableView.reloadData()
             
    }
    func changeButton(checked: Bool, index: Int) {
        tasks[index].checked = checked
        tableView.reloadData()
    }
    

}

class Task{
    var name = ""
    var checked = false
    
    convenience init(name:String){
        self.init()
        self.name = name
    }
}
