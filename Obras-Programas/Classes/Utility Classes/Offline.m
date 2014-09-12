//
//  Offline.m
//  cintermex
//
//  Created by Juan Pablo Gonzalez Hermosillo Cires on 02/09/12.
//
//

#import "Offline.h"
#include <sys/xattr.h>

@implementation Offline{
    
    NSFileManager *fileManager;
    
}

sqlite3 *_database2;

-(id)init{
    
    if (self = [super init]) {
        
       fileManager = [NSFileManager defaultManager];
    }
    
    return self;
}

-(NSArray *)AutoConsulta:(NSString *)strSQL{
    
    [self OpenDB];
    NSArray *arrRegresa = [self Consulta:[strSQL stringByReplacingOccurrencesOfString:@"***" withString:@""]];
    [self CloseDB];
    return arrRegresa;
}


-(NSArray *)Consulta:(NSString *)strSQL{
    
    NSLog(@"%@", strSQL);

    [self OpenDB];
    sqlite3_stmt *statement;
    NSMutableArray *arrRegistros = [NSMutableArray new];
    
    int retVal =sqlite3_prepare_v2(_database2, [strSQL UTF8String], -1, &statement, NULL);
    if ( retVal == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSMutableDictionary *dicCampos = [NSMutableDictionary new];
            for (int i=0; i<sqlite3_column_count(statement); i++) {
                NSString *strColumna = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_name(statement, i)];
                                
                char * charValor = (char *) sqlite3_column_text(statement, i);
                                
                NSString *strValor;
                if (charValor == NULL) {
                    strValor= @"";
                } else {
                    strValor= [[NSString alloc] initWithUTF8String:charValor];
                }
                if ([strValor length]>0) {
                    [dicCampos setObject:strValor forKey:strColumna];
                } else {
                    [dicCampos setObject:@"" forKey:strColumna];
                }
            }
            [arrRegistros addObject:dicCampos];
        }
    } else {
        NSLog(@"Error en SQLite: %@", strSQL);
        sqlite3_reset(statement);
    }
    
    sqlite3_finalize(statement);
    
   // NSLog(@"SQLITE %@", arrRegistros);
    return arrRegistros;

}

-(BOOL)ExecuteSQL:(NSString *)strSQL{
    
    BOOL succes = YES;
    
    sqlite3_stmt *statement;
    int retVal =sqlite3_prepare_v2(_database2, [strSQL UTF8String], -1, &statement, NULL);
    if ( retVal == SQLITE_OK) {
        if(sqlite3_step(statement) != SQLITE_DONE ){
            //NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(_database2));
            NSLog(@"Error while updating. '%s'", sqlite3_errmsg(_database2));
            NSLog(@"Error en SQLite: %@", strSQL);
            succes = NO;
        }
    } else {
        succes = NO;
        NSLog(@"Error en SQLite: %@", strSQL);
    }
    
    sqlite3_reset(statement);
    sqlite3_finalize(statement);
    
    return succes;
 }

-(BOOL)AutoExecute:(NSString *)strSQL{
    NSLog(@"%@", strSQL);
    
    BOOL succes = YES;
    [self OpenDB];
    succes = [self ExecuteSQL:strSQL];
    [self CloseDB];
    
    
    return succes;
    //[(AppDelegate *)[[UIApplication sharedApplication] delegate] notShowActivityIndicator:M13ProgressViewActionNone whithMessage:kProgressMessage delay:0];
}

-(void)CloseDB{
    sqlite3_close(_database2);
}

-(void)OpenDB{
    
    NSString *storePath = [[self applicationDocumentsDirectory]
                           stringByAppendingPathComponent: @"versailles.sqlite"];
    // NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
    
    // Put down default db if it doesn't already exist
    if (![fileManager fileExistsAtPath:storePath]) {
        NSString *defaultStorePath = [[NSBundle mainBundle]
                                      pathForResource:@"versailles" ofType:@"sqlite"];
        if (defaultStorePath) {
            [fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
            [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:storePath]];
        }
    }
    
    //NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"Chevez_llena" ofType:@"sqlite3"];
    if (sqlite3_open([storePath UTF8String], &_database2) != SQLITE_OK) {
        NSLog(@"Failed to open database!");
    }
    
}


- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL{
    
    
    const char* filePath = [[URL path] fileSystemRepresentation];
    const char* attrName = "com.apple.MobileBackup";
    
    if (&NSURLIsExcludedFromBackupKey == nil) {
        
        // iOS 5.0.1 and lower
        u_int8_t attrValue = 1;
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        return result == 0;
        
    } else {
        
        // First try and remove the extended attribute if it is present
        
        double result = getxattr(filePath, attrName, NULL, sizeof(u_int8_t), 0, 0);
        if (result != -1) {
            // The attribute exists, we need to remove it
            int removeResult = removexattr(filePath, attrName, 0);
            if (removeResult == 0) {
            }
        }
        
        NSError *error = nil;
        
        BOOL success = [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
        
        if(!success){
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
        
        // Set the new key
        return success;
    }
}


- (NSString *)applicationDocumentsDirectory {
    //Changed to caches directory for compliance with iOS Data Storage Guidelines
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}



@end
