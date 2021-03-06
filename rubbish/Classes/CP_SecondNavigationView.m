//
//  CP_SecondNavigationView.m
//  kongjiantabbat
//
//  Created by houchenguang on 12-11-30.
//
//

#import "CP_SecondNavigationView.h"
#import "SharedMethod.h"

@implementation CP_SecondNavigationView
@synthesize bgImgeView;
//@synthesize tiaoImageView;
@synthesize delegate;
@synthesize myImageArray;
@synthesize mySelectImageArray;

- (void)setMarkArray:(NSMutableArray *)_markArray{
    if (markArray != _markArray) {
        [markArray release];
        markArray = [_markArray retain];
    }
    NSInteger icou = 0;
    if ([markArray count] > buttonCount){
        icou = buttonCount;
    }else{
        icou = [markArray count];
    }
    for (int i = 0; i < icou; i++) {
       
        UIImageView * image = (UIImageView *)[self viewWithTag:buttonCount+i+1];
        if(![[markArray objectAtIndex:i] isEqualToString:@"0"]){
            image.image = [UIImage imageNamed:@"XIHD960.png"];
        }else{
        
            image.image = nil;
        
        }
    if (i+1 == selectedIndex){
        image.image = nil;
    
    }
        
    }
    
    int select = 0;
    for (int i = 0; i < [markArray count]; i++) {
        if (![[markArray objectAtIndex:i] isEqualToString:@"0"]) {
            select = i;
            break;
        }
    }
    if (panduandiyici) {
         self.selectedIndex = select+1;
        panduandiyici = NO;
    }
    
    
}




- (NSMutableArray *)markArray{
    return markArray;
}

- (NSInteger)selectedIndex{
    return selectedIndex;
}

- (void)setSelectedIndex:(NSInteger)_selectedIndex{
    if (_selectedIndex > buttonCount) {
        selectedIndex = 0;
    }else{
         selectedIndex = _selectedIndex;
    }
   
    UIImageView * image = (UIImageView *)[self viewWithTag:buttonCount+_selectedIndex];
    image.image = nil;
//    [self animationFunc:selectedIndex];
    
    for (int i = 0; i < myImageArray.count; i++) {
        UIImageView * selectImageView = (UIImageView *)[self viewWithTag:1000 + i];
        if (i == _selectedIndex - 1) {
            selectImageView.image = [UIImage imageNamed:[mySelectImageArray objectAtIndex:i]];
        }else{
            selectImageView.image = [UIImage imageNamed:[myImageArray objectAtIndex:i]];
        }
    }
    
    
     [self  secondDelegateSelectedIndex:_selectedIndex];
}

- (void)dealloc{
    [markArray release];
    [bgImgeView release];
//    [tiaoImageView release];

    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame buttonImageName:(NSArray *)imageArray selectImageName:(NSArray *)selectImageArray
{

    self = [super initWithFrame:frame];
    if (self) {
        self.myImageArray = imageArray;
        self.mySelectImageArray = selectImageArray;
        
        panduandiyici = YES;
        // Initialization code
        buttonCount = [imageArray count];
        bgImgeView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgImgeView.backgroundColor = [SharedMethod getColorByHexString:@"10518d"];
//        bgImgeView.image = [[UIImage imageNamed:@"EJDH960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:22];
        [self addSubview:bgImgeView];
        
        float width = 0;
        for (int i = 0; i < [imageArray count]; i++) {
            UIButton * buttonImage = [UIButton buttonWithType:UIButtonTypeCustom];
           // [buttonImage setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]] forState:UIControlStateNormal];
            buttonImage.tag = i+1;
            [buttonImage addTarget:self action:@selector(pressButtonImage:) forControlEvents:UIControlEventTouchUpInside];
          //  buttonImage.frame = CGRectMake(width + ((self.frame.size.width/[imageArray count] - 20)/2), 10, 20, 18);
            buttonImage.frame = CGRectMake(width, 0, self.frame.size.width/[imageArray count], self.frame.size.height);
            [self addSubview:buttonImage];
            
            UIImageView * imagebut = [[UIImageView alloc] initWithFrame: CGRectMake(width + ((self.frame.size.width/[imageArray count] - 22)/2), 10, 22, 22)];
            if (i == imageArray.count - 1) {
                imagebut.frame = CGRectMake(imagebut.frame.origin.x, imagebut.frame.origin.y + 2, imagebut.frame.size.width, 18);
            }
            imagebut.backgroundColor = [UIColor  clearColor];
            imagebut.tag = 1000 + i;
            imagebut.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
            [self addSubview:imagebut];
            [imagebut release];
            
            
            UIImageView * _markimage = [[UIImageView alloc] initWithFrame:CGRectMake(width + ((self.frame.size.width/[imageArray count] - 22)/2)+22,  6, 6, 6)];
            _markimage.backgroundColor = [UIColor clearColor];
            _markimage.tag = buttonCount+1+i;
            [self addSubview:_markimage];
            [_markimage release];
            
            
            width += self.frame.size.width/[imageArray count];
            
        }
        
       // UIButton * oneButton = (UIButton *)[self viewWithTag:1];
        
//        tiaoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(((self.frame.size.width/buttonCount - 20)/2), 33, 20, 3)];
//        tiaoImageView.backgroundColor = [UIColor clearColor];
//        tiaoImageView.image = [UIImage imageNamed:@"XIH960.png"];
//        [self addSubview:tiaoImageView];
        
    }
    return self;
}

//- (void)animationFunc:(NSInteger)sender{//动画功能
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    [UIView setAnimationDuration:0.3];
// //   UIButton * oneButton = (UIButton *)[self viewWithTag:sender];
//   // tiaoImageView.frame = CGRectMake(oneButton.frame.origin.x, tiaoImageView.frame.origin.y, tiaoImageView.frame.size.width, tiaoImageView.frame.size.height);
////    tiaoImageView.frame = CGRectMake((self.frame.size.width/buttonCount)*(sender-1)+((self.frame.size.width/buttonCount - 20)/2), 33, 20, 3);
//    
//    [UIView commitAnimations];
//}

- (void)pressButtonImage:(UIButton *)sender{
    
//    [self animationFunc:sender.tag];
    self.selectedIndex = sender.tag;
    
    UIImageView * image = (UIImageView *)[self viewWithTag:buttonCount+sender.tag];
    image.image = nil;
    
    [self  secondDelegateSelectedIndex:sender.tag];

}

- (void)secondDelegateSelectedIndex:(NSInteger)index{
    if ([delegate respondsToSelector:@selector(secondDelegateSelectedIndex:)]) {
        [delegate secondDelegateSelectedIndex:index];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
            
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    