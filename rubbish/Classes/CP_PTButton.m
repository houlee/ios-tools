//
//  CP_PTButton.m
//  iphone_control
//
//  Created by zhang on 12/4/12.
//  Copyright (c) 2012 yaofuyu. All rights reserved.
//

#import "CP_PTButton.h"

@implementation CP_PTButton
@synthesize buttonImage;
@synthesize buttonName;
@synthesize otherImage;
@synthesize selectImage;
@synthesize nomorImage;
@synthesize hightImage;
@synthesize showNomore;
@synthesize selectTextColor;
@synthesize nomorTextColor;
@synthesize highTextColor;
@synthesize otherLabel;
@synthesize showShadow;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        showNomore = NO;
    }
    return self;
}

- (void)loadButonImage:(NSString *)imageName LabelName:(NSString *)labeName {
        
    if (!buttonImage && imageName) {
        buttonImage = [[UIImageView alloc] init];
        buttonImage.frame = self.bounds;
        [self addSubview:buttonImage];
//        [buttonImage release];
    }
    buttonImage.image = [UIImageGetImageFromName(imageName) stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    self.nomorImage = buttonImage.image;
    self.backgroundColor = [UIColor clearColor];
    if (!buttonName) {
        buttonName = [[UILabel alloc] init];
        buttonName.textAlignment = NSTextAlignmentCenter;
        buttonName.backgroundColor = [UIColor clearColor];
        buttonName.text = labeName;
        buttonName.frame = self.bounds;
        buttonName.font = [UIFont boldSystemFontOfSize:18];
        buttonName.textColor = [UIColor whiteColor];
        [self addSubview:buttonName];
    }
    buttonName.text = labeName;

}

- (void)setFrame:(CGRect)frame {
    if (CGRectEqualToRect(buttonImage.bounds, self.bounds)) {
        [super setFrame:frame];
        
        buttonImage.frame = self.bounds;
        buttonName.frame = self.bounds;
    }
    else {
        [super setFrame:frame];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (!self.nomorTextColor) {
        self.nomorTextColor = self.buttonName.textColor;
    }
    if (highTextColor) {
        
        self.buttonName.textColor = highTextColor;
    }
    if (self.hightImage) {
        if (!self.nomorImage) {
            self.nomorImage = self.buttonImage.image;
        }
        self.buttonImage.image = self.hightImage;
        return;
    }
    if (showNomore&&!self.selectImage) {
        self.buttonName.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5];
        return;
    }
    self.buttonImage.alpha = 0.75;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.selected = self.selected;
    if (self.hightImage) {
        self.buttonImage.image = self.nomorImage;
        return;
    }
    if (showNomore && !self.selectImage) {
        self.buttonName.backgroundColor = [UIColor clearColor];
        return;
    }
    self.buttonImage.alpha = 1.0;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    self.selected = self.selected;
    if (self.hightImage) {
        self.buttonImage.image = self.nomorImage;
        return;
    }
    if (showNomore&&!self.selectImage) {
        self.buttonName.backgroundColor = [UIColor clearColor];
        return;
    }
    self.buttonImage.alpha = 1.0;
}



- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (self.selectImage) {
        if (selected) {
            self.buttonImage.image = self.selectImage;
        }
        else {
            self.buttonImage.image = self.nomorImage;
        }
    }
        if (selected) {
            if (self.selectTextColor) {
                self.buttonName.textColor = self.selectTextColor;
            }
            
        }
        else {
            if (self.nomorTextColor) {
                self.buttonName.textColor = self.nomorTextColor;
            }
            
        }
}

- (void)setOtherImage:(UIImageView *)_otherImage {
    [otherImage release];
    [otherImage removeFromSuperview];
    otherImage = [_otherImage retain];
    [self addSubview:otherImage];
}

- (void)dealloc {
    self.nomorImage = nil;
    self.otherImage = nil;
    self.selectImage = nil;
    self.buttonImage = nil;
    self.hightImage = nil;
    self.nomorTextColor = nil;
    self.selectTextColor = nil;
    self.highTextColor = nil;
    self.otherLabel = nil;
    self.buttonImage = nil;
    self.buttonName = nil;
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