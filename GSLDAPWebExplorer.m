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
#include "GSLDAPWESession.h"

//====================================================================
@implementation GSLDAPWebExplorer

//--------------------------------------------------------------------
-(id)init
{
  LOGObjectFnStart();
  if ((self=[super init]))
    {
    };
  [GSWApplication setSessionTimeOutValue:2*60*60];
  [self setPageCacheSize:500];
  LOGObjectFnStop();
  return self;
};

//--------------------------------------------------------------------
-(void)dealloc
{
  [super dealloc];
};

//--------------------------------------------------------------------
//	allowsConcurrentRequestHandling
-(BOOL)allowsConcurrentRequestHandling
{
  return NO;
};

-(Class)_sessionClass
{
  return [GSLDAPWESession class];
};
@end

