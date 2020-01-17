//
//  YMFileListViewController.m
//  FileBrower_OC_Demo
//
//  Created by zhiming9 on 2020/1/17.
//  Copyright © 2020 zhiming9. All rights reserved.
//

#import "YMFileListViewController.h"
#import "YMFileParser.h"
#import <QuickLook/QuickLook.h>

@interface YMFileListViewController ()<UISearchResultsUpdating,UISearchBarDelegate,UISearchControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) UISearchController *searchController;


//
@property (nonatomic,strong) NSMutableArray *sectionTitles;
@property (nonatomic,strong) NSMutableArray *sortedArray;
@property (nonatomic,strong) UILocalizedIndexedCollation *indexCollation;
// origin
@property (nonatomic,strong) NSMutableArray *originArray;
@property (nonatomic,strong) NSMutableArray *searchResultArray;
@property (nonatomic,strong) YMFileBrowerModel *selectModel;
@end

@implementation YMFileListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchResultArray = @[].mutableCopy;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = self.path.lastPathComponent;
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchController.searchBar.backgroundColor = [UIColor whiteColor];
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.delegate = self;
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = back;
    self.tableview.tableHeaderView = self.searchController.searchBar;
    [self getAllData];
}

#pragma mark actions
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark data
- (void)getAllData
{
    self.originArray = [[YMFileParser shareInstance]filesForDirectory:self.path];
    self.sectionTitles = @[].mutableCopy;
    //建立索引的核心
    self.indexCollation = [UILocalizedIndexedCollation currentCollation];
    [self.sectionTitles addObjectsFromArray:[self.indexCollation sectionTitles]];
    //
    self.sortedArray = @[].mutableCopy;
    for (NSInteger i = 0; i < self.sectionTitles.count; i++) {
        [self.sortedArray addObject:@[].mutableCopy];
    }
    //
    for (YMFileBrowerModel *model in self.originArray) {
        NSInteger section = [self.indexCollation sectionForObject:model collationStringSelector:@selector(displayName)];
        NSMutableArray *sub = self.sortedArray[section];
        [sub addObject:model];
    }
    for (NSMutableArray *sub in self.sortedArray) {
        NSArray *sorted = [self.indexCollation sortedArrayFromArray:sub collationStringSelector:@selector(displayName)];
        [sub removeAllObjects];
        [sub addObjectsFromArray:sorted];
    }
}

#pragma mark UISearchController
- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    [self searchText:searchController.searchBar.text];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchText:searchText];
}

- (void)searchText:(NSString *)text
{
    [self.searchResultArray removeAllObjects];
    for (YMFileBrowerModel *model in self.originArray) {
        if ([[model.displayName lowercaseString] containsString:text.lowercaseString]) {
            [self.searchResultArray addObject:model];
        }
    }
    [self.tableview reloadData];
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.searchController.isActive) {
        return 1;
    }
    return self.sortedArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.isActive) {
        return self.searchResultArray.count;
    }
    NSArray *arr = self.sortedArray[section];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"YMFileListViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"YMFileListViewCell"];
    }
    YMFileBrowerModel *model;
    if (self.searchController.isActive) {
        model = self.searchResultArray[indexPath.row];
    }else{
        model = self.sortedArray[indexPath.section][indexPath.row];
    }
    cell.textLabel.text = model.displayName;
    cell.imageView.image = [YMFileBrowerModel typeImage:model];
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.searchController.isActive) {
        return nil;
    }
    NSArray *tmp = self.sortedArray[section];
    if (tmp.count > 0) {
        return self.sectionTitles[section];
    }else{
        return nil;
    }
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.searchController.isActive) {
        return nil;
    }
    return self.indexCollation.sectionIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (self.searchController.isActive) {
        return 0;
    }
    return [self.indexCollation sectionForSectionIndexTitleAtIndex:index];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YMFileBrowerModel *model;
    if (self.searchController.isActive) {
        model = self.searchResultArray[indexPath.row];
    }else{
        model = self.sortedArray[indexPath.section][indexPath.row];
    }
    [self.searchController dismissViewControllerAnimated:YES completion:nil];
    if (model.fileBrowerType == YMFileBrowerTypeDirectory) {
        YMFileListViewController *vc = [[YMFileListViewController alloc]init];
        vc.path = model.filePath;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        self.selectModel = model;
        QLPreviewController *vc = [[QLPreviewController alloc]init];
        vc.delegate = self;
        vc.dataSource = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark QLPreviewController
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    return self.selectModel.filePath;
}

@end
