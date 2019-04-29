//
//  FFStarView.h
//  FFStarView_Example
//
//  Created by 肖凡 on 2019/4/26.
//  Copyright © 2019年 fanxiaoApple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FFStarViewTypeSelect,
    FFStarViewTypeShow,
} FFStarViewType;

typedef void(^starClickBlock)(int starScore);

@interface FFStarView : UIView

/**星星间距*/
@property (nonatomic, assign) CGFloat starMargin;
/**分数*/
@property (nonatomic, assign) CGFloat starScore;
/**星星个数*/
@property (nonatomic, assign) int starCount;
/**类型，展示/打分*/
@property (nonatomic, assign) FFStarViewType type;
/**点击打分后回调*/
@property (nonatomic, copy) starClickBlock clickBlock;
@end
