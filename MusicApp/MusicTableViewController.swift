//
//  MusicTableViewController.swift
//  MusicApp
//
//  Created by masonjheng on 2021/9/4.
//

import UIKit

class MusicTableViewController: UITableViewController {
    var items = [StoreItem]()
    
    func fetchItems(){
        if let urlStr = "https://itunes.apple.com/search?term=林俊傑&media=music".addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed),
        let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, response ,error in
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    do {
                        let searchResponse = try
                        decoder.decode(SearchResponse.self, from: data)
                        self.items = searchResponse.results
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    } catch {
                        
                    }
                }
            }.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchItems()
    }
    
    
    @IBSegueAction func showDetail(_ coder: NSCoder) -> SongDetailViewController? {
        if let row = tableView.indexPathForSelectedRow?.row{
            return SongDetailViewController(coder: coder, item: items[row])
        }else{
            return nil
        }
        
    }
    
    // MARK: - Table view data source

 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongTableViewCell
        let item = items[indexPath.row]
//        cell.textLabel?.text = item.trackName
//        cell.detailTextLabel?.text = item.artistName
        cell.nameLabel.text = item.trackName
        
        cell.photoImageView.image = nil
        URLSession.shared.dataTask(with: item.artworkUrl100) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    //cell.imageView?.image = UIImage(data: data)
                    cell.photoImageView.image = UIImage(data: data)
                }
                
            }
        }.resume()
        
        
        return cell
    }
    

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

}
