//
//  ViewController.m
//  MultiStyleAlert
//
//  Created by LianLeven on 2018/9/7.
//  Copyright © 2018年 lianleven. All rights reserved.
//
//  https://github.com/lianleven/MultiStyleAlert
//

#import "ViewController.h"
#import "MultiStyleAlert.h"

static NSString * const kTitleKey = @"kTitle";
static NSString * const kDetailKey = @"kDetailKey";


typedef NS_ENUM(NSUInteger, ItemType){
    Normal = 0,
    ChangeTitle,
    ChangeAction,
};

@interface AlertItem: NSObject

@property (nonatomic, assign) ItemType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;

+ (instancetype)itemWithTitle:(NSString *)title detail:(NSString *)detail type:(ItemType)type;

@end

@implementation AlertItem

+ (instancetype)itemWithTitle:(NSString *)title detail:(NSString *)detail type:(ItemType)type{
    
    AlertItem *item = AlertItem.new;
    item.title = title;
    item.detail = detail;
    item.type = type;
    
    return item;
}

@end

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;
@property (assign, nonatomic) UIAlertControllerStyle alertControllerStyle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.alertControllerStyle = UIAlertControllerStyleAlert;
    [self setupTable];
}

- (void)setupTable{
    self.tableView.tableFooterView = UIView.new;
    self.tableView.rowHeight = 60;
}
- (IBAction)segmentControlAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.alertControllerStyle = UIAlertControllerStyleAlert;
    }else if (sender.selectedSegmentIndex == 1) {
        self.alertControllerStyle = UIAlertControllerStyleActionSheet;
    }
}
#pragma mark - Show Alert Controller
- (void)showAlert:(NSIndexPath *)indexPath{
    AlertItem *item = [self itemWithIndexPath:indexPath];
    NSString *title = item.title;
    NSString *message = item.detail;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:self.alertControllerStyle];
    switch (item.type) {
        case Normal:{
            [alert addActionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            [alert addActionWithTitle:@"Destructive" style:UIAlertActionStyleDestructive handler:nil];
            break;
        }
        case ChangeTitle:{
            [alert addActionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            [alert addActionWithTitle:@"Default" style:UIAlertActionStyleDefault handler:nil];
            [alert setTitleFont:[UIFont systemFontOfSize:18] color:[UIColor redColor]];
            [alert setMessageFont:[UIFont systemFontOfSize:12] color:[UIColor purpleColor]];
            break;
        }
        case ChangeAction:{
            [alert addActionWithTitle:@"Cancel" color:[UIColor darkGrayColor] image:[UIImage imageNamed:@"error"] style:UIAlertActionStyleCancel handler:nil];
            [alert addActionWithTitle:@"Destructive" color:[UIColor orangeColor] image:nil style:UIAlertActionStyleDestructive handler:nil];
            [alert addActionWithTitle:@"Default" color:[UIColor purpleColor] image:nil style:UIAlertActionStyleDefault handler:nil];
            break;
        }
    }
    [alert show];
}
#pragma mark - UITableView DataSource
- (AlertItem *)itemWithIndexPath:(NSIndexPath *)indexPath{
    AlertItem *item = nil;
    NSDictionary *itemDic = self.dataSource[indexPath.section];
    NSArray *items = itemDic.allValues.firstObject;
    if (items && [items isKindOfClass:[NSArray class]]) {
        if (indexPath.row < items.count) {
            item = items[indexPath.row];
        }
    }
    return item;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *itemDic = self.dataSource[section];
    return [itemDic.allValues.firstObject count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    AlertItem *item = [self itemWithIndexPath:indexPath];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.detail;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self showAlert:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *itemDic = self.dataSource[section];
    return itemDic[kTitleKey];
}

#pragma mark - Getter DataSource
- (NSDictionary *)title:(NSString *)title typeArray:(NSArray *)typeArray{
    NSMutableDictionary *dic = @{}.mutableCopy;
    dic[kTitleKey] = title;
    dic[kDetailKey] = typeArray;
    return dic;
}
- (NSArray *)normalItemArray{
    AlertItem *item = [AlertItem itemWithTitle:@"Simple" detail:@"normal alert controller, 2 of button" type:Normal];
    AlertItem *item2 = [AlertItem itemWithTitle:@"Change title & message" detail:@"change title & message's color and font " type:ChangeTitle];
    AlertItem *item3 = [AlertItem itemWithTitle:@"Change AlertAction" detail:@"change alertAction title's color and font" type:ChangeAction];
    
    return @[item,item2,item3];
}
- (NSArray *)dataSource{
    if (!_dataSource) {
        NSDictionary *itemDic = [self title:@"Normal" typeArray:[self normalItemArray]];
        _dataSource = @[itemDic];
    }
    return _dataSource;
}


@end


