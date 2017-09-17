//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class BalanceCell: UITableViewCell {

    private let currentCBLabel = StandardLabel(
        font: .openFontMedium(ofSize: 25),
        textColor: .white
    )
    private let averageCBLabel = StandardLabel(
        font: .openFont(ofSize: 17),
        textColor: .white
    )
    private let percentageLabel = StandardLabel(
        font: .openFont(ofSize: 17),
        textColor: .white
    )
    private let popularCategories = StandardLabel(
        font: .openFontMedium(ofSize: 20)
    ).with(text: "Популярные категории")

    private var info: InfoButton
    let gr = UITapGestureRecognizer()

    
    private var disposeBag = DisposeBag()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        info = InfoButton(info: "adfadsf asdg asd adg asdg asdg asdgadfgadfg", closeOn: gr.rx.event.asObservable().map{_ in })
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addGestureRecognizer(gr)
        
        

        let backImage = UIImageView(image: #imageLiteral(resourceName: "headerBackground"))
                .with(contentMode: .scaleAspectFill)
        let whiteBack = UIView().with(backgroundColor: .white)
                .with(clipsToBounds: true)
                .with(roundedEdges: 15)

        contentView.addSubviews([backImage, whiteBack, currentCBLabel, averageCBLabel, percentageLabel, popularCategories, info])

        info.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(currentCBLabel.snp.centerY)
        }

        backImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        whiteBack.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(15)
            $0.height.equalTo(50)
        }

        currentCBLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        averageCBLabel.snp.makeConstraints {
            $0.top.equalTo(currentCBLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        percentageLabel.snp.makeConstraints {
            $0.top.equalTo(averageCBLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        popularCategories.snp.makeConstraints {
            $0.top.equalTo(percentageLabel.snp.bottom).offset(68)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }

        separatorInset = .init(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configured(with info: BalanceInfo) -> BalanceCell {
        self.currentCBLabel.text = info.currentCashback.asString()
        self.averageCBLabel.text = "\(info.averageCashback.asString()) средний кэшбэк"
        self.percentageLabel.text = "\(info.percentageOfDedicatedCashback) % будет инвестировано в следующем месяце"
        return self
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        currentCBLabel.text = nil
        averageCBLabel.text = nil
        percentageLabel.text = nil
    }

}
