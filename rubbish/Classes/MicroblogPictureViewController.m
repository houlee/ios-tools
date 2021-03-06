//
//  MicroblogPictureViewController.m
//  caibo
//
//  Created by houchenguang on 14-10-31.
//
//

#import "MicroblogPictureViewController.h"
#import "Info.h"
#import "caiboAppDelegate.h"


@interface MicroblogPictureViewController ()

@end

@implementation MicroblogPictureViewController
@synthesize delegate;

- (void)setSelectImage:(UIImage *)_selectImage{
    if (selectImage != _selectImage) {
        [selectImage release];
        selectImage = [_selectImage retain];
    }
   
}

//- (void)viewWillDisappear:(BOOL)animated{
//    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
//    app.window.backgroundColor = [UIColor whiteColor];
//    [super viewWillDisappear:animated];
//}

- (UIImage *)selectImage{
    return selectImage;
}

- (void)dealloc{
    [selectImage release];
    [super dealloc];
}

- (void)pressPictureButton:(UIButton *)sender{

    if (sender.selected) {
        sender.selected = NO;
        
//        [UIView beginAnimations:@"nddd" context:NULL];
//        [UIView setAnimationDuration:.3];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        self.CP_navigation.frame = CGRectMake(self.CP_navigation.frame.origin.x,  self.CP_navigation.frame.origin.y, self.CP_navigation.frame.size.width, self.CP_navigation.frame.size.height);
//        [UIView commitAnimations];
        self.CP_navigation.hidden = NO;
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        showBool = NO;
        
    }else{
        sender.selected = YES;
        
        self.CP_navigation.hidden = YES;
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        showBool= YES;
//        [UIView beginAnimations:@"nddd" context:NULL];
//        [UIView setAnimationDuration:.3];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        self.CP_navigation.frame = CGRectMake(self.CP_navigation.frame.origin.x, -self.CP_navigation.frame.size.height, self.CP_navigation.frame.size.width, self.CP_navigation.frame.size.height);
//        [UIView commitAnimations];
    }
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
}

- (BOOL)prefersStatusBarHidden
{
    return showBool;//隐藏为YES，显示为NO
}

- (void)actionBack{
    [self.navigationController popViewControllerAnimated:YES];
    UIButton * bgButton = (UIButton *)[self.mainView viewWithTag:1001];
    bgButton.hidden = YES;
    
}

- (void)deleteButton:(UIButton *)sender{

    if(delegate && [delegate respondsToSelector:@selector(microblogPictureDelegateFunc)])
    {
        [delegate microblogPictureDelegateFunc];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.CP_navigation.alpha = 0.5;
    self.CP_navigation.title = @"发微博";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(actionBack)];
    self.CP_navigation.leftBarButtonItem = leftItem;
    
    
    
    UIButton *btnwan = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnwan setBounds:CGRectMake(0, 0, 70, 40)];
    UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
    imagevi.backgroundColor = [UIColor clearColor];
//    imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    [btnwan addSubview:imagevi];
    [imagevi release];
    
    UIImageView * deleteImage = [[UIImageView alloc] initWithFrame:CGRectMake(38, 9, 16, 20)];
    deleteImage.image = UIImageGetImageFromName(@"deleteimagewb.png");
    [btnwan addSubview:deleteImage];
    [deleteImage release];
    
    [btnwan addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btnwan];
    self.CP_navigation.rightBarButtonItem = barBtnItem;
    [barBtnItem release];

    
    
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];

    UIButton * pictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pictureButton.backgroundColor = [UIColor blackColor];
    pictureButton.tag = 1001;
    NSLog(@"ddd = %f", app.window.frame.size.height - self.mainView.frame.size.height);
    pictureButton.frame = CGRectMake(0,  self.mainView.frame.size.height - app.window.frame.size.height , self.mainView.frame.size.width, app.window.frame.size.height);
    [pictureButton addTarget:self action:@selector(pressPictureButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:pictureButton];
    
    self.mainView.backgroundColor = [UIColor blackColor];
    pictureImageView = [[UIImageView alloc] initWithFrame:pictureButton.bounds];
    pictureImageView.backgroundColor = [UIColor clearColor];
    [pictureButton addSubview:pictureImageView];
    [pictureImageView release];
    
    
    
    
   
    
    
    float imageWidth = selectImage.size.width;
    float imageHight = selectImage.size.height;
   
    
    if ((imageHight <= pictureButton.frame.size.height) && (imageWidth <= pictureButton.frame.size.width)) {
        pictureImageView.frame = CGRectMake((pictureButton.frame.size.width - selectImage.size.width)/2, (pictureButton.frame.size.height - selectImage.size.height)/2, selectImage.size.width, selectImage.size.height);
        pictureImageView.image  = selectImage;
        return;
    }
    
    if (imageWidth > pictureButton.frame.size.width && imageWidth > imageHight) {
        
        float widthProportion = selectImage.size.width / pictureButton.frame.size.width;
       
        imageWidth = pictureButton.frame.size.width;
        imageHight = selectImage.size.height / widthProportion;
        
        pictureImageView.frame = CGRectMake((pictureButton.frame.size.width - imageWidth)/2, (pictureButton.frame.size.height - imageHight)/2, imageWidth, imageHight);
        
        
    }
    
    
    if (imageHight > pictureButton.frame.size.height && imageHight > imageWidth) {
        float hightProportion = selectImage.size.height / pictureButton.frame.size.height;
        
        
        imageHight = pictureButton.frame.size.height;
        imageWidth = selectImage.size.width / hightProportion;
        
        pictureImageView.frame = CGRectMake((pictureButton.frame.size.width - imageWidth)/2, (pictureButton.frame.size.height - imageHight)/2, imageWidth, imageHight);
        
    }
    
    pictureImageView.image  = selectImage;
    
    NSLog(@"imageWidth = %f , imageHight = %f", imageWidth, imageHight);
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    