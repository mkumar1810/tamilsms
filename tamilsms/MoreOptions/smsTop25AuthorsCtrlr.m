//
//  smsTop25AuthorsCtrlr.m
//  tamilsms
//
//  Created by arun benjamin on 27/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import "smsTop25AuthorsCtrlr.h"
#import "smsRESTProxy.h"

@interface smsTop25AuthorsCtrlr ()
{
    NSArray * _authorsListData;
    NSInteger _selectedAuthorPosn;
}
@end

@implementation smsTop25AuthorsCtrlr



@synthesize hideStatusBar, navigateParams, transitionType;

- (void)awakeFromNib
{
    self.transitionType = vertical;
    [[smsRESTProxy alloc] initDatawithAPIType:@"TOP25_AUTHORS" andInputParams:nil andReturnMethod:^(NSData * p_receivedListData){
        NSDictionary * l_receiveddict = [NSJSONSerialization JSONObjectWithData:p_receivedListData options:NSJSONReadingMutableLeaves error:NULL];
        _authorsListData = (NSArray*) [l_receiveddict valueForKey:@"Quotes"];
        NSLog(@"authors list data %@", _authorsListData);
        [self.tableView reloadData];
    }];
//    _authorsListData = @[@{@"author_name":@"mohan",@"noof_msgs":@(101)},
//                         @{@"author_name":@"benjamin",@"noof_msgs":@(125)},
//                         @{@"author_name":@"Martin",@"noof_msgs":@(135)}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    UIButton * l_bar_back_btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30.0f, 25.0f)];
    [l_bar_back_btn setImage:[UIImage imageNamed:@"bckbtn-1.png"] forState:UIControlStateNormal];
    [l_bar_back_btn addTarget:self action:@selector(backNavigation) forControlEvents:UIControlEventTouchUpInside];
    _baradd_btn = [[UIBarButtonItem alloc] initWithCustomView:l_bar_back_btn];
   
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.navigationItem.leftBarButtonItem = _baradd_btn;
    [self.navigationItem setTitle:@"Top 25 Authors"];
    
}

-(void)backNavigation
{
    NSLog(@"event fires");
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return [_authorsListData count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * l_selvaldict = [_authorsListData objectAtIndex:indexPath.row];
    NSLog(@"value is %@",l_selvaldict);
    _selectedAuthorPosn = indexPath.row;
    UIAlertView * selectTxtImg = [[UIAlertView alloc]initWithTitle:@"Information" message:[NSString stringWithFormat:@"User Name: %@ ,Total Post : %@",[l_selvaldict valueForKey:@"author_name"],[l_selvaldict valueForKey:@"noof_msgs"]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Text",@"Image", nil];
    
    [selectTxtImg show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        NSLog(@"cancel");
    }
    else if (buttonIndex==1)
    {
        NSLog(@"Text");
        self.navigateParams = [_authorsListData objectAtIndex:_selectedAuthorPosn];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"showtop25authorsText" sender:self];
        });
        
       /* self.navigateParams = @{@"initialposn":@(p_positno),
                                @"allmessages":_categorymessages};
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"showIndividualTextMessage" sender:self];
        });*/

    }
    else
    {
        NSLog(@"Image");
        self.navigateParams = [_authorsListData objectAtIndex:_selectedAuthorPosn];
        [self performSegueWithIdentifier:@"showtop25authorsImage" sender:self];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   smsTop25AuthorsCell * l_returncell = [tableView dequeueReusableCellWithIdentifier:@"author_cell"];
    
    l_returncell.accessoryType=UITableViewCellAccessoryDisclosureIndicator
    ;
    
    [l_returncell setDisplayInformation:[_authorsListData objectAtIndex:indexPath.row]];
    return l_returncell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


@interface smsTop25AuthorsCell()
{
    NSDictionary * _dispDict;
}

@end

@implementation smsTop25AuthorsCell

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
   // UIImageView * l_iconimgvw = (UIImageView*) [self.contentView viewWithTag:101];
  //  UIImageView *  l_arrowimgvw = (UIImageView*) [self.contentView viewWithTag:102];
    //[l_iconimgvw setFrame:CGRectMake(0, 0, 25, rect.size.height-2)];
    //[l_arrowimgvw setFrame:CGRectMake(30, 0, 30, rect.size.height-2)];
   // [self.userdisplaymsg setFrame:CGRectMake(rect.size.width/2, 1, rect.size.width/2, rect.size.height-2.0)];
    
    [self displayValues];
}

- (void) setDisplayInformation:(NSDictionary*) p_dispDict
{
    _dispDict = p_dispDict;
    [self displayValues];
}

- (void) displayValues
{
    self.userdisplaymsg.text = [NSString stringWithFormat:@"  %@(%d)",[_dispDict valueForKey:@"username"],[[_dispDict valueForKey:@"tot_sms_count"] intValue]];
}


@end