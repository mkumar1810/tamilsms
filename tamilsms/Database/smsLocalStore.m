//
//  smsLocalStore.m
//  tamilsms
//
//  Created by Mohan Kumar on 10/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import "smsLocalStore.h"
#import <objc/objc-sync.h>
#import "sqlite3.h"

static sqlite3 * s_tamilsms_db;
static BOOL s_dbOpen;
static NSString * s_dbFileName;

@implementation smsLocalStore

+ (void) getDBOpened
{
    if (s_dbOpen==YES) return;
    NSString * l_dbName = @"tamilsms";
#ifdef DEBUG
    //l_dbName = @"almsales_h_coln";
#endif
    NSArray * l_paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"l_paths value: %@",l_paths);
    NSString * l_docDirectory = [l_paths objectAtIndex:0];
    NSLog(@"l_docdirectory value is: %@",l_docDirectory);
    s_dbFileName = [l_docDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", l_dbName]];
    NSLog(@"l_dbname name :%@",s_dbFileName);
    NSFileManager * l_fileMgr = [[NSFileManager alloc] init];
    NSString * l_resFilePath = [[NSBundle mainBundle] pathForResource:l_dbName ofType:@"sqlite"];
    NSLog(@"nslog file path is  %@", l_resFilePath);
    NSError * l_error ;
    if ([l_fileMgr fileExistsAtPath:s_dbFileName]==NO)
    {
        if (![l_fileMgr copyItemAtPath:l_resFilePath toPath:s_dbFileName error:&l_error])
        {
            //NSString * l_errmsg = [NSString stringWithFormat:@"normal error during copying %@",[l_error description]];
            s_dbOpen = NO;
            return;
        }
    }
#ifdef DEBUG
    else
    {
        [l_fileMgr removeItemAtPath:s_dbFileName error:&l_error];
        if (![l_fileMgr copyItemAtPath:l_resFilePath toPath:s_dbFileName error:&l_error])
        {
            //NSString * l_errmsg = [NSString stringWithFormat:@"debug mode error during copying %@",[l_error description]];
            s_dbOpen = NO;
            return;
        }
        else
        {
            //NSString * l_errmsg = [NSString stringWithFormat:@"debug mode file copied successfully %@",s_dbFileName];
            NSLog(@"%@", s_dbFileName);
        }
    }
#endif
    
    if (sqlite3_open([s_dbFileName UTF8String], &s_tamilsms_db)==SQLITE_OK)
    {
        NSLog(@"successfully opened after copying");
        s_dbOpen = YES;
    }
    else
    {
        sqlite3_close(s_tamilsms_db);
    }
    
}

- (NSArray *)getMainCategoryTitlesForImgMsgs
{
    
    NSMutableArray * l_returnList = [[NSMutableArray alloc] init];
    //NSString * l_txtmsgcatqry = @"SELECT  cid, category_name,category_imgcount FROM categories WHERE par_id=0 ORDER BY sorting ASC";
    NSString * l_imgmsgcatqry = @"select cid,category_name,count(quotes) "
        " from categories ca "
        " left join tamilsms ts on ca.cid = ts.catid and is_image = 1 "
        " where par_id=0 "
        " group by cid order by sorting asc ";
    
    sqlite3_stmt * l_tamilsmsstmt;
    if (sqlite3_prepare_v2(s_tamilsms_db, [l_imgmsgcatqry UTF8String], -1, &l_tamilsmsstmt, NULL)==SQLITE_OK)
    {
        while (sqlite3_step(l_tamilsmsstmt)==SQLITE_ROW)
        {
            
            int l_cid = sqlite3_column_int(l_tamilsmsstmt, 0);
            const char * l_categoryname = (char*) sqlite3_column_text(l_tamilsmsstmt, 1);
            int l_categorycount = sqlite3_column_int(l_tamilsmsstmt, 2);
            
            [l_returnList addObject:[NSDictionary
                                     dictionaryWithObjectsAndKeys:
                                     [NSString stringWithUTF8String:l_categoryname], @"category_name",
                                     [NSNumber numberWithInt:l_cid], @"cid",
                                     [NSNumber numberWithInt:l_categorycount],@"category_count",nil]];
            //NSLog(@"the messaages in database are :%@",l_returnList);
            
        }
        sqlite3_finalize(l_tamilsmsstmt);
    }
    return l_returnList;
}

