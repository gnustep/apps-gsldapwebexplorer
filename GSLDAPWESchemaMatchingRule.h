/** GSLDAPWESchemaMatchingRule.h - <title>GSLDAPWESchemaMatchingRule: Class GSLDAPWESchemaMatchingRule</title>

   Copyright (C) 2003 Free Software Foundation, Inc.
   
   Written by:  Manuel Guesdon <mguesdon@orange-concept.com>
   Date: 	Jan 2003

   $Revision$
   $Date$
   $Id$
   
   This file is part of the GNUstep GSLDAPWESchemaMatchingRule application.
   
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

#ifndef _GSLDAPWESchemaMatchingRule_h__
	#define _GSLDAPWESchemaMatchingRule_h__

@class GSLDAPMatchingRule;
//====================================================================
@interface GSLDAPWESchemaMatchingRule : GSLDAPWESchemaElementBase
{
  GSLDAPMatchingRule* _ldapElement;
}
@end


#endif //_GSLDAPWESchemaMatchingRule_h__
