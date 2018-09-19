//
//  BijiTableViewCell.m
//  LeanCloud
//
//  Created by ilovedxracer on 2018/9/18.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "BijiTableViewCell.h"

@implementation BijiTableViewCell

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
        self.lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 40)];
        self.lab1.font = FONT(18);
    }
    return _lab1;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.lab1];
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.lab1];
    }
    return self;
}
@end
