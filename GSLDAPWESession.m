/** GSLDAPWESession.m - <title>GSLDAPWESession: Class GSLDAPWESession</title>

   Copyright (C) 2003 Free Software Foundation, Inc.
   
   Written by:  Manuel Guesdon <mguesdon@orange-concept.com>
   Date: 	Jan 2003

   $Revision$
   $Date$
   $Id$
   
   This file is part of the GNUstep GSLDAPWESession application.
   
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
#include "GSLDAPWESession.h"
#include "GSLDAPWebExplorer.h"

//====================================================================
@implementation GSLDAPWESession

-(id)init
{
  if ((self=[super init]))
    {
      [self setStoresIDsInURLs:YES];//[AppServer() storesIDsInURLs]];
      [self setStoresIDsInCookies:YES];//[AppServer() storesIDsInCookies]];
    };
  return self;
};

//--------------------------------------------------------------------
-(void)dealloc
{
  GSWLogAssertGood(self);
  GSWLogC("Dealloc GSLDAPWESession");
  [super dealloc];
};

-(void)awakeInContext:(GSWContext*)aContext
{
  LOGObjectFnStart();
  [super awakeInContext:aContext];
/*  if (![self objectForKey:stateKey_AffiliateCustomerReference]
      && ![self objectForKey:stateKey_AffiliateLoginReference])
    {
      GSWRequest* aRequest=nil;
      NSString* affiliateCustomerReference=nil;
      NSString* affiliateLoginName=nil;
      aRequest=[aContext request];
      affiliateCustomerReference=[aRequest formValueForKey:@"affiliateCustomerReference"];
      if ([affiliateCustomerReference length]>0)
        [self setObject:affiliateCustomerReference
              forKey:stateKey_AffiliateCustomerReference];
      affiliateLoginName=[aRequest formValueForKey:@"affiliateLoginReference"];
      if ([affiliateLoginName length]>0)
        [self setObject:affiliateLoginName
              forKey:stateKey_AffiliateLoginReference];
    };
*/
  LOGObjectFnStop();
};

//--------------------------------------------------------------------
-(void)awake
{
  LOGObjectFnStart();
  [super awake];
  LOGObjectFnStop();
};

//--------------------------------------------------------------------
-(void)sleep
{
  LOGObjectFnStart();
  [super sleep];
  LOGObjectFnStop();
};

//--------------------------------------------------------------------
-(NSString*)description
{
  return [super description];
};

//--------------------------------------------------------------------
//NDFN
-(uint)pageCacheSize
{
  return [super pageCacheSize];
};

-(GSLDAPConnection*)ldapConnection
{
  GSLDAPConnection* ldapConnection=nil;
  ldapConnection=[self objectForKey:@"ldapConnection"];
  if (!ldapConnection)
    {
      GSWRequest* request=[[self context] request];
      NSString* ldapHost=[request formValueForKey:@"ldapHost"];
      if (ldapHost)
        {
          NSString* ldapPortString=[request formValueForKey:@"ldapPort"];
          NSString* ldapBaseDN=[request formValueForKey:@"ldapBaseDN"];
          NSString* ldapBindDN=[request formValueForKey:@"ldapBindDN"];
          NSString* ldapBindPassword=[request formValueForKey:@"ldapBindPassword"];
          int ldapPort=0;
          if (ldapPortString)
            ldapPort=[ldapPortString intValue];
          ldapConnection=[GSLDAPConnection ldapConnectionWithHost:ldapHost
                                           port:ldapPort
                                           authMethod:LDAP_AUTH_SIMPLE
                                           bindDN:ldapBindDN
                                           bindPassword:ldapBindPassword
                                           baseDN:ldapBaseDN
                                           scope:LDAP_SCOPE_SUBTREE
                                           flags:(GSLDAPConnection__bindOnConnect | GSLDAPConnection__autoConnect)];
        }
      else
        {
          ldapConnection=[GSLDAPConnection ldapConnectionWithAuthMethod:LDAP_AUTH_SIMPLE
                                           scope:LDAP_SCOPE_SUBTREE
                                           flags:(GSLDAPConnection__bindOnConnect | GSLDAPConnection__autoConnect)];
        };
      [self setObject:ldapConnection
            forKey:@"ldapConnection"];
    };
  [ldapConnection connect];
  return ldapConnection;
}


@end

