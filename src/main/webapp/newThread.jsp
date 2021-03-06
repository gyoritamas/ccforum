<%@ page import="com.codecool.ccforum.ui.model.NewThreadModel" %>
<%@ page import="com.codecool.ccforum.ui.controller.NewThreadController" %>
<%@ page import="com.codecool.ccforum.application.ServiceRegistry" %>

<%
    NewThreadController controller = ServiceRegistry.getInstance(NewThreadController.class);
    boolean isPost = request.getMethod().equalsIgnoreCase("POST");
    NewThreadModel model = null;
    if (isPost) {
        model = controller.onSubmit(request.getParameter("title"), request.getParameter("desc"));
        if (model.isSuccess()) {
            response.sendRedirect("/thread.jsp?threadId=" + model.getNewThreadId());
            return;
        }
    }
%>


<html>
<head>
    <title>Create new Thread</title>
</head>
<body>



<h1>Create new Thread</h1>

<form action="/newThread.jsp" method="POST">
    Title: <input name="title" type="text" /><br/>
    <% if (model != null && model.getTitleError() != null) { %>
    <div style="color: red"><%= model.getTitleError() %></div>
    <% } %>
    Description: <input name="desc" type="text" /><br/>
    <% if (model != null && model.getDescriptionError() != null) { %>
    <div style="color: red"><%= model.getDescriptionError() %></div>
    <% } %>
    <input type="submit" />
</form>

</body>
</html>