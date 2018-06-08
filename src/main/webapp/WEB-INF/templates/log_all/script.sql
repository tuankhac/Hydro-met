delimiter $$
create DEFINER = `billing`@`localhost` function `new_log_all`(
	pentity varchar(100),
	pcontent varchar(100),
	plogdate varchar(100),
	pUserId varchar(50),
	pUserIp	varchar(50))
returns varchar(1000) CHARSET utf8 
begin
	declare s varchar(1000);
	declare exit handler for sqlexception
	begin
		declare err varchar(500);
		GET DIAGNOSTICS CONDITION 1
		@p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		set err:=concat('Loi thuc hien, ma loi:',@p1,', ',@p2);
		call access('new_log_all|ERR',err);
		return err;
	end;
	call access('billing.log_all|NEW',concat(pentity,'|',pcontent,'|',plogdate));
	insert into billing.log_all(entity,content,logdate)
	values(pentity,pcontent,plogdate);
	return '1';
end $$
delimiter;
delimiter $$
create DEFINER = `billing`@`localhost` procedure `search_log_all`(
	pentity varchar(100),
	pcontent varchar(100),
	plogdate varchar(100),
	pRecordPerPage varchar(50),
	pPageIndex varchar(50),
	pUserId varchar(100),
	pUserIp	varchar(100))

begin
	declare s MEDIUMTEXT;
	declare exit handler for sqlexception
	begin
		declare err varchar(500);
		GET DIAGNOSTICS CONDITION 1
		@p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		set err:=concat('Loi thuc hien, ma loi:',@p1,', ',@p2);
		call access('search_log_all|ERR',err);
		select err;
	end;
	call access('billing.log_all|SEARCH',pentity,'|',pcontent,'|',plogdate);
	set s:='select * from billing.log_all where 1=1';
 	if nullif(pentity,'') is not null then 
		set s:= concat(s,' and entity like ''',replace(pentity,'*','%'),''''); 
	end if;
	if nullif(pcontent,'') is not null then 
		set s:= concat(s,' and content like ''',replace(pcontent,'*','%'),''''); 
	end if;
	if nullif(plogdate,'') is not null then 
		set s:= concat(s,' and logdate like ''',replace(plogdate,'*','%'),''''); 
	end if;
	set s:= concat(s,' order by id');
	set @sql_ = xuly_phantrang(s,pPageIndex,pRecordPerPage);
	PREPARE stmt from  @sql_;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
end $$ 
delimiter;
delimiter $$
create DEFINER = `billing`@`localhost` function edit_log_all(
	pentity varchar(100),
	pcontent varchar(100),
	plogdate varchar(100),
	pUserId varchar(50),
	pUserIp	varchar(50))
returns varchar(1000) charset utf8
begin
	declare exit handler for sqlexception
	begin
		declare err varchar(500);
		GET DIAGNOSTICS CONDITION 1
		@p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		set err:=concat('Loi thuc hien, ma loi:',@p1,', ',@p2);
		call access('edit_log_all|ERR',err);
		return err;
	end;
	call access('billing.log_all|EDIT',concat(pentity,'|',pcontent,'|',plogdate));
	update billing.log_all set  entity=pentity,content=pcontent,logdate=plogdate where id=pid;
	return '1';
end $$ 
delimiter;
delimiter $$
create DEFINER = `billing`@`localhost` function del_log_all(
	pId	varchar(100),
	pUserId varchar(50),
	pUserIp	varchar(50))
returns varchar(1000) charset utf8
begin
	declare exit handler for sqlexception
	begin
		declare err varchar(500);
		GET DIAGNOSTICS CONDITION 1
		@p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		set err:=concat('Loi thuc hien, ma loi:',@p1,', ',@p2);
		call access('del_log_all|ERR',err);
		return err;
	end;
	call access('billing.log_all|DEL',pId);
	delete from billing.log_all where id=pid;
end;