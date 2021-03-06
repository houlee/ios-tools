//
//  YrbSectionHeaderView.m
//  caibo
//
//  Created by  on 12-2-15.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "YrbSectionHeaderView.h"
#import "ColorUtils.h"
@implementation YrbSectionHeaderView
@synthesize opened,delegate,section,titleLabel,disclosureButton;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)aTitle delegate:(id)aDelegate section:(NSInteger)aSection open:(BOOL)isOpened
{
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleAction:)];
        [self addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        self.section = aSection;
        self.opened = isOpened;
        self.delegate = aDelegate;
        [self setUserInteractionEnabled:YES];
        
        CGRect titleRect = self.bounds;
        titleRect.origin.x += 15;
        titleRect.size.width -= 15;
        CGRectInset(titleRect, 0.0, 5.0);
        
        UILabel *tmpLabel = [[UILabel alloc]initWithFrame:titleRect];
        [tmpLabel setFont:[UIFont systemFontOfSize:17.0]];
        [tmpLabel setText:aTitle];
        [tmpLabel setTextColor:[UIColor blackColor]];
        [tmpLabel setTextAlignment:NSTextAlignmentLeft];
        [tmpLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:tmpLabel];
        self.titleLabel = tmpLabel;
        [tmpLabel release];
        
        UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tmpButton setFrame:CGRectMake(280, -2, 35, 35)];
        [tmpButton setImage:UIImageGetImageFromName(@"carat.png")forState:UIControlStateNormal];
        [tmpButton setImage:UIImageGetImageFromName(@"carat-open.png") forState:UIControlStateSelected];
        [tmpButton setSelected:self.opened];
        [tmpButton setUserInteractionEnabled:NO];
        self.disclosureButton = tmpButton;
        [self addSubview:tmpButton];
		self.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"xihaoSection.png")];
		
    }
    return self;
}
- (void)dealloc
{
    [titleLabel release];
    [disclosureButton release];
    [super dealloc];
}

- (void)toggleAction:(id)sender
{
    self.disclosureButton.selected = !self.disclosureButton.selected;
    if (self.disclosureButton.selected) {
        if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
            [self.delegate sectionHeaderView:self sectionOpened:section];
    }
    }else
        {
        if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
			[self.delegate sectionHeaderView:self sectionClosed:section];
        }
        }
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