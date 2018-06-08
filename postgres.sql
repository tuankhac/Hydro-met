--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: DATABASE mydb; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE mydb IS 'My First Postgre DB';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: add_two(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_two(a integer, b integer, OUT sum integer) RETURNS integer
    LANGUAGE sql
    AS $_$SELECT $1 + $2$_$;


ALTER FUNCTION public.add_two(a integer, b integer, OUT sum integer) OWNER TO postgres;

--
-- Name: crud_create_params(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.crud_create_params(param character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
DECLARE
    field varchar;
BEGIN
    EXECUTE $1; 
    RETURN '1';
END;
$_$;


ALTER FUNCTION public.crud_create_params(param character varying) OWNER TO postgres;

--
-- Name: del_menu(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.del_menu(pid character varying, puserid character varying, puserip character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare
	s varchar(1000);
begin
	--logger.access('menu|DEL',pId);
	s:='delete from menu where "ID"=$1';
	execute s using cast(pid as integer);
	--commit;
	return '1';
	exception when others then
	declare err varchar(500); 
	begin    
		err:='Loi thuc hien, ma loi:'||sqlerrm;
		--logger.access('del_menu|ERR',err);
		return err;
	end;
end;$_$;


ALTER FUNCTION public.del_menu(pid character varying, puserid character varying, puserip character varying) OWNER TO postgres;

--
-- Name: del_roles(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.del_roles(pid character varying, puserid character varying, puserip character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare
	s varchar(1000);
begin
	--logger.access('role|DEL',pId);
	s:='delete from roles where "ID"=$1';
	execute s using pid;
	--commit;
	return '1';
	exception when others then
	declare err varchar(500); 
	begin    
		err:='Loi thuc hien, ma loi:'||sqlerrm;
	--logger.access('del_role|ERR',err);
		return err;
	end;
end;$_$;


ALTER FUNCTION public.del_roles(pid character varying, puserid character varying, puserip character varying) OWNER TO postgres;

--
-- Name: del_user_info(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.del_user_info(pid character varying, puserid character varying, puserip character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare
	s varchar(1000);
begin
	--logger.access('user_info|DEL',pId);

	s:='delete from user_info where "ID"=$1';
	execute  s using pid;
	--commit;
	return '1';
	exception when others then
		declare err varchar(500); 
		begin
			err:='Loi thuc hien, ma loi:'||sqlerrm;
			--logger.access('user_info|DEL|ERR',err);
			return err;
		end;
end;
$_$;


ALTER FUNCTION public.del_user_info(pid character varying, puserid character varying, puserip character varying) OWNER TO postgres;

--
-- Name: edit_menu(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edit_menu(pid character varying, pname character varying, pdisplay_order character varying, ppicture_file character varying, pdetail_file character varying, pmenu_level character varying, pparent_id character varying, ppublish character varying, puserid character varying, puserip character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare
    s varchar(1000);
begin
	--logger.access('menu|EDIT',pid||'|'||pname||'|'||pdisplay_order||'|'||ppicture_file||'|'||pdetail_file||'|'||pmenu_level||'|'||pparent_id||'|'||ppublish);
	s:='update menu set  "NAME"=$1,"DISPLAY_ORDER"=$2,"PICTURE_FILE"=$3,"DETAIL_FILE"=$4,"MENU_LEVEL"=$5,"PARENT_ID"=$6,"PUBLISH"=$7 where "ID"=$8';
	execute s using pname,cast(pdisplay_order as integer),ppicture_file,pdetail_file,cast(pmenu_level as integer),cast(pparent_id as integer),cast(ppublish as integer),cast(pid as integer);
	--commit;
	return '1';
	exception when others then
		declare err varchar(500); 
		begin    
			err:='Loi thuc hien, ma loi:'||sqlerrm;
			--logger.access('edit_menu|ERR',err);
			return err;
		end;
end;$_$;


ALTER FUNCTION public.edit_menu(pid character varying, pname character varying, pdisplay_order character varying, ppicture_file character varying, pdetail_file character varying, pmenu_level character varying, pparent_id character varying, ppublish character varying, puserid character varying, puserip character varying) OWNER TO postgres;

--
-- Name: edit_role(character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edit_role(pid character varying, prole_name character varying, pdescription character varying, puserid character varying, puserip character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare
	s varchar(1000);
begin
	--logger.access('role|EDIT',pid||'|'||prole_name||'|'||pdescription);
	s:='update role set role_name=$1,description=$2 where id=$3';
	execute immediate s using prole_name,pdescription,pid;
	--commit;
	return '1';
	exception when others then
		declare err varchar(500); 
		begin    
			err:='Loi thuc hien, ma loi:'||sqlerrm;
			--logger.access('edit_role|ERR',err);
			return err;
		end;
end;$_$;


ALTER FUNCTION public.edit_role(pid character varying, prole_name character varying, pdescription character varying, puserid character varying, puserip character varying) OWNER TO postgres;

--
-- Name: edit_roles(character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edit_roles(pid character varying, prole_name character varying, pdescription character varying, puserid character varying, puserip character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare
    s varchar(1000);
begin
    --logger.access('role|EDIT',pid||'|'||prole_name||'|'||pdescription);
    s:='update roles set "ROLE_NAME"=$1,"DESCRIPTION"=$2 where "ID"=$3';
    execute s using prole_name,pdescription,pid;
    --commit;
    return '1';
    exception when others then
        declare err varchar(500); begin    err:='Loi thuc hien, ma loi:'||sqlerrm;
        --logger.access('edit_role|ERR',err);
        return err;
    end;
end;$_$;


ALTER FUNCTION public.edit_roles(pid character varying, prole_name character varying, pdescription character varying, puserid character varying, puserip character varying) OWNER TO postgres;

--
-- Name: edit_user_info(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.edit_user_info(pid character varying, pfirst_name character varying, plast_name character varying, pmobile character varying, pemail character varying, pgender character varying, pstatus_id character varying, puserid character varying, puserip character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare
    s varchar(1000);
begin
    --logger.access('user_info|EDIT',pid||'|'||ppassword||'|'||pfirst_name||'|'||plast_name||'|'||pmobile||'|'||pdepartment||'|'||pemail||'|'||pgender||'|'||pstatus_id||'|'||pcreated_date||'|'||pmodified_date);
     s:='update user_info set "FIRST_NAME"=$1,"LAST_NAME"=$2,"MOBILE"=$3,"EMAIL"=$4,"GENDER"=$5,"STATUS_ID"=$6,"MODIFIED_DATE"=$7 where "ID"=$8';
    execute s using pfirst_name,plast_name,pmobile,pemail,pgender,cast(pstatus_id as integer),now(),pid;
    --commit;
    return '1';
    exception when others then
        declare err varchar(500); begin
            err:='Loi thuc hien, ma loi:'||sqlerrm;
            --logger.access('user_info|EDIT|ERR',err);
            return err;
    end;
end;
$_$;


ALTER FUNCTION public.edit_user_info(pid character varying, pfirst_name character varying, plast_name character varying, pmobile character varying, pemail character varying, pgender character varying, pstatus_id character varying, puserid character varying, puserip character varying) OWNER TO postgres;

--
-- Name: get_field(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_field(field_name character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
DECLARE
    field varchar;
BEGIN
    EXECUTE $1; 
    RETURN '1';
END;
$_$;


ALTER FUNCTION public.get_field(field_name character varying) OWNER TO postgres;

--
-- Name: get_name(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_name() RETURNS SETOF character
    LANGUAGE sql
    AS $$
    SELECT "Name" FROM "Student";
$$;


ALTER FUNCTION public.get_name() OWNER TO postgres;

--
-- Name: layds_menu_theo_nguoidung(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.layds_menu_theo_nguoidung(OUT ref_ refcursor, puser character varying, pi18n character varying) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
	declare
	s varchar(4000);
begin
	open ref_ for
		select distinct a."ID" "ID", "NAME", "DETAIL_FILE", "PICTURE_FILE", "MENU_LEVEL",
		"PARENT_ID","DISPLAY_ORDER" from
		menu as a,menu_access as b,user_role as c
		WHERE "PUBLISH" = 1
		AND a."ID" = b."MENU_ID"
		and b."ROLE_ID" = c."ROLE_ID"
		and c."USER_ID"=puser
		ORDER BY a."ID","DISPLAY_ORDER","PARENT_ID";
	exception when others then
		declare
			strTmp_  varchar(2000);
		begin    
			strTmp_:='Loi thuc hien, ma loi: '||sqlerrm; 
			open ref_ for execute 'select '''||strTmp_||''' "ERROR"'; 
			--return ref_;
		end;
end; $$;


ALTER FUNCTION public.layds_menu_theo_nguoidung(OUT ref_ refcursor, puser character varying, pi18n character varying) OWNER TO postgres;

--
-- Name: layds_menu_theo_nguoidungs(character varying, character varying, refcursor); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.layds_menu_theo_nguoidungs(puser character varying, pi18n character varying, ref refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
    BEGIN

        OPEN ref FOR
            Select distinct a.ID "ID", NAME "NAME", detail_file "DETAIL_FILE", picture_file "PICTURE_FILE", menu_level "MENU_LEVEL",
                 parent_id "PARENT_ID",display_order "DISPLAY_ORDER" from
            menu a,menu_access b,user_role c
            WHERE publish = 1
                AND a.id = b.menu_id
                and b.role_id = c.role_id
                and c.user_id=puser
            ORDER BY a.ID,DISPLAY_ORDER,PARENT_ID;
        return ref;
    EXCEPTION WHEN others THEN
             DECLARE
                strTmp_  varchar(2000);
             BEGIN
                -- strTmp_ := TO_CHAR(sqlcode)||': '||sqlerrm;
                -- open c for select  ROW_NUMBER() OVER (ORDER BY strTmp_ ) as "ERROR" ;
                return ref;
             END;
    END; $$;


ALTER FUNCTION public.layds_menu_theo_nguoidungs(puser character varying, pi18n character varying, ref refcursor) OWNER TO postgres;

--
-- Name: layds_menu_theo_nguoidungs2(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.layds_menu_theo_nguoidungs2(puser character varying, pi18n character varying) RETURNS TABLE(id integer, name character, detail_file character, picture_file character, menu_level integer, parent_id integer, display_order integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
 RETURN QUERY Select distinct a.ID , a.NAME , a.detail_file , a.picture_file , a.menu_level,
                 a.parent_id ,a.display_order  from
            menu a,menu_access b,user_role c
            WHERE publish = 1
                AND a.id = b.menu_id
                and b.role_id = c.role_id
                and c.user_id=puser
            ORDER BY a.ID,DISPLAY_ORDER,PARENT_ID;
END; $$;


ALTER FUNCTION public.layds_menu_theo_nguoidungs2(puser character varying, pi18n character varying) OWNER TO postgres;

--
-- Name: new_menu(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.new_menu(pid character varying, pname character varying, pdisplay_order character varying, ppicture_file character varying, pdetail_file character varying, pmenu_level character varying, pparent_id character varying, ppublish character varying, puserid character varying, puserip character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare
    s varchar(1000);
begin
    --logger.access('menu|NEW',pid||'|'||pname||'|'||pdisplay_order||'|'||ppicture_file||'|'||pdetail_file||'|'||pmenu_level||'|'||pparent_id||'|'||ppublish);
    s:='insert into menu("ID","NAME","DISPLAY_ORDER","PICTURE_FILE","DETAIL_FILE","MENU_LEVEL","PARENT_ID","PUBLISH")
     values ($1,$2,$3,$4,$5,$6,$7,$8)';
    execute s using cast(pid as integer),pname,cast(pdisplay_order as integer),ppicture_file,pdetail_file,cast(pmenu_level as integer),cast(pparent_id as integer),cast(ppublish as integer);
    --commit;
    return '1';
    exception when others then
        declare err varchar(500); begin    err:='Loi thuc hien, ma loi:'||sqlerrm;
        --logger.access('new_menu|ERR',err);
        return err;
    end;
end;$_$;


ALTER FUNCTION public.new_menu(pid character varying, pname character varying, pdisplay_order character varying, ppicture_file character varying, pdetail_file character varying, pmenu_level character varying, pparent_id character varying, ppublish character varying, puserid character varying, puserip character varying) OWNER TO postgres;

--
-- Name: new_role(character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.new_role(pid character varying, prole_name character varying, pdescription character varying, puserid character varying, puserip character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare
    s varchar(1000);
    l_lever integer;
begin
    --logger.access('new_role|NEW',pid||'|'||prole_name||'|'||pUserId||'|'||pUserIp);
    --IF instr(UPPER(pid),'ADMIN') > 0 THEN
    --    select role_lever into l_lever  from user_info where id = pUserId and rownum=1;
    --   IF l_lever <> 5 THEN
    --        RETURN 'Permission denied: Role id must not have "admin" word!';
    --    END IF;
    --END IF;
    s:='insert into role(id,role_name,description)
     values ($1,$2,$3)';
    execute s using pid,prole_name,pdescription;
    --commit;
    return '1';
    exception when others then
        declare err varchar(500); begin
            err:='Loi thuc hien, ma loi:'||sqlerrm;
            --logger.access('new_role|ERR',err);
            return err;
    end;
end;$_$;


ALTER FUNCTION public.new_role(pid character varying, prole_name character varying, pdescription character varying, puserid character varying, puserip character varying) OWNER TO postgres;

--
-- Name: new_roles(character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.new_roles(pid character varying, prole_name character varying, pdescription character varying, puserid character varying, puserip character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$

declare
    s varchar(1000);
    l_lever integer;
begin
    --logger.access('new_role|NEW',pid||'|'||prole_name||'|'||pUserId||'|'||pUserIp);
    --IF instr(UPPER(pid),'ADMIN') > 0 THEN
    --    select role_lever into l_lever  from user_info where id = pUserId and rownum=1;
    --   IF l_lever <> 5 THEN
    --        RETURN 'Permission denied: Role id must not have "admin" word!';
    --    END IF;
    --END IF;
    s:='insert into roles("ID","ROLE_NAME","DESCRIPTION")
     values ($1,$2,$3)';
    execute s using pid,prole_name,pdescription;
    --commit;
    return '1';
    exception when others then
        declare err varchar(500); begin
            err:='Loi thuc hien, ma loi:'||sqlerrm;
            --logger.access('new_role|ERR',err);
            return err;
    end;
end;$_$;


ALTER FUNCTION public.new_roles(pid character varying, prole_name character varying, pdescription character varying, puserid character varying, puserip character varying) OWNER TO postgres;

--
-- Name: new_user_info(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.new_user_info(pid character varying, ppassword character varying, pfirst_name character varying, plast_name character varying, pmobile character varying, pdepartment character varying, pemail character varying, pgender character varying, pstatus_id character varying, pcreated_date character varying, pmodified_date character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare
    s varchar(1000);
begin

    --logger.access('user_info|NEW',pid||'|'||ppassword||'|'||pfirst_name||'|'||plast_name||'|'||pmobile||'|'||pdepartment||'|'||pemail||'|'||pgender||'|'||pstatus_id||'|'||pcreated_date||'|'||pmodified_date);
    s:='insert into user_info("ID","PASSWORD","FIRST_NAME","LAST_NAME","MOBILE","EMAIL","GENDER","STATUS_ID","CREATE_DATE","MODIFIED_DATE")
     values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)';
    execute s using pid,MD5(ppassword),pfirst_name,plast_name,pmobile,pemail,pgender,cast(pstatus_id as integer),now(),now();
    --commit;
    return '1';
    exception when others then
        declare err varchar(500); begin
            err:='Loi thuc hien, ma loi:'||sqlerrm;
            --logger.access('user_info|NEW|ERR',err);
            return err;

    end;
end;$_$;


ALTER FUNCTION public.new_user_info(pid character varying, ppassword character varying, pfirst_name character varying, plast_name character varying, pmobile character varying, pdepartment character varying, pemail character varying, pgender character varying, pstatus_id character varying, pcreated_date character varying, pmodified_date character varying) OWNER TO postgres;

--
-- Name: random_numero(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.random_numero(amount integer) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT array_to_string(
    ARRAY(
        SELECT chr((48 + round(random() * 9)) :: integer) 
        FROM generate_series(1,$1)
    ), '');
$_$;


ALTER FUNCTION public.random_numero(amount integer) OWNER TO postgres;

--
-- Name: sales_tax(real); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sales_tax(subtotal real) RETURNS real
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN subtotal * 0.06;
    END;
    $$;


ALTER FUNCTION public.sales_tax(subtotal real) OWNER TO postgres;

--
-- Name: search_menu(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.search_menu(OUT ref_ refcursor, pid character varying, pname character varying, pdisplay_order character varying, ppicture_file character varying, pdetail_file character varying, pmenu_level character varying, pparent_id character varying, ppublish character varying, precordperpage character varying, ppageindex character varying, puserid character varying, puserip character varying) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
declare
    s varchar(1000);
    pageIndex integer;
	recordPerPage integer;
begin
    s:='select a.*,lpad("NAME",("MENU_LEVEL"-1)*24+length("NAME"),''&nbsp;'') "NAME_LPAD" from menu as a where 1=1 ';
    if pid is not null and pid <> '' then s:=s||' and "ID" = '''||replace(pid,'*','%')||''''; end if;
    if pname is not null and pname <> '' then s:=s||' and "NAME" like '''||replace(pname,'*','%')||''''; end if;
    if pdisplay_order is not null and pdisplay_order <> '' then s:=s||' and "DISPLAY_ORDER" like '''||replace(pdisplay_order,'*','%')||''''; end if;
    if ppicture_file is not null and ppicture_file <> '' then s:=s||' and "PICTURE_FILE" like '''||replace(ppicture_file,'*','%')||''''; end if;
    if pdetail_file is not null and pdetail_file <> ''  then s:=s||' and "DETAIL_FILE" like '''||replace(pdetail_file,'*','%')||''''; end if;
    if pmenu_level is not null and pmenu_level <> '' then s:=s||' and "MENU_LEVEL" like '''||replace(pmenu_level,'*','%')||''''; end if;
    if pparent_id is not null and pparent_id <> '' then s:=s||' and "PARENT_ID" like '''||replace(pparent_id,'*','%')||''''; end if;
    if ppublish is not null and ppublish <> '' then s:=s||' and "PUBLISH" like '''||replace(ppublish,'*','%')||''''; end if;
    
    pageIndex := CAST (ppageindex AS INTEGER);
	recordPerPage := CAST (precordperpage AS INTEGER);
  if (pageIndex = -1) then
		
		s := 'select ceil(count(*)/'||recordPerPage||') "NOP",count(*) "NOR" from ('||s||') b';
		RAISE NOTICE 'Hello %',s;
		
	else
		s:=s||' order by "ID","PARENT_ID","DISPLAY_ORDER"';
		if (pageIndex < 2) then
			s := s || ' limit ' || recordPerPage;
		else
			s := s || ' limit ' || recordPerPage || ' offset ' || (pageIndex * recordPerPage - recordPerPage);
		end if;
		
	end if;
	open ref_ for execute s;
	RAISE NOTICE 'Hello %',s;
    --return ref_;
    exception when others then
        declare err varchar(500); 
	    begin    err:='Loi thuc hien, ma loi:'||sqlerrm; 
	    open ref_ for execute 'select '''||err||''' "ERROR"'; 
	    RAISE NOTICE 'Hello %',err;
        --return ref_;
    end;
end; $$;


ALTER FUNCTION public.search_menu(OUT ref_ refcursor, pid character varying, pname character varying, pdisplay_order character varying, ppicture_file character varying, pdetail_file character varying, pmenu_level character varying, pparent_id character varying, ppublish character varying, precordperpage character varying, ppageindex character varying, puserid character varying, puserip character varying) OWNER TO postgres;

--
-- Name: search_role(character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.search_role(OUT ref_ refcursor, pid character varying, prole_name character varying, pdescription character varying, precordperpage character varying, ppageindex character varying, puserid character varying, puserip character varying) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
declare
	s varchar(1000);
	pageIndex integer;
	recordPerPage integer;
begin
	-- select role_lever into l_lever  from user_info where id = pUserId and rownum=1;
	s:='select * from roles where 1=1';
	if pid is not null and pid <> '' then s:=s||' and "ID" like '''||replace(pid,'*','%')||''''; end if;
	if prole_name is not null and  prole_name <> '' then s:=s||' and "ROLE_NAME" like '''||replace(prole_name,'*','%')||''''; end if;
	if pdescription is not null and pdescription <> '' then s:=s||' and "DESCRIPTION" like '''||replace(pdescription,'*','%')||''''; end if;
	s:=s||' order by "ID"';

	pageIndex := CAST (pPageIndex AS INTEGER);
	recordPerPage := CAST (pRecordPerPage AS INTEGER);
	if (pageIndex < 2) then
		s := s || ' limit ' || recordPerPage;
	else
		s := s || ' limit ' || recordPerPage || ' offset ' || (pageIndex * recordPerPage - recordPerPage);
	end if;
	/*
	2 dong duoi day chuc nang tuong duong, nhung dong tren cho oracle, dong duoi cho postgres
	*/
	-- open ref_ for util.xuly_phantrang(s,pPageIndex,pRecordPerPage);
	--return query execute xuly_phantrang(s,CAST (pPageIndex AS INTEGER),CAST (pRecordPerPage AS INTEGER));
	open ref_ for execute s;


	-- chuc nang tuong tu nhu dbms_output.putline trong oracle
	--RAISE NOTICE 'Hello %',xuly_phantrang(s,CAST (pPageIndex AS INTEGER),CAST (pRecordPerPage AS INTEGER));

	exception when others then
	    declare err varchar(500); 
	    begin    err:='Loi thuc hien, ma loi:'||sqlerrm; 
	    open ref_ for execute 'select '''||err||''' "ERROR"'; 
	end;
END; $$;


ALTER FUNCTION public.search_role(OUT ref_ refcursor, pid character varying, prole_name character varying, pdescription character varying, precordperpage character varying, ppageindex character varying, puserid character varying, puserip character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.roles (
    "ID" character(50) NOT NULL,
    "ROLE_NAME" character(200),
    "DESCRIPTION" character(200)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: search_roles(character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.search_roles(pid character varying, prole_name character varying, pdescription character varying, precordperpage character varying, ppageindex character varying, puserid character varying, puserip character varying) RETURNS SETOF public.roles
    LANGUAGE plpgsql
    AS $$declare
	s varchar(1000);
	pageIndex integer;
	recordPerPage integer;
	ref_ refcursor;
	l_lever decimal;
begin
	-- select role_lever into l_lever  from user_info where id = pUserId and rownum=1;
	s:='select * from roles where 1=1';
	if pid is not null and pid <> '' then s:=s||' and "ID" like '''||replace(pid,'*','%')||''''; end if;
	if prole_name is not null and  prole_name <> '' then s:=s||' and "ROLE_NAME" like '''||replace(prole_name,'*','%')||''''; end if;
	if pdescription is not null and pdescription <> '' then s:=s||' and "DESCRIPTION" like '''||replace(pdescription,'*','%')||''''; end if;
	s:=s||' order by "ID"';

	pageIndex := CAST (pPageIndex AS INTEGER);
	recordPerPage := CAST (pRecordPerPage AS INTEGER);
	if (pageIndex < 2) then
		s := s || ' limit ' || recordPerPage;
	else
		s := s || ' limit ' || recordPerPage || ' offset ' || (pageIndex * recordPerPage - recordPerPage);
	end if;
	/*
	2 dong duoi day chuc nang tuong duong, nhung dong tren cho oracle, dong duoi cho postgres
	*/
	-- open ref_ for util.xuly_phantrang(s,pPageIndex,pRecordPerPage);
	--return query execute xuly_phantrang(s,CAST (pPageIndex AS INTEGER),CAST (pRecordPerPage AS INTEGER));
	return query execute s;


	-- chuc nang tuong tu nhu dbms_output.putline trong oracle
	--RAISE NOTICE 'Hello %',xuly_phantrang(s,CAST (pPageIndex AS INTEGER),CAST (pRecordPerPage AS INTEGER));

	--exception when others then
	--    declare err varchar(500); begin    err:='Loi thuc hien, ma loi:'||to_char(sqlerrm); open ref_ for 'select :1 err from dual' using err; return ref_;
	--end;
END; $$;


ALTER FUNCTION public.search_roles(pid character varying, prole_name character varying, pdescription character varying, precordperpage character varying, ppageindex character varying, puserid character varying, puserip character varying) OWNER TO postgres;

--
-- Name: search_user_info(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.search_user_info(OUT ref_ refcursor, pid character varying, pfirst_name character varying, plast_name character varying, pmobile character varying, pemail character varying, precordperpage character varying, ppageindex character varying, puserid character varying, puserip character varying) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
declare
	s varchar(1000);
	pageIndex integer;
	recordPerPage integer;
begin

	s:='select * from user_info where 1=1 ';
	if pid is not null and pid <> '' then s:=s||' and "ID" like '''||replace(pid,'*','%')||''''; end if;
	--if ppassword is not null then s:=s||' and password like '''||replace(ppassword,'*','%')||''''; end if;
	if pfirst_name is not null and pfirst_name <> '' then s:=s||' and "FIRST_NAME" like '''||replace(pfirst_name,'*','%')||''''; end if;
	if plast_name is not null and plast_name <> '' then s:=s||' and "LAST_NAME" like '''||replace(plast_name,'*','%')||''''; end if;
	if pmobile is not null and pmobile <> '' then s:=s||' and "MOBILE" like '''||replace(pmobile,'*','%')||''''; end if;
	--if pdepartment is not null then s:=s||' and department like '''||replace(pdepartment,'*','%')||''''; end if;
	--if pemail is not null then s:=s||' and email like '''||replace(pemail,'*','%')||''''; end if;
	--if pgender is not null then s:=s||' and gender like '''||replace(pgender,'*','%')||''''; end if;
	--if pstaff is not null then s:=s||' and STAFF like '''||replace(pstaff,'*','%')||''''; end if;
	--if pstatus_id is not null then s:=s||' and status_id like '''||replace(pstatus_id,'*','%')||''''; end if;
	--if pcreated_date is not null then s:=s||' and created_date=to_date('''||pcreated_date||''',''dd/mm/yyyy'')'; end if;
	--if pmodified_date is not null then s:=s||' and CQT_TMS='||pmodified_date||''; end if;
	
	pageIndex := CAST (ppageindex AS INTEGER);
	recordPerPage := CAST (precordperpage AS INTEGER);
	RAISE NOTICE 'Hello %',pageIndex;
	--return query execute 'select '''||err||''' "ERROR" from user_info'; 
	if (pageIndex = -1) then
		
		s := 'select ceil(count(*)/'||recordPerPage||') "NOP",count(*) "NOR" from ('||s||') b';
		RAISE NOTICE 'Hello %',s;
		
	else
		s:=s||' order by "ID"';
		if (pageIndex < 2) then
			s := s || ' limit ' || recordPerPage;
		else
			s := s || ' limit ' || recordPerPage || ' offset ' || (pageIndex * recordPerPage - recordPerPage);
		end if;
		
	end if;
	raise notice 'Hello %',s;
	open ref_ for execute s;
	--return ref_;
	exception when others then
		--returns table(error varchar)
		declare err varchar(500); 
		begin    err:='Loi thuc hien, ma loi: '||sqlerrm; 
		open ref_ for execute 'select '''||err||''' "ERROR" from user_info'; 
		--return ref_;
		end;
end;$$;


ALTER FUNCTION public.search_user_info(OUT ref_ refcursor, pid character varying, pfirst_name character varying, plast_name character varying, pmobile character varying, pemail character varying, precordperpage character varying, ppageindex character varying, puserid character varying, puserip character varying) OWNER TO postgres;

--
-- Name: search_user_info(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, refcursor); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.search_user_info(pid character varying, pfirst_name character varying, plast_name character varying, pmobile character varying, pemail character varying, precordperpage character varying, ppageindex character varying, puserid character varying, puserip character varying, ref_ refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
declare
	s varchar(1000);
	pageIndex integer;
	recordPerPage integer;
begin

	s:='select * from user_info where 1=1 ';
	if pid is not null and pid <> '' then s:=s||' and "ID" like '''||replace(pid,'*','%')||''''; end if;
	--if ppassword is not null then s:=s||' and password like '''||replace(ppassword,'*','%')||''''; end if;
	if pfirst_name is not null and pfirst_name <> '' then s:=s||' and "FIRST_NAME" like '''||replace(pfirst_name,'*','%')||''''; end if;
	if plast_name is not null and plast_name <> '' then s:=s||' and "LAST_NAME" like '''||replace(plast_name,'*','%')||''''; end if;
	if pmobile is not null and pmobile <> '' then s:=s||' and "MOBILE" like '''||replace(pmobile,'*','%')||''''; end if;
	--if pdepartment is not null then s:=s||' and department like '''||replace(pdepartment,'*','%')||''''; end if;
	--if pemail is not null then s:=s||' and email like '''||replace(pemail,'*','%')||''''; end if;
	--if pgender is not null then s:=s||' and gender like '''||replace(pgender,'*','%')||''''; end if;
	--if pstaff is not null then s:=s||' and STAFF like '''||replace(pstaff,'*','%')||''''; end if;
	--if pstatus_id is not null then s:=s||' and status_id like '''||replace(pstatus_id,'*','%')||''''; end if;
	--if pcreated_date is not null then s:=s||' and created_date=to_date('''||pcreated_date||''',''dd/mm/yyyy'')'; end if;
	--if pmodified_date is not null then s:=s||' and CQT_TMS='||pmodified_date||''; end if;
	
	pageIndex := CAST (ppageindex AS INTEGER);
	recordPerPage := CAST (precordperpage AS INTEGER);
	RAISE NOTICE 'Hello %',pageIndex;
	--return query execute 'select '''||err||''' "ERROR" from user_info'; 
	if (pageIndex = -1) then
		
		s := 'select ceil(count(*)/'||recordPerPage||') "NOP",count(*) "NOR" from ('||s||') b';
		RAISE NOTICE 'Hello %',s;
		
	else
		s:=s||' order by "ID"';
		if (pageIndex < 2) then
			s := s || ' limit ' || recordPerPage;
		else
			s := s || ' limit ' || recordPerPage || ' offset ' || (pageIndex * recordPerPage - recordPerPage);
		end if;
		
	end if;
	raise notice 'Hello %',s;
	open ref_ for execute s;
	return ref_;
	exception when others then
		--returns table(error varchar)
		declare err varchar(500); 
		begin    err:='Loi thuc hien, ma loi: '||sqlerrm; 
		open ref_ for execute 'select '''||err||''' "ERROR" from user_info'; 
		return ref_;
		end;
end;$$;


ALTER FUNCTION public.search_user_info(pid character varying, pfirst_name character varying, plast_name character varying, pmobile character varying, pemail character varying, precordperpage character varying, ppageindex character varying, puserid character varying, puserip character varying, ref_ refcursor) OWNER TO postgres;

--
-- Name: show_citie_out_ref(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.show_citie_out_ref(a character varying, OUT ref refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$declare 
s varchar(100);
    BEGIN
	s:= 'SELECT id, name FROM menu';
      OPEN ref FOR execute s;   -- Open a cursor
      --RETURN ref;                                                       -- Return the cursor to the caller
    END;
    $$;


ALTER FUNCTION public.show_citie_out_ref(a character varying, OUT ref refcursor) OWNER TO postgres;

--
-- Name: show_cities(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.show_cities() RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
    DECLARE
      ref refcursor;                                                     -- Declare a cursor variable
    BEGIN
      OPEN ref FOR SELECT id, name FROM menu;   -- Open a cursor
      RETURN ref;                                                       -- Return the cursor to the caller
    END;
    $$;


ALTER FUNCTION public.show_cities() OWNER TO postgres;

--
-- Name: show_cities(character varying, refcursor); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.show_cities(a character varying, ref refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$declare 
s varchar(100);
    BEGIN
	s:= 'SELECT id, name FROM menu';
      OPEN ref FOR execute s;   -- Open a cursor
      RETURN ref;                                                       -- Return the cursor to the caller
    END;
    $$;


ALTER FUNCTION public.show_cities(a character varying, ref refcursor) OWNER TO postgres;

--
-- Name: show_cities2(refcursor); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.show_cities2(ref refcursor) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
    BEGIN
      OPEN ref FOR SELECT city, state FROM cities;   -- Open a cursor
      RETURN ref;                                                       -- Return the cursor to the caller
    END;
    $$;


ALTER FUNCTION public.show_cities2(ref refcursor) OWNER TO postgres;

--
-- Name: stamp_user(integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.stamp_user(id integer, comment text) RETURNS void
    LANGUAGE plpgsql
    AS $$
    #variable_conflict use_variable
    DECLARE
        curtime timestamp := now();
    BEGIN
        PERFORM   * from user_info;
    END;
$$;


ALTER FUNCTION public.stamp_user(id integer, comment text) OWNER TO postgres;

--
-- Name: test_ret(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.test_ret(a text, b text) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE 
  ret RECORD;
BEGIN
  -- Arbitrary expression to change the first parameter
  IF LENGTH(a) < LENGTH(b) THEN
      SELECT TRUE, a || b, 'a shorter than b' INTO ret;
  ELSE
      SELECT FALSE, b || a INTO ret;
  END IF;
RETURN ret;
END;$$;


ALTER FUNCTION public.test_ret(a text, b text) OWNER TO postgres;

--
-- Name: word_frequency(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.word_frequency(_max_tokens integer) RETURNS TABLE(txt text, cnt bigint, ratio bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY
   SELECT t.txt
        , count(*) AS cnt  -- column alias only visible inside
        , (count(*) * 100) / _max_tokens  -- I added brackets
   FROM  (
      SELECT t.txt
      FROM   token t
      WHERE  t.chartype = 'ALPHABETIC'
      LIMIT  _max_tokens
      ) t
   GROUP  BY t.txt
   ORDER  BY cnt DESC;  -- note the potential ambiguity 
END
$$;


ALTER FUNCTION public.word_frequency(_max_tokens integer) OWNER TO postgres;

--
-- Name: Student; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public."Student" (
    "ID" character(10),
    "Name" character(100)
);


ALTER TABLE public."Student" OWNER TO postgres;

--
-- Name: checks; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.checks (
    "ID" integer
);


ALTER TABLE public.checks OWNER TO postgres;

--
-- Name: crud_detail; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.crud_detail (
    id integer DEFAULT 0 NOT NULL,
    column_id integer,
    column_name character(100),
    data_type character(100),
    data_length integer,
    check_nullable character(10),
    label character(300),
    related character(500),
    owner character(100),
    table_name character(100)
);


ALTER TABLE public.crud_detail OWNER TO postgres;

--
-- Name: log_all; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.log_all (
    entity character(200),
    content character(30000),
    logdate date
);


ALTER TABLE public.log_all OWNER TO postgres;

--
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.menu (
    "ID" integer NOT NULL,
    "NAME" character(200),
    "NAME_EN" character(200),
    "DISPLAY_ORDER" integer,
    "PICTURE_FILE" character(200),
    "DETAIL_FILE" character(200),
    "DETAIL_FILE_EN" character(200),
    "MENU_LEVEL" integer,
    "PARENT_ID" integer,
    "PUBLISH" integer
);


ALTER TABLE public.menu OWNER TO postgres;

--
-- Name: menu_access; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.menu_access (
    "ID" integer NOT NULL,
    "ROLE_ID" character(200),
    "MENU_ID" integer
);


ALTER TABLE public.menu_access OWNER TO postgres;

--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.role (
    id character(50) NOT NULL,
    role_name character(200),
    description character(200)
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: user_info; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.user_info (
    "ID" character(200) NOT NULL,
    "PASSWORD" character(32),
    "FIRST_NAME" character(200),
    "LAST_NAME" character(50),
    "MOBILE" character(18),
    "EMAIL" character(100),
    "GENDER" character(1),
    "STATUS_ID" integer,
    "CREATE_DATE" date,
    "MODIFIED_DATE" date,
    "ROLE_LEVER" integer
);


ALTER TABLE public.user_info OWNER TO postgres;

--
-- Name: TABLE user_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.user_info IS 'Bảng lưu thông tin người dùng để lưu trữ khi đăng nhập';


--
-- Name: COLUMN user_info."ID"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.user_info."ID" IS 'Id lưu trữ tên đăng nhập';


--
-- Name: COLUMN user_info."PASSWORD"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.user_info."PASSWORD" IS 'Lưu thông tin password';


--
-- Name: COLUMN user_info."FIRST_NAME"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.user_info."FIRST_NAME" IS 'Thông tin first_name';


--
-- Name: user_role; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE public.user_role (
    "ID" integer NOT NULL,
    "ROLE_ID" character(15),
    "USER_ID" character(200)
);


ALTER TABLE public.user_role OWNER TO postgres;

--
-- Data for Name: Student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Student" ("ID", "Name") FROM stdin;
2         	an hanh                                                                                             
3         	an hanh                                                                                             
4         	an hanh                                                                                             
1         	an hanh                                                                                             
\.


--
-- Data for Name: checks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.checks ("ID") FROM stdin;
1
\.


--
-- Data for Name: crud_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.crud_detail (id, column_id, column_name, data_type, data_length, check_nullable, label, related, owner, table_name) FROM stdin;
4	1	ID                                                                                                  	character                                                                                           	10	YES       	ID                                                                                                                                                                                                                                                                                                          	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    	public                                                                                              	Student                                                                                             
4	2	Name                                                                                                	character                                                                                           	100	YES       	Name                                                                                                                                                                                                                                                                                                        	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    	public                                                                                              	Student                                                                                             
0	0	0                                                                                                   	0                                                                                                   	0	0         	0                                                                                                                                                                                                                                                                                                           	0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   	0                                                                                                   	0                                                                                                   
\.


--
-- Data for Name: log_all; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log_all (entity, content, logdate) FROM stdin;
\.


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu ("ID", "NAME", "NAME_EN", "DISPLAY_ORDER", "PICTURE_FILE", "DETAIL_FILE", "DETAIL_FILE_EN", "MENU_LEVEL", "PARENT_ID", "PUBLISH") FROM stdin;
2	Quyền                                                                                                                                                                                                   	Role                                                                                                                                                                                                    	11	fa fa-lock                                                                                                                                                                                              	crud.jsp?crud_type=role/index.html                                                                                                                                                                      	crud.jsp?crud_type=role/index.html&language=en_US                                                                                                                                                       	2	1	1
3	Người dùng                                                                                                                                                                                              	Users                                                                                                                                                                                                   	1	fa fa-users                                                                                                                                                                                             	crud.jsp?crud_type=user_info/index.html                                                                                                                                                                 	crud.jsp?crud_type=user_info/index.html&language=en_US                                                                                                                                                  	2	1	1
4	Change password                                                                                                                                                                                         	Change password                                                                                                                                                                                         	7	fa fa-power-off                                                                                                                                                                                         	crud.jsp?crud_type=admin/change_password.html                                                                                                                                                           	crud.jsp?crud_type=admin/change_password.html&language=en_US                                                                                                                                            	2	1	1
5	User's Roles                                                                                                                                                                                            	User's Roles                                                                                                                                                                                            	4	fa fa-check-square-o                                                                                                                                                                                    	crud.jsp?crud_type=user_role/new.html                                                                                                                                                                   	crud.jsp?crud_type=user_role/new.html&language=en_US                                                                                                                                                    	2	1	1
6	Phân quyền Role                                                                                                                                                                                         	Assignment Rights Role                                                                                                                                                                                  	3	fa fa-unlock-alt                                                                                                                                                                                        	crud.jsp?crud_type=menu_access/new.html                                                                                                                                                                 	crud.jsp?crud_type=menu_access/new.html&language=en_US                                                                                                                                                  	2	1	1
7	Menus                                                                                                                                                                                                   	Menus                                                                                                                                                                                                   	5	fa fa-medium                                                                                                                                                                                            	crud.jsp?crud_type=menu/index.html                                                                                                                                                                      	crud.jsp?crud_type=menu/index.html&language=en_US                                                                                                                                                       	2	1	1
1	Quản trị hệ thống                                                                                                                                                                                       	System management                                                                                                                                                                                       	0	fa fa-user-secret                                                                                                                                                                                       	\N	\N	1	0	1
\.


--
-- Data for Name: menu_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu_access ("ID", "ROLE_ID", "MENU_ID") FROM stdin;
6291	THONGKE                                                                                                                                                                                                 	200
6292	THONGKE                                                                                                                                                                                                 	201
6293	THONGKE                                                                                                                                                                                                 	202
6294	THONGKE                                                                                                                                                                                                 	203
6295	THONGKE                                                                                                                                                                                                 	204
6296	THONGKE                                                                                                                                                                                                 	51
6297	TRACUU                                                                                                                                                                                                  	50
6298	TRACUU                                                                                                                                                                                                  	55
6299	TRACUU                                                                                                                                                                                                  	51
6330	TEST                                                                                                                                                                                                    	2
6331	TEST                                                                                                                                                                                                    	101
6332	TEST                                                                                                                                                                                                    	201
6333	QUANTRI                                                                                                                                                                                                 	1
6334	QUANTRI                                                                                                                                                                                                 	3
6335	QUANTRI                                                                                                                                                                                                 	4
6336	QUANTRI                                                                                                                                                                                                 	51
6337	QUANTRI                                                                                                                                                                                                 	100
6338	QUANTRI                                                                                                                                                                                                 	101
6339	QUANTRI                                                                                                                                                                                                 	103
6340	UNGDUNGNGOAI                                                                                                                                                                                            	300
6341	UNGDUNGNGOAI                                                                                                                                                                                            	302
6342	UNGDUNGNGOAI                                                                                                                                                                                            	303
6343	UNGDUNGNGOAI                                                                                                                                                                                            	304
6344	UNGDUNGNGOAI                                                                                                                                                                                            	310
6345	UNGDUNGNGOAI                                                                                                                                                                                            	305
6354	CSKH                                                                                                                                                                                                    	1
6355	CSKH                                                                                                                                                                                                    	2
6356	CSKH                                                                                                                                                                                                    	3
6357	CSKH                                                                                                                                                                                                    	4
6358	CSKH                                                                                                                                                                                                    	5
6359	CSKH                                                                                                                                                                                                    	6
6360	CSKH                                                                                                                                                                                                    	7
6361	CSKH                                                                                                                                                                                                    	50
6362	CSKH                                                                                                                                                                                                    	55
6363	TRACUUDN                                                                                                                                                                                                	51
6364	TRACUUDN                                                                                                                                                                                                	50
6471	DULIEU                                                                                                                                                                                                  	100
6472	DULIEU                                                                                                                                                                                                  	101
6473	DULIEU                                                                                                                                                                                                  	103
6474	DULIEU                                                                                                                                                                                                  	104
6475	DULIEU                                                                                                                                                                                                  	105
6476	DULIEU                                                                                                                                                                                                  	106
6477	DULIEU                                                                                                                                                                                                  	107
6478	DULIEU                                                                                                                                                                                                  	108
6479	DULIEU                                                                                                                                                                                                  	109
6480	DULIEU                                                                                                                                                                                                  	115
6481	DULIEU                                                                                                                                                                                                  	120
6482	DULIEU                                                                                                                                                                                                  	121
6483	DULIEU                                                                                                                                                                                                  	122
6484	DULIEU                                                                                                                                                                                                  	123
6512	ADMIN                                                                                                                                                                                                   	1
6513	ADMIN                                                                                                                                                                                                   	2
6514	ADMIN                                                                                                                                                                                                   	3
6515	ADMIN                                                                                                                                                                                                   	4
6516	ADMIN                                                                                                                                                                                                   	5
6517	ADMIN                                                                                                                                                                                                   	6
6518	ADMIN                                                                                                                                                                                                   	7
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id, role_name, description) FROM stdin;
ADMIN                                             	QUẢN TRỊ                                                                                                                                                                                                	quản trị                                                                                                                                                                                                
DULIEU                                            	DỮ LIỆU                                                                                                                                                                                                 	DU LIEU                                                                                                                                                                                                 
QUANTRI                                           	QUẢN TRỊ                                                                                                                                                                                                	QUẢN TRỊ                                                                                                                                                                                                
THONGKE                                           	thống kê                                                                                                                                                                                                	thống kê                                                                                                                                                                                                
TRACUU                                            	Tra cứu                                                                                                                                                                                                 	DÙNG TRA CỨU CÁC , TÌM KIẾM                                                                                                                                                                             
UNGDUNGNGOAI                                      	Ứng dụng ngoài                                                                                                                                                                                          	Các ứng dụng ngoài                                                                                                                                                                                      
anahs                                             	anhs                                                                                                                                                                                                    	check choác các kiểu                                                                                                                                                                                    
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles ("ID", "ROLE_NAME", "DESCRIPTION") FROM stdin;
ADMIN                                             	QUẢN TRỊ                                                                                                                                                                                                	quản trị                                                                                                                                                                                                
DULIEU                                            	DỮ LIỆU                                                                                                                                                                                                 	DU LIEU                                                                                                                                                                                                 
QUANTRI                                           	QUẢN TRỊ                                                                                                                                                                                                	QUẢN TRỊ                                                                                                                                                                                                
THONGKE                                           	thống kê                                                                                                                                                                                                	thống kê                                                                                                                                                                                                
TRACUU                                            	Tra cứu                                                                                                                                                                                                 	DÙNG TRA CỨU CÁC , TÌM KIẾM                                                                                                                                                                             
\.


--
-- Data for Name: user_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_info ("ID", "PASSWORD", "FIRST_NAME", "LAST_NAME", "MOBILE", "EMAIL", "GENDER", "STATUS_ID", "CREATE_DATE", "MODIFIED_DATE", "ROLE_LEVER") FROM stdin;
admin                                                                                                                                                                                                   	25d55ad283aa400af464c76d713c07ad	Quản trị hệ thống                                                                                                                                                                                       	84918486486                                       	84918486486       	0                                                                                                   	1	1	2017-09-27	2017-08-16	5
\.


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role ("ID", "ROLE_ID", "USER_ID") FROM stdin;
2046	DULIEU         	thiennt                                                                                                                                                                                                 
2065	TEST           	tuanna                                                                                                                                                                                                  
2066	DULIEU         	tuanna                                                                                                                                                                                                  
2067	QUANTRI        	tuanna                                                                                                                                                                                                  
2096	UNGDUNGNGOAI   	khacvt                                                                                                                                                                                                  
2119	ADMIN          	admin                                                                                                                                                                                                   
2120	DULIEU         	admin                                                                                                                                                                                                   
2121	QUANTRI        	admin                                                                                                                                                                                                   
2122	TRACUU         	admin                                                                                                                                                                                                   
2123	THONGKE        	admin                                                                                                                                                                                                   
2124	UNGDUNGNGOAI   	admin                                                                                                                                                                                                   
2129	DULIEU         	nhienla                                                                                                                                                                                                 
2130	THONGKE        	nhienla                                                                                                                                                                                                 
2131	TRACUU         	nhienla                                                                                                                                                                                                 
2134	DULIEU         	test                                                                                                                                                                                                    
2135	QUANTRI        	test                                                                                                                                                                                                    
2136	THONGKE        	test                                                                                                                                                                                                    
2137	TRACUU         	test                                                                                                                                                                                                    
2138	UNGDUNGNGOAI   	test                                                                                                                                                                                                    
\.


--
-- Name: id_menu_access; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.menu_access
    ADD CONSTRAINT id_menu_access PRIMARY KEY ("ID");


--
-- Name: menu_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_id_pk PRIMARY KEY ("ID");


--
-- Name: role_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_id_pk PRIMARY KEY (id);


--
-- Name: roles_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_id_pk PRIMARY KEY ("ID");


--
-- Name: user_info_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.user_info
    ADD CONSTRAINT user_info_id_pk PRIMARY KEY ("ID");


--
-- Name: user_role_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_id_pk PRIMARY KEY ("ID");


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

