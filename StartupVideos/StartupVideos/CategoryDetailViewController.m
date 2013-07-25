//
//  CategoryDetailViewController.m
//  StartupVideos
//
//  Created by Sheehan Alam on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoryDetailViewController.h"
#import "CategoryDetailCell.h"
#import "SVHTTPClient.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AdViewController.h"


@interface CategoryDetailViewController ()

@end

@implementation CategoryDetailViewController
@synthesize category;

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
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    

    UIImage *chapterBtnImage = [UIImage imageNamed:@"backBtn"];
    UIButton *chapterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chapterBtn.bounds = CGRectMake( 0, 0, chapterBtnImage.size.width, chapterBtnImage.size.height );
    [chapterBtn setImage:chapterBtnImage forState:UIControlStateNormal];
    [chapterBtn addTarget:self action:@selector(chapterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *chBtnItem = [[UIBarButtonItem alloc] initWithCustomView:chapterBtn];
    
    self.navigationItem.leftBarButtonItem = chBtnItem;
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"proPackage"]) {
        UIImage *moreBtnImage = [UIImage imageNamed:@"moreBtn"];
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        moreBtn.bounds = CGRectMake( 0, 0, moreBtnImage.size.width, moreBtnImage.size.height );
        [moreBtn setImage:moreBtnImage forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(upgradeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *moreBtnItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
        
        self.navigationItem.rightBarButtonItem = moreBtnItem;
        
    }


    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"proPackage"]) {
        [self fetchProVideos];
    }
    else {
        [self fetchVideos];
    }
}


-(void)fetchVideos
{
    
    [[SVHTTPClient sharedClient] getPath:[NSString stringWithFormat:@"1/categories/%d/videos.json",category] parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON){
        NSLog(@"%@",JSON);
        
        _videos = [[NSMutableArray alloc] init];
        
        for(NSDictionary* object in JSON)
        {
            NSDictionary *video = [object objectForKey:@"video"];
            [_videos addObject:video];
        }
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check your internet connection" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }];
    
}

-(void)fetchProVideos
{
    
    [[SVHTTPClient sharedClient] getPath:[NSString stringWithFormat:@"2/categories/%d/videos.json",category] parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON){
        NSLog(@"%@",JSON);
        
        _videos = [[NSMutableArray alloc] init];
        
        for(NSDictionary* object in JSON)
        {
            NSDictionary *video = [object objectForKey:@"video"];
            [_videos addObject:video];
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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    appDelegate.isMovieView = NO;
    self.navigationController.navigationBar.hidden = NO;
    if (wasPopped && ![[NSUserDefaults standardUserDefaults]boolForKey:@"proPackage"]) {
        wasPopped = NO;
        int willShowAd = arc4random()%2;
        if (willShowAd) {
            AdViewController *avc = [[AdViewController alloc]initWithNibName:@"AdViewController" bundle:nil];
            [self.navigationController pushViewController:avc animated:YES];
        }
        
    }
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"didUpgrade"]) {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"didUpgrade"];
        self.navigationItem.rightBarButtonItem = nil;
        self.category = self.category + 7;
        [self fetchProVideos];
    }
    
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
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"proPackage"] && _videos.count >= 5) {
        return [_videos count] + 1;
    }
    else {
        return [_videos count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    if (indexPath.row < _videos.count) {
        CellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.row];
    }
    else {
        CellIdentifier = @"LastCell";
    }
    CategoryDetailCell *cell = (CategoryDetailCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = nil;
    if (cell == nil) {
        cell = [[CategoryDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if (indexPath.row < _videos.count && _videos.count != 0)
        {
            cell.thumbnailImage.image = [UIImage imageNamed:@"Icon"];
            [cell.playicon setImage:[UIImage imageNamed:@"playicon2"]];
            if ([[_videos objectAtIndex:indexPath.row]objectForKey:@"video_thumbnails"])
            {
                NSArray *videoThumb = [[_videos objectAtIndex:indexPath.row]objectForKey:@"video_thumbnails"];
            
                NSDictionary *videoThumb1 = [videoThumb objectAtIndex:0];
                NSDictionary *videoThumb2 = [videoThumb1 objectForKey:@"video_thumbnail"];
                NSString *videoThumbUrl = [videoThumb2 valueForKey:@"video_thumbnail_url"];
                [cell.thumbnailImage reloadWithUrl:videoThumbUrl];

            
            }
            // Configure the cell...
            cell.titleLabel.text = [[_videos objectAtIndex:indexPath.row] valueForKey:@"video_name"];
            //[cell.titleLabel setFrame:CGRectMake(cell.titleLabel.frame.origin.x, cell.titleLabel.frame.origin.y, cell.titleLabel.frame.size.width, cell.titleLabel.contentSize.height)];
            [cell.titleLabel sizeToFit];
            cell.duration.text = [[_videos objectAtIndex:indexPath.row] valueForKey:@"duration"];
            [cell.duration setFrame:CGRectMake(cell.duration.frame.origin.x, cell.titleLabel.frame.origin.y + cell.titleLabel.frame.size.height, cell.duration.frame.size.width, cell.duration.frame.size.height)];
            
        }
        else
        {
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
    if ([[_videos objectAtIndex:indexPath.row]objectForKey:@"video_url"])
    {
        videoNumber = indexPath.row+1;
        videoPath = [[_videos objectAtIndex:indexPath.row]objectForKey:@"video_url"];

        LBYouTubeExtractor *extractor = [[LBYouTubeExtractor alloc]initWithURL:[NSURL URLWithString:videoPath] quality:LBYouTubeVideoQualityLarge];
        extractor.delegate = self;
        [extractor startExtracting];
        
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}


#pragma mark - LBYoutubePlayer Delegate Methods
-(void)youTubeExtractor:(LBYouTubeExtractor *)extractor didSuccessfullyExtractYouTubeURL:(NSURL *)videoURL {
    dispatch_async(dispatch_get_main_queue(), ^{
        wasPopped = YES;
        player = [[MoviePlayerViewController alloc]initWithContentURL:videoURL];
        player.category = self.category;
        player.videoNumber = videoNumber;
        player.videoUrl = videoPath;
        [self.navigationController presentMoviePlayerViewControllerAnimated:player];
    });
    
    
}
-(void)youTubeExtractor:(LBYouTubeExtractor *)extractor failedExtractingYouTubeURLWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Startup Videos" message:@"Sorry, hustler, this video is not working right now" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - Button Clicks

- (void) chapterBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)upgradeButtonClicked:(id)sender {
    AdViewController *avc = [[AdViewController alloc]initWithNibName:@"AdViewController" bundle:nil];
    avc.moreClicked = YES;
    [self.navigationController pushViewController:avc animated:YES];
}


@end
