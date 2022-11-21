//
//  ProfileController.swift
//  Job4m2
//
//  Created by Danil Dubov on 20.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import PhotosUI

class ProfileController: ObservableObject {
    @MainActor @Published var model: ProfileModel? = nil

    @Published var name: String = ""
    @Published var age: String = ""
    @Published var education: String = ""
    @Published var company: String = ""
    @Published var telegrammName: String = ""
    @Published var description: String = ""
    @Published var slider: Double = 18
    @Published var userType: UserType = .workDealer
    @Published var imagePath: String = ""
    @MainActor @Published var tags: [ProfileTag] = []

    @Published var photos: [PhotosPickerItem] = []
    @Published var photoData: Data?

    // Костыль
    @Published var type: String = ""
    @Published var attachments: [Attachments] = []

    var disposable = Set<AnyCancellable>()

    private let profileService = ProfileService()
    private let registrationService = RegistrationService()

    func onAppear() {
        Task {
            guard let fetchedProfile = await profileService.fetchProfileSettings() else {
                return
            }

            await MainActor.run {
                model = fetchedProfile

                name = fetchedProfile.name
                age = String(fetchedProfile.age)
                education = fetchedProfile.education
                company = fetchedProfile.company
                telegrammName = fetchedProfile.tg_link
                description = fetchedProfile.description
                slider = Double(fetchedProfile.age)
                userType = fetchedProfile.type == "candidate" ? .workFinder : .workDealer
                imagePath = fetchedProfile.image
                tags = fetchedProfile.tags

                // Костыль
                type = fetchedProfile.type
                attachments = fetchedProfile.attachments
            }
        }
    }

    @MainActor
    func saveData() {
        Task {
            let selectedTags = tags
                .filter { $0.isSelected }
                .map { $0.id }

            let profileUpdateDTO = ProfileUpdateDTO(
                name: name,
                age: Int(slider),
                education: education,
                company: company,
                description: description,
                tg_link: telegrammName,
                type: type,
                tags: selectedTags,
                attachments: attachments
            )

            let _ = await profileService.updateProfile(model: profileUpdateDTO)

            if let photoData = self.photoData {
                let _ = await registrationService.uploadPhoto(data: photoData)
            }
        }
    }

    @MainActor
    func onTagSelected(tagID: Int) {
        tags = tags.map { tag in
            if tag.id == tagID {
                return ProfileTag(
                    id: tag.id,
                    text: tag.text,
                    isSelected: !tag.isSelected
                )
            } else {
                return tag
            }
        }
    }

    func updatePhoto() {
        guard let image = photos.first else { return }
        image.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data):
                if let data {
                    Task {
                        await MainActor.run {
                            self.photoData = data
                        }
                    }
                }
            case .failure(let failure):
                fatalError()
                print(failure.localizedDescription)
            }
        }
    }
}
