/** GSLDAPWETree.m - <title>GSLDAPWETree: Class GSLDAPWETree</title>

   Copyright (C) 2003 Free Software Foundation, Inc.
   
   Written by:  Manuel Guesdon <mguesdon@orange-concept.com>
   Date: 	Jan 2003

   $Revision$
   $Date$
   $Id$
   
   This file is part of the GNUstep GSLDAPWETree application.
   
   <license>
   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.
   
   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.
   
   You should have received a copy of the GNU Library General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
   </license>
**/

#include <GSWeb/GSWeb.h>
#include <gsldap/GSLDAPCom.h>
#include "GSLDAPWETree.h"
#include "GSLDAPWESession.h"

//====================================================================
@implementation GSLDAPWETree


-(NSArray*)subDNs
{
  if (!_subDNs)
    {
      GSLDAPConnection* ldapConn=[(GSLDAPWESession*)[self session]ldapConnection];
      ASSIGN(_subDNs,([[ldapConn searchOneLevelDNsWithBaseDN:_dn] 
                        sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]));
      NSDebugMLog(@"_subDNs=%@",_subDNs);
    };
  return _subDNs;
};

-(GSWComponent*)selectEntryAction
{
  if (![_selectedDNs containsObject:_tmpDN])
    [_selectedDNs addObject:_tmpDN];
  NSDebugMLog(@"selectedDNs=%@",_selectedDNs);
  return nil;
};

-(GSWComponent*)unselectEntryAction
{
/*  ASSIGN(_currentEntry,_tmpDN);
  DESTROY(_subDNs);
*/
  if ([_selectedDNs containsObject:_tmpDN])
    [_selectedDNs removeObject:_tmpDN];
  NSDebugMLog(@"selectedDNs=%@",_selectedDNs);
  return nil;
};

-(BOOL)isPartOfSelected
{
  BOOL isIt=NO;
  int count=[_selectedDNs count];
  int i=0;
  NSString* tmpCurDN=[_tmpDN cleanedDN];
  for(i=0;!isIt && i<count;i++)
    {
      NSString* testDN=[_selectedDNs objectAtIndex:i];
      NSDebugMLog(@"hasSuffix: testDN=%@ tmpCurDN=%@ ==> %d len=%d",
                  testDN,
                  tmpCurDN,
                  [testDN hasSuffix:tmpCurDN],
                  [testDN length]>=[tmpCurDN length]);
      isIt=[testDN length]>=[tmpCurDN length] && [testDN hasSuffix:tmpCurDN];
    };
  return isIt;
};

-(void)setDn:(NSString*)dn
{
  NSDebugMLog(@"dn=%@",dn);
  _dn=dn;
}

-(NSString*)tmpRDN
{
  return [GSLDAPEntry rdnFromDN:_tmpDN];
}
@end