-(NSArray*)getMainCategoryTitlesForTxtMsgs
{
    NSMutableArray * l_returnList = [[NSMutableArray alloc] init];
    //NSString * l_txtmsgcatqry = @"SELECT  cid, category_name,category_count FROM categories WHERE par_id=0 ORDER BY sorting ASC";
    NSString * l_txtmsgcatqry = @"select cid,category_name,count(quotes) "
        " from categories ca "
        " left join tamilsms ts on ca.cid = ts.catid and is_image = 0 "
        " where par_id=0 "
        " group by cid order by sorting asc ";
    sqlite3_stmt * l_tamilsmsstmt;
    if (sqlite3_prepare_v2(s_tamilsms_db, [l_txtmsgcatqry UTF8String], -1, &l_tamilsmsstmt, NULL)==SQLITE_OK)
    {
        while (sqlite3_step(l_tamilsmsstmt)==SQLITE_ROW)
        {
            
            int l_cid = sqlite3_column_int(l_tamilsmsstmt, 0);
            const char * l_categoryname = (char*) sqlite3_column_text(l_tamilsmsstmt, 1);
            int l_categorycount = sqlite3_column_int(l_tamilsmsstmt, 2);
            
            [l_returnList addObject:[NSDictionary
                                     dictionaryWithObjectsAndKeys:
                                     [NSString stringWithUTF8String:l_categoryname], @"category_name",
                                     [NSNumber numberWithInt:l_cid], @"cid",
                                     [NSNumber numberWithInt:l_categorycount],@"category_count",nil]];
            //NSLog(@"the messaages in database are :%@",l_returnList);

        }
        sqlite3_finalize(l_tamilsmsstmt);
    }
    return l_returnList;
}

-(NSArray*)getTextMsgForCategory:(NSInteger) p_categoryId
{
    //NSLog(@"the category is passed in the database is %ld",(long)p_categoryId);
    NSMutableArray * l_messageList = [[NSMutableArray alloc] init];
    NSString * l_txtmsg = @"select id,qid,quotes,author,userid from tamilsms where is_image = 0 and catid=?";
    
    sqlite3_stmt * l_tamilmesgsmt;
    if (sqlite3_prepare_v2(s_tamilsms_db, [l_txtmsg UTF8String], -1, &l_tamilmesgsmt, NULL)==SQLITE_OK)
    {
        sqlite3_bind_int(l_tamilmesgsmt, 1, (int) p_categoryId);
        while (sqlite3_step(l_tamilmesgsmt)==SQLITE_ROW)
        {
            
            int l_id = sqlite3_column_int(l_tamilmesgsmt, 0);
            int l_qid = sqlite3_column_int(l_tamilmesgsmt, 1);
            const char * l_quotes = (char*) sqlite3_column_text(l_tamilmesgsmt, 2);
            const char * l_author = (char*) sqlite3_column_text(l_tamilmesgsmt, 3);
            int l_userid = sqlite3_column_int(l_tamilmesgsmt, 4);
            
            
            [l_messageList addObject:[NSDictionary
                                      dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInt:l_id],@"id",
                                      [NSNumber numberWithInt:l_qid],@"l_qid",
                                      [NSString stringWithUTF8String:l_quotes],@"quotes",
                                      [NSString stringWithUTF8String:l_author],@"author",
                                      [NSNumber numberWithInt:l_userid], @"userid", nil]];
            //NSLog(@"the messaages in database are :%@",l_messageList);
        }
        sqlite3_finalize(l_tamilmesgsmt);
    }
    return l_messageList;
}

-(NSArray*)getImageMsgForCategory:(NSInteger)p_categoryId
{
    NSMutableArray * l_imgmessageList = [[NSMutableArray alloc] init];
    NSString * l_imgmsg = @"select id,qid,msg_image,author,userid from tamilsms where is_image = 1 and catid=?";
    sqlite3_stmt * l_tamilimgsmt;
    if (sqlite3_prepare_v2(s_tamilsms_db, [l_imgmsg UTF8String], -1, &l_tamilimgsmt, NULL)==SQLITE_OK)
    {
        sqlite3_bind_int(l_tamilimgsmt, 1, (int) p_categoryId);
        while (sqlite3_step(l_tamilimgsmt)==SQLITE_ROW)
        {
            
            int l_id = sqlite3_column_int(l_tamilimgsmt, 0);
            int l_qid = sqlite3_column_int(l_tamilimgsmt, 1);
            const char * l_msg_image = (char*) sqlite3_column_text(l_tamilimgsmt, 2);
            const char * l_author = (char*) sqlite3_column_text(l_tamilimgsmt, 3);
            int l_userid = sqlite3_column_int(l_tamilimgsmt, 4);
            
            
            [l_imgmessageList addObject:[NSDictionary
                                      dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInt:l_id],@"id",
                                      [NSNumber numberWithInt:l_qid],@"l_qid",
                                      [NSString stringWithUTF8String:l_msg_image],@"msg_image",
                                      [NSString stringWithUTF8String:l_author],@"author",
                                      [NSNumber numberWithInt:l_userid], @"userid", nil]];
            //NSLog(@"the messaages in database are :%@",l_imgmessageList);
        }
        sqlite3_finalize(l_tamilimgsmt);
    }
    return l_imgmessageList;

}

