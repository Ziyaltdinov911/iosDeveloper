//
//  CameraView.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 15.01.2024.
//

import UIKit
import AVFoundation

protocol CameraViewProtocol: AnyObject {
    
}

class CameraView: UIViewController, CameraViewProtocol {
    
    var presenter: CameraViewPresenterProtocol!
    
    lazy var shotsCollectionView: UICollectionView = {
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 60)
        
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "shotCell")
        $0.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.dataSource = self
        
        return $0
    }(UICollectionView(frame: CGRect(x: 0, y: 60, width: view.frame.width - 110, height: 60), collectionViewLayout: UICollectionViewFlowLayout()))
    
    private lazy var closeBtn: UIButton = {
        $0.setBackgroundImage(UIImage(named: "closeIcon"), for: .normal)
        
        return $0
    }(UIButton(frame: CGRect(x: view.frame.width - 60, y: 60, width: 25, height: 25), primaryAction: presenter.closeViewAction))
    
    private lazy var shotBtn: UIButton = {
        $0.setBackgroundImage(UIImage(named: "shotIcon"), for: .normal)
        
        return $0
    }(UIButton(frame: CGRect(x: view.center.x - 30, y: view.frame.height - 110, width: 60, height: 60), primaryAction: showAction))    
    
    private lazy var switchCameraBtn: UIButton = {
        $0.setBackgroundImage(UIImage(named: "switchCameraIcon"), for: .normal)
        
        return $0
    }(UIButton(frame: CGRect(x: shotBtn.frame.origin.x - 110, y: shotBtn.frame.origin.y + 10, width: 42, height: 35), primaryAction: presenter.switchCamera))
    
    private lazy var nextBtn: UIButton = {
        $0.setTitle("Далее", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 17.5
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.frame.size = CGSize(width: 100, height: 35)
        $0.frame.origin = CGPoint(x: shotBtn.frame.origin.x + 110, y: shotBtn.frame.origin.y + 10)
        
        return $0
    }(UIButton())
    
    private lazy var showAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = .auto
        self.presenter.cameraService.output.capturePhoto(with: photoSettings, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.cameraService.setupCaptureSession()
        navigationController?.navigationBar.isHidden = true
        
        NotificationCenter.default.post(name: .hideTabBar, object: nil, userInfo: ["isHide": true])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermissions()
        setupPreviewLayer()
        
        view.backgroundColor = .gray
        view.addSubview(shotsCollectionView)
        view.addSubview(closeBtn)
        view.addSubview(shotBtn)
        view.addSubview(switchCameraBtn)
        view.addSubview(nextBtn)
    }
    
    private func checkPermissions() {
        let cameraStatusAuth = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraStatusAuth {
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { auth in
                if !auth {
                    abort()
                }
            }
        case .restricted, .denied:
            abort()
        case .authorized:
            return
        default:
            fatalError()
        }
    }
    
    private func setupPreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer(session: presenter.cameraService.captureSession)
        
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
    }
    
    private func getImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.frame.size = CGSize(width: 60, height: 60)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }

}

extension CameraView: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
            print(error!.localizedDescription)
            return
        }
        
        guard let imageDate = photo.fileDataRepresentation() else { return }
        
        if let image = UIImage(data: imageDate) {
            presenter.photos.append(image)
            self.shotsCollectionView.reloadData()
        }
    }
}

extension CameraView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shotCell", for: indexPath)
        
        let photo = presenter.photos[indexPath.item]
        let imageView = self.getImageView(image: photo)
        cell.addSubview(imageView)
        
        return cell
    }
    
}
