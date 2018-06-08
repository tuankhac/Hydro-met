

//	Lib Function template common: =lFTCommon....
// 	Tao doi tuong chua cac ham se dung chung cho viec phan trang.
function libFTemplateCommon()
{
	this.callFunction=function(func_name,page_index,rec_per_page)
	{
		var call_func=func_name + "(" + page_index + "," + rec_per_page +")";
		if(func_name.length>0)
		{
			eval(call_func);//Thuc thi ham co ten la : func_name. va cac tham so...
		}
	}
	// Tim den trang tuong ung: theo su kien enter....
	this.CallGotoPage=function(e,obj,func_name,rec_per_page,max_page)
	{
		var keycode;
		if (window.event) keycode = window.event.keyCode;
		else if (e) keycode = e.which;
		else return true;
		if (keycode != 13) return true;
		if(obj.value.length==0) obj.value=0;
		else {
			if(isNaN(obj.value)) obj.value=0;
		}
		var goto_page=parseInt(obj.value);
		if(goto_page>max_page)
		{
			goto_page=max_page;
		}
		if(goto_page>=1 && goto_page <=max_page)
		{
			this.callFunction(func_name,goto_page,rec_per_page);
		}
	}
}
//Khai bao thu vien dung chung:
var lFTCommon= new libFTemplateCommon();
//Xay dung lop phan trang o day:
function pageTemplates(ps_obj_top, ps_obj_bottom, ps_f_name, ps_f_get_data)//Khoi tao doi tuong phan trang: trang tren va trang o duoi. 
{
	//Ten doi tuong chua trang: Gom Top va Bottom:
	var objNameTop=ps_obj_top;
	var objNameBottom=ps_obj_bottom;
	//Ham se duoc goi khi phan trang:
	
	var func_ShowData="";
	if(ps_f_get_data!=null && ps_f_get_data.length>0)
	{
		func_ShowData=ps_f_get_data;
		}
	//Chua ten ham se duoc goi: khi click thay doi trang...
	var func_name="";
	if(ps_f_name!=null)
	{
		func_name=ps_f_name;
	}
	var current_Page=1;	//Trang hien tai. ban dau=1.
	var total_Page=1;	//Tong so trang: Phu thuoc vao tong so ban ghi va so ban ghi tren trang. 
	var total_Rec=0;	//Tong so ban ghi.
	var rec_Per_Page=20;//So ban ghi tren trang.
	var default_Rec_Per_page=20;
	var num_Show_Page=7;//So trang hien thi moi tab....
	var is_First=true;				
	var is_Last=true;
	var arr_Option_Rec=new Array(20,30,50);//select so ban ghi hien thi. Co the duoc thiet lap lai boi nguoi dung !
	
	// Khai bao cac gia tri true, false: Voi muc dich cho phep hay khong cho phep hien thi:
	var type_template='STANDARD';
	var is_Show_Total_Page=true;
	var is_Show_Total_Rec=true;
	var is_Show_Txt_First=true;
	var is_Show_Txt_Last=true;
	var is_Show_Select=true;
	var is_Show_Textbox_See=true;
	var show_align="left";
	// Khai bao cac noi dung text:
	var str_page_first="Trang &#273;&#7847;u";
	var str_page_last="Trang cu&#7889;i";
	var str_page_ms="Hi&#7875;n th&#7883; trang: ";
	var str_total_page_ms="T&#7893;ng trang:";
	var str_total_rec_ms="T&#7893;ng b&#7843;n ghi:";
	var str_select_rec_per_page_ms="Thay &#273;&#7893;i s&#7889; b&#7843;n ghi hi&#7875;n th&#7883; tr&#234;n trang";
	var str_rec_per_page_ms="Hi&#7875;n th&#7883;: ";
	var str_text_see_page="Nh&#7853;p trang b&#7841;n mu&#7889;n xem";
	var str_see_page="Xem trang: ";
	
	//Xay dung cac ham khoi tao o day:
	this.CreateObjPage=function(ps_obj_top,ps_f_name)
	{
		objNameTop=ps_obj_top;
		func_name=ps_f_name;
	}
	
	
	//Thiet lap kieu trang se hien thi:
	
	this.setTypeTemplate=function(v)
	{
		if(v.length>0)
		{
			type_template=v;
		}
	}
	this.getTypeTemplate=function()
	{
		return type_template;
	}
	//Cho phep hien thi hay khong hien thi:
	this.setShowTxtLeftRight=function(v1,v2){is_Show_Txt_First=v1;is_Show_Txt_Last=v2;}
	this.setShowTxtFirstLast=function(v1,v2){is_Show_Txt_First=v1;is_Show_Txt_Last=v2;}
	this.setShowSelect=function(v){is_Show_Select=v}
	this.setShowTBSee=function(v){is_Show_Textbox_See=v}
	this.setShowTotalPage=function(v){is_Show_Total_Page=v}
	this.setShowTotalRec=function(v){is_Show_Total_Rec=v}
	this.setBasePage=function(v)//Trang co ban nhat. Chi hien thi so:
	{
		is_Show_Total_Page=!v;
		is_Show_Total_Rec=!v;
		is_Show_Txt_First=!v;
		is_Show_Txt_Last=!v;
		is_Show_Select=!v;
		is_Show_Textbox_See=!v;
	}
	//hien thi phan trang:left,right,or center?
	this.setShowAlign=function(value)
	{
		show_align=value;
	}
	this.getTotalPage=function()
	{
		return total_Page;
	}
	this.getTotalRec=function()
	{
		return total_Rec;
	}
	this.setTotalRec=function(value)
	{
		try
		  {
		  	total_Rec=parseInt(value);
			if(isNaN(total_Rec))
			{
				total_Rec=0;
			}
		  }
		catch(err)
		  {
			  total_Rec=0;
		  }
		calTotalpage();
	}
	this.getRecPerPage=function()
	{
		return rec_Per_Page;
	}
	this.setRecPerPage=function(value)
	{
		rec_Per_Page=parseInt(value);
		if(isNaN(rec_Per_Page))
		{
			rec_Per_Page=default_Rec_Per_page;
		}
		calTotalpage();
	}
	this.getCurrentPage=function()
	{
		return 	current_Page;
	}
	
	this.setCurrentPage=function(value)
	{
		current_Page=parseInt(value);
		if(isNaN(current_Page))
		{
			current_Page=1;
		}
		//Tinh toan lai xem current_Page co chap nhan dc ko: 1<=current_Page<=total_page.
		calTotalpage();
	}
	//Thiet lap mang cac gia tri rec_per_page de nguoi dung lua chon !
	this.setListRecPerPage=function(arr)
	{
		arr_Option_Rec=arr;
		if (arr!=null && arr.length>0)
		{
			rec_Per_Page=arr_Option_Rec[0];
		}
		
	}
	this.setDefaultRecPerPage=function(page){
		rec_Per_Page=page;
	}
	this.getListRecPerPage=function()
	{
		return arr_Option_Rec;
	}
	//Thiet lap so trang de nguoi dung co the nhin thay. (default=7) !
	this.setNumShowPage=function(value)
	{
		num_Show_Page=value;
	}
	this.getNumShowPage=function()
	{
		return num_Show_Page;
	}
	

	
	this.showTemplates=function(ps_page_id,ps_rec_per_page,ps_total_rec)
	{
		//alert(ps_total_rec);
		current_Page=parseInt(ps_page_id);
		if(isNaN(current_Page))
		{
			current_Page=1;
		}
		rec_Per_Page=parseInt(ps_rec_per_page);
		if(isNaN(rec_Per_Page))
		{
			rec_Per_Page=default_Rec_Per_page;
		}
		this.setTotalRec(ps_total_rec);
		
		if (type_template=='FULLNUMBER')
		{
			buildTemplateNumber(objNameTop,objNameBottom);
		}else if (type_template=='BOOTSTRAP'){
				buildPageBootStrap(objNameTop,objNameBottom);
		}else {
			buildTemplates(objNameTop,objNameBottom);
		}
	}
	//Hien thi lai phan trang theo total_Rec moi:
	this.showTemplates=function(ps_total_rec)
	{
		//alert(ps_total_rec);
		this.setTotalRec(ps_total_rec);
		if (type_template=='FULLNUMBER') {
			buildTemplateNumber(objNameTop,objNameBottom);
		}else if (type_template=='BOOTSTRAP'){
				buildPageBootStrap(objNameTop,objNameBottom);
		}else {
			buildTemplates(objNameTop,objNameBottom);
		}
	}
	
	
	//Build Pages: template chuan:
	function buildTemplates(obj1,obj2)
	{
		if((obj1.length<=0 || document.getElementById(obj1)==null) && (obj2.length<=0 || document.getElementById(obj2)==null))
		{
			return;//Doi tuong khong ton tai !. Bo qua !
		}
		var str_pages ="";
		str_pages +="<div class='css_pages_bg'><table cellpadding='0' cellspacing='0' border='0' align='"+ show_align +"'>";
		str_pages += "<tr height='26'>";
		str_pages += "<td valign='middle'>";
		var call_func="";
		var str_txt_first="&nbsp;";
		var str_txt_last="&nbsp;";
		if(is_Show_Txt_First)
		{
			str_txt_first=str_page_first;
		}
		if(is_Show_Txt_Last)
		{
			str_txt_last=str_page_last;
		}
		if(is_First)// Dang la trang dau tien. Khong cho phep goi ve trang dau.
		{			
			str_pages +="<span class='first_hd' title=\"" + str_page_first + "\">" + str_txt_first + "</span> ";
		}else // Khong phai la trang dau tien: cho phep goi ve trang dau.
		{
			//Goi hien thi trang dau tien. Page_index=1:
			call_func="lFTCommon.callFunction('"+ func_name + "',1," + rec_Per_Page + ");";
			str_pages +="<span class='page_first' title=\"" + str_page_first + "\" onclick=\"" + call_func + "\">" + str_txt_first + "</span> ";
		}
		var arr_index=calIndexLeftRight();
		for(var i=arr_index[0];i<=arr_index[1];i++)
		{
			if(i==current_Page)
			{
				str_pages +="<a class='page_current' title='" + str_page_ms + i + "/" + total_Page + "'>" + i + "</a> ";
			}else
			{
				call_func="lFTCommon.callFunction('"+ func_name + "'," + i +"," + rec_Per_Page + ");";
				str_pages +="<a  href='javascript:' title='" +str_page_ms + i + "/" + total_Page + "' onclick=\"" + call_func + "\">" + i + "</a> ";
			}
			
		}
		if(is_Last)//Dang la trang cuoi. Ko cho phep goi ve trang cuoi.
		{
			str_pages+="<span class=\"last_hd\" title=\"" + str_page_last + "\"> " + str_txt_last + "</span> ";
		}else
		{
			//Khong phai la trang cuoi. Cho phep goi ve trang cuoi.
			call_func="lFTCommon.callFunction('"+ func_name + "'," + total_Page +"," + rec_Per_Page + ");";
			str_pages +="<span class=\"page_last\" title=\"" + str_page_last + ": " + total_Page + "\" onclick=\"" + call_func + "\"> " + str_txt_last + "</span> ";
		}
		str_pages +="</td>";
		//Ket thuc phan hien thi so trang
		//Hien thi selectbox:
		if(is_Show_Select)
		{
			str_pages += builSelectRecPerPage();
		}
		//Hien thi: TextBox see page:
		if(is_Show_Textbox_See)
		{
			str_pages +=buildTextSeePage();
		}
		//Hien thi tong so trang:
		str_pages += buildMessageShow();
		str_pages += "</tr>";
		str_pages += "</table></div>";
		
		if(document.getElementById(obj1)!=null)
		{
			document.getElementById(obj1).innerHTML=str_pages;
		}
		if(document.getElementById(obj2)!=null)
		{
			document.getElementById(obj2).innerHTML=str_pages;
		}
		return;
	}
	
	function buildTemplateNumber(obj1,obj2)
	{
		if((obj1.length<=0 || document.getElementById(obj1)==null) && (obj2.length<=0 || document.getElementById(obj2)==null))
		{
			return;//Doi tuong khong ton tai !. Bo qua !
		}
		var str_pages ="";
		if (total_Page>0)
		{
			str_pages +="<div class='css_pages_only_number'><table cellpadding='0' cellspacing='0' border='0' align='"+ show_align +"'>";
			str_pages += "<tr style='height:19px;'>";
			str_pages += "<td valign='middle'>";
			var call_func="";
			var str_txt_Left="&nbsp;";
			var str_txt_Right="&nbsp;";
			if(is_First)// Dang la trang dau tien. Khong cho phep goi ve trang dau.
			{			
				str_pages +="<span class='next_left'>" + str_txt_Left + "</span> ";
			}else // Khong phai la trang dau tien: cho phep goi ve trang dau.
			{
				//Quay ve trang truoc:
				var page_Left=current_Page - 1;
				call_func="lFTCommon.callFunction('"+ func_name + "',"+ page_Left +"," + rec_Per_Page + ");";
				str_pages +="<span class='next_left' title='" + str_page_ms + page_Left + "/" + total_Page + "' onclick=\"" + call_func + "\">" + str_txt_Left + "</span> ";
			}
			var arr_index=calIndexLeftRight();
			for(var i=arr_index[0];i<=arr_index[1];i++)
			{
				if(i==current_Page)
				{
					str_pages +="<a class='page_current' title='" + str_page_ms + i + "/" + total_Page + "'>" + i + "</a> ";
				}else
				{
					call_func="lFTCommon.callFunction('"+ func_name + "'," + i +"," + rec_Per_Page + ");";
					str_pages +="<a  href='javascript:' title='" + str_page_ms + i + "/" + total_Page + "' onclick=\"" + call_func + "\">" + i + "</a> ";
				}
				
			}
			if(is_Last)//Dang la trang cuoi. Ko cho phep goi ve trang cuoi.
			{
				str_pages+="<span class='next_right'> " + str_txt_Right + "</span> ";
			}else
			{
				//Next len truoc 1 trang:
				var page_Right=current_Page + 1;
				call_func="lFTCommon.callFunction('"+ func_name + "'," + page_Right +"," + rec_Per_Page + ");";
				str_pages +="<span class='next_right' title=\"" + str_page_ms + page_Right + "/" + total_Page + "\" onclick=\"" + call_func + "\"> " + str_txt_Right + "</span> ";
			}
			str_pages +="</td>";
			str_pages += "</tr>";
			str_pages += "</table></div>";
		}else
		{
			str_pages="";
		}
		
		if(document.getElementById(obj1)!=null)
		{
			document.getElementById(obj1).innerHTML=str_pages;
		}
		if(document.getElementById(obj2)!=null)
		{
			document.getElementById(obj2).innerHTML=str_pages;
		}
		return;
	}
	
	//Build new Template with BOOTSTRAP:
	function buildPageBootStrap(obj1,obj2)
	{
		if((obj1.length<=0 || document.getElementById(obj1)==null) && (obj2.length<=0 || document.getElementById(obj2)==null))
		{
			return;//Doi tuong khong ton tai !. Bo qua !
		}
		var str_pages ="";
		if (total_Page>0)
		{
			//show_align:
			str_pages += "<ul class='pagination pagination-sm'>";
			var call_func="";
			var str_txt_Left="&laquo;";
			var str_txt_Right="&raquo;";
			if(is_First)// Dang la trang dau tien. Khong cho phep goi ve trang dau.
			{
				str_pages +="<li><a href='javascript:'>" + str_txt_Left + "</a></li>";
			}else // Khong phai la trang dau tien: cho phep goi ve trang dau.
			{
				//Quay ve trang truoc:
				var page_Left=current_Page - 1;
				call_func="lFTCommon.callFunction('"+ func_name + "',"+ page_Left +"," + rec_Per_Page + ");";
				str_pages +="<li title='" + str_page_ms + page_Left + "/" + total_Page + "' onclick=\"" + call_func + "\"><a href='javascript:'>" + str_txt_Left + "</a></li>";
			}
			var arr_index=calIndexLeftRight();
			for(var i=arr_index[0];i<=arr_index[1];i++)
			{
				if(i==current_Page)
				{
					str_pages +="<li class='active'><a href='javascript:' title='" + str_page_ms + i + "/" + total_Page + "'>" + i + "</a></li>";
				}else
				{
					call_func="lFTCommon.callFunction('"+ func_name + "'," + i +"," + rec_Per_Page + ");";
					str_pages +="<li><a  href='javascript:' title='" + str_page_ms + i + "/" + total_Page + "' onclick=\"" + call_func + "\">" + i + "</a></li>";
				}
			}
			if(is_Last)//Dang la trang cuoi. Ko cho phep goi ve trang cuoi.
			{
				str_pages +="<li><a href='#'>" + str_txt_Right + "</a></li>";
			}else
			{
				//Next len truoc 1 trang:
				var page_Right=current_Page + 1;
				call_func="lFTCommon.callFunction('"+ func_name + "'," + page_Right +"," + rec_Per_Page + ");";
				str_pages +="<li class='next_right' title=\"" + str_page_ms + page_Right + "/" + total_Page + "\" onclick=\"" + call_func + "\"> <a href='#'>" + str_txt_Right + "</a></li>";
			}
			str_pages += "</ul>";
		}else
		{
			str_pages="";
		}
		
		//alert("du lieu trang:" + str_pages);
		
		if(document.getElementById(obj1)!=null)
		{
			document.getElementById(obj1).innerHTML=str_pages;
		}
		if(document.getElementById(obj2)!=null)
		{
			document.getElementById(obj2).innerHTML=str_pages;
		}
		return;
	}
	
	
	//Tinh toan lai cac thong so phu thuoc vao: total_Rec, rec_Per_Page:
	function calTotalpage()
	{
		if(rec_Per_Page>0)
		{
			if(total_Rec==0)
			{
				total_Page=0;
				current_Page=1;
				is_First=true;
				is_Last=true;
				return;
			}
			//Tinh toan tong so trang theo: total_Rec and rec_Per_page:
			total_Page=parseInt(total_Rec/rec_Per_Page);
			if(total_Rec%rec_Per_Page>0)
			{
				total_Page++;
			}
			if(current_Page<=0)
			{
				current_Page=1;
			}
			if(current_Page>total_Page)
			{
				current_Page=total_Page;
			}
			//Thiet lap la trang dau khong?
			if(current_Page==1)
			{
				is_First=true;
			}else
			{
				is_First=false;
			}
			//Thiet lap la trang cuoi khong?
			if(current_Page==total_Page)
			{
			is_Last=true;
			}
			else
			{
				is_Last=false;
			}
		}else
		{
			total_Page=0;
			current_Page=1;
			is_First=true;
			is_Last=true;
		}
	}
	//Function: Return string show total_page and total_rec: ( Neu duoc phep hien thi thi tra ra message: Thong bao tong so trang va tong so ban ghi !
	function buildMessageShow()
	{
		var str_show="";
		if(is_Show_Total_Page)
		{
			str_show += "<span class='txt_title'>" + str_total_page_ms + "</span> <span class='txt_number'>"+ total_Page +"</span>";
		}
		if(is_Show_Total_Rec)
		{
			if(str_show.length>0)
			{
				str_show+=", ";
			}
			str_show += "<span class='txt_title'>" + str_total_rec_ms + "</span> <span class='txt_number'>"+ total_Rec +"</span>";
		}
		if(str_show.length>0)
		{
			str_show ="<td class='css_line_y'></td><td>"  + str_show + "</td>";
		}
		return str_show;
	}
	//Function: Return str TextBox See page:
	function buildTextSeePage()
	{
		var str_text="";
		str_text ="<td class='css_line_y'></td>";
		var call_func="lFTCommon.CallGotoPage(event,this,'"+ func_name + "'," + rec_Per_Page  + ","+ total_Page +");";
		var str_ms=str_text_see_page + " (Max="+ total_Page +")";
      	str_text +="<td class='txt_title'>"+ str_see_page +"<input type='text' class='text_box' maxlength='8' value='' style='width:40px;' title='"+ str_ms +"' onKeyPress=\"" + call_func + "\" /></td>";
		return str_text;
	}
	//Build Select Box: Rec_Per_page: Cho phep select tong so ban ghi se hien thi tren trang:
	function builSelectRecPerPage()
	{
		var str_select="";
		var call_func="lFTCommon.callFunction('"+ func_name + "',1,this.value);";
		str_select +="<td class='css_line_y'></td><td valign='middle' class='txt_title'>";
		str_select +=str_rec_per_page_ms +"</td><td><select onchange=\"" + call_func + "\" class=\"select_box\" title='"+ str_select_rec_per_page_ms +"'>";
		var num=arr_Option_Rec.length;
        for(var i=0;i<num;i++)
		{
		  if(arr_Option_Rec[i]==rec_Per_Page)
		  {
			  str_select+= "<option value='" + arr_Option_Rec[i] + "' selected>" + arr_Option_Rec[i] + "</option>";
			}else
			{
				str_select+= "<option value='" + arr_Option_Rec[i] + "'>" + arr_Option_Rec[i] + "</option>";
				}
		}
        str_select +="</select>";
		str_select +="</td>";
		return str_select;
	}
	
	// Tra ve index left and index right voi trang hien tai ( Muc dich: Gioi han so trang hien thi cho nguoi dung nhin thay)
	function calIndexLeftRight()
	{
		var arr=new Array(1,1);
		var index_Left=1;
		var index_Right=1;
		var mid=1;
		mid= parseInt(num_Show_Page/2);
		//alert(num_Show_Page);
		index_Left=current_Page - mid;
		if(index_Left<1)
		{
			index_Left=1;
			// left thieu: tinh right:
			index_Right=current_Page + (num_Show_Page  - (current_Page-index_Left)) -1;//trang 1 da dc tinh roi !
			if(index_Right>total_Page)
			{
				index_Right=total_Page;
			}
		}else
		{
			//left du. Kiem tra xem right co du khong?
			index_Right=current_Page + mid;
			if(index_Right>=total_Page)//right thieu.
			{
				index_Right=total_Page;
				//Tinh lai left:
				index_Left=current_Page - (num_Show_Page -(index_Right-current_Page)) + 1;
				if (index_Left<1)
				{
					index_Left=1;
				}
			}else
			{
				//du ca 2 chieu. ko phai lam gi...
				if (index_Right - index_Left > num_Show_Page-1)
				{
					index_Left++;
				}
			}
		}
		arr[0]=index_Left;
		arr[1]=index_Right;
		return arr;
	}
	
	//Hien thi phan trang su dung bootstrap:
	this.returnDataCount=function(data)
	{
		if(data!=null)
		{
			var toTalRec=parseInt(data,10);
			if(isNaN(toTalRec))
			{
					alert('Loi phan trang: So ban ghi tra ve khong phai dang so. Khong the hien thi phan trang.');
					return;
			}
			total_Rec=toTalRec;
			calTotalpage();
			if (type_template=='FULLNUMBER')
			{
				buildTemplateNumber(objNameTop,objNameBottom);
			}else if (type_template=='BOOTSTRAP'){
				buildPageBootStrap(objNameTop,objNameBottom);
			}
			else {
				buildTemplates(objNameTop,objNameBottom);
			}
			
			if (func_ShowData.length>0)
			{
				try
				  {
					  var func_call=func_ShowData + "("+ current_Page +"," + rec_Per_Page +");"; 
					  eval(func_call);
					  return;
				  }
				catch(err)
				  {
					  alert('Loi phan trang: Ham "' + func_ShowData +'" khong ton tai.');
					  return;
				  }
				
			}else
			{
				//alert('Loi phan trang: Ham hien thi du lieu chua duoc dang ky.');
				return;
				}
		}else
		{
			alert('Loi ket noi CSDL. Khong lay duoc so ban ghi.');
			return;
		}
	}
}