<%@ page import="Model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="Service.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Information</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid black;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        form {
            margin: 0;
        }
    </style>
</head>
<body>
<h2>Users Information:</h2>
<table>
    <thead>
    <tr>
        <th>User ID</th>
        <th>User Name</th>
        <th>User Age</th>
        <th>User Sex</th>
        <th>Phone Number</th>
        <th>Email</th>
        <th>Address</th>
        <th>County</th>
    </tr>
    </thead>
    <tbody>
    <%
        int currentPage = 1;
        int recordsPerPage = 5;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        List<User> scheduledUserByPage = UserDao.getUsersByPage(currentPage, recordsPerPage);
        for (User user : scheduledUserByPage) {
    %>
    <tr>
        <td><%= user.getUserId() %>
        </td>
        <td><%= user.getUserName() %>
        </td>
        <td><%= user.getUserAge() %>
        </td>
        <td><%= user.getUserSex() %>
        </td>
        <td><%= user.getPhoneNumber() %>
        </td>
        <td><%= user.getEmail() %>
        </td>
        <td><%= user.getAddress() %>
        </td>
        <td><%= user.getCountry() %>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<div style="text-align: center">
    <%
        int numberOfUser = UserDao.getTotalNumberOfUser();
        int numberOfPage = numberOfUser / recordsPerPage;
        if (numberOfUser % recordsPerPage != 0) {
            numberOfPage++;
        }

        int startPage = Math.max(1, currentPage - 1);
        int endPage = Math.min(numberOfPage, startPage + 2);

        if (currentPage > 1) {
    %>
    <a href="<%=request.getContextPath()%>/Admin/ViewUsers.jsp?page=<%= currentPage - 1%>">Previous</a>
    <%
        }
        for (int i = startPage; i <= endPage; i++) {
    %>
    <a href="<%=request.getContextPath()%>/Admin/ViewUsers.jsp?page=<%= i %>"><%= i %>
    </a>
    <%
        }
        if (currentPage < numberOfPage) {
    %>
    <a href="<%=request.getContextPath()%>/Admin/ViewUsers.jsp?page=<%= currentPage + 1%>">Next</a>
    <%
        }
    %>

    <br>
    <a href="<%=request.getContextPath()%>/Admin/AdminHome.jsp">Back to home</a>
</div>
</body>
</html>
