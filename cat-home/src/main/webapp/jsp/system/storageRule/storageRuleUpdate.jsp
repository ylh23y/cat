<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="a" uri="/WEB-INF/app.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="res" uri="http://www.unidal.org/webres"%>
<%@ taglib prefix="w" uri="http://www.unidal.org/web/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:useBean id="ctx" type="com.dianping.cat.system.page.config.Context" scope="request"/>
<jsp:useBean id="payload" type="com.dianping.cat.system.page.config.Payload" scope="request"/>
<jsp:useBean id="model" type="com.dianping.cat.system.page.config.Model" scope="request"/>

<a:config>
			<h3 class="text-center text-success">编辑Storage监控规则</h3>
			<form name="appRuleUpdate" id="form" method="post">
				<table style='width:100%' class='table table-striped table-condensed '>
				<c:set var="conditions" value="${fn:split(payload.ruleId, ';')}" />
				<c:set var="name" value="${conditions[0]}" />
				<c:set var="machine" value="${conditions[1]}" />
				<c:set var="method" value="${conditions[2]}" />
				<c:set var="attribute" value="${conditions[3]}" />
				<c:set var="domain" value="${conditions[4]}" />
				<tr>
					<td>&nbsp;&nbsp;名字&nbsp;&nbsp;<input name="name" id="name" value="${name}"/>
					&nbsp;&nbsp;机器&nbsp;&nbsp;<input name="machine" id="machine" value="${machine}"/>
					&nbsp;&nbsp;方法&nbsp;&nbsp;<input name="method" id="method" value="${method}"/>（默认为All）
					&nbsp;&nbsp;监控项&nbsp;&nbsp;<select name="attribute" id="attribute" style="width:200px;">
													<option value="count">执行次数</option>
								                	<option value="avg">错误率</option>
								            	</select>
	            	&nbsp;&nbsp;项目&nbsp;&nbsp;<input name="domain" id="domain" value="${name}"/>（默认为All）
				</tr>
				<tr><th>${model.content}</th></tr>
					<tr>
						<td style='text-align:center' colspan='2'><input class="btn btn-primary btn-sm" id="ruleSubmitButton" type="text" name="submit" value="提交"></button></td>
					</tr>
				</table>
			</form>
</a:config>

<script type="text/javascript">
function update() {
    var configStr = generateConfigsJsonString();
    var domain = $("#domain").val();
    if(domain == "undefined" || domain == ""){
		if($("#errorMessage").length == 0){
			$("#domain").after($("<span class=\"text-danger\" id=\"errorMessage\">  该字段不能为空</span>"));
		}
		return;
	}
    var type = $("#type").val();
    if(type == "undefined" || type == ""){
		if($("#errorMessage").length == 0){
			$("#type").after($("<span class=\"text-danger\" id=\"errorMessage\">  该字段不能为空</span>"));
		}
		return;
	}
    var name = $("#name").val();
    if(name == "undefined" || name == ""){
		name = "All";
		$("#domain").val("All");
	}
    
    var monitor = $("#monitor").val();
    var split = ";";
    var id = domain + split + type + split + name + split + monitor;
    window.location.href = "?op=transactionRuleSubmit&configs=" + configStr + "&ruleId=" + id;
}

	$(document).ready(function() {
		initRuleConfigs(["DescVal","DescPer","AscVal","AscPer"]);
		var ruleId = "${payload.ruleId}";
		if(ruleId.length > 0){
			document.getElementById("domain").disabled = true;
			document.getElementById("type").disabled = true;
			document.getElementById("name").disabled = true;
			document.getElementById("monitor").disabled = true;
			var monitor = ruleId.split(';')[3];
			$('#monitor').val(monitor);
		}
		var name = $("#name").val();
		if(name == "" || name.length == 0){
			$("#name").val("All");
		}
		
		$('#application_config').addClass('active open');
		$('#transactionRule').addClass('active');
		$(document).delegate("#ruleSubmitButton","click",function(){
			update();
		})
	});
</script>