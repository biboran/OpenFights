//
// Created by Артмеий Шлесберг on 16/09/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources
import SnapKit

class SuggestedInvestmentsController: UIViewController {

    private enum SectionItem {
        case balance(BalanceInfo)
        case investmentCategory(InvestmentCategoryInCell)
    }

    private let balance: Balance
    private let investmentCategories: InvestmentCategories
    init(with balance: Balance, investmentCategories: InvestmentCategories) {
        self.balance = balance
        self.investmentCategories = investmentCategories
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let disposeBag = DisposeBag()
    private let tableView = StandardTableView()
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.top.equalTo(topLayoutGuide.snp.bottom)
            $0.bottom.equalTo(bottomLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }

        let dataSource = RxTableViewSectionedReloadDataSource<StandardSectionModel<SectionItem>>()
        dataSource.configureCell = { ds, tv, ip, item in
            switch item {
            case let .balance(info):
                return tv.dequeueReusableCellOfType(BalanceCell.self, for: ip).configured(with: info)
            case let .investmentCategory(category):
                return tv.dequeueReusableCellOfType(CategoryCell.self, for: ip).configured(with: category)
            }
        }

        Observable.combineLatest(
                balance.fetchInformation(),
                investmentCategories.fetch().map{ $0.map{InvestmentCategoryInCell(origin: $0)} }
        ).map{ info, categories in
                [
                    StandardSectionModel<SectionItem>(
                        items: [SectionItem.balance(info)] + categories.map{ SectionItem.investmentCategory($0) }
                    )
                ]
            }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        

        tableView.rx.modelSelected(SectionItem.self)
            .subscribe(onNext: { [unowned self] item in
                switch item {
                case .investmentCategory:
                    self.commandToShowController(
                            from: { InvestmentCategoryViewController(nibName: nil, bundle: nil) }
                    ).execute()
                default:
                    return
                }
            })
            .disposed(by: disposeBag)

        title = "Главная"
    }

}
