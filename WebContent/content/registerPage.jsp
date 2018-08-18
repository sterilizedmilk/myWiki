<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String from = request.getParameter("from"); %>
<script>
    $(function() {
        $("#nickname").blur(function() {nicknameCheck(); } );
        $("#password").blur(function() {passwordCheck();} );
        $("#password_check").keyup(function() {passwordConfirmCheck();} );
        $("#nickname").keyup(function() { nicknameDuplicateCheck(); } );

        $("#btn_return").click(function() {
            location.href = "/myWiki/index.jsp?page=<%=request.getParameter("from")%>";
        });
    });

   function nicknameCheck() { // duplication check!
        var exp = /^[a-zA-Z][a-zA-Z0-9]{5,19}$/;
        if ($("#nickname").val() != "" && exp.test($("#nickname").val())) {
            $("#nickname").next().removeClass().text("");
            return true;
        } else {
            $("#nickname").next().addClass("box_error").text("Invalid Nickname");
            return false;
        }
    }
   
    function nicknameDuplicateCheck() {
        var valid = false;
        $.ajax({
            url: "/myWiki/util/nicknameDuplicateCheck.jsp?nickname=" + $("#nickname").val(),
            type: "get",
            async: false,
            success: function(result) {
                result = $.trim(result);
                if (result == "OK") {
                    $("#nickname").next().removeClass().text("");
                    valid = true;
                } else if (result == "USED") {
                    $("#nickname").next().addClass("box_error").text("Already Used Nickname");
                }
            }
        });
        return valid;
    }
    
    function passwordCheck() {
        var exp = /^[a-zA-Z0-9!~@#$%^&*?]{6,20}$/;
        if ($("#password").val() != "" && exp.test($("#password").val())) {
            $("#password").next().removeClass().text("");  
            return true;
        } else {
            $("#password").next().addClass("box_error").text("Invalid password");
            return false;
        }
    }
    
    function passwordConfirmCheck() {
        if ($("#password").val() == $("#password_check").val()) {
            $("#password_check").next().removeClass().text("");
            return true;
        } else {
            $("#password_check").next().addClass("box_error").text("password is not matched");
            return false;
        }
    }
    
    function requestRegister() {
        if (nicknameCheck() && nicknameDuplicateCheck() && passwordCheck() && passwordConfirmCheck()) {
            var from = document.createElement('input');
            from.setAttribute("type", "hidden");
            from.setAttribute("name", "from");
            from.setAttribute("value", "<%=from%>");
            var form = document.getElementById("register_form");
            form.appendChild(from);
            return true;
        }
        return false;
    }
</script>
    
    
<div class="heading">
    <h1>Register</h1>
</div>

<div class="content_body">
    <form action="/myWiki/util/register.jsp" method="post" id="register_form" onsubmit="return requestRegister();">
        <table>
            <tr>
                <th>Nickname:</th>
                <td><input type="text" id="nickname" name="nickname"><span></span></td>
            </tr>
            <tr>
                <th>Password:</th>
                <td><input type="password" id="password" name="password"><span></span></td>
            </tr>
            <tr>
                <th>Password-check:</th>
                <td><input type="password" id="password_check" name="password_check"><span></span></td>
            </tr>
            <tr>
                <td><input type="submit" value="register"></td>
                <td><input type="button" value="cancle" id="btn_return"></td>
            </tr>
        </table>
    </form>    
</div>
