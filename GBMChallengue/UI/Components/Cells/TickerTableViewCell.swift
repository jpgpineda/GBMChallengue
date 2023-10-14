//
//  TickerTableViewCell.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

import UIKit

class TickerTableViewCell: UITableViewCell {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var tickerSymbolLabel: UILabel!
    @IBOutlet weak var stockPrice: UILabel!
    @IBOutlet weak var stockCountryLabel: UILabel!
    @IBOutlet weak var tickerNameLabel: UILabel!
    @IBOutlet weak var stockAcronymLabel: UILabel!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    static let identifier = "TickerTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    internal func setupView(ticker: TickerDetailDTO?) {
        tickerNameLabel.text = ticker?.name
        tickerSymbolLabel.text = ticker?.symbol
        stockCountryLabel.text = ticker?.stock.country
        stockAcronymLabel.text = ticker?.stock.acronym
    }
}
