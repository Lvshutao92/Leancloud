//
//  LiaoTian_A_TableViewCell.m
//  LeanCloud
//
//  Created by ilovedxracer on 2018/9/18.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "LiaoTian_A_TableViewCell.h"

@implementation LiaoTian_A_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UILabel *)lab1{
    if (_lab1 == nil) {
        self.lab1 = [[UILabel alloc]init];
        self.lab1.font = FONT(14);
        self.lab1.backgroundColor = [UIColor redColor];
        self.lab1.textColor = [UIColor whiteColor];
        self.lab1.textAlignment = NSTextAlignmentCenter;
        LRViewBorderRadius(self.lab1, 3, 0, [UIColor redColor]);
    }
    return _lab1;
}
- (UILabel *)lab2{
    if (_lab2 == nil) {
        self.lab2 = [[UILabel alloc]init];
        self.lab2.font = FONT(18);
        self.lab2.numberOfLines = 0;
    }
    return _lab2;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.lab1];
        [self.contentView addSubview:self.lab2];
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.lab1];
        [self.contentView addSubview:self.lab2];
    }
    return self;
}

@end
