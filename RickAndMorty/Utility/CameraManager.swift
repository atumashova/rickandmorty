//
//  Camera.swift
//  RickAndMorty
//
//  Created by Ann on 25.12.2024.
//
import Foundation
import UIKit
import AVFoundation
import PhotosUI

enum AddPhotosType {
    case library
    case camera
    var title: String {
        switch self {
        case .library:
            Constants.deniedLibraryTitle
        case .camera:
            Constants.deniedCameraTitle
        }
    }
    var message: String {
        switch self {
        case .library:
            Constants.deniedLibraryMessage
        case .camera:
            Constants.deniedCameraMessage
        }
    }
}
protocol CameraManagerDelegate: AnyObject {
    func didCaptureImage(_ image: UIImage)
    func didFailWithError(_ error: String)
}

class CameraManager: NSObject {
    static let shared = CameraManager()
    weak var delegate: CameraManagerDelegate?
    private override init() {
        super.init()
    }
    // Проверка доступна ли камера
    func isCameraAvailable() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    // Проверка доступа приложения к камере
    func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { response in
                DispatchQueue.main.async {
                    completion(response)
                }
            }
        case .restricted, .denied:
            DispatchQueue.main.async {
                completion(false)
            }
        case .authorized:
            DispatchQueue.main.async {
                completion(true)
            }
        @unknown default:
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
    // Запрос на доступ к библиотеке фото
    func requestPhotoLibraryPermission(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized || status == .limited {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            }
        case .restricted:
            completion(false)
        case .denied:
            completion(false)
        case .authorized:
            completion(true)
        case .limited:
            completion(true)
        @unknown default:
            completion(false)
        }
    }
    func presentChoosePhotoAlert(from viewController: UIViewController) {
        let alert = UIAlertController(title: "", message: Constants.loadImageAlert, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: Constants.loadImageCamera, style: .default) { _ in
            alert.dismiss(animated: true) {
                self.presentCamera(from: viewController)
            }
        }
        alert.addAction(cameraAction)
        let libraryAction = UIAlertAction(title: Constants.loadImageLibrary, style: .default) { _ in
            alert.dismiss(animated: true) {
                self.presentPhotoLibrary(from: viewController)
            }
        }
        alert.addAction(libraryAction)
        viewController.present(alert, animated: true)
    }
    // Показать камеру
    func presentCamera(from viewController: UIViewController) {
        if isCameraAvailable() {
            requestCameraPermission { granted in
                if granted {
                    self.showCamera(from: viewController)
                } else {
                    self.showPermissionDeniedAlert(from: viewController, type: .camera)
                }
            }
        } else {
            self.showCameraNotAvailableAlert(from: viewController)
        }
    }
    // Показать фотогалерею
    func presentPhotoLibrary(from viewController: UIViewController) {
        requestPhotoLibraryPermission { granted in
            if granted {
                self.showLibrary(from: viewController)
            } else {
                self.showPermissionDeniedAlert(from: viewController, type: .library)
            }
        }
    }
    private func showLibrary(from viewController: UIViewController) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        viewController.present(picker, animated: true, completion: nil)
    }

    private func showCamera(from viewController: UIViewController) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        viewController.present(imagePickerController, animated: true, completion: nil)
    }
    private func showPermissionDeniedAlert(from viewController: UIViewController, type: AddPhotosType) {
        let alert = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.okTitle, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: Constants.settings, style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        viewController.present(alert, animated: true, completion: nil)
    }
    private func showCameraNotAvailableAlert(from viewController: UIViewController) {
        let alert = UIAlertController(
            title: Constants.notAvailableCameraTitle,
            message: Constants.notAvailableCameraMessage,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: Constants.okTitle, style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    func dismissCamera(from viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
extension CameraManager: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.delegate?.didCaptureImage(image)
                    }
                }
            }
        }
    }
}
extension CameraManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let image = info[.originalImage] as? UIImage {
            delegate?.didCaptureImage(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
