//
//  MediaViewController.swift
//  Alarm_Demo
//
//  Created by Jeegnasa Mudsa on 13/05/24.
//

import UIKit
import MediaPlayer
import AVFoundation

class MediaItems {
    var soundName: String
    var isPlay: Bool
    
    init(soundName: String, isPlay: Bool) {
        self.soundName = soundName
        self.isPlay = isPlay
    }
    
}

class MediaViewController: UITableViewController, MPMediaPickerControllerDelegate, AVAudioPlayerDelegate {
    
    
    
    private let numberOfRingtones = 2
    var mediaItem: MPMediaItem?
    var mediaLabel: String?
    var mediaID: String?
    var isPlay: Bool? = true
    var isPlay1: Bool? = true
    var arrMedia = [MediaItems]()
    
    
    private var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = [MediaItems(soundName: "bell", isPlay: false),MediaItems(soundName: "tickle", isPlay: false)]
        
        arrMedia.append(contentsOf: item)
    }

    override func viewWillDisappear(_ animated: Bool) {
        performSegue(withIdentifier: Identifier.soundUnwindIdentifier, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor =  UIColor.gray
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrMedia.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "RINGTONS"

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: Identifier.musicIdentifier) ?? UITableViewCell(
            style: UITableViewCell.CellStyle.default, reuseIdentifier: Identifier.musicIdentifier)
        if indexPath.section == 0 {
            cell.textLabel?.text = arrMedia[indexPath.row].soundName
        }
        
        
//        if indexPath.section == 0 {
//            if indexPath.row == 0 {
//                cell.textLabel?.text = arrMedia[indexPath.row].soundName
//            }
//            else if indexPath.row == 1 {
//                cell.textLabel?.text = "tickle"
//            }
//
            if cell.textLabel?.text == mediaLabel {
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            }
//        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mediaPicker = MPMediaPickerController(mediaTypes: MPMediaType.anyAudio)

        if indexPath.section == 0 {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
            mediaLabel = cell?.textLabel?.text
            cell?.setSelected(true, animated: true)
            cell?.setSelected(false, animated: true)
            let cells = tableView.visibleCells
            for c in cells {
                let section = tableView.indexPath(for: c)?.section
                if (section == indexPath.section && c != cell) {
                    c.accessoryType = UITableViewCell.AccessoryType.none
                }
            }
            
            if indexPath.row == 0 {
                arrMedia[indexPath.row].isPlay.toggle()
                if arrMedia[indexPath.row].isPlay == true {
                    arrMedia[indexPath.row].isPlay = false
                    playSound("bell")
                }else {
                    audioPlayer?.stop()
                    arrMedia[indexPath.row].isPlay = true
                }
                
            }else {
                arrMedia[indexPath.row].isPlay.toggle()
                if arrMedia[indexPath.row].isPlay == true {
                    arrMedia[indexPath.row].isPlay = false
                    playSound("tickle")
                }else {
                    arrMedia[indexPath.row].isPlay = true
                    audioPlayer?.stop()
                }
            }
        }
    }
    
    
    //MPMediaPickerControllerDelegate
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection:MPMediaItemCollection){
        if !mediaItemCollection.items.isEmpty {
            let aMediaItem = mediaItemCollection.items[0]
        
            self.mediaItem = aMediaItem
            mediaID = (self.mediaItem?.value(forProperty: MPMediaItemPropertyPersistentID)) as? String
            //self.dismiss(animated: true, completion: nil)
        }
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension MediaViewController {
    //AlarmApplicationDelegate protocol
    func playSound(_ soundName: String) {
    
        guard let filePath = Bundle.main.path(forResource: soundName, ofType: "mp3") else {fatalError()}
        let url = URL(fileURLWithPath: filePath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
        } catch let error as NSError {
            audioPlayer = nil
            print("audioPlayer error \(error.localizedDescription)")
            return
            
        }
        
        if let player = audioPlayer {
            player.delegate = self
            player.prepareToPlay()
            //negative number means loop infinity
            player.numberOfLoops = -1
            player.play()
        }
    }
}
