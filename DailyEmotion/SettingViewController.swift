//
//  SettingViewController.swift
//  DailyEmotion
//
//  Created by 이충현 on 2021/03/13.
//

import UIKit

class SettingViewController: UITableViewController {

    
    @IBOutlet weak var darkModeSelect: UISegmentedControl!
    @IBOutlet weak var versionInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let plist = UserDefaults.standard
         
        darkModeSelect.selectedSegmentIndex = plist.integer(forKey: "darkModeSelect")
        if darkModeSelect.selectedSegmentIndex == 0 {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = UIUserInterfaceStyle.unspecified

        } else if darkModeSelect.selectedSegmentIndex == 1 {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        } else {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = UIUserInterfaceStyle.dark
        }
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        versionInfo.text = " \(appVersion!) Vesion"

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
              return 1
          } else if section == 1 {
              return 4
          } else if section == 2{
            return 1
          } else {
            return 0
          }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func darkModeSelect(_ sender: UISegmentedControl) {
                if sender.selectedSegmentIndex == 0 {
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = UIUserInterfaceStyle.unspecified
                } else if sender.selectedSegmentIndex == 1 {
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
                 } else {
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = UIUserInterfaceStyle.dark
                }
   
                
                let plist = UserDefaults.standard
                let value = sender.selectedSegmentIndex
                plist.set(value, forKey: "darkModeSelect")
                plist.synchronize()
        }
        
           

    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
}
