//
//  MyController.m
//  SampleHideTableSection
//
//  Created by Peter Chen on 1/6/14.
//  Copyright (c) 2014 Peter Chen. All rights reserved.
//

#import "MyController.h"

#define kHideableSection 1

@interface MyController ()

@property (nonatomic, assign) BOOL hideSection;

@end

@implementation MyController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Toggle" style:UIBarButtonItemStyleDone target:self action:@selector(_toggleButtonTapped)];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    
    self.hideSection = NO;
}

- (void)setHideSection:(BOOL)hideSection {
    _hideSection = hideSection;
    
    if ([self isViewLoaded]) {
        [self.tableView beginUpdates];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kHideableSection] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}

//==================================================
#pragma mark - Table view
//==================================================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == kHideableSection) {
        if (self.hideSection)
            return nil;
    }
    return [NSString stringWithFormat:@"Section %d", section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == kHideableSection) {
        if (self.hideSection)
            return 0.01;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == kHideableSection) {
        if (self.hideSection)
            return 0.01;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == kHideableSection) {
        if (self.hideSection)
            return 0;
    }
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Section %d, Row %d", indexPath.section, indexPath.row];
    return cell;
}

- (void)_toggleButtonTapped {
    self.hideSection = ! self.hideSection;
}

@end
