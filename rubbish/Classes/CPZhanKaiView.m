//
//  CPZhanKaiView.m
//  caibo
//
//  Created by yaofuyu on 13-1-17.
//
//

#import "CPZhanKaiView.h"
#import <QuartzCore/QuartzCore.h>
#import "ColorView.h"

@implementation CPZhanKaiView

@synthesize zhankaiDelegate = _zhankaiDelegate;
@synthesize normalHeight = _normalHeight;
@synthesize zhankaiHeight = _zhankaiHeight;
@synthesize isOpen = _isOpen,canZhanKaiByTouch = _canZhanKaiByTouch;
@synthesize fengeImageView = _fengeImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer setMasksToBounds:YES];
        _canZhanKaiByTouch = YES;
        // Initialization code
    }
    return self;
}

- (void)openByTouch {
    _isOpen = !_isOpen;
    if (_isOpen) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        _fengeImageView.frame = CGRectMake(_fengeImageView.frame.origin.x, _zhankaiHeight - _fengeImageView.frame.size.height, _fengeImageView.frame.size.width, _fengeImageView.frame.size.height);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _zhankaiHeight);
        [UIView commitAnimations];
        
    }
    else {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        _fengeImageView.frame = CGRectMake(_fengeImageView.frame.origin.x, _normalHeight - _fengeImageView.frame.size.height, _fengeImageView.frame.size.width, _fengeImageView.frame.size.height);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _normalHeight);
        
        [UIView commitAnimations];
    }
    if (_zhankaiDelegate && [_zhankaiDelegate respondsToSelector:@selector(ZhankaiViewClicke:)]) {
        
        [_zhankaiDelegate ZhankaiViewClicke:self];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_canZhanKaiByTouch) {
        return;
    }
    [self openByTouch];
}

- (void)dealloc {
    self.zhankaiDelegate = self;
    self.fengeImageView = nil;
    [super dealloc];
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