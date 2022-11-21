//
//  ProfileService.swift
//  Job4m2
//
//  Created by Danil Dubov on 20.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation

class ProfileService {
    private let apiService = APIService.shared

    func fetchProfileSettings() async -> ProfileModel? {
        let route = APIRoute(
            route: Route.User.me.asPath,
            method: .get
        )
        let profileDTO: ProfileDTO? = await apiService.perform(route: route)

        return profileDTO.map { profile in
            ProfileModel(
                name: profile.name ?? "",
                age: profile.age ?? 1488,
                education: profile.education ?? "",
                company: profile.company ?? "",
                description: profile.description,
                tg_link: profile.tg_link,
                image: profile.image,
                type: profile.type,
                tags: profile.tags,
                attachments: profile.attachments
            )
        }
    }

    func updateProfile(model: ProfileUpdateDTO) async -> PisyaDTO? {
        let route = APIRoute(route: Route.User.update.asPath, method: .post)
        return await apiService.perform(route: route, parameters: model)
    }
}
