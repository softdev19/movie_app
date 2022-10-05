//
//  LocalDataManager.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 04.10.2022.
//

import Foundation
import CoreData
import UIKit

final class LocalDataManager{
    
    private enum LocalStorageError: Error{
        case FailedToSaveData
        case FailedToGetData
        case FailedToDeleteData
    }
    
    static let shared = LocalDataManager()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Create
    func addData(with video: Video){
        let newVideo = CoreVideo(context: context)
        newVideo.title = video.title
        newVideo.year = video.year
        newVideo.image = video.image
        
        saveData { response in
            switch response{
                case .success(): return
                case .failure(let error): print(error.localizedDescription)
            }
        }
    }

    //Read
    func fetchData(completionHandler: @escaping (Result<[CoreVideo], Error>)->Void){
        do{
            let response = try context.fetch(NSFetchRequest(entityName: "CoreVideo")) as! [CoreVideo]
            completionHandler(.success(response))
        }
        catch{
            completionHandler(.failure(LocalStorageError.FailedToGetData))
        }
    }

    //Delete
    func deleteData(video: CoreVideo,completionHandler: @escaping (Result<Void, Error>)->Void){
        do{
            context.delete(video)
        }
        catch{
            completionHandler(.failure(LocalStorageError.FailedToDeleteData))
        }
        
        saveData { response in
            switch response{
                case .success(): return
                case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    //Save
    func saveData(completionHandler: @escaping (Result<Void, Error>)->Void){
        do{
            try context.save()
        }
        catch{
            completionHandler(.failure(LocalStorageError.FailedToSaveData))
        }
    }
}
