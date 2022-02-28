//
//  ViewController.swift
//  UITableViewSettings
//
//  Created by Alexey Davidenko on 28.02.2022.
//

import UIKit

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackGroundColor: UIColor
    let handler: (() -> Void)
    let isOn: Bool
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackGroundColor: UIColor
    let handler: (() -> Void)
    let statusLabel: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TableViewCell.self,
                       forCellReuseIdentifier: TableViewCell.identifier)
        table.register(SwitchTableViewCell.self,
                       forCellReuseIdentifier: SwitchTableViewCell.identifier)

        return table
    }()

    var models = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }

    func configure() {
        models.append(Section(title: "", options: [
            .switchCell(model: SettingsSwitchOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane"), iconBackGroundColor: .systemOrange, handler: {
                    print("Tapped Airplane mode")
            }, isOn: false)),

            .staticCell(model: SettingsOption(title: "Wi-Fi", icon: UIImage(systemName: "wifi"), iconBackGroundColor: .systemBlue, handler: {
                    print("Tapped Wi-Fi")
            }, statusLabel: "Not connected")),

            .staticCell(model: SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "bonjour"), iconBackGroundColor: .systemBlue, handler: {
                    print("Tapped Bluetooth")
            }, statusLabel: "Off")),

            .staticCell(model: SettingsOption(title: "Mobile Data", icon: UIImage(systemName: "antenna.radiowaves.left.and.right"), iconBackGroundColor: .systemGreen, handler: {
                    print("Tapped Mobile Data")
            }, statusLabel: "")),

            .staticCell(model: SettingsOption(title: "Personal Hotspot", icon: UIImage(systemName: "personalhotspot"), iconBackGroundColor: .systemGreen, handler: {
                    print("Tapped Personal Hotspot")
            }, statusLabel: "Off")),

            .switchCell(model: SettingsSwitchOption(title: "VPN", icon: UIImage(systemName: "network"), iconBackGroundColor: .systemBlue, handler: {
                    print("Tapped VPN")
            }, isOn: false)),
        ]))

        models.append(Section(title: "", options: [
            .staticCell(model: SettingsOption(title: "Notifications", icon: UIImage(systemName: "bell.badge.fill"), iconBackGroundColor: .systemRed, handler: {
                    print("Tapped Notifications")
            }, statusLabel: "")),

            .staticCell(model: SettingsOption(title: "Sounds & Haptics", icon: UIImage(systemName: "speaker.wave.3.fill"), iconBackGroundColor: .systemPink, handler: {
                    print("Tapped Sounds & Haptics")
            }, statusLabel: "")),

            .staticCell(model: SettingsOption(title: "Do Not Disturb", icon: UIImage(systemName: "moon.fill"), iconBackGroundColor: .systemPurple, handler: {
                    print("Tapped Do Not Disturb")
            }, statusLabel: "")),

            .staticCell(model: SettingsOption(title: "Screen Time", icon: UIImage(systemName: "hourglass"), iconBackGroundColor: .systemPurple, handler: {
                    print("Tapped Screen Time")
            }, statusLabel: "")),
        ]))

    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]

        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TableViewCell.identifier,
                for: indexPath
            ) as? TableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler()
        }
    }
}
