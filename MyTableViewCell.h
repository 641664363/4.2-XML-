
#import <UIKit/UIKit.h>

#import "MyModel.h"
@interface MyTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *title;
//对外声明一个对象方法
-(void)addModel:(MyModel *)model;

@end
