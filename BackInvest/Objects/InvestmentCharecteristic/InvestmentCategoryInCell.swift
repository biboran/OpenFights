//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

class InvestmentCategoryInCell: InvestmentCategory {

    var description: DescribableCharacteristic {
        return origin.description
    }
    
    var title: String {
        return origin.title
    }
    
    var image: ObservableImage {
        return origin.image
    }
    
    var punchCount: CountableCharacteristic {
        return CountableCharacteristicInCell(origin: origin.punchCount)
    }
    
    var fatalityDifficulty: MeasurableCharacteristic {
        return MeasurableCharacteristicInCell(origin: origin.fatalityDifficulty)
    }
    
    var fatalityFailRisk: MeasurableCharacteristic {
        return origin.fatalityFailRisk
    }
    
    private var origin: InvestmentCategory
    
    init(origin: InvestmentCategory) {
        self.origin = origin
    }
}

class MeasurableCharacteristicInCell: MeasurableCharacteristic {
    
    var title: String {
        return origin.title
    }
    
    var value: Double {
        return origin.value
    }
    var range: Double  {
        return origin.range
    }
    var information: UIView {
        return TitledProgressView(completion: value/range, title: title)
    }

    private var origin: MeasurableCharacteristic

    init(origin: MeasurableCharacteristic) {
        self.origin = origin
    }
}

class TitledProgressView: VerticalStackView {
    init(completion: Double, title: String, progressHeight: CGFloat = 5) {
        let titleLabel: StandardLabel = StandardLabel(font: .openFontMedium(ofSize: 15), textColor: .black, text: title)
                .aligned(by: .left)
        let progressView = ProgressBarView(completion: completion)
        super.init(frame: .zero)
        addArrangedSubviews([titleLabel, progressView])
        progressView.snp.makeConstraints {
            $0.height.equalTo(progressHeight)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class CountableCharacteristicInCell: CountableCharacteristic {
    
    var title: String {
        return origin.title
    }
    
    var count: Int {
        return origin.count
    }

    var information: UIView {
        var titleLabel: StandardLabel = StandardLabel(font: .openFont(ofSize: 15), textColor: .black, text: title)
                .aligned(by: .left)
        var valueView = ValueView(value: "\(count) чел.", icon: #imageLiteral(resourceName: "people"))
        valueView.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        return VerticalStackView(arrangedSubviews: [titleLabel, valueView] )
    }

    private var origin: CountableCharacteristic

    init(origin: CountableCharacteristic){
        self.origin = origin
    }
}



