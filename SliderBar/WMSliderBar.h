//
//  WMSliderBar.h
//  SliderBar
//
//  Created by jackli on 2017/4/6.
//  Copyright © 2017年 jackli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMSliderBar : UIView

/** <#desc#> */
@property (nonatomic, assign) int selectedIndex;
/** <#desc#> */
@property (nonatomic, strong) NSMutableArray *dataSource;
@end
