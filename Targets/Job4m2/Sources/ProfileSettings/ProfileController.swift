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

class ProfileController: ObservableObject {
    var model: ProfileModel? = nil

    @Published var name: String = ""
    @Published var age: String = ""
    @Published var education: String = ""
    @Published var company: String = ""
    @Published var telegrammName: String = ""
    @Published var description: String = ""
    @Published var slider: Double = 18
    @Published var userType: UserType = .workDealer
    @Published var imagePath: String = ""
    @MainActor @Published var tags: [RegistrationTag] = []

    // Костыль
    @Published var type: String = ""
    @Published var attachments: [Attachments] = []

    var disposable = Set<AnyCancellable>()

    private let profileService = ProfileService()

    func onAppear() {
        Task {
            guard let fetchedProfile = await profileService.fetchProfileSettings() else {
                return
            }

            await MainActor.run { [fetchedProfile] in
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

                // Костыль
                type = fetchedProfile.type
                attachments = fetchedProfile.attachments
            }
        }
    }

    @MainActor
    func saveData() {
        let selectedTags = tags
            .filter { $0.isSelected }
            .map { $0.id }

        let profileUpdateDTO = ProfileUpdateDTO(
            name: name,
            age: age,
            education: education,
            company: company,
            description: description,
            tg_link: telegrammName,
            type: type,
            tags: selectedTags,
            attachments: attachments
        )

        Task {
            let _ = await profileService.updateProfile(model: profileUpdateDTO)
        }
    }

    @MainActor
    func onTagSelected(tagID: Int) {
        tags = tags.map { tag in
            if tag.id == tagID {
                return RegistrationTag(
                    id: tag.id,
                    text: tag.text,
                    isSelected: !tag.isSelected
                )
            } else {
                return tag
            }
        }
    }
}
