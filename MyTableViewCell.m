//
//  MyTableViewCell.m
//  4.2 XML网络练习
//
//  Created by MS on 16-4-21.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)addModel:(MyModel *)model
{
    
    self.title.text=model.title;
    
    
    self.date.text=model.pubDate;
}
@end
