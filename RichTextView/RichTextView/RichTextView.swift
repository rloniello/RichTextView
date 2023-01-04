//
//  RichTextView.swift
//  RichTextView
//
//  Created by Russell on 9/8/22.
//

import UIKit


/// A text attribute that is represented to
fileprivate enum TextAttribute {
    case plain
    case bold
    case italic
    case strikethrough
    
    var attribute: NSAttributedString.Key {
        switch self {
            case .plain, .bold, .italic:
                return NSAttributedString.Key.font
            case .strikethrough:
                return NSAttributedString.Key.strikethroughStyle
        }
    }
    
    var value: Any {
        switch self {
            case .plain:
                return UIFont.systemFont(ofSize: UIFont.systemFontSize)
            case .bold:
                return UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .bold)
            case .italic:
                return UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)
            case .strikethrough:
                return 1
        }
    }
}

class RichTextView: UIView, UITextViewDelegate {
    
    //
    // MARK: Property Accessors
    //
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.accessibilityIdentifier = "RichTextViewBox"
        return tv
    }()
    
    public var attributedText: NSAttributedString {
        return self.textView.attributedText
    }
    
    public var currentFont: UIFont? {
        return self.textView.font
    }
    
    private lazy var attributeSelector: UISegmentedControl = {
        let sc = UISegmentedControl(items: [UIImage.init(systemName: "textformat.abc")!,
                                            UIImage.init(systemName: "bold")!,
                                            UIImage.init(systemName: "italic")!,
                                            UIImage.init(systemName: "strikethrough")!])
        sc.addTarget(self, action: #selector(editModeDidChange(_:)), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.isOpaque = true
        sc.layer.zPosition = 5
        sc.selectedSegmentIndex = 0
        sc.backgroundColor  = UIColor.systemGray6
        sc.accessibilityIdentifier = "RichTextViewSegmentedControl"
        return sc
    }()
    
    private var isTextSelected: Bool {
        get {
            guard let textRange = self.textView.selectedTextRange else {
                return false
            }
            if (textRange.end == textRange.start) {
                return false
            }
            return true
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 200)
    }
    
    //
    // MARK: Property Accessors
    //
    func setText(_ string: String) {
        self.textView.attributedText = NSMutableAttributedString(string: string)
    }
    
    func setAttributedString(_ attributedString: NSAttributedString) {
        self.textView.attributedText = attributedString
    }
    
    func getAttributedString() -> NSAttributedString {
        return self.textView.attributedText
    }

    
    //
    // MARK: Initializers
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        if (frame == .zero) {
            self.frame = CGRect(origin: .zero, size: self.intrinsicContentSize)
        }
        self.commonInit()
        self.setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
        self.setupSubviews()
    }
    
    private func commonInit() {
        self.layer.borderColor = UIColor.systemFill.cgColor
        self.layer.borderWidth = 1
        // Prevent text from overriding styling selection segmented control
        self.textView.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 45, right: 0)
        self.textView.typingAttributes = [TextAttribute.plain.attribute:TextAttribute.plain.value]
        self.clipsToBounds = true
        self.accessibilityIdentifier = "RichTextView"
    }
    
    //
    // MARK: Internal Class Methods
    //
    private func setupSubviews() {
        self.addSubview(textView)
        self.addSubview(attributeSelector)
        
        let constraints: [NSLayoutConstraint] = [
            textView.topAnchor.constraint(equalTo: super.topAnchor),
            textView.leadingAnchor.constraint(equalTo: super.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: super.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: super.bottomAnchor),
            
            attributeSelector.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 8.0),
            attributeSelector.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -8.0),
            attributeSelector.heightAnchor.constraint(equalToConstant: 32),
            attributeSelector.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -8.0),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    //
    // MARK: Actions
    //
    @objc private func editModeDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                self.setAttribute(to: .plain)
            case 1:
                self.setAttribute(to: .bold)
            case 2:
                self.setAttribute(to: .italic)
            case 3:
                self.setAttribute(to: .strikethrough)
            default:
                return
        }
    }
    
    private func setAttribute(to textAttribute: TextAttribute) {
        if (isTextSelected) {
            let range = textView.selectedRange
            let mutableSelectedText = NSMutableAttributedString(attributedString: textView.attributedText)
            mutableSelectedText.setAttributes([textAttribute.attribute:textAttribute.value], range: range)
            self.textView.attributedText = mutableSelectedText
            self.textView.selectedRange = range
        } else {
            textView.typingAttributes.removeAll()
            textView.typingAttributes = [textAttribute.attribute: textAttribute.value]
        }
    }
        
    //
    // MARK: UITextViewDelegate
    //
    func textViewDidChangeSelection(_ textView: UITextView) {
        let typingAttributes = textView.typingAttributes
        if let fontValue = typingAttributes[.font] as? UIFont {
            if let numberValue = typingAttributes[.strikethroughStyle] as? Int {
                switch numberValue {
                    case 1:
                        self.attributeSelector.selectedSegmentIndex = 3
                    default:
                        return
                }
            }
            switch fontValue {
                case TextAttribute.plain.value as? UIFont:
                    self.attributeSelector.selectedSegmentIndex = 0
                case TextAttribute.bold.value  as? UIFont:
                    self.attributeSelector.selectedSegmentIndex = 1
                case TextAttribute.italic.value as? UIFont:
                    self.attributeSelector.selectedSegmentIndex = 2
                default:
                    return
            }
            return
        }
    }
    
}