-(NSArray*)getTextSubCategoryForMainCaregory:(NSInteger) p_maincategoryId
{
    //NSLog(@"the category is passed in the database is %ld",(long)p_maincategoryId);
    NSMutableArray * l_SubCatgList = [[NSMutableArray alloc] init];
    //NSString * l_subCatglistqry = @"select id,cid,category_name,category_count,sorting from categories where par_id=? ORDER BY sorting ASC";
    NSString * l_subCatglistqry = @"select cid,category_name,count(quotes) "
        " from categories ca "
        " left join tamilsms ts on ca.cid = ts.catid and is_image = 0 "
        " where par_id=? "
        " group by cid order by sorting asc ";
    
    sqlite3_stmt * l_tamilmesgsmt;
    if (sqlite3_prepare_v2(s_tamilsms_db, [l_subCatglistqry UTF8String], -1, &l_tamilmesgsmt, NULL)==SQLITE_OK)
    {
        sqlite3_bind_int(l_tamilmesgsmt, 1, (int) p_maincategoryId);
        while (sqlite3_step(l_tamilmesgsmt)==SQLITE_ROW)
        {
            
            int l_cid = sqlite3_column_int(l_tamilmesgsmt, 0);
            const char * l_catgryname = (char*) sqlite3_column_text(l_tamilmesgsmt, 1);
            int l_catgrycount = sqlite3_column_int(l_tamilmesgsmt, 2);
            
            [l_SubCatgList addObject:[NSDictionary
                                      dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInt:l_cid],@"cid",
                                      [NSString stringWithUTF8String:l_catgryname],@"category_name",
                                      [NSNumber numberWithInt:l_catgrycount],@"category_count",
                                       nil]];
            //NSLog(@"the messaages in database are :%@",l_messageList);
        }
        sqlite3_finalize(l_tamilmesgsmt);
    }
    return l_SubCatgList;
}

-(NSArray*)getImageSubCategoryForMainCaregory:(NSInteger) p_maincategoryId
{
    //NSLog(@"the category is passed in the database is %ld",(long)p_maincategoryId);
    NSMutableArray * l_SubCatgList = [[NSMutableArray alloc] init];
    //NSString * l_subCatglistqry = @"select id,cid,category_name,category_imgcount,sorting from categories where par_id=? ORDER BY sorting ASC";
    NSString * l_subCatglistqry = @"select cid,category_name,count(quotes) "
        " from categories ca "
        " left join tamilsms ts on ca.cid = ts.catid and is_image = 1 "
        " where par_id=? "
        " group by cid order by sorting asc ";
    sqlite3_stmt * l_tamilmesgsmt;
    if (sqlite3_prepare_v2(s_tamilsms_db, [l_subCatglistqry UTF8String], -1, &l_tamilmesgsmt, NULL)==SQLITE_OK)
    {
        sqlite3_bind_int(l_tamilmesgsmt, 1, (int) p_maincategoryId);
        while (sqlite3_step(l_tamilmesgsmt)==SQLITE_ROW)
        {
            int l_cid = sqlite3_column_int(l_tamilmesgsmt, 0);
            const char * l_catgryname = (char*) sqlite3_column_text(l_tamilmesgsmt, 1);
            int l_catgrycount = sqlite3_column_int(l_tamilmesgsmt, 2);
            
            [l_SubCatgList addObject:[NSDictionary
                                      dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInt:l_cid],@"cid",
                                      [NSString stringWithUTF8String:l_catgryname],@"category_name",
                                      [NSNumber numberWithInt:l_catgrycount],@"category_count",
                                      nil]];
            //NSLog(@"the messaages in database are :%@",l_messageList);
        }
        sqlite3_finalize(l_tamilmesgsmt);
    }
    return l_SubCatgList;
}

