package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.ConcertService;
import com.chengxusheji.po.Concert;
import com.chengxusheji.service.ConcertTypeService;
import com.chengxusheji.po.ConcertType;

//Concert管理控制层
@Controller
@RequestMapping("/Concert")
public class ConcertController extends BaseController {

    /*业务层对象*/
    @Resource ConcertService concertService;

    @Resource ConcertTypeService concertTypeService;
	@InitBinder("concertTypeObj")
	public void initBinderconcertTypeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("concertTypeObj.");
	}
	@InitBinder("concert")
	public void initBinderConcert(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("concert.");
	}
	/*跳转到添加Concert视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Concert());
		/*查询所有的ConcertType信息*/
		List<ConcertType> concertTypeList = concertTypeService.queryAllConcertType();
		request.setAttribute("concertTypeList", concertTypeList);
		return "Concert_add";
	}

	/*客户端ajax方式提交添加演唱会信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Concert concert, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			concert.setConcertPhoto(this.handlePhotoUpload(request, "concertPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        concertService.addConcert(concert);
        message = "演唱会添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询演唱会信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("concertTypeObj") ConcertType concertTypeObj,String concertName,String concertTime,String concertPlace,String ycry,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (concertName == null) concertName = "";
		if (concertTime == null) concertTime = "";
		if (concertPlace == null) concertPlace = "";
		if (ycry == null) ycry = "";
		if(rows != 0)concertService.setRows(rows);
		List<Concert> concertList = concertService.queryConcert(concertTypeObj, concertName, concertTime, concertPlace, ycry, page);
	    /*计算总的页数和总的记录数*/
	    concertService.queryTotalPageAndRecordNumber(concertTypeObj, concertName, concertTime, concertPlace, ycry);
	    /*获取到总的页码数目*/
	    int totalPage = concertService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = concertService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Concert concert:concertList) {
			JSONObject jsonConcert = concert.getJsonObject();
			jsonArray.put(jsonConcert);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询演唱会信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Concert> concertList = concertService.queryAllConcert();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Concert concert:concertList) {
			JSONObject jsonConcert = new JSONObject();
			jsonConcert.accumulate("concertId", concert.getConcertId());
			jsonConcert.accumulate("concertName", concert.getConcertName());
			jsonArray.put(jsonConcert);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询演唱会信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("concertTypeObj") ConcertType concertTypeObj,String concertName,String concertTime,String concertPlace,String ycry,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (concertName == null) concertName = "";
		if (concertTime == null) concertTime = "";
		if (concertPlace == null) concertPlace = "";
		if (ycry == null) ycry = "";
		List<Concert> concertList = concertService.queryConcert(concertTypeObj, concertName, concertTime, concertPlace, ycry, currentPage);
	    /*计算总的页数和总的记录数*/
	    concertService.queryTotalPageAndRecordNumber(concertTypeObj, concertName, concertTime, concertPlace, ycry);
	    /*获取到总的页码数目*/
	    int totalPage = concertService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = concertService.getRecordNumber();
	    request.setAttribute("concertList",  concertList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("concertTypeObj", concertTypeObj);
	    request.setAttribute("concertName", concertName);
	    request.setAttribute("concertTime", concertTime);
	    request.setAttribute("concertPlace", concertPlace);
	    request.setAttribute("ycry", ycry);
	    List<ConcertType> concertTypeList = concertTypeService.queryAllConcertType();
	    request.setAttribute("concertTypeList", concertTypeList);
		return "Concert/concert_frontquery_result"; 
	}

     /*前台查询Concert信息*/
	@RequestMapping(value="/{concertId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer concertId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键concertId获取Concert对象*/
        Concert concert = concertService.getConcert(concertId);

        List<ConcertType> concertTypeList = concertTypeService.queryAllConcertType();
        request.setAttribute("concertTypeList", concertTypeList);
        request.setAttribute("concert",  concert);
        return "Concert/concert_frontshow";
	}

	/*ajax方式显示演唱会修改jsp视图页*/
	@RequestMapping(value="/{concertId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer concertId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键concertId获取Concert对象*/
        Concert concert = concertService.getConcert(concertId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonConcert = concert.getJsonObject();
		out.println(jsonConcert.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新演唱会信息*/
	@RequestMapping(value = "/{concertId}/update", method = RequestMethod.POST)
	public void update(@Validated Concert concert, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String concertPhotoFileName = this.handlePhotoUpload(request, "concertPhotoFile");
		if(!concertPhotoFileName.equals("upload/NoImage.jpg"))concert.setConcertPhoto(concertPhotoFileName); 


		try {
			concertService.updateConcert(concert);
			message = "演唱会更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "演唱会更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除演唱会信息*/
	@RequestMapping(value="/{concertId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer concertId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  concertService.deleteConcert(concertId);
	            request.setAttribute("message", "演唱会删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "演唱会删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条演唱会记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String concertIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = concertService.deleteConcerts(concertIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出演唱会信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("concertTypeObj") ConcertType concertTypeObj,String concertName,String concertTime,String concertPlace,String ycry, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(concertName == null) concertName = "";
        if(concertTime == null) concertTime = "";
        if(concertPlace == null) concertPlace = "";
        if(ycry == null) ycry = "";
        List<Concert> concertList = concertService.queryConcert(concertTypeObj,concertName,concertTime,concertPlace,ycry);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Concert信息记录"; 
        String[] headers = { "演唱会id","演唱会分类","演唱会名称","演唱会图片","演唱会时间","演唱会地点","演出人员","门票价格"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<concertList.size();i++) {
        	Concert concert = concertList.get(i); 
        	dataset.add(new String[]{concert.getConcertId() + "",concert.getConcertTypeObj().getTypeName(),concert.getConcertName(),concert.getConcertPhoto(),concert.getConcertTime(),concert.getConcertPlace(),concert.getYcry(),concert.getConcertPrice() + ""});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Concert.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
