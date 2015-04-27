/*------------------------------------------------------------------------------
Copyright 2010 MW Riley Consulting LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
------------------------------------------------------------------------------*/

USE [master]
GO

CREATE DATABASE [EngageLogin]
GO

ALTER DATABASE [EngageLogin] SET COMPATIBILITY_LEVEL = 100
GO

USE [EngageLogin]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[profiles](
	[profileID] [int] IDENTITY(1,1) NOT NULL,
	[displayName] [varchar](100) NULL,
	[email] [varchar](100) NULL,
	[userId] [varchar](100) NULL,
	[identifier] [varchar](100) NULL,
	[familyName] [varchar](100) NULL,
	[formattedName] [varchar](100) NULL,
	[givenName] [varchar](100) NULL,
	[preferredUsername] [varchar](100) NULL,
	[providerName] [varchar](100) NULL,
	[url] [varchar](100) NULL,
	[verifiedEmail] [varchar](100) NULL,
	[systemCreationDate] [datetime] NOT NULL,
	[lastLogin] [datetime] NULL,
 CONSTRAINT [PK_profiles] PRIMARY KEY CLUSTERED 
(
	[profileID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------
Copyright 2010 MW Riley Consulting LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
------------------------------------------------------------------------------*/

CREATE PROCEDURE [dbo].[proc_get_customers]
@profileID	int = null,
@identifier	varchar(100) = null


AS
SET NOCOUNT ON

BEGIN

SELECT profileID, displayName, email, userId, identifier, familyName, formattedName, givenName, preferredUsername, providerName, url, verifiedEmail, systemCreationDate, lastLogin
FROM profiles
WHERE profileID = ISNULL(@profileID, profileID)
AND identifier = ISNULL(@identifier, identifier)
ORDER BY profileID

END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------
Copyright 2010 MW Riley Consulting LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
------------------------------------------------------------------------------*/

CREATE PROCEDURE [dbo].[proc_edit_customers]
@profileID	int = null,
@displayName	varchar(100) = null,
@email	varchar(100) = null,
@userId	varchar(100) = null,
@identifier	varchar(100) = null,
@familyName	varchar(100) = null,
@formattedName	varchar(100) = null,
@givenName	varchar(100) = null,
@preferredUsername	varchar(100) = null,
@providerName	varchar(100) = null,
@url	varchar(100) = null,
@verifiedEmail	varchar(100) = null,
@lastLogin	datetime = null


AS
SET NOCOUNT ON

DECLARE
@message as varchar(50),
@result as bit,
@recordID AS int


-- Script to add new customer
IF @profileID IS NULL
BEGIN

	INSERT INTO profiles
	(displayName, email, userId, identifier, familyName, formattedName, givenName, preferredUsername, providerName, url, verifiedEmail, lastLogin)
	VALUES (@displayName, @email, @userId, @identifier, @familyName, @formattedName, @givenName, @preferredUsername, @providerName, @url, @verifiedEmail, GETDATE())

	SET @message = 'Profile has been added.'
	SET @result = 1
	SET @recordID = @@IDENTITY
	SELECT @message AS message, @result AS result, @recordID AS recordid
	RETURN

END


-- Script to update a customer
IF @profileID IS NOT NULL
BEGIN

	UPDATE profiles
	SET lastLogin = @lastLogin
	WHERE profileID = @profileID

	SET @message = 'Profile has been updated.'
	SET @result = 1
	SELECT @message AS message, @result AS result, @profileID AS recordid
	RETURN

END
GO

ALTER TABLE [dbo].[profiles] ADD  CONSTRAINT [DF_profiles_systemCreationDate]  DEFAULT (getdate()) FOR [systemCreationDate]
GO