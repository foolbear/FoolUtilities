//
//  FoolAudioManager.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/3/19.
//

import Foundation
import MediaPlayer
import SwiftyTimer

public enum AudioState {
    case idleInit
    case playing, paused, idleAfterPlay
    case recording, idleAfterRecord
}

public enum PlaySource { case fromData, fromRecFile }

public enum PlayRate: Float, CaseIterable, Hashable, Identifiable {
    case slow = 0.5, normal = 1, quick = 2
    public var id: PlayRate { self }
    func icon() -> String {
        switch self {
        case .slow: return "tortoise"
        case .normal: return "person"
        case .quick: return "hare"
        }
    }
}

@available(iOS 13.0, *)
public class FoolAudioManager: NSObject, ObservableObject {
    static let shared = FoolAudioManager()
    var filePath: String = ""
    var albumImage: UIImage = UIImage()
    var player: AVAudioPlayer?
    var recorder: AVAudioRecorder?
    var playTitle: String? = nil
    var recFile: String? = nil
    var duration: Double = 0
    var power: Double = 0
    var playSoruce: PlaySource = .fromData
    @Published var playData: Data? = nil
    @Published var isForPlayer: Bool = false
    @Published var state: AudioState = .idleInit
    @Published var rate: PlayRate = .normal { didSet { setPlayRate() } }
    @Published var currentTime: Double = 0
    
    private override init() {
        super.init()
        Timer.every(0.2.seconds) { self.update() }
    }
    
    deinit {}
    
    func setup(filePath path: String, andAlbumImage album: UIImage) { filePath = path; albumImage = album }
    
    func update() {
        switch state {
        case .playing:
            power = getAudioPlayPower()
            currentTime = getAudioPlayCurrentTime()
        case .recording:
            power = getAudioRecordPower()
            currentTime = getAudioRecordCurrentTime()
        default:
            break
        }
    }
    
    func reset(withPlayData playData: Data? = nil, title playTitle: String? = nil, andDuration duration: Double? = nil) {
        stopAudioPlay()
        stopAudioRecord()
        
        if let playData = playData {
            state = .idleAfterRecord
            self.playData = playData
            self.playTitle = playTitle
            self.duration = duration ?? 0
            self.recFile = nil
        } else {
            state = .idleInit
            self.playData = nil
            self.playTitle = nil
            self.duration = 0
            self.recFile = nil
        }
        rate = .normal
        power = 0
        currentTime = 0
    }
    
    func setPlayRate() {
        guard let player = player else { return }
        player.rate = rate.rawValue
        updateNowPlayingCenter()
    }
    
    func updateNowPlayingCenter() {
        let albumArt = MPMediaItemArtwork.init(boundsSize: albumImage.size, requestHandler: { (size) -> UIImage in return self.albumImage })
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle: playTitle ?? "-",
            MPMediaItemPropertyArtwork: albumArt,
            MPMediaItemPropertyPlaybackDuration: getAudioPlayDuration(),
            MPNowPlayingInfoPropertyElapsedPlaybackTime: getAudioPlayCurrentTime(),
            MPNowPlayingInfoPropertyPlaybackRate: getAudioPlayRate()
        ]
    }
    
    func showPlayer() -> Bool {
        return isForPlayer && playData != nil
    }
}

@available(iOS 13.0, *)
extension FoolAudioManager: AVAudioPlayerDelegate {
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch {
            foolPrint("AVAudioSession setActive(false) error")
        }
        state = .idleAfterPlay
        power = 0
        currentTime = 0
        updateNowPlayingCenter()
    }
    
    func preparePlayAudioFile(_ filename: String) -> Bool {
        let path = filePath + filename
        let fm = FileManager.default
        guard fm.fileExists(atPath: path) else {
            foolPrint("Audio file(\(path)) does not exist.")
            return false
        }
        
        if let player = player, player.isPlaying {
            player.stop()
        }
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playback)
            try session.setActive(true)
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        } catch {
            foolPrint("AVAudioPlayer create error")
            return false
        }
        
        guard let player = player else { return false }
        player.isMeteringEnabled = true
        player.delegate = self
        player.enableRate = true
        player.prepareToPlay()
        playTitle = filename
        currentTime = 0
        updateNowPlayingCenter()
        return true
    }
    
    func preparePlayAudio(_ data: Data?) -> Bool {
        guard let data = data else { return false }
        if let player = player, player.isPlaying { player.stop() }
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playback)
            try session.setActive(true)
            try player = AVAudioPlayer(data: data)
        } catch {
            foolPrint("AVAudioPlayer create error")
            return false
        }
        
        guard let player = player else { return false }
        player.isMeteringEnabled = true
        player.delegate = self
        player.enableRate = true
        player.prepareToPlay()
        playData = data
        currentTime = 0
        updateNowPlayingCenter()
        return true
    }
    
    func playAudio() {
        guard let player = player else { return }
        guard !player.isPlaying else { return }
        player.play()
        state = .playing
        power = 0
        duration = getAudioPlayDuration()
        updateNowPlayingCenter()
    }
    
    func playAudioAt(_ timestamp: TimeInterval) {
        guard let player = player else { return }
        player.currentTime = timestamp
        if !player.isPlaying {
            player.play()
        }
        state = .playing
        currentTime = timestamp
        updateNowPlayingCenter()
    }
    
    func playAudioOffset(_ offset: TimeInterval) {
        guard let player = player else { return }
        let duration = player.duration - 1
        let currentTime = player.currentTime
        var timestamp = currentTime + offset
        if timestamp > duration { timestamp = duration }
        if timestamp < 0 { timestamp = 0 }
        playAudioAt(timestamp)
    }
    
    func pauseAudioPlay() {
        guard let player = player else { return }
        guard player.isPlaying else { return }
        player.pause()
        state = .paused
        power = 0
        updateNowPlayingCenter()
    }
    
    func stopAudioPlay() {
        guard let player = player else { return }
        guard player.isPlaying else { return }
        player.stop()
        
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch {
            foolPrint("AVAudioSession setActive(false) error")
        }
        state = .idleAfterPlay
        power = 0
        currentTime = 0
        updateNowPlayingCenter()
    }
}

