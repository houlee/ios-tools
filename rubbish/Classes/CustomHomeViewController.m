    //
//  CustomHomeViewController.m
//  caibo
//
//  Created by yao on 11-12-9.
//  Copyright 2011 第一视频. All rights reserved.
//

#import "CustomHomeViewController.h"
#import "Info.h"


@implementation CustomHomeViewController

@synthesize dataArray;
@synthesize mTableView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)doBack {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"changeNa" object:nil];
	[self.navigationController popViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"自定义导航栏";
	UITableView *TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 420) style:UITableViewStylePlain];
	self.mTableView = TableView;
	[TableView release];
	[self.view addSubview:mTableView];
	mTableView.delegate = self;
	mTableView.dataSource = self;
	[mTableView setEditing:YES animated:YES];
	
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	[self.navigationItem setLeftBarButtonItem:leftItem];
	
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *path=[paths    objectAtIndex:0];
	NSString *plistPath = [path stringByAppendingPathComponent:@"persondata.plist"];
	NSMutableDictionary* dic = [ [ NSMutableDictionary alloc ] initWithContentsOfFile:plistPath ];
	self.dataArray = [dic objectForKey:@"data"];
    [dic release];
	[mTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.dataArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",[[dataArray objectAtIndex:indexPath.row] objectForKey:@"name"],[[dataArray objectAtIndex:indexPath.row] objectForKey:@"shortname"]];
	cell.textLabel.font = [UIFont systemFontOfSize:15];
	return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath 
	  toIndexPath:(NSIndexPath *)destinationIndexPath {
	if (destinationIndexPath.row != 0) {
		NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithDictionary:[self.dataArray objectAtIndex:sourceIndexPath.row]];
		[self.dataArray removeObjectAtIndex:sourceIndexPath.row];
		[self.dataArray insertObject:dic1 atIndex:destinationIndexPath.row];
		[dic1 release];
		NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
		NSString *path=[paths    objectAtIndex:0];
		NSString *plistPath = [path stringByAppendingPathComponent:@"persondata.plist"];
		NSMutableDictionary* dic = [ [ NSMutableDictionary alloc ] initWithContentsOfFile:plistPath ];
		[dic setValue:self.dataArray forKey:@"data"];
		[dic writeToFile:plistPath atomically:YES ];
		[dic release];
//		[tableView reloadData];
//		return;
	}
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath 
{
	if (proposedDestinationIndexPath.row != 0) {
		
	
		return proposedDestinationIndexPath;
	}
	else {
		return sourceIndexPath;
	}
	
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) {
		return NO;
	}
	return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)dealloc {
	self.dataArray = nil;
	[mTableView release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    