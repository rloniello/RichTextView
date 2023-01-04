#  RichTextView

### Overview
RichTextView is a subclass of UIView that allows the user to display and edit rich text content with various font styles, including bold, italic, normal, and strikethrough. It is implemented as a drop-in replacement for UITextView. RichTextView is a convenient and easy-to-use View for displaying and editing rich text content in your iOS applications.

![Screenshot of RichTextView](https://github.com/rloniello/RichTextView/blob/main/Other/screenshot.png)


### Use
1) Download / Clone or Copy the `RichTextView.swift` in this repository. Add it to your Project. (You may also want to copy tests as well).

2) To use RichTextView, you simply need to create an instance of it and add it to your view hierarchy.
The Intrisic content size is 300 (width) x 200 (height). You can create your own frame during initialization or add custom constraints after initialization like a regular UIView.

```
class ViewController: UIViewController {
    
    private var richTextView: RichTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.richTextView = RichTextView()
        self.setupSubviews()
    }

    func setupSubviews() {
        self.richTextView.center = self.view.center
        self.view.addSubview(self.richTextView)
    }
    
}
```

### Reading and Writting Values
You may use the following properties and methods to access data stored in the RichTextView:

```
    public var attributedText: NSAttributedString { get }
    
    public var currentFont: UIFont? { get }
```

Remember you can get the a string value from `attributedText.string`

```
    func setText(_ string: String)
    
    func setAttributedString(_ attributedString: NSAttributedString)
    
    func getAttributedString() -> NSAttributedString 
```
