#define Kpath @"http://www.oschina.net/action/api/news_list?catalog=1&pageIndex=1&pageSize=20"

#import "AFNetworking.h"
#import "GDataXMLNode.h"
#import "MyModel.h"
#import "MyTableViewCell.h"
#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_muTbaleArray;
    
    UITableView *_tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _muTbaleArray=[[NSMutableArray alloc]init];

    [self downLoadData];
    
    [self CreatUI];
    
}
-(void)downLoadData
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager GET:Kpath parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
#if 0
      
        NSString *XMLstring=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",XMLstring);
        
        
#endif
        //初始化XML解析管理对象
        GDataXMLDocument *XML=[[GDataXMLDocument alloc]initWithData:responseObject options:0 error:nil];
        
        NSArray *array=[XML nodesForXPath:@"/oschina/newslist/news" error:nil];
        
        for (GDataXMLElement * element in array) {
            
            MyModel *model=[[MyModel alloc]init];
            
             NSArray *titleArray=[element elementsForName:@"title"];
            
            GDataXMLElement *titlEmement=[titleArray lastObject];
            
            model.title=titlEmement.stringValue;
            
            NSArray *pubDateArray=[element elementsForName:@"pubDate"];
            
            GDataXMLElement *pubDateElement=[pubDateArray lastObject];
            
            model.pubDate=pubDateElement.stringValue;
            
            [_muTbaleArray addObject:model];
        }
        
        //刷新数据
        [_tableView reloadData];
        NSLog(@"%ld",_muTbaleArray.count);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error.description);
    }];
}
-(void)CreatUI
{
  /*是字符串调用   1.文本能承受的最大的宽和高 2.原来的大小 3.设置字体的大小   4.nil
    CGRect rect =[@"1agdgajdgjagdjadagjhdgajdgjadhajdjadgadazmbbmdmadhkdqhkdhkqhdkq" boundingRectWithSize:CGSizeMake(300,1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];
NSLog(@"%f %f",rect.size.width,rect.size.height);
  */
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20,self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
#pragma mark -回调
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _muTbaleArray.count;
}
//cell 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyModel *model=_muTbaleArray[indexPath.row];
    
    //1.是文本能承受的最大限度 2.原有的大小 3.设置文字的字体大小
    CGRect rect=[model.title boundingRectWithSize:CGSizeMake(300, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    
    //从服务器返回的字符串的宽高可能是长达几千的 
    NSLog(@"%f %f ",rect.size.height,rect.size.width);
    
    return rect.size.width;
    
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    MyModel *model=_muTbaleArray[indexPath.row];
    
    [cell addModel:model];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

@end
