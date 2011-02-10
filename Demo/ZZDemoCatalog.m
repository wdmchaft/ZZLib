//
//  ZZDemoCatalog.m
//

#import "ZZDemoCatalog.h"
#import "ZZDemoViewController.h"
#import "ZZDemoTableController.h"

@implementation ZZDemoCatalog

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
	if (self=[super init]) {
		self.title = @"ZZCatalog";
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Table view data source
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	
	if (indexPath.row==0) {
		cell.textLabel.text = @"ZZViewVontroller";
	} else if (indexPath.row==1) {
		cell.textLabel.text = @"ZZTableController";
	}

    return cell;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Table view delegate
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row==0) {
		ZZDemoViewController* demoView = [[ZZDemoViewController alloc] init];
		[self.navigationController pushViewController:demoView animated:YES];
		[demoView release];
	} else if (indexPath.row==1) {
		ZZDemoTableController* demoTable = [[ZZDemoTableController alloc] init];
		[self.navigationController pushViewController:demoTable animated:YES];
		[demoTable release];
	}
}

@end