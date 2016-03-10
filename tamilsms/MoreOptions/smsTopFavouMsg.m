//
//  smsTopFavouMsg.m
//  tamilsms
//
//  Created by arun benjamin on 25/02/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import "smsTopFavouMsg.h"
#import "smsRESTProxy.h"

@interface smsTopFavouMsg ()
{
    NSMutableArray * _txtMessages;
    NSMutableParagraphStyle * _txtmsgstyle;
    NSInteger _authorid, _auth_noofmsgs;
    NSString * _author_name;
    NSInteger _pageNo;
    BOOL _allmsgsarereceived;
}
@end

@implementation smsTopFavouMsg
@synthesize hideStatusBar, navigateParams, transitionType;

- (void)awakeFromNib
{
    _txtMessages = [NSMutableArray new];
    self.transitionType = vertical;
    _txtmsgstyle =[[NSMutableParagraphStyle alloc] init];
    _txtmsgstyle.lineBreakMode = NSLineBreakByWordWrapping;
    _txtmsgstyle.alignment = NSTextAlignmentLeft;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIButton * l_bar_back_btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30.0f, 25.0f)];
    [l_bar_back_btn setImage:[UIImage imageNamed:@"bckbtn-1.png"] forState:UIControlStateNormal];
    [l_bar_back_btn addTarget:self action:@selector(backNavigation) forControlEvents:UIControlEventTouchUpInside];
    _baradd_btn = [[UIBarButtonItem alloc] initWithCustomView:l_bar_back_btn];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.navigationItem.leftBarButtonItem = _baradd_btn;
    [self.navigationItem setTitle:@"Top Favourite Message"];
    [self initializeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backNavigation
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initializeData
{
    _pageNo = 1;
    [[smsRESTProxy alloc] initDatawithAPIType:@"TOP_FAV_TEXT_MSG" andInputParams:@{@"page":@(_pageNo)} andReturnMethod:^(NSData * p_txtmsgsData){
        NSDictionary * l_receiveddict = [NSJSONSerialization JSONObjectWithData:p_txtmsgsData options:NSJSONReadingMutableLeaves error:NULL];
        [_txtMessages addObjectsFromArray:[l_receiveddict valueForKey:@"Quotes"]];
        NSLog(@"Top Favourite Text list data %@", l_receiveddict);
        [self.tableView reloadData];
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_allmsgsarereceived == NO)
    {
        return [_txtMessages count]+1;
    }
    else
    {
        return [_txtMessages count];
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==[_txtMessages count])
    {
        return 44.0;
    }
    NSDictionary * mess = [_txtMessages objectAtIndex:indexPath.row];
    //UILabel* messtext;
    /*
     NSLog(@"the text values in qoutes is %@",text);
     CGSize textSize = [text sizeWithAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"systemFontOfSize" size:15.0] }];
     NSLog(@"width = %f, height = %f", textSize.width, textSize.height);*/
    
    NSString * l_msgtext = [mess valueForKey:@"news_heading"];
    CGRect l_reqdrect = [l_msgtext boundingRectWithSize:CGSizeMake(self.tableView.bounds.size.width-30.0, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin+NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0f],NSParagraphStyleAttributeName:_txtmsgstyle} context:nil];
    NSInteger l_reqdheight = l_reqdrect.size.height;
    //(l_reqdrect.size.height/10.0+0.5);
    //l_reqdheight = l_reqdheight*10;
    //NSLog(@"the received height %ld for row %ld", (long)l_reqdheight, (long)indexPath.row );
    if (l_reqdheight<65.0f)
        return 105.0f;
    else
        return l_reqdheight+40.0;
    //return textSize.height;
    //return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * l_CellIdentifier = @"sampleCell";
    
    static NSString * l_loadmorecellid = @"loadmorecell";
    //NSLog(@"the messages for category is %@",l_dictvalur);
    //NSLog(@"the cell value is %@",l_dictvalur);
    if (_allmsgsarereceived == NO)
    {
        if (indexPath.row==[_txtMessages count])
        {
            UITableViewCell * l_loadmorecell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:l_loadmorecellid];
            [l_loadmorecell setBackgroundColor:[UIColor colorWithRed:0.33 green:0.53 blue:0.25 alpha:1.0]];
            [l_loadmorecell.textLabel setTextAlignment:NSTextAlignmentCenter];
            [l_loadmorecell.textLabel setTextColor:[UIColor whiteColor]];
            [l_loadmorecell.textLabel setText:@"Load More"];
            return l_loadmorecell;
        }
        
    }
    NSDictionary * l_dictvalur = [_txtMessages objectAtIndex:indexPath.row];

    smsTopFavourCell * l_cell = (smsTopFavourCell*) [tableView dequeueReusableCellWithIdentifier:l_CellIdentifier];
    if (l_cell == nil)
    {
        l_cell = [[smsTopFavourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:l_CellIdentifier];
    }
    [l_cell setBackgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.87 alpha:1.0]];
    [l_cell setDisplayData:l_dictvalur];

    return l_cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

@interface smsTopFavourCell()
{
    UILabel * _lblfavnos, *_lblsharenos;
    UIImageView * _imgshare, * _imgfav;
    NSString * l_prodqnty;
}

@end


@implementation smsTopFavourCell

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (_lblfavnos) {
        return;
    }
    
    _lblsharenos = [[UILabel alloc] init];
    [_lblsharenos setFrame:CGRectMake(5*rect.size.width/8.0-15, 6, 60, 18)];
    //[_lblsharenos setText:@"1234"];
    [_lblsharenos setFont:[UIFont systemFontOfSize:14]];
    [_lblsharenos setTextColor:[UIColor whiteColor]];
    //[_lblsharenos setBackgroundColor:[UIColor redColor]];
    [self addSubview:_lblsharenos];
    
    _imgshare = [[UIImageView alloc]init];
    [_imgshare setFrame:CGRectMake(rect.size.width/2.0, 5, 20, 20)];
    //[_imgfav setBackgroundColor:[UIColor redColor]];
    [_imgshare setImage:[UIImage imageNamed:@"share.png"]];
    [self addSubview:_imgshare];
    
    _imgfav = [[UIImageView alloc]init];
    [_imgfav setFrame:CGRectMake(3*rect.size.width/4.0+10, 5, 20, 20)];
    //[_imgfav setBackgroundColor:[UIColor redColor]];
    [_imgfav setImage:[UIImage imageNamed:@"fav.png"]];
    [self addSubview:_imgfav];
    
    _lblfavnos = [[UILabel alloc] init];
    [_lblfavnos setFrame:CGRectMake(13*rect.size.width/15, 6, 40, 18)];
    //[_lblfavnos setText:@"556"];
    [_lblfavnos setFont:[UIFont systemFontOfSize:14]];
    [_lblfavnos setTextColor:[UIColor whiteColor]];
    //[_lblfavnos setBackgroundColor:[UIColor redColor]];
    [self addSubview:_lblfavnos];
    
    
    [self layoutIfNeeded];
    [self displayValues];
}
-(void)displayValues
{
    self.username.text = [[NSString alloc]initWithFormat:@"%@",[self.datamsgdict valueForKey:@"username"]];
    self.txtmessagevw.text =[[NSString alloc]initWithFormat:@"%@",[self.datamsgdict valueForKey:@"news_heading"]];
    
    _lblsharenos.text =[[NSString alloc]initWithFormat:@"%@",[self.datamsgdict valueForKey:@"sms_shares"]];
    
    _lblfavnos.text =[[NSString alloc]initWithFormat:@"%@",[self.datamsgdict valueForKey:@"sms_likes"]];
}


@end