@available(iOS 13.0, *)
extension FoolAudioManager {
    func getAudioPlayCurrentTime() -> Double {
        guard let player = player else { return 0 }
        return player.currentTime
    }
    
    func getAudioPlayDuration() -> Double {
        guard let player = player else { return 0 }
        return player.duration
    }
    
    func getAudioPlayRate() -> Float {
        guard let player = player else { return 0 }
        return player.rate
    }
    
    func getAudioPlayPower() -> Double {
        guard let player = player else { return 0 }
        player.updateMeters()
        let power = player.peakPower(forChannel: 0)
        return FoolAudioManager.nicePower(power)
    }
}

@available(iOS 13.0, *)
extension FoolAudioManager: AVAudioRecorderDelegate {
    public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch {
            foolPrint("AVAudioSession setActive(false) error")
        }
        state = .idleAfterRecord
        duration = currentTime
        currentTime = 0
        power = 0
    }
    
    func recordAudio(_ filename: String) {
        if let recorder = recorder {
            if recorder.isRecording {
                recorder.stop()
            }
        }
        let recordSettings = [
            AVSampleRateKey : NSNumber(value: Float(44100.0) as Float),
            AVFormatIDKey : NSNumber(value: Int32(kAudioFormatMPEG4AAC) as Int32),
            AVNumberOfChannelsKey : NSNumber(value: 1 as Int32),
            AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.medium.rawValue) as Int32)]
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord)
            try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
            try session.setActive(true)
            try recorder = AVAudioRecorder(url: URL(fileURLWithPath: filePath + filename), settings: recordSettings)
        } catch {
            foolPrint("AVAudioRecorder create error")
            return
        }
        
        guard let recorder = recorder else {
            foolPrint("AVAudioRecorder is nil")
            return
        }
        recorder.isMeteringEnabled = true
        recorder.delegate = self
        recorder.prepareToRecord()
        recorder.record(forDuration: 60.0*60.0)
        state = .recording
        recFile = filename
        power = 0
        currentTime = 0
        duration = 0
    }
    
    func stopAudioRecord() {
        guard let recorder = recorder else { return }
        guard recorder.isRecording else { return }
        recorder.stop()
    }
}

@available(iOS 13.0, *)
extension FoolAudioManager {
    func getAudioRecordCurrentTime() -> Double {
        guard let recorder = recorder else { return 0 }
        return recorder.currentTime
    }
    
    func getAudioRecordPower() -> Double {
        guard let recorder = recorder else { return 0 }
        recorder.updateMeters()
        let power = recorder.peakPower(forChannel: 0)
        return FoolAudioManager.nicePower(power)
    }
}

@available(iOS 13.0, *)
extension FoolAudioManager {
    class func nicePower(_ power: Float) -> Double {
        var nicePower: Float = 0.0
        let minDb: Float = -80.0
        let peakDb = power
        if (peakDb < minDb) {
            nicePower = 0.0
        } else if (peakDb >= 0) {
            nicePower = 1.0
        } else {
            let root: Float = 2.0
            let amp = powf(10.0, 0.05 * peakDb)
            let minAmp = powf(10.0, 0.05 * minDb)
            let inverseAmpRange = 1.0 / (1.0 - minAmp)
            let adjAmp = (amp - minAmp) * inverseAmpRange
            nicePower = powf(adjAmp, 1.0 / root)
        }
        return Double(nicePower)
    }
    
    class func getAudioFileDuration(path: String) -> Double {
        let asset = AVURLAsset(url: URL(fileURLWithPath: path))
        let ct_duration = asset.duration
        return CMTimeGetSeconds(ct_duration)
    }
    
    class func generateAudioFileName() -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let filename = formatter.string(from: currentDateTime) + "-\(UUID().uuidString).caf"
        return filename
    }
}
