//
//  ViewController.swift
//  Instruction_Tutorial
//
//  Created by SeongMinK on 2021/11/09.
//

import UIKit
import Instructions

class ViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var viewBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var alarmBtn: UIButton!
    
    let coachMarksController = CoachMarksController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(#fileID, #function, "called")
        
        self.coachMarksController.dataSource = self
        self.coachMarksController.delegate = self
        self.coachMarksController.animationDelegate = self
        
        let skipView = CoachMarkSkipDefaultView()
        skipView.setTitle("Skip", for: .normal)
        self.coachMarksController.skipView = skipView
        
        self.coachMarksController.statusBarVisibility = .hidden
        self.coachMarksController.overlay.isUserInteractionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#fileID, #function, "called")
        
        self.coachMarksController.start(in: .window(over: self))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#fileID, #function, "called")
        
        self.coachMarksController.stop(immediately: true)
    }
}

extension ViewController: CoachMarksControllerDelegate {
    func coachMarksController(_ coachMarksController: CoachMarksController, configureOrnamentsOfOverlay overlay: UIView) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        overlay.addSubview(label)
        label.text = "Overlay"
        label.alpha = 0.5
        label.font = label.font.withSize(60.0)
        label.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: overlay.topAnchor, constant: 100).isActive = true
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, willShow coachMark: inout CoachMark, beforeChanging change: ConfigurationChange, at index: Int) {
        print("willShow() index: \(index)")
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, willHide coachMark: CoachMark, at index: Int) {
        print("willHide() index: \(index)")
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, didEndShowingBySkipping skipped: Bool) {
        print("스킵 여부: \(skipped)")
    }
    
    func shouldHandleOverlayTap(in coachMarksController: CoachMarksController, at index: Int) -> Bool {
        print("Tapped")
        return true
    }
}

// 보여줄 뷰 설정
extension ViewController: CoachMarksControllerDataSource {
    // 가이드 마커 설정
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(
            withArrow: true,
            arrowOrientation: coachMark.arrowOrientation
        )
        
        switch index {
        case 0:
            coachViews.bodyView.hintLabel.text = "이것은 당신의 프로필 사진입니다."
            coachViews.bodyView.nextLabel.text = "다음"
            coachViews.bodyView.background.innerColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
            coachViews.arrowView?.background.innerColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
            coachViews.bodyView.background.borderColor = .yellow
            coachViews.bodyView.hintLabel.textColor = .white
            coachViews.bodyView.nextLabel.textColor = .yellow
        case 1:
            coachViews.bodyView.hintLabel.text = "이것은 당신의 닉네임입니다."
            coachViews.bodyView.nextLabel.text = "다음"
            coachViews.bodyView.background.borderColor = .yellow
            coachViews.bodyView.nextLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case 2:
            coachViews.bodyView.hintLabel.text = "제 채널을 보러오세요!"
            coachViews.bodyView.nextLabel.text = "다음"
            coachViews.bodyView.background.borderColor = .yellow
            coachViews.bodyView.nextLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case 3:
            coachViews.bodyView.hintLabel.text = "좋아요 부탁드립니다!"
            coachViews.bodyView.nextLabel.text = "다음"
            coachViews.bodyView.background.borderColor = .yellow
            coachViews.bodyView.nextLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case 4:
            coachViews.bodyView.hintLabel.text = "알람 설정까지!!"
            coachViews.bodyView.nextLabel.text = "다음"
            coachViews.bodyView.background.borderColor = .yellow
            coachViews.bodyView.nextLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        default:
            coachViews.bodyView.hintLabel.text = "이것은 당신의 프로필 사진입니다."
            coachViews.bodyView.nextLabel.text = "다음"
        }
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    // 가르키고자 하는 뷰 지정
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        switch index {
        case 0: return coachMarksController.helper.makeCoachMark(for: profileImage)
        case 1: return coachMarksController.helper.makeCoachMark(for: profileLabel)
        case 2: return coachMarksController.helper.makeCoachMark(for: viewBtn)
        case 3: return coachMarksController.helper.makeCoachMark(for: likeBtn)
        case 4: return coachMarksController.helper.makeCoachMark(for: alarmBtn)
        default: return coachMarksController.helper.makeCoachMark(for: profileImage)
        }
    }
    
    // 가이드를 제공할 뷰의 개수
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 5
    }
}

extension ViewController: CoachMarksControllerAnimationDelegate {
    // 마커가 나타날 때
    func coachMarksController(_ coachMarksController: CoachMarksController, fetchAppearanceTransitionOfCoachMark coachMarkView: UIView, at index: Int, using manager: CoachMarkTransitionManager) {
        manager.parameters.options = [.beginFromCurrentState]
        manager.animate(.regular) { (CoachMarkAnimationManagementContext) in
            coachMarkView.transform = .identity
            coachMarkView.alpha = 1
        } fromInitialState: {
            // 투명한 상태, 절반 크기에서 시작
            coachMarkView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            coachMarkView.alpha = 0
        } completion: { (Bool) in
            
        }
    }
    
    // 마커가 사라질 때
    func coachMarksController(_ coachMarksController: CoachMarksController, fetchDisappearanceTransitionOfCoachMark coachMarkView: UIView, at index: Int, using manager: CoachMarkTransitionManager) {
        manager.animate(.keyframe) { (CoachMarkAnimationManagementContext) in
            // 절반 크기로 쪼그라들기
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.8) {
                coachMarkView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }
            // 투명화
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                coachMarkView.alpha = 0
            }
        }
    }
    
    // 마커가 떠있을 때
    func coachMarksController(_ coachMarksController: CoachMarksController, fetchIdleAnimationOfCoachMark coachMarkView: UIView, at index: Int, using manager: CoachMarkAnimationManager) {
        manager.parameters.options = [.repeat, .autoreverse, .allowUserInteraction]
        manager.parameters.duration = 0.5
        manager.animate(.regular) { (context: CoachMarkAnimationManagementContext) in
            let offset: CGFloat = context.coachMark.arrowOrientation == .top ? 5 : -5
            coachMarkView.transform = CGAffineTransform(translationX: 0, y: offset)
        }
    }
}
