<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:directive.include file="includes/top.jsp" />
        <div id="header">
            <h1>Login</h1>
        </div><!--close header-->
        <div id="column-one" style="width:350px">
            <div class="section">
            <script type="text/javascript">
                $(document).ready(function() {
                    $("input#username").focus();
                });
                function setUserNameLc() {
                    $("input#username").val(function() {
                        return $("input#username").val().toLowerCase();
                    });
                }
            </script>
            <form:form method="post" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" htmlEscape="true" onsubmit="setUserNameLc()">
                <form:errors path="*" cssClass="errors" id="status" element="div" />
                <div class="box fl-panel" id="login">
                <!-- <spring:message code="screen.welcome.welcome" /> -->
                    <h2><spring:message code="screen.welcome.instructions" /></h2>
                    <div class="row fl-controls-left">
                        <label for="username" class="fl-label"><spring:message code="screen.welcome.label.netid" /></label>
                        <c:if test="${not empty sessionScope.openIdLocalId}">
                        <strong>${sessionScope.openIdLocalId}</strong>
                        <input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}" />
                        </c:if>

                        <c:if test="${empty sessionScope.openIdLocalId}">
                        <spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
                        <form:input cssClass="required" cssErrorClass="error" id="username" size="32" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="false" htmlEscape="true"  value="${param.email}"/>
                        </c:if>
                    </div>
                    <div class="row fl-controls-left">
                        <label for="password" class="fl-label"><spring:message code="screen.welcome.label.password" /></label>
                        <%--
                        NOTE: Certain browsers will offer the option of caching passwords for a user.  There is a non-standard attribute,
                        "autocomplete" that when set to "off" will tell certain browsers not to prompt to cache credentials.  For more
                        information, see the following web page:
                        http://www.geocities.com/technofundo/tech/web/ie_autocomplete.html
                        --%>
                        <spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
                        <form:password cssClass="required" cssErrorClass="error" id="password" size="32" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" />
                    </div>
                    <div class="row check">
                        <%--
                        <input id="warn" name="warn" value="true" tabindex="3" accesskey="<spring:message code="screen.welcome.label.warn.accesskey" />" type="checkbox" />
                        <label for="warn"><spring:message code="screen.welcome.label.warn" /></label>
                        --%>
                        <input type="checkbox" name="rememberMe" id="rememberMe" value="true" />
                        <label for="rememberMe">Remember Me</label>
                    </div>
                    <div class="row btn-row">
                        <input type="hidden" name="lt" value="${flowExecutionKey}" />
                        <input type="hidden" name="_eventId" value="submit" />

                        <input class="btn-submit" name="submit" accesskey="l" value="<spring:message code="screen.welcome.button.login" />" tabindex="4" type="submit" />
                        <input class="btn-reset" name="reset" accesskey="c" value="<spring:message code="screen.welcome.button.clear" />" tabindex="5" type="reset" />
                    </div>
                </div>
            </form:form>
            </div><!--close section-->
        </div><!--close column-one-->
        <div id="column-two" style="width:500px">
            <div class="section">
                <p><spring:message code="screen.welcome.security" /></p>
                <h2><spring:message code="screen.welcome.registered" text="Register"/></h2>
                <p><spring:message code="screen.welcome.notRegistered" arguments="${properties['userdetails.url']}/registration/createAccount"/></p>
                <h2><spring:message code="screen.welcome.forgottenpassword.hdr" text="Forgotten password ?"/></h2>
                <p><spring:message code="screen.welcome.forgottenpassword" arguments="${properties['userdetails.url']}/registration/forgottenPassword"/></p>
            </div><!--close section-->
        </div><!--close column-two-->
<jsp:directive.include file="includes/bottom.jsp" />
