//
//  WMSliderItem.m
//  SliderBar
//
//  Created by jackli on 2017/4/6.
//  Copyright © 2017年 jackli. All rights reserved.
//

#import "WMSliderItem.h"

@implementation WMSliderItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setSelected:(BOOL)selected {
    super.selected = selected;
    if (selected) {
        self.backgroundColor= [UIColor blackColor];
    } else {
        self.backgroundColor= [UIColor clearColor];
    }
}
@end
