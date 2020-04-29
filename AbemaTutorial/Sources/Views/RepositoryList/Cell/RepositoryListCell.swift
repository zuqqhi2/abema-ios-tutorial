import Action
import RxRelay
import RxSwift
import Unio
import UIKit

final class RepositoryListCell: UITableViewCell {

    private let viewStream = RepositoryListCellStream()

    private let disposeBag = DisposeBag()

    var repository: Repository? = nil {
        didSet { viewStream.input.accept(repository, for: \.repository) }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        viewStream.output.titleText
            .bind(to: textLabel!.rx.text)
            .disposed(by: disposeBag)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewStream.input.accept((), for: \.prepareForReuse)
    }
}
