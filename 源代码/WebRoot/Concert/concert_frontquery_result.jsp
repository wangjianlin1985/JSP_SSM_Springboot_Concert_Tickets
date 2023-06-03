<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Concert" %>
<%@ page import="com.chengxusheji.po.ConcertType" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Concert> concertList = (List<Concert>)request.getAttribute("concertList");
    //获取所有的concertTypeObj信息
    List<ConcertType> concertTypeList = (List<ConcertType>)request.getAttribute("concertTypeList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    ConcertType concertTypeObj = (ConcertType)request.getAttribute("concertTypeObj");
    String concertName = (String)request.getAttribute("concertName"); //演唱会名称查询关键字
    String concertTime = (String)request.getAttribute("concertTime"); //演唱会时间查询关键字
    String concertPlace = (String)request.getAttribute("concertPlace"); //演唱会地点查询关键字
    String ycry = (String)request.getAttribute("ycry"); //演出人员查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>演唱会查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Concert/frontlist">演唱会信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Concert/concert_frontAdd.jsp" style="display:none;">添加演唱会</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<concertList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Concert concert = concertList.get(i); //获取到演唱会对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Concert/<%=concert.getConcertId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=concert.getConcertPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		演唱会id:<%=concert.getConcertId() %>
			     	</div>
			     	<div class="field">
	            		演唱会分类:<%=concert.getConcertTypeObj().getTypeName() %>
			     	</div>
			     	<div class="field">
	            		演唱会名称:<%=concert.getConcertName() %>
			     	</div>
			     	<div class="field">
	            		演唱会时间:<%=concert.getConcertTime() %>
			     	</div>
			     	<div class="field">
	            		演唱会地点:<%=concert.getConcertPlace() %>
			     	</div>
			     	<div class="field">
	            		演出人员:<%=concert.getYcry() %>
			     	</div>
			     	<div class="field">
	            		门票价格:<%=concert.getConcertPrice() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Concert/<%=concert.getConcertId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="concertEdit('<%=concert.getConcertId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="concertDelete('<%=concert.getConcertId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>演唱会查询</h1>
		</div>
		<form name="concertQueryForm" id="concertQueryForm" action="<%=basePath %>Concert/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="concertTypeObj_typeId">演唱会分类：</label>
                <select id="concertTypeObj_typeId" name="concertTypeObj.typeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(ConcertType concertTypeTemp:concertTypeList) {
	 					String selected = "";
 					if(concertTypeObj!=null && concertTypeObj.getTypeId()!=null && concertTypeObj.getTypeId().intValue()==concertTypeTemp.getTypeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=concertTypeTemp.getTypeId() %>" <%=selected %>><%=concertTypeTemp.getTypeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="concertName">演唱会名称:</label>
				<input type="text" id="concertName" name="concertName" value="<%=concertName %>" class="form-control" placeholder="请输入演唱会名称">
			</div>
			<div class="form-group">
				<label for="concertTime">演唱会时间:</label>
				<input type="text" id="concertTime" name="concertTime" class="form-control"  placeholder="请选择演唱会时间" value="<%=concertTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="concertPlace">演唱会地点:</label>
				<input type="text" id="concertPlace" name="concertPlace" value="<%=concertPlace %>" class="form-control" placeholder="请输入演唱会地点">
			</div>
			<div class="form-group">
				<label for="ycry">演出人员:</label>
				<input type="text" id="ycry" name="ycry" value="<%=ycry %>" class="form-control" placeholder="请输入演出人员">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="concertEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;演唱会信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="concertEditForm" id="concertEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="concert_concertId_edit" class="col-md-3 text-right">演唱会id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="concert_concertId_edit" name="concert.concertId" class="form-control" placeholder="请输入演唱会id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="concert_concertTypeObj_typeId_edit" class="col-md-3 text-right">演唱会分类:</label>
		  	 <div class="col-md-9">
			    <select id="concert_concertTypeObj_typeId_edit" name="concert.concertTypeObj.typeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="concert_concertName_edit" class="col-md-3 text-right">演唱会名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="concert_concertName_edit" name="concert.concertName" class="form-control" placeholder="请输入演唱会名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="concert_concertPhoto_edit" class="col-md-3 text-right">演唱会图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="concert_concertPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="concert_concertPhoto" name="concert.concertPhoto"/>
			    <input id="concertPhotoFile" name="concertPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="concert_concertTime_edit" class="col-md-3 text-right">演唱会时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date concert_concertTime_edit col-md-12" data-link-field="concert_concertTime_edit">
                    <input class="form-control" id="concert_concertTime_edit" name="concert.concertTime" size="16" type="text" value="" placeholder="请选择演唱会时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="concert_concertPlace_edit" class="col-md-3 text-right">演唱会地点:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="concert_concertPlace_edit" name="concert.concertPlace" class="form-control" placeholder="请输入演唱会地点">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="concert_ycry_edit" class="col-md-3 text-right">演出人员:</label>
		  	 <div class="col-md-9">
			    <textarea id="concert_ycry_edit" name="concert.ycry" rows="8" class="form-control" placeholder="请输入演出人员"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="concert_concertPrice_edit" class="col-md-3 text-right">门票价格:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="concert_concertPrice_edit" name="concert.concertPrice" class="form-control" placeholder="请输入门票价格">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="concert_concertDesc_edit" class="col-md-3 text-right">详细说明:</label>
		  	 <div class="col-md-9">
			 	<textarea name="concert.concertDesc" id="concert_concertDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#concertEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxConcertModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var concert_concertDesc_edit = UE.getEditor('concert_concertDesc_edit'); //详细说明编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.concertQueryForm.currentPage.value = currentPage;
    document.concertQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.concertQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.concertQueryForm.currentPage.value = pageValue;
    documentconcertQueryForm.submit();
}

/*弹出修改演唱会界面并初始化数据*/
function concertEdit(concertId) {
	$.ajax({
		url :  basePath + "Concert/" + concertId + "/update",
		type : "get",
		dataType: "json",
		success : function (concert, response, status) {
			if (concert) {
				$("#concert_concertId_edit").val(concert.concertId);
				$.ajax({
					url: basePath + "ConcertType/listAll",
					type: "get",
					success: function(concertTypes,response,status) { 
						$("#concert_concertTypeObj_typeId_edit").empty();
						var html="";
		        		$(concertTypes).each(function(i,concertType){
		        			html += "<option value='" + concertType.typeId + "'>" + concertType.typeName + "</option>";
		        		});
		        		$("#concert_concertTypeObj_typeId_edit").html(html);
		        		$("#concert_concertTypeObj_typeId_edit").val(concert.concertTypeObjPri);
					}
				});
				$("#concert_concertName_edit").val(concert.concertName);
				$("#concert_concertPhoto").val(concert.concertPhoto);
				$("#concert_concertPhotoImg").attr("src", basePath +　concert.concertPhoto);
				$("#concert_concertTime_edit").val(concert.concertTime);
				$("#concert_concertPlace_edit").val(concert.concertPlace);
				$("#concert_ycry_edit").val(concert.ycry);
				$("#concert_concertPrice_edit").val(concert.concertPrice);
				concert_concertDesc_edit.setContent(concert.concertDesc, false);
				$('#concertEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除演唱会信息*/
function concertDelete(concertId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Concert/deletes",
			data : {
				concertIds : concertId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#concertQueryForm").submit();
					//location.href= basePath + "Concert/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交演唱会信息表单给服务器端修改*/
function ajaxConcertModify() {
	$.ajax({
		url :  basePath + "Concert/" + $("#concert_concertId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#concertEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#concertQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*演唱会时间组件*/
    $('.concert_concertTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

