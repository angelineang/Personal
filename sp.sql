USE [db_smart]
GO
/****** Object:  StoredProcedure [dbo].[prospect_report]    Script Date: 13/4/2023 10:46:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[prospect_report] (
	@trans_id VARCHAR(50), 
	@total_records INT OUTPUT
) AS
BEGIN
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET DEADLOCK_PRIORITY LOW
SET LOCK_TIMEOUT 2000

	DECLARE @prospect_count int;
	DECLARE @phone_count int;
	DECLARE @email_count int;
	DECLARE @address_count int;
	DECLARE @remark_count int;
	DECLARE @relationship_count int;

	BEGIN TRAN
	BEGIN TRY

		-- prospect
		MERGE [dbo].[aia_prospect] tgt
		USING [dbo].[aia_prospect_temp] tmp 
			ON tgt.aia_prospectid = tmp.aia_prospectid 
		    AND @trans_id = tmp.aia_transid
			AND tgt.aia_modifiedon = tmp.aia_old_modifiedon
		WHEN MATCHED THEN
			UPDATE SET  
			     tgt.[aia_alphaid] = tmp.[aia_alphaid]
			   , tgt.[aia_agentcode] = tmp.[aia_agentcode]
			   , tgt.[aia_fullnamecn] = tmp.[aia_fullnamecn]
			   , tgt.[aia_firstnameen] = tmp.[aia_firstnameen]
			   , tgt.[aia_lastnameen] = tmp.[aia_lastnameen]
			   , tgt.[aia_alias] = tmp.[aia_alias]
			   , tgt.[aia_dayofbirthday] = tmp.[aia_dayofbirthday]
			   , tgt.[aia_monthofbirthday] = tmp.[aia_monthofbirthday]
			   , tgt.[aia_yearofbirthday] = tmp.[aia_yearofbirthday]
			   , tgt.[aia_gender] = tmp.[aia_gender]
			   , tgt.[aia_isvitalitymember] = tmp.[aia_isvitalitymember]
			   , tgt.[aia_isdeceased] = tmp.[aia_isdeceased]
			   , tgt.[aia_maritalstatus] = tmp.[aia_maritalstatus]
			   , tgt.[aia_maritalstatusmodifydate] = tmp.[aia_maritalstatusmodifydate]
			   , tgt.[aia_referrerid] = tmp.[aia_referrerid]
			   , tgt.[aia_wechatid] = tmp.[aia_wechatid]
			   , tgt.[aia_monthlyincomehkd] = tmp.[aia_monthlyincomehkd]
			   , tgt.[aia_monthlyincomemodifiedon] = tmp.[aia_monthlyincomemodifiedon]
			   , tgt.[aia_numofchildren] = tmp.[aia_numofchildren]
			   , tgt.[aia_rating] = tmp.[aia_rating]
			   , tgt.[aia_othercoverages] = tmp.[aia_othercoverages]
			   , tgt.[aia_p100] = tmp.[aia_p100]
			   , tgt.[aia_source] = tmp.[aia_source]
			   , tgt.[aia_createdon] = tmp.[aia_createdon]
			   , tgt.[aia_modifiedon] = tmp.[aia_modifiedon]
			   , tgt.[aia_isdeleted] = tmp.[aia_isdeleted]
			   , tgt.[aia_record_update_time] = tmp.[aia_record_update_time]
			   , tgt.[aia_json] = tmp.[aia_json]
			WHEN NOT MATCHED BY TARGET 
				 AND @trans_id = tmp.aia_transid 
				 AND NOT EXISTS (
					SELECT [aia_prospectid] FROM [aia_prospect] WHERE [aia_prospectid] = tmp.[aia_prospectid]
				 ) 
			THEN
				INSERT (   
					   [aia_prospectid]
					 , [aia_alphaid]
					 , [aia_agentcode]
					 , [aia_fullnamecn]
					 , [aia_firstnameen]
					 , [aia_lastnameen]
					 , [aia_alias]
					 , [aia_dayofbirthday]
					 , [aia_monthofbirthday]
					 , [aia_yearofbirthday]
					 , [aia_gender]
					 , [aia_isvitalitymember]
					 , [aia_isdeceased]
					 , [aia_maritalstatus]
					 , [aia_maritalstatusmodifydate]
					 , [aia_referrerid]
					 , [aia_wechatid]
					 , [aia_monthlyincomehkd]
					 , [aia_monthlyincomemodifiedon]
					 , [aia_numofchildren]
					 , [aia_rating]
					 , [aia_othercoverages]
					 , [aia_p100]
					 , [aia_source]
					 , [aia_createdon]
					 , [aia_modifiedon]
					 , [aia_isdeleted]
					 , [aia_record_update_time]
					 , [aia_json])
				VALUES 
				(
					   tmp.[aia_prospectid]
					 , tmp.[aia_alphaid]
					 , tmp.[aia_agentcode]
					 , tmp.[aia_fullnamecn]
					 , tmp.[aia_firstnameen]
					 , tmp.[aia_lastnameen]
					 , tmp.[aia_alias]
					 , tmp.[aia_dayofbirthday]
					 , tmp.[aia_monthofbirthday]
					 , tmp.[aia_yearofbirthday]
					 , tmp.[aia_gender]
					 , tmp.[aia_isvitalitymember]
					 , tmp.[aia_isdeceased]
					 , tmp.[aia_maritalstatus]
					 , tmp.[aia_maritalstatusmodifydate]
					 , tmp.[aia_referrerid]
					 , tmp.[aia_wechatid]
					 , tmp.[aia_monthlyincomehkd]
					 , tmp.[aia_monthlyincomemodifiedon]
					 , tmp.[aia_numofchildren]
					 , tmp.[aia_rating]
					 , tmp.[aia_othercoverages]
					 , tmp.[aia_p100]
					 , tmp.[aia_source]
					 , tmp.[aia_createdon]
					 , tmp.[aia_modifiedon]
					 , tmp.[aia_isdeleted]
					 , tmp.[aia_record_update_time]
					 , tmp.[aia_json]
				);
		SET @prospect_count = @@ROWCOUNT;
		

		-- prospectphone
		MERGE [dbo].[aia_prospectphone] tgt
		USING [dbo].[aia_prospectphone_temp] tmp 
			ON tgt.aia_prospectid = tmp.aia_prospectid 
			AND tgt.aia_contactphoneid = tmp.aia_contactphoneid
		    AND @trans_id = tmp.aia_transid
			AND tgt.aia_modifiedon = tmp.aia_old_modifiedon
		WHEN MATCHED THEN
			UPDATE SET 
					tgt.[aia_phonenumber] = tmp.[aia_phonenumber]
				,	tgt.[aia_phoneprefix] = tmp.[aia_phoneprefix]
				,	tgt.[aia_phonetype] = tmp.[aia_phonetype]
				,	tgt.[aia_createdon] = tmp.[aia_createdon]
				,	tgt.[aia_modifiedon] = tmp.[aia_modifiedon]
				,	tgt.[aia_isdeleted] = tmp.[aia_isdeleted]
				,	tgt.[aia_record_update_time] = tmp.[aia_modifiedon]
			WHEN NOT MATCHED BY TARGET 
				 AND @trans_id = tmp.aia_transid 
				 --AND tmp.aia_old_modifiedon IS NULL
				 AND NOT EXISTS (
					SELECT [aia_contactphoneid] FROM [aia_prospectphone] WHERE [aia_contactphoneid] = tmp.[aia_contactphoneid]
				 ) 
			THEN
				INSERT (
					[aia_contactphoneid]
				,	[aia_prospectid]
				,	[aia_phonenumber]
				,	[aia_phoneprefix]
				,	[aia_phonetype]
				,	[aia_createdon]
				,	[aia_modifiedon]
				,	[aia_isdeleted]
				,	[aia_record_update_time]
				)
				VALUES 
				(
				tmp.[aia_contactphoneid],
				tmp.[aia_prospectid],
				tmp.[aia_phonenumber],
				tmp.[aia_phoneprefix],
				tmp.[aia_phonetype],
				tmp.[aia_createdon],
				tmp.[aia_modifiedon],
				tmp.[aia_isdeleted],
				tmp.[aia_record_update_time]
				);
		SET @phone_count = @@ROWCOUNT;


		-- prospectemail
		MERGE [dbo].[aia_prospectemail] tgt
		USING [dbo].[aia_prospectemail_temp] tmp 
			ON tgt.aia_prospectid = tmp.aia_prospectid 
			AND tgt.aia_contactemailid = tmp.aia_contactemailid
		    AND @trans_id = tmp.aia_transid
			AND tgt.aia_modifiedon = tmp.aia_old_modifiedon
		WHEN MATCHED THEN
			UPDATE SET
				tgt.[aia_emailaddress] = tmp.[aia_emailaddress],
				tgt.[aia_createdon] = tmp.[aia_createdon],
				tgt.[aia_modifiedon] = tmp.[aia_modifiedon],
				tgt.[aia_isdeleted] = tmp.[aia_isdeleted],
				tgt.[aia_record_update_time] = tmp.[aia_record_update_time]
			WHEN NOT MATCHED BY TARGET 
				 AND @trans_id = tmp.aia_transid 
				 --AND tmp.aia_old_modifiedon IS NULL
				 AND NOT EXISTS (
					SELECT [aia_contactemailid] FROM [aia_prospectemail] WHERE [aia_contactemailid] = tmp.[aia_contactemailid]
				 ) 
			THEN
				INSERT (
					[aia_contactemailid],
					[aia_prospectid],
					[aia_emailaddress],
					[aia_createdon],
					[aia_modifiedon],
					[aia_isdeleted],
					[aia_record_update_time]
				)
				VALUES 
				(
					tmp.[aia_contactemailid],
					tmp.[aia_prospectid],
					tmp.[aia_emailaddress],
					tmp.[aia_createdon],
					tmp.[aia_modifiedon],
					tmp.[aia_isdeleted],
					tmp.[aia_record_update_time]
				);
		SET @email_count = @@ROWCOUNT;


		-- prospectaddress
		MERGE [dbo].[aia_prospectaddress] tgt
		USING [dbo].[aia_prospectaddress_temp] tmp 
			ON tgt.aia_prospectid = tmp.aia_prospectid 
			AND tgt.aia_contactaddressid = tmp.aia_contactaddressid
		    AND @trans_id = tmp.aia_transid
			AND tgt.aia_modifiedon = tmp.aia_old_modifiedon
		WHEN MATCHED THEN
			UPDATE SET 
			    tgt.[aia_addresstype] = tmp.[aia_addresstype]
			   ,tgt.[aia_addressline1] = tmp.[aia_addressline1]
			   ,tgt.[aia_addressline2] = tmp.[aia_addressline2]
			   ,tgt.[aia_addressline3] = tmp.[aia_addressline3]
			   ,tgt.[aia_addressline4] = tmp.[aia_addressline4]
			   ,tgt.[aia_addressline5] = tmp.[aia_addressline5]
			   ,tgt.[aia_addresslanguagetype] = tmp.[aia_addresslanguagetype]
			   ,tgt.[aia_country] = tmp.[aia_country]
			   ,tgt.[aia_province] = tmp.[aia_province]
			   ,tgt.[aia_provincecity] = tmp.[aia_provincecity]
			   ,tgt.[aia_createdon] = tmp.[aia_createdon]
			   ,tgt.[aia_modifiedon] = tmp.[aia_modifiedon]
			   ,tgt.[aia_isdeleted] = tmp.[aia_isdeleted]
			   ,tgt.[aia_record_update_time] = tmp.[aia_record_update_time]
				
			WHEN NOT MATCHED BY TARGET 
				 AND @trans_id = tmp.aia_transid 
				 --AND tmp.aia_old_modifiedon IS NULL
				 AND NOT EXISTS (
					SELECT [aia_contactaddressid] FROM [aia_prospectaddress] WHERE [aia_contactaddressid] = tmp.[aia_contactaddressid]
				 )
			THEN
				INSERT (
					 [aia_contactaddressid]
					,[aia_prospectid]
					,[aia_addresstype]
					,[aia_addressline1]
					,[aia_addressline2]
					,[aia_addressline3]
					,[aia_addressline4]
					,[aia_addressline5]
					,[aia_addresslanguagetype]
					,[aia_country]
					,[aia_province]
					,[aia_provincecity]
					,[aia_createdon]
					,[aia_modifiedon]
					,[aia_isdeleted]
					,[aia_record_update_time]
				)
				VALUES 
				(
					 tmp.[aia_contactaddressid]
					,tmp.[aia_prospectid]
					,tmp.[aia_addresstype]
					,tmp.[aia_addressline1]
					,tmp.[aia_addressline2]
					,tmp.[aia_addressline3]
					,tmp.[aia_addressline4]
					,tmp.[aia_addressline5]
					,tmp.[aia_addresslanguagetype]
					,tmp.[aia_country]
					,tmp.[aia_province]
					,tmp.[aia_provincecity]
					,tmp.[aia_createdon]
					,tmp.[aia_modifiedon]
					,tmp.[aia_isdeleted]
					,tmp.[aia_record_update_time]
				);
		SET @address_count = @@ROWCOUNT;


		-- prospectremark
		MERGE [dbo].[aia_prospectremark] tgt
		USING [dbo].[aia_prospectremark_temp] tmp 
			ON tgt.aia_prospectid = tmp.aia_prospectid 
			AND tgt.aia_remarkid = tmp.aia_remarkid
		    AND @trans_id = tmp.aia_transid
			AND tgt.aia_modifiedon = tmp.aia_old_modifiedon
		WHEN MATCHED THEN
			UPDATE SET 
			    tgt.[aia_title] = tmp.[aia_title]
			   ,tgt.[aia_description] = tmp.[aia_description]
			   ,tgt.[aia_createdon] = tmp.[aia_createdon]
			   ,tgt.[aia_modifiedon] = tmp.[aia_modifiedon]
			   ,tgt.[aia_isdeleted] = tmp.[aia_isdeleted]
			   ,tgt.[aia_record_update_time] = tmp.[aia_record_update_time]		
				
			WHEN NOT MATCHED BY TARGET 
				 AND @trans_id = tmp.aia_transid 
				 --AND tmp.aia_old_modifiedon IS NULL
				 AND NOT EXISTS (
					SELECT [aia_remarkid] FROM [aia_prospectremark] WHERE [aia_remarkid] = tmp.[aia_remarkid]
				 )
			THEN
				INSERT (
					 [aia_remarkid]
					,[aia_prospectid]
					,[aia_title]
					,[aia_description]
					,[aia_createdon]
					,[aia_modifiedon]
					,[aia_isdeleted]
					,[aia_record_update_time]	
				)
				VALUES 
				(
					 tmp.[aia_remarkid]
					,tmp.[aia_prospectid]
					,tmp.[aia_title]
					,tmp.[aia_description]
					,tmp.[aia_createdon]
					,tmp.[aia_modifiedon]
					,tmp.[aia_isdeleted]
					,tmp.[aia_record_update_time]
				);
		SET @remark_count = @@ROWCOUNT;


		-- prospectrelationship
		MERGE [dbo].[aia_prospectrelationship] tgt
		USING [dbo].[aia_prospectrelationship_temp] tmp 
			--ON tgt.aia_prospectid = tmp.aia_prospectid
			ON tgt.aia_memberrelationshipid = tmp.aia_memberrelationshipid
		    AND @trans_id = tmp.aia_transid
			AND tgt.aia_modifiedon = tmp.aia_old_modifiedon
		WHEN MATCHED THEN
			UPDATE SET 
				 tgt.[aia_prospectid] = tmp.[aia_prospectid]
				,tgt.[aia_relateprospectid] = tmp.[aia_relateprospectid]
				,tgt.[aia_rolekey] = tmp.[aia_rolekey]
				,tgt.[aia_relaterolekey] = tmp.[aia_relaterolekey]
				,tgt.[aia_createdon] = tmp.[aia_createdon]
				,tgt.[aia_modifiedon] = tmp.[aia_modifiedon]
				,tgt.[aia_isdeleted] = tmp.[aia_isdeleted]
				,tgt.[aia_record_update_time] = tmp.[aia_record_update_time]
				
			WHEN NOT MATCHED BY TARGET 
				 AND @trans_id = tmp.aia_transid 
				 --AND tmp.aia_old_modifiedon IS NULL
				 AND NOT EXISTS (
					SELECT [aia_memberrelationshipid] FROM [aia_prospectrelationship] WHERE [aia_memberrelationshipid] = tmp.[aia_memberrelationshipid]
				 )
			THEN
				INSERT (
					 [aia_memberrelationshipid]
					,[aia_prospectid]
					,[aia_relateprospectid]
					,[aia_rolekey]
					,[aia_relaterolekey]
					,[aia_createdon]
					,[aia_modifiedon]
					,[aia_isdeleted]
					,[aia_record_update_time]
				)
				VALUES 
				(
					 [aia_memberrelationshipid]
					,[aia_prospectid]
					,[aia_relateprospectid]
					,[aia_rolekey]
					,[aia_relaterolekey]
					,[aia_createdon]
					,[aia_modifiedon]
					,[aia_isdeleted]
					,[aia_record_update_time]
				);
		SET @relationship_count = @@ROWCOUNT;
		

		SET @total_records = @prospect_count + @phone_count + @email_count + @address_count + @remark_count + @relationship_count;
		SELECT @total_records as total_records;

	COMMIT;
	END TRY

	BEGIN CATCH
		ROLLBACK; 
		SET @total_records =-1;
		SELECT @total_records as total_records;
	END CATCH;


 RETURN;
END

