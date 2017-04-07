//
//  WMSliderBar.m
//  SliderBar
//
//  Created by jackli on 2017/4/6.
//  Copyright © 2017年 jackli. All rights reserved.
//

#import "WMSliderBar.h"
#import "WMSliderItem.h"
#import "Masonry.h"


@interface WMSliderBar ()

/** <#desc#> */
@property (nonatomic, strong) UIImageView *arrow;
/** <#desc#> */
@property (nonatomic, strong) UIScrollView *scroller;
/** <#desc#> */
@property (nonatomic, strong) UIView *line;
@end
@implementation WMSliderBar

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectedIndex = 0;
        self.scroller = [UIScrollView new];
        self.scroller.showsVerticalScrollIndicator = NO;
        self.scroller.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scroller];
        [self.scroller mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@-20);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
        self.line = [UIView new];
        self.line.backgroundColor=[UIColor greenColor];
        [self.scroller addSubview:self.line];
    }
    return self;
}
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self refreshButtonState];
    [self refreshOffset];
    [self refreshLineConstraint];
}
- (void)setDataSource:(NSMutableArray *)dataSource {
    
    UIButton *oldItem;
    int i = 0;
    for (NSString *title in dataSource) {
        WMSliderItem *item = [WMSliderItem new];
        item.tag = i;
        [item addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
        if (i == _selectedIndex) {
            item.selected = YES;
        } else {
            item.selected = NO;
        }
        [item setTitle:title forState:UIControlStateNormal];
        [self.scroller addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!oldItem) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(oldItem.mas_right);
            }
            make.top.equalTo(@0);
            make.bottom.equalTo(self.scroller.mas_bottom);
            make.width.equalTo(@50);
            make.height.equalTo(self.scroller.mas_height).with.offset(-2);
        }];
        oldItem = item;
        i++;
    }
    if (oldItem) {
        [oldItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.scroller);
        }];
    }
    [self.scroller bringSubviewToFront:self.line];
    [self refreshLineConstraint];
}
- (void)btnClicked:(UIButton *)sender {
    if (sender.tag == _selectedIndex) {
        //        return;
    }
    self.selectedIndex = sender.tag;
}
- (void)refreshButtonState {
    for (UIView *view in self.scroller.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button =(UIButton *)view;
            if (button.tag == _selectedIndex) {
                button.selected = YES;
            } else {
                button.selected = NO;
            }
        }
    }
}
- (void)refreshOffset {
    float left = 80;
    UIButton *button;
    for (UIView *view in self.scroller.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *buttonTmp =(UIButton *)view;
            if (buttonTmp.tag == _selectedIndex) {
                button =buttonTmp;
                break;
            }
        }
    }
    CGRect rect = [self.scroller convertRect:button.frame toView:self];
    CGPoint point = self.scroller.contentOffset;
    float maxOffsetX = self.scroller.contentSize.width - self.scroller.frame.size.width;
    //左移
    if (rect.origin.x < left) {
        float newOffsetX = point.x - (left-rect.origin.x);
        [self.scroller setContentOffset:CGPointMake(newOffsetX > 0 ? newOffsetX : 0, 0) animated:YES];
    }
    //右移
    else {
        float newOffsetX = point.x +(rect.origin.x - left);
        [self.scroller setContentOffset:CGPointMake(newOffsetX < maxOffsetX ? newOffsetX : maxOffsetX, 0) animated:YES];
    }
}
- (void)refreshLineConstraint {
    UIButton *button;
    for (UIView *view in self.scroller.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *buttonTmp =(UIButton *)view;
            if (buttonTmp.tag == _selectedIndex) {
                button =buttonTmp;
                break;
            }
        }
    }
    
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.width.equalTo(button);
        make.top.equalTo(self.scroller.mas_bottom);
        make.height.equalTo(@2);
    }];
    [UIView animateWithDuration:0.2 animations:^{[self layoutIfNeeded];}];
}
@end
