<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="server" value="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }"/>
<%! String externalGlobalBaseUrl="http://192.168.3.207:7081";%>
<%! String serverContextPath="adminFinance";%>
<%! String testPath="https://www.baidu.com";%>