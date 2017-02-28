//
//  OptionView.m
//  nen
//
//  Created by nenios101 on 2017/2/28.
//  Copyright © 2017年 nen. All rights reserved.
//

#import "OptionView.h"
#import "OptionModel.h"

@interface OptionView ()
//@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *button;

@end


@implementation OptionView


- (instancetype)initWithFrame:(CGRect)frame Model:(OptionModel *)model
{
    
    _model = model;
    
    self = [super initWithFrame:frame];
    if (self)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat buttonX = 5;
        CGFloat buttonY = 0;
        CGFloat buttonW = 50;
        CGFloat buttonH = 50;
        [_button setBackgroundImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(tapButton) forControlEvents:UIControlEventTouchUpInside];
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
        _button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self addSubview:_button];
        
        UILabel *namelable = [[UILabel alloc] init];
        namelable.font = [UIFont systemFontOfSize:13];
        namelable.frame = CGRectMake(0, (buttonY + buttonH)+ 5,self.frame.size.width,15);
        namelable.textColor = [UIColor blackColor];
        namelable.textAlignment = NSTextAlignmentCenter;
        namelable.text = model.name;
        [self addSubview:namelable];
        
        
        
    }
    return self;
}

- (void)tapButton
{
    NSLog(@"按钮比点击");
}

@end
