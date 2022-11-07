import Foundation
import SwiftUI
import CoreMotion
import Combine
import PhotosUI

final class RegistrationController: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var age: String = ""
    @Published var education: String = ""
    @Published var company: String = ""
    @Published var telegrammName: String = ""
    @Published var description: String = ""
    @Published var slider: Double = 18
    @Published var segmentSelected: Int = 0
    @Published var userType: UserType = .workDealer
    @Published var isAllFiled: Bool = false
    @MainActor @Published var tags: [RegistrationTag] = []

    @Published var photos: [PhotosPickerItem] = []
    @Published var photoData: Data?

    var disposable = Set<AnyCancellable>()

    private let registrationService = RegistrationService()
    private let authService = AuthService()

    private var userParameters: UserRegistrationParameters?
    private var companyParameters: CompanyRegistrationParameters?

    var onRegistrationFinish: Action?

    func onApear() {
        $segmentSelected.sink { value in
            if value <= 0 {
                self.userType = .workDealer
            } else {
                self.userType = .workFinder
            }
        }
        .store(in: &disposable)

        $username
            .combineLatest($name)
            .combineLatest($password)
            .combineLatest($education)
            .combineLatest($telegrammName)
            .combineLatest($slider)
            .combineLatest($description)
            .combineLatest($userType)
            .combineLatest($tags)
            .sink { result in
                let ((((((((nick, name), pass), education), telegram), slider), description), _), tags) = result
                
                let fields: [String] = [nick, name, education, telegram, description, pass]
                guard fields.allSatisfy({ !$0.isEmpty }) else {
                    self.isAllFiled = false
                    return
                }
                self.isAllFiled = true
                self.userParameters = UserRegistrationParameters(
                    username: nick,
                    password: pass,
                    name: name,
                    age: Int(slider),
                    education: education,
                    description: description,
                    tg_link: telegram,
                    type: .candidate,
                    tags: tags
                        .filter { $0.isSelected }
                        .map { $0.id }
                )
            }
            .store(in: &disposable)

        $username
            .combineLatest($name)
            .combineLatest($password)
            .combineLatest($telegrammName)
            .combineLatest($description)
            .combineLatest($userType)
            .combineLatest($tags)
            .sink { result in
                let ((((((nick, companyName), pass), telegram), description), _), tags) = result
                
                let fields: [String] = [nick, companyName, pass, telegram, description]

                guard fields.allSatisfy({ !$0.isEmpty }) else {
                    self.isAllFiled = false
                    return
                }
                self.isAllFiled = true
                self.companyParameters = CompanyRegistrationParameters(
                    username: nick,
                    password: pass,
                    description: description,
                    tg_link: telegram,
                    type: .recruiter,
                    tags: tags
                        .filter { $0.isSelected }
                        .map { $0.id },
                    company: companyName
                )

            }
            .store(in: &disposable)

        Task {
            let userTags = await registrationService.fetchTags()

            await MainActor.run { [userTags] in
                tags = userTags
                print(tags)
            }
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

    func registrate() {
        Task {
            var user: User? = nil

            if let userParameters = userParameters, userType == .workFinder {
                guard let _ = await registrationService.registerUser(parameters: userParameters) else { return }
                user = User(username: username, password: password)
                auth(username: username, password: password)
            } else if let companyParameters = companyParameters, userType == .workDealer {
                guard let _ = await registrationService.registerCompany(parameters: companyParameters) else { return }
                user = User(username: username, password: password)
                auth(username: username, password: password)
            }

            guard let superUser = user else { return }
            registrationService.saveUser(superUser)

            if let photoData = self.photoData {
                let _ = await registrationService.uploadPhoto(data: photoData)
            }

            await MainActor.run {
                onRegistrationFinish?()
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

    private func auth(username: String, password: String) {
        let parameters = AuthParameters(username: username, password: password)
        authService.auth(parameters: parameters)
    }
}
