//
//  CountryPickerViewController.swift
//  PenguinPay
//
//  Created by Audrey SOBGOU ZEBAZE on 22/06/2021.
//

import UIKit

/// Inspired from the CountryPickerViewController from PhoneNumberKit Library
protocol CountryPickerDelegate: AnyObject {
    func countryPickerDidPickCountry(_ country: Country)
}

class CountryPickerViewController: UITableViewController {

    private let viewModel = CountryPickerViewModel()

    public weak var delegate: CountryPickerDelegate?

    lazy var cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self,
                                            action: #selector(dismissAnimated))

    init() {
        super.init(style: .grouped)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    func commonInit() {
        self.title = NSLocalizedString("PhoneNumberKit.CountryCodePicker.Title",
                                       value: "Choose your country",
                                       comment: "Title of CountryPickerViewController")
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        definesPresentationContext = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.countries.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countries[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath)
        let country = viewModel.country(for: indexPath)

        cell.textLabel?.text = country.prefix + " " + country.flag
        cell.detailTextLabel?.text = country.name

        cell.textLabel?.font = .preferredFont(forTextStyle: .callout)
        cell.detailTextLabel?.font = .preferredFont(forTextStyle: .body)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = viewModel.country(for: indexPath)
        delegate?.countryPickerDidPickCountry(country)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc func dismissAnimated() {
        dismiss(animated: true)
    }

}
