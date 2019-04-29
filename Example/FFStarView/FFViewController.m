//
//  FFViewController.m
//  FFStarView
//
//  Created by fanxiaoApple on 04/26/2019.
//  Copyright (c) 2019 fanxiaoApple. All rights reserved.
//

#import "FFViewController.h"
#import "Masonry.h"
#import "FFStarView.h"

@interface FFViewController ()
/**<#desc#>*/
@property (nonatomic, weak) FFStarView *v;
@end

@implementation FFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FFStarView *v = [[FFStarView alloc] init];
    v.starMargin = 5;
    v.starScore = 4.5;
    v.clickBlock = ^(int starScore) {
        NSLog(@">>>%d",starScore);
    };
    v.type = FFStarViewTypeSelect;
    [self.view addSubview:v];
    self.v = v;
    
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(50);//不需要设置frame，只需要设置约束即可，宽高根据星星图片大小自适应
    }];

}
- (IBAction)testclick:(id)sender {
    self.v.starCount = 7;
    float s = self.v.starScore;
    NSLog(@"%f",s);
}

@end
