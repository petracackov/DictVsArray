
import UIKit

class CustomView: UIView {
    
    @IBOutlet weak var contentView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // The nib must be named exactly the same as the source files
        let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last
        interfaceBundle().loadNibNamed(nibName!, owner: self, options: nil)
        internalSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last
        interfaceBundle().loadNibNamed(nibName!, owner: self, options: nil)
        internalSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private var isSetup: Bool = false
    private func internalSetup() {
        guard isSetup == false else { return }
        isSetup = true
        
        // The following is to make sure content view, extends out all the way to fill whatever our view size is even as our view's size is changed by autolayout
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        
        addEdgeConstraint(edge: .left, superview: self, subview: contentView)
        addEdgeConstraint(edge: .right, superview: self, subview: contentView)
        addEdgeConstraint(edge: .top, superview: self, subview: contentView)
        addEdgeConstraint(edge: .bottom, superview: self, subview: contentView)
        
        layoutIfNeeded()
        
        setup()
    }
    
    /**
     Override this function to customize setup. It is called after awakeFromNib bounds view with nib.
     */
    func setup() {
        
    }
    
    private func interfaceBundle() -> Bundle {
        #if TARGET_INTERFACE_BUILDER
            return Bundle(for: type(of: self))
        #else
            return Bundle.main
        #endif
    }
    
    private func addEdgeConstraint(edge: NSLayoutConstraint.Attribute, superview: UIView, subview: UIView) {
        let constraint = NSLayoutConstraint(item: subview, attribute: edge, relatedBy: .equal, toItem: superview, attribute: edge, multiplier: 1.0, constant: 0.0)
        superview.addConstraint(constraint)
    }
}