- (NSDictionary*) getSyncParamsFromDB
{
    int l_smsversion = 0;
    NSInteger l_userversion = 0;
    NSInteger l_ismsversion = 0;
    NSInteger l_iuserversion = 0;
    NSString * l_smsverqry = @"select max(qid) from tamilsms where userid=1 and is_image=0";
    NSString * l_userverqry = @"select max(qid) from tamilsms where userid>1 and is_image =0";
    NSString * l_ismsverqry = @"select max(qid) from tamilsms where userid=1 and is_image=1";
    NSString * l_iuserverqry = @"select max(qid) from tamilsms where userid>1 and is_image=1";
    sqlite3_stmt * l_smsverstmt, * l_userverstmt, * l_ismsverstmt, * l_iuserverstmt;
    if (sqlite3_prepare_v2(s_tamilsms_db, [l_smsverqry UTF8String], -1, &l_smsverstmt, NULL)==SQLITE_OK)
    {
        if (sqlite3_step(l_smsverstmt)==SQLITE_ROW)
        {
            l_smsversion =  sqlite3_column_int(l_smsverstmt, 0);
        }
        sqlite3_finalize(l_smsverstmt);
    }
    if (sqlite3_prepare_v2(s_tamilsms_db, [l_userverqry UTF8String], -1, &l_userverstmt, NULL)==SQLITE_OK)
    {
        if (sqlite3_step(l_userverstmt)==SQLITE_ROW)
        {
            l_userversion = (NSInteger) sqlite3_column_int(l_userverstmt, 0);
        }
        sqlite3_finalize(l_userverstmt);
    }
    if (sqlite3_prepare_v2(s_tamilsms_db, [l_ismsverqry UTF8String], -1, &l_ismsverstmt, NULL)==SQLITE_OK)
    {
        if (sqlite3_step(l_ismsverstmt)==SQLITE_ROW)
        {
            l_ismsversion = (NSInteger) sqlite3_column_int(l_ismsverstmt, 0);
        }
        sqlite3_finalize(l_ismsverstmt);
    }
    if (sqlite3_prepare_v2(s_tamilsms_db, [l_iuserverqry UTF8String], -1, &l_iuserverstmt, NULL)==SQLITE_OK)
    {
        if (sqlite3_step(l_iuserverstmt)==SQLITE_ROW)
        {
            l_iuserversion = (NSInteger) sqlite3_column_int(l_iuserverstmt, 0);
        }
        sqlite3_finalize(l_iuserverstmt);
    }
    return @{@"smsversion":@(l_smsversion),
             @"userversion":@(l_userversion),
             @"ismsversion":@(l_ismsversion),
             @"iuserversion":@(l_iuserversion)};
}


- (void) updateParsedDatasIntoDatabase:(NSDictionary*) p_payData
{
    
    NSString * l_insertquery = @"insert into tamilsms(id,qid,quotes,author, userid, catid,msg_image,is_image) values (?,?,?,?,?,?,?,?)";
    sqlite3_stmt * l_insertstmt;
    if (sqlite3_prepare_v2(s_tamilsms_db, [l_insertquery UTF8String], -1, &l_insertstmt, NULL)==SQLITE_OK)
    {
        /*
         id-  This is AUTO id generated by the database
         qid- nid
         quotes- news_heading
         author- username
         userid- user_id
         catid- cat_id
         msg_image- news_image
         is_image- news_isimage
         */
        sqlite3_bind_int64(l_insertstmt, 0,[self getNewIdForTable:@"tamilsms" withIdColumn:@"id"]);
        sqlite3_bind_int(l_insertstmt, 1, [[p_payData valueForKey:@"nid"] intValue]);
        sqlite3_bind_text(l_insertstmt, 2, [[p_payData valueForKey:@"news_heading"] UTF8String], -1,SQLITE_TRANSIENT);
        sqlite3_bind_text(l_insertstmt, 3, [[p_payData valueForKey:@"username"] UTF8String], -1,SQLITE_TRANSIENT);
        sqlite3_bind_int(l_insertstmt, 4,  [[p_payData valueForKey:@"user_id"] intValue]);
        sqlite3_bind_int(l_insertstmt, 5,[[p_payData valueForKey:@"cat_id"] intValue]);
        sqlite3_bind_text(l_insertstmt, 6, [[p_payData valueForKey:@"news_image"] UTF8String], -1,SQLITE_TRANSIENT);
        sqlite3_bind_int(l_insertstmt, 7, [[p_payData valueForKey:@"news_isimage"] intValue]);
        sqlite3_step(l_insertstmt);
        sqlite3_finalize(l_insertstmt);
    }
    
    
    
    //return l_returnDict;
}

- (long) getNewIdForTable:(NSString*) p_tabName withIdColumn:(NSString*) p_columnName
{
    NSInteger l_maxId = 0;
    NSString * l_getMaxId = [NSString stringWithFormat:@"select max(%@) from %@ ", p_columnName, p_tabName];
    sqlite3_stmt * l_getMaxstmt;
    if (sqlite3_prepare_v2(s_tamilsms_db, [l_getMaxId UTF8String], -1, &l_getMaxstmt, NULL)==SQLITE_OK)
    {
        if (sqlite3_step(l_getMaxstmt)==SQLITE_ROW)
            l_maxId = (long) sqlite3_column_int64(l_getMaxstmt, 0);
        l_maxId++;
        sqlite3_finalize(l_getMaxstmt);
    }
    return l_maxId;
}




@end
