/** GSLDAPWebExplorer.m - <title>GSLDAPWebExplorer: Class GSLDAPWebExplorer</title>

   Copyright (C) 2003 Free Software Foundation, Inc.
   
   Written by:  Manuel Guesdon <mguesdon@orange-concept.com>
   Date: 	Jan 2003

   $Revision$
   $Date$
   $Id$
   
   This file is part of the GNUstep GSLDAPWebExplorer application.
   
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
#include "GSLDAPWebExplorer.h"

int main(int argc, char** argv, char** env)
{
  NSAutoreleasePool     *arp = [NSAutoreleasePool new];
  GSWApplication* app=nil;
#if NeXT_runtime
  [NSDistantObject setProtocolForProxies:@protocol(AllProxies)];
#endif
  //[NSObject enableDoubleReleaseCheck:YES];

  {
    NSString* str=@"( 1.3.6.1.4.1.4980.1.3.3 NAME 'oxyInetDomain' DESC 'Oxymium Inet Domain' SUP oxyTop AUXILIARY MUST dc MAY ( admContact $ admincontact $ billingContact $ cn $ domainCreationDate $ labeledURL $ mailRelayedBy $ managerEMail $ nic $ nichandle $ registrant $ soa $ techContact $ domaindescription $ oxymiumReferenceDisplay $ associatedServices $ associatedrootentity $ associatedmanagemententity $ associatedrootcompany $ associatedmanagemententityrights $ associatedrootentityrights $ associatedrootcompanyrights $ parkmessage $ logoURL ) )";
      NSScanner *aScanner = [NSScanner scannerWithString:str];

      if (1)
        {
          BOOL upTo1=[aScanner scanUpToString:@"MUST "
                               intoString:NULL];
          NSLog(@"upTo1=%d",upTo1);
          if (upTo1)
            {
              BOOL scan1=[aScanner scanString:@"MUST "
                                   intoString:NULL];
              NSLog(@"scan1=%d",scan1);
              if (scan1)
                {
                  NSString* must=nil;
                  [aScanner scanUpToString:@" "
                            intoString:&must];
                }
            };
        };
      NSLog(@"scanLocation=%u",[aScanner scanLocation]);
      NSLog(@"scan=[%@]",[[aScanner string] substringFromIndex:[aScanner scanLocation]]);
      BOOL upTo2=[aScanner scanUpToString:@"MAY "
                          intoString:NULL];
      NSLog(@"upTo2=%d",upTo2);
      NSLog(@"scanLocation=%u",[aScanner scanLocation]);
      NSLog(@"scan=[%@]",[[aScanner string] substringFromIndex:[aScanner scanLocation]]);
      upTo2=[aScanner scanString:@"MAY"
                      intoString:NULL];
      NSLog(@"upTo2=%d",upTo2);
      if (upTo2)
        {
          BOOL scan2=[aScanner scanString:@"MAY"
                               intoString:NULL];
          NSLog(@"scan2=%d",scan2);
        };
  };
/*
2003-02-19 10:31:28.489 GSLDAPWebExplorer[11494] File GSLDAPUtils.m: 52. In [NSScanner -scanThruAndDiscardString:] scan=[ MAY ( admContact $ admincontact $ billingContact $ cn $ domainCreationDate $ labeledURL $ mailRelayedBy $ managerEMail $ nic $ nichandle $ registrant $ soa $ techContact $ domaindescription $ oxymiumReferenceDisplay $ associatedServices $ associatedrootentity $ associatedmanagemententity $ associatedrootcompany $ associatedmanagemententityrights $ associatedrootentityrights $ associatedrootcompanyrights $ parkmessage $ logoURL ) )]
2003-02-19 10:31:28.489 GSLDAPWebExplorer[11494] File GSLDAPUtils.m: 53. In [NSScanner -scanThruAndDiscardString:] startLoc=101
2003-02-19 10:31:28.489 GSLDAPWebExplorer[11494] File GSLDAPUtils.m: 56. In [NSScanner -scanThruAndDiscardString:] ok1=0
2003-02-19 10:31:28.489 GSLDAPWebExplorer[11494] File GSLDAPUtils.m: 50. In [NSScanner -scanThruAndDiscardString:] string=MAY 
2003-02-19 10:31:28.490 GSLDAPWebExplorer[11494] File GSLDAPUtils.m: 51. In [NSScanner -scanThruAndDiscardString:] scan str=[( 1.3.6.1.4.1.4980.1.3.3 NAME 'oxyInetDomain' DESC 'Oxymium Inet Domain' SUP oxyTop AUXILIARY MUST dc MAY ( admContact $ admincontact $ billingContact $ cn $ domainCreationDate $ labeledURL $ mailRelayedBy $ managerEMail $ nic $ nichandle $ registrant $ soa $ techContact $ domaindescription $ oxymiumReferenceDisplay $ associatedServices $ associatedrootentity $ associatedmanagemententity $ associatedrootcompany $ associatedmanagemententityrights $ associatedrootentityrights $ associatedrootcompanyrights $ parkmessage $ logoURL ) )]
2003-02-19 10:31:28.490 GSLDAPWebExplorer[11494] File GSLDAPUtils.m: 52. In [NSScanner -scanThruAndDiscardString:] scan=[ MAY ( admContact $ admincontact $ billingContact $ cn $ domainCreationDate $ labeledURL $ mailRelayedBy $ managerEMail $ nic $ nichandle $ registrant $ soa $ techContact $ domaindescription $ oxymiumReferenceDisplay $ associatedServices $ associatedrootentity $ associatedmanagemententity $ associatedrootcompany $ associatedmanagemententityrights $ associatedrootentityrights $ associatedrootcompanyrights $ parkmessage $ logoURL ) )]
2003-02-19 10:31:28.490 GSLDAPWebExplorer[11494] File GSLDAPUtils.m: 53. In [NSScanner -scanThruAndDiscardString:] startLoc=101
2003-02-19 10:31:28.490 GSLDAPWebExplorer[11494] File GSLDAPUtils.m: 56. In [NSScanner -scanThruAndDiscardString:] ok1=0
2003-02-19 10:31:28.490 GSLDAPWebExplorer[11494] File GSLDAPUtils.m: 50. In [NSScanner -scanThruAndDiscardString:] string= MAY (
2003-02-19 10:31:28.490 GSLDAPWebExplorer[11494] File GSLDAPUtils.m: 51. In [NSScanner -scanThruAndDiscardString:] scan str=[( 1.3.6.1.4.1.4980.1.3.3 NAME 'oxyInetDomain' DESC 'Oxymium Inet Domain' SUP oxyTop AUXILIARY MUST dc MAY ( admContact $ admincontact $ billingContact $ cn $ domainCreationDate $ labeledURL $ mailRelayedBy $ managerEMail $ nic $ nichandle $ registrant $ soa $ techContact $ domaindescription $ oxymiumReferenceDisplay $ associatedServices $ associatedrootentity $ associatedmanagemententity $ associatedrootcompany $ associatedmanagemententityrights $ associatedrootentityrights $ associatedrootcompanyrights $ parkmessage $ logoURL ) )]
2003-02-19 10:31:28.490 GSLDAPWebExplorer[11494] File GSLDAPUtils.m: 52. In [NSScanner -scanThruAndDiscardString:] scan=[ MAY ( admContact $ admincontact $ billingContact $ cn $ domainCreationDate $ labeledURL $ mailRelayedBy $ managerEMail $ nic $ nichandle $ registrant $ soa $ techContact $ domaindescription $ oxymiumReferenceDisplay $ associatedServices $ associatedrootentity $ associatedmanagemententity $ associatedrootcompany $ associatedmanagemententityrights $ associatedrootentityrights $ associatedrootcompanyrights $ parkmessage $ logoURL ) )]
2003-02-19 10:31:28.491 GSLDAPWebExplorer[11494] File GSLDAPUtils.m: 53. In [NSScanner -scanThruAndDiscardString:] startLoc=101
*/

  GSWApplicationMain(@"GSLDAPWebExplorer",
                     argc,
                     argv);
  app=[GSWApplication application];
  [arp release];
  exit(0);
}

