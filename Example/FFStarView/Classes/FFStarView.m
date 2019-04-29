//
//  FFStarView.m
//  FFStarView_Example
//
//  Created by 肖凡 on 2019/4/26.
//  Copyright © 2019年 fanxiaoApple. All rights reserved.
//

#import "FFStarView.h"

@interface FFStarView ()
@property (nonatomic, strong) UIImage *normalStarImage;
@property (nonatomic, strong) UIImage *lightedStarImage;
@property (nonatomic, strong) NSMutableArray<UIButton *> *normalBtnArray;
@property (nonatomic, strong) NSMutableArray<UIButton *> *lightedBtnArray;
/**亮星content约束*/
@property (nonatomic, strong) NSArray *lightedStarContentConstArray;
/**亮星content*/
@property (nonatomic, weak) UIView *lightedStarContent;
@end

@implementation FFStarView
-(NSMutableArray<UIButton *> *)normalBtnArray{
    if (!_normalBtnArray) {
        _normalBtnArray = [NSMutableArray array];
    }
    return _normalBtnArray;
}
-(NSMutableArray<UIButton *> *)lightedBtnArray{
    if (!_lightedBtnArray) {
        _lightedBtnArray = [NSMutableArray array];
    }
    return _lightedBtnArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.starCount = 5;
        self.starMargin = 5;
        self.starScore = 0;//这里三个赋值的顺序不要调整
        self.type = FFStarViewTypeSelect;
    }
    return self;
}
- (void) commonInit {
    // 获取星星图片
    NSBundle *resourcesBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"FFStarView" ofType:@"bundle"]];
    _normalStarImage = [UIImage imageNamed:@"1yy_star_dark" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
    _lightedStarImage = [UIImage imageNamed:@"1yy_star_bright" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
    // 添加底部5个暗星
    for (int i = 0; i < self.starCount; i++) {
        UIButton *normalStarBtn = [[UIButton alloc] init];
        normalStarBtn.imageView.contentMode = UIViewContentModeScaleToFill;
        [normalStarBtn setImage:_normalStarImage forState:UIControlStateNormal];
        [normalStarBtn setImage:_normalStarImage forState:UIControlStateHighlighted];
        [self addSubview:normalStarBtn];
        [self.normalBtnArray addObject:normalStarBtn];
        
        [normalStarBtn addTarget:self action:@selector(starBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    // 亮星contentView
    UIView *lightedStarContent = [UIView new];
    lightedStarContent.userInteractionEnabled = NO;
    lightedStarContent.clipsToBounds = YES;
    [self addSubview:lightedStarContent];
    self.lightedStarContent = lightedStarContent;
    
    //lightedStarContent constraint
    lightedStarContent.translatesAutoresizingMaskIntoConstraints = NO;
    [self removeConstraints:self.lightedStarContentConstArray];
    NSLayoutConstraint *contentConstTop = [NSLayoutConstraint constraintWithItem:lightedStarContent attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *contentConstLeft = [NSLayoutConstraint constraintWithItem:lightedStarContent attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *contentConstBottom = [NSLayoutConstraint constraintWithItem:lightedStarContent attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *contentConstRight = [NSLayoutConstraint constraintWithItem:lightedStarContent attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    self.lightedStarContentConstArray = @[contentConstTop, contentConstLeft, contentConstBottom, contentConstRight];
    [self addConstraints:self.lightedStarContentConstArray];
    
    // 添加5个亮星
    for (int i = 0; i < self.starCount; i++) {
        UIButton *lightedStarBtn = [[UIButton alloc] init];
        [lightedStarBtn setImage:_lightedStarImage forState:UIControlStateNormal];
        [lightedStarContent addSubview:lightedStarBtn];
        [self.lightedBtnArray addObject:lightedStarBtn];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    // 布局
    CGFloat margin = self.starMargin;
    CGFloat starH = _normalStarImage.size.height;
    // 暗星
    for (int i = 0; i < self.starCount; i++) {
        UIButton *btn = [self.normalBtnArray objectAtIndex:i];
        btn.tag = i + 101;
        
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *btnConstTop = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        NSLayoutConstraint *btnConstBottom = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        NSLayoutConstraint *btnConstLeft = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:(margin+starH)*i];
        NSLayoutConstraint *btnConstHeight = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:starH];
        NSLayoutConstraint *btnConstWidth = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:starH];
        if (i == self.starCount - 1) {
            NSLayoutConstraint *btnConstRight = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
            [self addConstraints:@[btnConstTop, btnConstBottom, btnConstLeft, btnConstHeight, btnConstWidth, btnConstRight]];
        }else{
            [self addConstraints:@[btnConstTop, btnConstBottom, btnConstLeft, btnConstHeight, btnConstWidth]];
        }
         
    }
    // 亮星
    for (int i = 0; i < self.starCount; i++) {
        UIButton *btnL = [self.lightedBtnArray objectAtIndex:i];
        UIButton *btnN = [self.normalBtnArray objectAtIndex:i];
        
        btnL.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *btnConstTop = [NSLayoutConstraint constraintWithItem:btnL attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationLessThanOrEqual toItem:btnN attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        NSLayoutConstraint *btnConstLeft = [NSLayoutConstraint constraintWithItem:btnL attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationLessThanOrEqual toItem:btnN attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        NSLayoutConstraint *btnConstBottom = [NSLayoutConstraint constraintWithItem:btnL attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:btnN attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        NSLayoutConstraint *btnConstRight = [NSLayoutConstraint constraintWithItem:btnL attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:btnN attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        [self addConstraints:@[btnConstTop, btnConstLeft, btnConstBottom, btnConstRight]];
        
    }
}
#pragma mark - 点击星
- (void) starBtnClick:(UIButton *)button {
    int index = (int)button.tag - 100;
    self.starScore = index;
    
    if (self.clickBlock) {
        self.clickBlock(index);
    }
}
#pragma mark - setter
-(void)setStarScore:(CGFloat)starScore{
    if (starScore > self.starCount) {
        starScore = self.starCount;
    }
    if (starScore < 0) {
        starScore = 0;
    }
    _starScore = starScore;
    // 设置lightedContent宽度
    CGFloat rightConst = (self.normalStarImage.size.width+self.starMargin)*(int)starScore+(starScore-(int)starScore)*self.normalStarImage.size.width - self.normalStarImage.size.width*self.starCount-(self.starCount-1)*self.starMargin;
    
    // 布局
    [self removeConstraints:self.lightedStarContentConstArray];
    self.lightedStarContent.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *contentConstTop = [NSLayoutConstraint constraintWithItem:self.lightedStarContent attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *contentConstLeft = [NSLayoutConstraint constraintWithItem:self.lightedStarContent attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *contentConstBottom = [NSLayoutConstraint constraintWithItem:self.lightedStarContent attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *contentConstRight = [NSLayoutConstraint constraintWithItem:self.lightedStarContent attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:rightConst];
    self.lightedStarContentConstArray = @[contentConstTop, contentConstLeft, contentConstBottom, contentConstRight];
    [self addConstraints:self.lightedStarContentConstArray];
    [self updateConstraints];
    
}
-(void)setStarMargin:(CGFloat)starMargin{
    if (starMargin > 10 || starMargin < 1) {
        starMargin = 5;
    }
    _starMargin = starMargin;
    
    [self setNeedsLayout];
    
    // 设置了margin后可能会影响lightContent，这里主动调用一次设置starScore
    self.starScore = self.starScore;
}
-(void)setStarCount:(int)starCount{
    _starCount = starCount;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.normalBtnArray removeAllObjects];
    [self.lightedBtnArray removeAllObjects];
    [self commonInit];
    
    self.starScore = self.starScore;
    
}
-(void)setType:(FFStarViewType)type {
    _type = type;
    
    self.userInteractionEnabled = self.type == FFStarViewTypeSelect;
}

@end
