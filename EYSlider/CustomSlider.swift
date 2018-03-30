import UIKit

@IBDesignable class CustomSlider: UIControl {
    
    // MARK: - Properties
    
    private let borderLayer = CALayer()
    private let trackLayer = CALayer()
    private let handleLayer = CALayer()
    
    // Mark: - Editable Properties
    
    @IBInspectable var maxValue: Float = 10.0
    @IBInspectable var sliderValue: Float = 0.0
    @IBInspectable var animationDuration: Float = 0.5
    @IBInspectable var value: Float {
        get {
            return sliderValue
        }
        set {
            sliderValue = newValue >= 0 ? min(newValue, maxValue) : max(newValue, -maxValue)
            animateSlider()
        }
    }
    
    @IBInspectable var viewBackColor: UIColor = UIColor.clear {
        didSet {
            self.backgroundColor = viewBackColor
        }
    }
    
    @IBInspectable var viewCornerRadius: CGFloat = 15.0 {
        didSet {
            self.layer.cornerRadius = viewCornerRadius
        }
    }
    
    @IBInspectable var borderBackColor: UIColor = UIColor.black {
        didSet {
            borderLayer.backgroundColor = borderBackColor.cgColor
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            borderLayer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            borderLayer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var positiveTrackColor: UIColor = UIColor.green {
        didSet {
            trackLayer.backgroundColor = value >= 0 ? positiveTrackColor.cgColor : negativeTrackColor.cgColor
        }
    }
    @IBInspectable var negativeTrackColor: UIColor = UIColor.red {
        didSet {
            trackLayer.backgroundColor = value >= 0 ? positiveTrackColor.cgColor : negativeTrackColor.cgColor
        }
    }
    
    @IBInspectable var handleBackColor: UIColor = UIColor.brown {
        didSet {
            handleLayer.backgroundColor = handleBackColor.cgColor
        }
    }
    
    @IBInspectable var handleShadowColor: UIColor = UIColor.black {
        didSet {
            handleLayer.shadowColor = handleShadowColor.cgColor
        }
    }
    
    @IBInspectable var handleShadowRadius: CGFloat = 2.0 {
        didSet {
            handleLayer.shadowRadius = handleShadowRadius
        }
    }
    
    @IBInspectable var handleShadowOpacity: Float = 0.5 {
        didSet {
            handleLayer.shadowOpacity = handleShadowOpacity
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()  
    }
    
    private func setupUI(){
        designBorder()
        designTrack()
        designHandle()
    }
    
    private func updateUI() {
        updateContainerView()
        updateBorder()
        updateTrack()
        updateHandle()
    }
    
    // MARK: - Design Layers

    private func designBorder() {
        borderLayer.frame = CGRect(x: 0, y: 0, width: 30, height: 100)
        borderLayer.cornerRadius = borderLayer.frame.size.width / 2.0
        borderLayer.masksToBounds = true
        layer.addSublayer(borderLayer)
    }
    
    private func designTrack() {
        trackLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        trackLayer.frame = CGRect(x: 0, y: 0, width: 30, height: 80)
        trackLayer.position = CGPoint(x: borderLayer.bounds.size.width / 2.0, y: borderLayer.bounds.size.height / 2.0)
        layer.addSublayer(trackLayer)
    }
    
    private func designHandle() {
        handleLayer.position = borderLayer.position
        handleLayer.bounds.size = CGSize(width: borderLayer.bounds.size.width, height: borderLayer.bounds.size.width)
        handleLayer.cornerRadius = borderLayer.bounds.size.width / 2.0
        handleLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layer.addSublayer(handleLayer)
    }
    
    // MARK: - Update Layers
    
    private func updateContainerView() {
        self.layer.cornerRadius = borderLayer.cornerRadius
    }
    
    private func updateBorder() {
        borderLayer.frame = bounds
        borderLayer.cornerRadius = bounds.size.width / 2.0
    }
    
    private func updateTrack() {
        trackLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width - 2, height: 0)
        trackLayer.position = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        trackLayer.bounds.size.height = abs(valueToY())
        trackLayer.anchorPoint = value >= 0 ? CGPoint(x: 0.5, y: 1) : CGPoint(x: 0.5, y: 0)
        trackLayer.backgroundColor = value >= 0 ? positiveTrackColor.cgColor : negativeTrackColor.cgColor
    }
    
    private func updateHandle() {
        handleLayer.bounds.size = CGSize(width: bounds.size.width, height: bounds.size.width)
        handleLayer.cornerRadius = bounds.size.width / 2.0
        var position = borderLayer.position
        if value != 0 { position.y -= valueToY() }
        handleLayer.position = position
    }
    
    private func animateSlider() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(CFTimeInterval(animationDuration))
        updateHandle()
        updateTrack()
        CATransaction.commit()
        self.sendActions(for: UIControlEvents.valueChanged)
    }
    
    private func valueToY()->CGFloat {
        let viewHeight = bounds.size.height
        let halfHandleHeight = handleLayer.bounds.size.height / 2.0
        let realY = (viewHeight - halfHandleHeight) / 2.0
        return CGFloat(value) / CGFloat(maxValue) * realY
    }
    
    // MARK: - Track Layers
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        self.handleLayer.transform = CATransform3DMakeScale(1.5, 1.5, 1)
        let point = touch.location(in: self)
        value = valueFromY(y: point.y)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let point = touch.location(in: self)
        value = valueFromY(y: point.y)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        self.handleLayer.transform = CATransform3DIdentity
    }
    
    override func cancelTracking(with event: UIEvent?) {
        self.handleLayer.transform = CATransform3DIdentity
    }
    
    private func valueFromY(y:CGFloat)->Float {
        let cleanY = min(max(0, y), bounds.size.height)
        let viewHalfHeight = bounds.size.height / 2.0
        let realY = viewHalfHeight - cleanY
        return Float(realY) * maxValue / Float(viewHalfHeight)
    }
}
