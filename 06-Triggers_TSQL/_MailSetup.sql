--enable db mail and configure a profile 

sp_configure 'show advanced options', 1;
go
reconfigure
go

--sp_configure let's you set an configuration option
sp_configure 'Database Mail XPs', 1;
Go
reconfigure --must be called after calling to sp_configure
go

--Create a new Mail Profile for Notifications
Execute msdb.dbo.sysmail_add_profile_sp
	@profile_name = 'Notifications',
	@description = 'Profile for sending outgoing notifications using'
Go

--Set the new profile as the default
Execute msdb.dbo.sysmail_add_principalprofile_sp
	@profile_name = 'Notifications',
	@principal_name = 'public',
	@is_default = 1;
go


--create an account for the notifications
execute msdb.dbo.sysmail_add_account_sp
	@account_name = 'Gmail',
	@description = 'Account for outgoing notifications',
	@email_address = 'mrjoefriday@gmail.com',
	@display_name = '70-461 - Triggers',
	@mailserver_name = 'smtp.gmail.com',
	@port = 587,
	@enable_ssl = 1,
	@username = 'mrjoefriday@gmail.com',
	@password = 'notmypwd'
go

--add the account to the profile
execute msdb.dbo.sysmail_add_profileaccount_sp
	@profile_name = 'Notifications',
	@account_name = 'Gmail',
	@sequence_number = 1
go