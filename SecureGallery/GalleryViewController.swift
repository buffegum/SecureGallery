import UIKit

enum Direction{
    case next
    case previous
}
class GalleryViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textField: UITextField!
    let likeImageView = UIImageView()
    let likeView = UIView()

    private var currentPhoto = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        addLikeView()
        setStartImage()
        
        
        
    
    }
    
    @IBAction func backButtonPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func previousImageButtonPress(_ sender: UIButton) {
        animationMoveSecondView(direction: .previous)    }
    
    @IBAction func nextImageButtpnPress(_ sender: UIButton) {
        animationMoveSecondView(direction: .next)
    }
    

    func getPhotoArray()->[Photo]{
        guard let photo = UserDefaults.standard.value([Photo].self, for: Keys.photo.rawValue)else{return []}
        return photo
    }
    
    func changeCurrentPhoto(direction: Direction){
        let photoArray = getPhotoArray()
        if photoArray.count > 0{
        
        switch direction {
        case .next:
            if currentPhoto == photoArray.count - 1{
                currentPhoto = 0
            }
            else{
                currentPhoto += 1
            }
            
        case .previous:
            if currentPhoto == 0 {
                currentPhoto = photoArray.count - 1
            }
            else{
                currentPhoto -= 1
        }
        }
       
        }    }
    
    func setStartImage(){
        let photoArray = getPhotoArray()
        imageView.image = loadImage(fileName: photoArray[currentPhoto].name)
        textField.text = photoArray[currentPhoto].comment
        setLikeImageView(cond: photoArray[currentPhoto].like)
        print(photoArray[currentPhoto].like)
    }
    
  
    func animationMoveSecondView(direction:Direction){
        let photoArray = getPhotoArray()
        saveComment(array: photoArray)
        switch direction {
        case .next:
            //saveComment(array: photoArray)
            changeCurrentPhoto(direction: direction)
            textField.text = photoArray[currentPhoto].comment
            let secondImageView = UIImageView(frame: CGRect(x: self.view.frame.width  , y: imageView.frame.origin.y , width: imageView.frame.width, height: imageView.frame.height))
            secondImageView.image = loadImage(fileName: photoArray[currentPhoto].name)
            self.view.addSubview(secondImageView)
            UIView.animate(withDuration: 0.3) {
                secondImageView.frame.origin.x = self.imageView.frame.origin.x
            }completion: { _ in
                self.imageView.image = self.loadImage(fileName: photoArray[self.currentPhoto].name)
                secondImageView.removeFromSuperview()
            }
            textField.text = photoArray[currentPhoto].comment
        case .previous:
            let secondImageView = UIImageView(frame: imageView.frame)
            secondImageView.frame.origin.x = self.imageView.frame.origin.x
            secondImageView.image = loadImage(fileName: photoArray[currentPhoto].name)
            self.view.addSubview(secondImageView)
            changeCurrentPhoto(direction: direction)
            textField.text = photoArray[currentPhoto].comment
            imageView.image = loadImage(fileName: photoArray[currentPhoto].name)
            UIView.animate(withDuration: 0.3) {
                secondImageView.frame.origin.x =  -secondImageView.frame.width
            } completion: { _ in
                secondImageView.removeFromSuperview()
                
            }
        }
        setLikeImageView(cond: photoArray[currentPhoto].like)
        print(photoArray[currentPhoto].like)
    }
    
    func saveComment(array: [Photo]){
        guard let text = textField.text else{return}
        if text != array[currentPhoto].comment {
            array[currentPhoto].comment = textField.text
            UserDefaults.standard.set(encodable: array, for: Keys.photo.rawValue)
        }
    }
    
    func addLikeView(){
        let size: CGFloat = 40
        likeImageView.frame = CGRect(x: imageView.frame.width - 2 * size, y: 0, width: size, height: size)
        likeView.frame = likeImageView.frame
        imageView.addSubview(likeImageView)
        //imageView.addSubview(likeView)
        //likeImageView.image = UIImage(named: "unlike")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.touchScreen(_:)))
        imageView.isUserInteractionEnabled = true
        likeImageView.isUserInteractionEnabled = true
        self.likeImageView.addGestureRecognizer(tap)
        
    }
    
    
    
    
    
    
    func changeLikeInArray(){
        let array = getPhotoArray()
        array[currentPhoto].like = !array[currentPhoto].like
        UserDefaults.standard.set(encodable: array, for: Keys.photo.rawValue)
        setLikeImageView(cond: array[currentPhoto].like)
    }
    
    func setLikeImageView(cond:Bool){
        let image: UIImage?
        if cond {
            image = UIImage(named: "like")
        }else {
            image = UIImage(named: "unlike")
        }
        likeImageView.image = image
    }

@objc func touchScreen(_ sender: UITapGestureRecognizer){
    changeLikeInArray()
}
    
    
    //funcLoadImage
    func loadImage(fileName:String)->UIImage?{
        if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imageUrl = docDir.appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }

    
}
extension GalleryViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
