//
//  CategoryViewController.m
//  StartupVideos
//
//  Created by Sheehan Alam on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryCell.h"
#import "CategoryDetailViewController.h"
#import "SVHTTPClient.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "AdViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"startupvideoNavigationbar"] forBarMetrics:UIBarMetricsDefault];

    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"proPackage"]) {
        UIImage *moreBtnImage = [UIImage imageNamed:@"moreBtn"];
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        moreBtn.bounds = CGRectMake( 0, 0, moreBtnImage.size.width, moreBtnImage.size.height );
        [moreBtn setImage:moreBtnImage forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(upgradeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *moreBtnItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
        
        self.navigationItem.rightBarButtonItem = moreBtnItem;

    }
    UIImage *image1 = [[UIImage alloc]init];
    image1 = [UIImage imageNamed:@"theIdea"];
    UIImage *image2 = [[UIImage alloc]init];
    image2 = [UIImage imageNamed:@"lean"];
    UIImage *image3 = [[UIImage alloc]init];
    image3 = [UIImage imageNamed:@"product"];
    UIImage *image4 = [[UIImage alloc]init];
    image4 = [UIImage imageNamed:@"marketing"];
    UIImage *image5 = [[UIImage alloc]init];
    image5 = [UIImage imageNamed:@"sales"];
    UIImage *image6 = [[UIImage alloc]init];
    image6 = [UIImage imageNamed:@"team"];
    UIImage *image7 = [[UIImage alloc]init];
    image7 = [UIImage imageNamed:@"entrepreneurship"];
    thumbnails = [[NSArray alloc]initWithObjects:image1, image2, image3, image4, image5, image6, image7, nil];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"proPackage"]) {
        [self fetchProCategories];
    }
    else {
        [self fetchCategories];
    }

}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"didUpgrade"]) {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"didUpgrade"];
        self.navigationItem.rightBarButtonItem = nil;
        [self fetchProCategories];
    }
}

-(void)upgradeButtonClicked:(id)sender {
    //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Upgrade" message:@"Upgrade to pro to disable ads" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    //[alert show];
    AdViewController *avc = [[AdViewController alloc]initWithNibName:@"AdViewController" bundle:nil];
    avc.moreClicked = YES;
    [self.navigationController pushViewController:avc animated:YES];
}

-(void)fetchCategories
{
    
    [[SVHTTPClient sharedClient] getPath:@"1/categories.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON){
        NSLog(@"%@",JSON);
        
        _categories = [[NSMutableArray alloc] init];
        
        for(NSDictionary* object in JSON)
        {
            NSDictionary *category = [object objectForKey:@"category"];
            [_categories addObject:category];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check your internet connection" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }];

}

-(void)fetchProCategories {
    [[SVHTTPClient sharedClient] getPath:@"2/categories.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON){
        NSLog(@"%@",JSON);
        if (_categories) {
            [_categories removeAllObjects];
        }
        else {
            _categories = [[NSMutableArray alloc] init];
        }
        
        for(NSDictionary* object in JSON)
        {
            NSDictionary *category = [object objectForKey:@"category"];
            [_categories addObject:category];
        }
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check your internet connection" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"proPackage"] && _categories.count >= 5) {
        return [_categories count] + 1;
    }
    else {
        return [_categories count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    if (indexPath.row < _categories.count) {
        CellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.row];
    }
    else {
        CellIdentifier = @"LastCell";
    }
    
    CategoryCell *cell = (CategoryCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        if (indexPath.row < _categories.count)
        {
            //cell.thumbnailImage.image = [UIImage imageNamed:@"Icon"];
            cell.thumbnailImage.image = [thumbnails objectAtIndex:indexPath.row];
            cell.playicon.image = [UIImage imageNamed:@"playicon"];
            /*if ([[_categories objectAtIndex:indexPath.row]objectForKey:@"category_thumbnails"])
            {
                NSArray *catThumb = [[_categories objectAtIndex:indexPath.row]objectForKey:@"category_thumbnails"];
                
                NSDictionary *catThumb1 = [catThumb objectAtIndex:0];
                NSDictionary *catThumb2 = [catThumb1 objectForKey:@"category_thumbnail"];
                NSString *catThumbUrl = [catThumb2 valueForKey:@"category_thumbnail_url"];
                [cell.thumbnailImage reloadWithUrl:catThumbUrl];
                
                
            }*/
            
            // Configure the cell...
            cell.titleLabel.text = [[_categories objectAtIndex:indexPath.row] valueForKey:@"category_name"];
            NSNumber *videoCount = [[_categories objectAtIndex:indexPath.row] valueForKey:@"video_count"];
            cell.videoCountLabel.text = [NSString stringWithFormat:@"Includes %d videos",[videoCount intValue]];
            cell.chapterLabel.text = [NSString stringWithFormat:@"Chapter %d", indexPath.row+1];

        }
        else {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell changeBackground];
        }
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _categories.count) {
        CategoryDetailViewController* cdvc = [[CategoryDetailViewController alloc] initWithNibName:@"CategoryDetailViewController" bundle:nil];
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"proPackage"]) {
            cdvc.category = indexPath.row + _categories.count + 1;
        }
        else {
            cdvc.category = indexPath.row+1;
        }
        [self.navigationController pushViewController:cdvc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}




@end
