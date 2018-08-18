<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
    function requestLogin() {
	    $("#login_form").attr("action", "/myWiki/util/login.jsp?from=<%=request.getParameter("from")%>");
	    return true;
    };
    
    $(function() {
        $(".btn_register").click(function() {
            location.href = "/myWiki/index.jsp?mode=register&from=<%=request.getParameter("from")%>";
        });
    });
</script>


<div class="heading">
    <h1>Log in</h1>
</div>

<div class="content_body">
    <form method="post" id="login_form" onsubmit="return requestLogin();">
        <table>
            <tr>
                <th>Nickname:</th>
                <td><input type="text" name="nickname"></td>
            </tr>
            <tr>
                <th>Password:</th>
                <td><input type="password" name="password"></td>
            </tr>
            <tr>
                <td><input type="submit" value="login"></td>
                <td><input type="button" value="register" class="btn_register"></td>
            </tr>
        </table>
    </form>    
</div>
